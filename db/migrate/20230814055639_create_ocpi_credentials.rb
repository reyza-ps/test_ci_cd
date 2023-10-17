# frozen_string_literal: true

class CreateOcpiCredentials < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_credentials, id: :uuid do |t|
      t.string :token
      t.string :url
      t.boolean :token_a, default: true
      t.string :token_b
      t.text :expected_identifiers, array: true, default: []

      t.timestamps
    end
  end
end
