# frozen_string_literal: true

class DeviseCreatePartners < ActiveRecord::Migration[7.0]
  def change
    create_table :partners do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Other attribute
      t.string  :code
      t.string  :name
      t.text    :address
      t.string  :city
      t.string  :state
      t.string  :country
      t.string  :postcode
      t.text    :overview
      t.string  :registration_no
      t.string  :website_url
      t.string  :logo
      t.string  :mobile_phone
      t.string  :party_id
      t.string  :country_code
      t.float   :ocpi_percentage_fee, default: 0.0
      t.string  :charger_group_option

      t.timestamps null: false
    end

    add_index :partners, :email,                unique: true
    add_index :partners, :reset_password_token, unique: true
    add_index :partners, :confirmation_token,   unique: true
    add_index :partners, %i[party_id country_code]
    # add_index :partners, :unlock_token,         unique: true

    add_reference :partners, :user, index: true
  end
end
