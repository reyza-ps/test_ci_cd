class CreateOcpiCdrTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_cdr_tokens, id: :uuid do |t|
      t.string :uid
      t.string :country_code
      t.string :party_id
      t.string :token_type
      t.string :contract_id
      t.uuid :cdrtokenable_id
      t.string :cdrtokenable_type

      t.timestamps
    end
  end
end
