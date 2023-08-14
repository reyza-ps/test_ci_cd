class ChangeOcpiCdrLocationCdrId < ActiveRecord::Migration[7.0]
  def change
    change_column :ocpi_cdr_locations, :cdr_id, 'uuid USING CAST(cdr_id AS uuid)'
  end
end
