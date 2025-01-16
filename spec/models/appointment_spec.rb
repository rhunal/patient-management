require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:user) { create(:user) }
  let(:patient) { create(:patient) }
  let(:appointment) { build(:appointment, patient: patient, user: user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(appointment).to be_valid
    end

    it 'is not valid without a date' do
      appointment.appointment_date = nil
      expect(appointment).not_to be_valid
    end

    it 'is not valid without a patient' do
      appointment.patient = nil
      expect(appointment).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a patient' do
      assoc = described_class.reflect_on_association(:patient)
      expect(assoc.macro).to eq :belongs_to
    end
  end

  describe 'scopes' do
    before do
      @appointment1 = create(:appointment, appointment_date: 1.day.from_now, patient: patient, user: user)
      @appointment2 = create(:appointment, appointment_date: 2.days.from_now, patient: patient, user: user)
    end

    it 'returns appointments for a specific user' do
      expect(Appointment.by_user(user)).to include(@appointment1, @appointment2)
    end
  end
end
