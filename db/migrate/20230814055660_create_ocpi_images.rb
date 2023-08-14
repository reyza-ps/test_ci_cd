# frozen_string_literal: true

class CreateOcpiImages < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_images do |t|
      t.string :url
      t.string :thumbnail
      t.integer :category
      t.string :type
      t.integer :width
      t.integer :height
      t.string :imageable_type
      t.string :imageable_id

      t.timestamps
    end
  end
end
