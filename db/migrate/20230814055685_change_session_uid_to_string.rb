class ChangeSessionUidToString < ActiveRecord::Migration[7.0]
  def change
    change_column :ocpi_sessions, :uid, :string
    change_column :ocpi_sessions, :authorization_reference, :string
  end
end
