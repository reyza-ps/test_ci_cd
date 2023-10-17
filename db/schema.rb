# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_230_821_080_409) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'
  enable_extension 'uuid-ossp'

  create_table 'countries', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'developer_partners', force: :cascade do |t|
    t.bigint 'partner_id'
    t.bigint 'application_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['application_id'], name: 'index_developer_partners_on_application_id'
    t.index ['partner_id'], name: 'index_developer_partners_on_partner_id'
  end

  create_table 'oauth_access_grants', force: :cascade do |t|
    t.bigint 'resource_owner_id', null: false
    t.bigint 'application_id', null: false
    t.string 'token', null: false
    t.integer 'expires_in', null: false
    t.text 'redirect_uri', null: false
    t.string 'scopes', default: '', null: false
    t.datetime 'created_at', null: false
    t.datetime 'revoked_at'
    t.index ['application_id'], name: 'index_oauth_access_grants_on_application_id'
    t.index ['resource_owner_id'], name: 'index_oauth_access_grants_on_resource_owner_id'
    t.index ['token'], name: 'index_oauth_access_grants_on_token', unique: true
  end

  create_table 'oauth_access_tokens', force: :cascade do |t|
    t.bigint 'resource_owner_id'
    t.bigint 'application_id', null: false
    t.string 'token', null: false
    t.string 'refresh_token'
    t.integer 'expires_in'
    t.string 'scopes'
    t.datetime 'created_at', null: false
    t.datetime 'revoked_at'
    t.string 'previous_refresh_token', default: '', null: false
    t.string 'ocpi_credentials_id'
    t.integer 'oauth_access_grant_id'
    t.index ['application_id'], name: 'index_oauth_access_tokens_on_application_id'
    t.index ['refresh_token'], name: 'index_oauth_access_tokens_on_refresh_token', unique: true
    t.index ['resource_owner_id'], name: 'index_oauth_access_tokens_on_resource_owner_id'
    t.index ['token'], name: 'index_oauth_access_tokens_on_token', unique: true
  end

  create_table 'oauth_applications', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'uid', null: false
    t.string 'secret', null: false
    t.text 'redirect_uri', null: false
    t.string 'scopes', default: '', null: false
    t.boolean 'confidential', default: true, null: false
    t.integer 'owner_id'
    t.string 'owner_type'
    t.boolean 'approved_by_admin', default: false
    t.string 'payment_gateway_webhook'
    t.string 'status_notification_webhook'
    t.string 'credentials_token_a'
    t.string 'ocpi_version_endpoint'
    t.integer 'ocpi_validation_status', default: 0
    t.boolean 'receive_push_model', default: true
    t.string 'payment_webhook_key'
    t.string 'payment_webhook_secret'
    t.string 'status_notification_webhook_key'
    t.string 'status_notification_webhook_secret'
    t.string 'environment', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[owner_id owner_type], name: 'index_oauth_applications_on_owner_id_and_owner_type'
    t.index ['uid'], name: 'index_oauth_applications_on_uid', unique: true
  end

  create_table 'ocpi_additional_geo_locations', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'latitude'
    t.string 'longitude'
    t.uuid 'ocpi_display_text_id'
    t.uuid 'ocpi_location_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_business_details', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.string 'website'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_cdr_dimensions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'dimension_type'
    t.float 'volume'
    t.uuid 'ocpi_charging_period_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_cdr_locations', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'uid'
    t.uuid 'cdr_id'
    t.string 'name'
    t.string 'address'
    t.string 'city'
    t.string 'state'
    t.string 'postal_code'
    t.string 'country'
    t.string 'evse_uid'
    t.string 'evse_id'
    t.string 'connector_id'
    t.string 'connector_standard'
    t.string 'connector_format'
    t.string 'connector_power_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_cdr_price_components', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'cdr_tariff_element_id'
    t.string 'type'
    t.float 'price'
    t.float 'vat'
    t.integer 'step_size'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_cdr_tariff_elements', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'cdr_tariff_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_cdr_tariff_restrictions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'cdr_tariff_element_id'
    t.string 'start_time'
    t.string 'end_time'
    t.string 'start_date'
    t.string 'end_date'
    t.float 'min_kwh'
    t.float 'max_kwh'
    t.float 'min_current'
    t.float 'max_current'
    t.float 'min_power'
    t.float 'max_power'
    t.integer 'min_duration'
    t.integer 'max_duration'
    t.string 'day_of_week', default: [], array: true
    t.string 'reservation'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_cdr_tariffs', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'party_id', limit: 3, null: false
    t.string 'country_code', limit: 2, null: false
    t.string 'currency'
    t.string 'type'
    t.string 'tariff_alt_url'
    t.datetime 'start_date_time'
    t.datetime 'end_date_time'
    t.datetime 'last_updated', null: false
    t.string 'uid'
    t.string 'cdr_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_cdr_tokens', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'uid'
    t.string 'country_code'
    t.string 'party_id'
    t.string 'token_type'
    t.string 'contract_id'
    t.uuid 'cdrtokenable_id'
    t.string 'cdrtokenable_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_cdrs', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'party_id', limit: 3, null: false
    t.string 'country_code', limit: 2, null: false
    t.datetime 'start_date_time'
    t.datetime 'end_date_time'
    t.string 'session_id'
    t.string 'auth_method'
    t.string 'authorization_reference'
    t.string 'meter_id'
    t.string 'currency'
    t.float 'total_energy'
    t.float 'total_time'
    t.float 'total_parking_time'
    t.string 'remark'
    t.string 'invoice_reference_id'
    t.boolean 'credit'
    t.integer 'credit_reference_id'
    t.boolean 'home_charging_compensation'
    t.datetime 'last_updated', null: false
    t.string 'uid'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_charging_periods', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.datetime 'start_date_time'
    t.uuid 'tariff_id'
    t.uuid 'charging_periodable_id'
    t.string 'charging_periodable_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'tariff_uid'
  end

  create_table 'ocpi_client_infos', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'country_code'
    t.string 'party_id'
    t.string 'role'
    t.string 'status'
    t.datetime 'last_updated'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_command_results', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'result'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_connectors', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'ocpi_evse_id'
    t.string 'uid'
    t.string 'standard'
    t.string 'format'
    t.string 'power_type'
    t.integer 'max_voltage'
    t.integer 'max_amperage'
    t.integer 'max_electric_power'
    t.string 'tariff_ids', default: [], array: true
    t.string 'terms_and_conditions'
    t.datetime 'last_updated'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_credential_roles', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'credential_id'
    t.uuid 'role_id'
    t.uuid 'business_detail_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_credentials', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'token'
    t.string 'url'
    t.boolean 'token_a', default: true
    t.string 'token_b'
    t.text 'expected_identifiers', default: [], array: true
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_display_texts', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'language'
    t.text 'text'
    t.uuid 'displaytextable_id'
    t.string 'displaytextable_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_endpoints', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'ocpi_version_detail_id'
    t.string 'identifier', null: false
    t.string 'role', null: false
    t.string 'url', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_energy_contracts', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'supplier_name'
    t.string 'contract_id'
    t.uuid 'ocpi_token_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_energy_mixs', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.boolean 'is_green_energy'
    t.string 'supplier_name'
    t.string 'energy_product_name'
    t.uuid 'energy_mixable_id'
    t.string 'energy_mixable_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_energy_sources', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'source'
    t.float 'percentage'
    t.uuid 'ocpi_energy_mix_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_environmental_impacts', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'category'
    t.float 'amount'
    t.uuid 'ocpi_energy_mix_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_evses', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'ocpi_location_id'
    t.string 'uid'
    t.string 'evse_id'
    t.string 'status'
    t.string 'capabilities', default: [], array: true
    t.string 'floor_level'
    t.string 'physical_reference'
    t.string 'parking_restrictions', default: [], array: true
    t.datetime 'last_updated'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_exceptional_periods', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.datetime 'period_begin'
    t.datetime 'period_end'
    t.uuid 'ocpi_hour_id'
    t.string 'period_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_geo_locations', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'latitude'
    t.string 'longitude'
    t.uuid 'coordinateable_id'
    t.string 'coordinateable_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_hours', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'ocpi_location_id'
    t.boolean 'twentyfourseven'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_images', force: :cascade do |t|
    t.string 'url'
    t.string 'thumbnail'
    t.integer 'category'
    t.string 'type'
    t.integer 'width'
    t.integer 'height'
    t.string 'imageable_type'
    t.string 'imageable_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_locations', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'uid'
    t.string 'party_id'
    t.string 'country_code'
    t.boolean 'publish'
    t.string 'name'
    t.string 'address'
    t.string 'city'
    t.string 'state'
    t.string 'postal_code'
    t.string 'country'
    t.string 'parking_type'
    t.uuid 'operator_id'
    t.uuid 'sub_operator_id'
    t.uuid 'owner_id'
    t.string 'facilities', default: [], array: true
    t.string 'time_zone'
    t.boolean 'charging_when_closed'
    t.datetime 'last_updated'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_price_components', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'tariff_element_id'
    t.string 'type'
    t.float 'price'
    t.float 'vat'
    t.integer 'step_size'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_prices', force: :cascade do |t|
    t.float 'excl_vat'
    t.float 'incl_vat'
    t.uuid 'priceable_id'
    t.string 'priceable_type'
    t.string 'price_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_publish_token_types', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'token_type'
    t.string 'visual_number'
    t.string 'issuer'
    t.uuid 'group_id'
    t.uuid 'ocpi_location_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_regular_hours', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'ocpi_hour_id'
    t.integer 'weekday'
    t.string 'period_begin'
    t.string 'period_end'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_roles', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'role'
    t.string 'party_id'
    t.string 'country_code'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_sessions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'uid'
    t.string 'country_code'
    t.string 'party_id'
    t.datetime 'start_date_time'
    t.datetime 'end_date_time'
    t.float 'kwh'
    t.string 'auth_method'
    t.string 'authorization_reference'
    t.string 'location_id'
    t.string 'evse_uid'
    t.string 'connector_id'
    t.string 'meter_id'
    t.string 'currency'
    t.string 'status'
    t.datetime 'last_updated'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_signed_data', force: :cascade do |t|
    t.string 'cdr_id'
    t.string 'encoding_method'
    t.integer 'encoding_method_version'
    t.string 'public_key'
    t.string 'url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_signed_values', force: :cascade do |t|
    t.string 'signed_data_id'
    t.text 'nature'
    t.text 'plain_data'
    t.text 'blob_signed_data'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_start_sessions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'response_url'
    t.uuid 'ocpi_token_id'
    t.string 'location_id'
    t.string 'evse_uid'
    t.string 'connector_id'
    t.string 'authorization_reference'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_status_schedules', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.datetime 'period_begin'
    t.datetime 'period_end'
    t.string 'status'
    t.uuid 'ocpi_evse_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_stop_sessions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'response_url'
    t.string 'session_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_tariff_elements', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'tariff_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_tariff_restrictions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'tariff_element_id'
    t.string 'start_time'
    t.string 'end_time'
    t.string 'start_date'
    t.string 'end_date'
    t.float 'min_kwh'
    t.float 'max_kwh'
    t.float 'min_current'
    t.float 'max_current'
    t.float 'min_power'
    t.float 'max_power'
    t.integer 'min_duration'
    t.integer 'max_duration'
    t.string 'day_of_week', default: [], array: true
    t.string 'reservation'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_tariffs', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'party_id', limit: 3, null: false
    t.string 'country_code', limit: 2, null: false
    t.string 'currency'
    t.string 'type'
    t.string 'tariff_alt_url'
    t.datetime 'start_date_time'
    t.datetime 'end_date_time'
    t.datetime 'last_updated', null: false
    t.string 'uid'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_tokens', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'country_code'
    t.string 'party_id'
    t.string 'uid'
    t.string 'token_type'
    t.string 'contract_id'
    t.string 'visual_number'
    t.string 'issuer'
    t.string 'group_id'
    t.boolean 'is_valid'
    t.string 'whitelist'
    t.string 'language'
    t.string 'default_profile_type'
    t.datetime 'last_updated'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_version_details', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'ocpi_version_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ocpi_versions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'version', limit: 10, null: false
    t.string 'url', limit: 255, null: false
    t.uuid 'ocpi_credential_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'partners', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.string 'code'
    t.string 'name'
    t.text 'address'
    t.string 'city'
    t.string 'state'
    t.string 'country'
    t.string 'postcode'
    t.text 'overview'
    t.string 'registration_no'
    t.string 'website_url'
    t.string 'logo'
    t.string 'mobile_phone'
    t.string 'party_id'
    t.string 'country_code'
    t.float 'ocpi_percentage_fee', default: 0.0
    t.string 'charger_group_option'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.index ['confirmation_token'], name: 'index_partners_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_partners_on_email', unique: true
    t.index %w[party_id country_code], name: 'index_partners_on_party_id_and_country_code'
    t.index ['reset_password_token'], name: 'index_partners_on_reset_password_token', unique: true
    t.index ['user_id'], name: 'index_partners_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.integer 'failed_attempts', default: 0, null: false
    t.string 'unlock_token'
    t.datetime 'locked_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['unlock_token'], name: 'index_users_on_unlock_token', unique: true
  end

  add_foreign_key 'oauth_access_grants', 'oauth_applications', column: 'application_id'
  add_foreign_key 'oauth_access_grants', 'partners', column: 'resource_owner_id'
  add_foreign_key 'oauth_access_tokens', 'oauth_applications', column: 'application_id'
  add_foreign_key 'oauth_access_tokens', 'partners', column: 'resource_owner_id'
end
