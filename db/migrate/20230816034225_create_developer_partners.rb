class CreateDeveloperPartners < ActiveRecord::Migration[7.0]
  def change
    create_table :developer_partners do |t|
      t.references :partner, index: true
      t.references :application, index: true
      t.timestamps
    end
  end
end
