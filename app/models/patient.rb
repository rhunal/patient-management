# frozen_string_literal: true

class Patient < ApplicationRecord
  attribute :next_appointment
  has_many :appointments, dependent: :destroy

  scope :soon, -> { joins(:appointments).where('appointments.appointment_date <= ?', 72.hours.from_now).distinct }
  scope :search, ->(term) { where('lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower(email) LIKE ?', "%#{term.downcase}%", "%#{term.downcase}%", "%#{term.downcase}%") }

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Fetch the next appointment
  def next_appointment
    soon_appointment&.appointment_date
  end

  def soon_appointment
    appointments.order(:appointment_date).first
  end

  def name
  "#{first_name} #{last_name}"
  end

  # update or create the next appointment
  def set_next_appointment(datetime, user_id)
    if datetime.present?
      if next_appointment.blank? || (next_appointment && next_appointment != datetime.to_date)
        if soon_appointment
          soon_appointment.update(appointment_date: datetime)
        else
          create_appointment(datetime, user_id)
        end
      end
    end
  end

  def create_appointment(datetime, user_id)
    appointments.create(
      appointment_date: datetime.to_date,
      appointment_time: datetime.to_time,
      user_id: user_id
    )
  end
end
