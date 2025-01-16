require 'rails_helper'

RSpec.describe Patient, type: :model do
  let(:patient) { create(:patient) }
  let(:user) { create(:user) }
  let(:datetime) { DateTime.now.to_date }

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should allow_value('email@example.com').for(:email) }
    it { should_not allow_value('email').for(:email) }

    it 'validates email uniqueness' do
      expect {
        create(:patient, email: patient.email)
      }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Email has already been taken')
    end
  end

  describe '.soon' do
    it 'returns patients with appointments within the next 72 hours' do
      patient1 = patient
      patient2 = create(:patient, email: 'patient2@example.com')
      patient3 = create(:patient, email: 'patient3@example.com')

      patient1.create_appointment(1.day.from_now, user.id)
      patient2.create_appointment(3.days.from_now, user.id)
      patient3.create_appointment(4.days.from_now, user.id)

      expect(Patient.soon).to include(patient1, patient2)
      expect(Patient.soon).not_to include(patient3)
    end
  end

  describe '.search' do
    it 'returns patients matching the search term' do
      patient1 = create(:patient, first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com')
      patient2 = create(:patient, first_name: 'Jane', last_name: 'Smith', email: 'jane.smith@example.com')
      patient3 = create(:patient, first_name: 'Alice', last_name: 'Johnson', email: 'alice.johnson@example.com')

      expect(Patient.search('john')).to include(patient1, patient3)
      expect(Patient.search('john')).not_to include(patient2)
      expect(Patient.search('smith')).to include(patient2)
      expect(Patient.search('smith')).not_to include(patient1, patient3)
    end
  end

  describe '#next_appointment' do
    it 'returns the date of the next appointment' do
      appointment = patient.create_appointment(datetime, user.id)
      expect(patient.next_appointment).to eq(appointment.appointment_date)
    end

    it 'returns nil if there are no appointments' do
      expect(patient.next_appointment).to be_nil
    end
  end

  describe '#soon_appointment' do
    it 'returns the soonest appointment' do
      appointment1 = patient.create_appointment(datetime + 1.day, user.id)
      appointment2 = patient.create_appointment(datetime, user.id)
      expect(patient.soon_appointment).to eq(appointment2)
    end

    it 'returns nil if there are no appointments' do
      expect(patient.soon_appointment).to be_nil
    end
  end

  describe '#name' do
    it 'returns the full name of the patient' do
      patient.update(first_name: 'John', last_name: 'Doe')
      expect(patient.name).to eq('John Doe')
    end
  end

  describe '#set_next_appointment' do
    context 'when there is no existing appointment' do
      it 'creates a new appointment' do
        expect {
          patient.set_next_appointment(datetime, user.id)
        }.to change { patient.appointments.count }.by(1)
      end
    end

    context 'when there is an existing appointment' do
      it 'updates the existing appointment' do
        appointment = patient.create_appointment(datetime + 1.day, user.id)
        patient.set_next_appointment(datetime, user.id)
        expect(appointment.reload.appointment_date).to eq(datetime)
      end
    end

    context 'when the datetime is blank' do
      it 'does not create or update an appointment' do
        expect {
          patient.set_next_appointment(nil, user.id)
        }.not_to change { patient.appointments.count }
      end
    end
  end
end
