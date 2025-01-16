# frozen_string_literal: true

class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.date :appointment_date
      t.time :appointment_time
      t.string :patient_name
      t.references :user, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
