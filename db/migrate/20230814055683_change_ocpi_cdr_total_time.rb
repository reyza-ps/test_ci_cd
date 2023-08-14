class ChangeOcpiCdrTotalTime < ActiveRecord::Migration[7.0]
  def change
    change_column :ocpi_cdrs, :total_energy, :float
    change_column :ocpi_cdrs, :total_time, :float
    change_column :ocpi_cdrs, :total_parking_time, :float
  end
end
