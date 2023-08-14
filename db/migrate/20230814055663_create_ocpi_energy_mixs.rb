class CreateOcpiEnergyMixs < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_energy_mixs, id: :uuid do |t|
      t.boolean :is_green_energy
      t.string :supplier_name
      t.string :energy_product_name
      t.uuid :energy_mixable_id
      t.string :energy_mixable_type

      t.timestamps
    end
  end
end
