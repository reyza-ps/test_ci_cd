# frozen_string_literal: true

class CreateOcpiCredentialRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_credential_roles, id: :uuid do |t|
      t.uuid :credential_id
      t.uuid :role_id
      t.uuid :business_detail_id

      t.timestamps
    end
  end
end
