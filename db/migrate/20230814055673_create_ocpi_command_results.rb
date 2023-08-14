class CreateOcpiCommandResults < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_command_results, id: :uuid do |t|
      t.string :result

      t.timestamps
    end
  end
end
