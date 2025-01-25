# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :appointments

  validates :first_name, :email, presence: true
  validates :upcoming_days, numericality: { only_integer: true, greater_than: 0 }

  def name
    "#{first_name} #{last_name}"
  end

  def upcoming_business_days
    business_days = 0
    result_date = Date.current

    while business_days < upcoming_days
      result_date += 1
      business_days += 1 if result_date.on_weekday?
    end

    result_date
  end
end
