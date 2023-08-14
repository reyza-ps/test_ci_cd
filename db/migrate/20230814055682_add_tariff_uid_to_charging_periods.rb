class AddTariffUidToChargingPeriods < ActiveRecord::Migration[7.0]
  def change
    add_column :ocpi_charging_periods, :tariff_uid, :string
  end
end
