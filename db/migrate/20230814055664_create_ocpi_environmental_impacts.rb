class CreateOcpiEnvironmentalImpacts < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_environmental_impacts, id: :uuid do |t|
      t.string :category
      t.float :amount
      t.uuid :ocpi_energy_mix_id

      t.timestamps
    end
  end
end
