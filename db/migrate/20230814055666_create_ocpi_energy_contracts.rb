class CreateOcpiEnergyContracts < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_energy_contracts, id: :uuid do |t|
      t.string :supplier_name
      t.string :contract_id
      t.uuid :ocpi_token_id

      t.timestamps
    end
  end
end
