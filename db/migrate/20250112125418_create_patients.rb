# frozen_string_literal: true

class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name

      t.string :email

      t.timestamps
    end
  end
end
