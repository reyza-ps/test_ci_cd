# frozen_string_literal: true

class CreateOcpiBusinessDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_business_details, id: :uuid do |t|
      t.string :name
      t.string :website

      t.timestamps
    end
  end
end
