class CreateOcpiEnergySources < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_energy_sources, id: :uuid do |t|
      t.string :source
      t.float :percentage
      t.uuid :ocpi_energy_mix_id

      t.timestamps
    end
  end
end
