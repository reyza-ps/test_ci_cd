class CreateOcpiTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_tokens, id: :uuid do |t|
      t.string :country_code
      t.string :party_id
      t.string :uid
      t.string :token_type
      t.string :contract_id
      t.string :visual_number
      t.string :issuer
      t.string :group_id
      t.boolean :is_valid
      t.string :whitelist
      t.string :language
      t.string :default_profile_type
      t.datetime :last_updated

      t.timestamps
    end
  end
end
