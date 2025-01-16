FactoryBot.define do
  factory :appointment do
    appointment_date { 1.day.from_now }
    association :patient
  end
end