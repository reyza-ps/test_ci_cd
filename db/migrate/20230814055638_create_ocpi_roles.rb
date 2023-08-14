# frozen_string_literal: true

class CreateOcpiRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_roles, id: :uuid do |t|
      t.string :role
      t.string :party_id
      t.string :country_code

      t.timestamps
    end
  end
end
