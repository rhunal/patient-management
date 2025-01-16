# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :patient

  scope :by_user, ->(user) { where(user_id: user.id) }
  scope :by_patient, ->(patient) { where(patient_id: patient.id) }

  validates :appointment_date, presence: true
  validates :appointment_date, uniqueness: { scope: :patient_id, message: "already exists for this patient" }

  def patient_name
    patient&.name
  end

  def appointment_datetime
    DateTime.parse("#{appointment_date} #{appointment_time}")
  end
end
