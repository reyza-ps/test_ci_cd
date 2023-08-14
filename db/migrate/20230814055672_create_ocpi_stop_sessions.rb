class CreateOcpiStopSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_stop_sessions, id: :uuid do |t|
      t.string :response_url
      t.string :session_id

      t.timestamps
    end
  end
end
