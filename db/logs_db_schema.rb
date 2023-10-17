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

ActiveRecord::Schema[7.1].define(version: 20_230_310_064_430) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'api_request_logs', force: :cascade do |t|
    t.string 'endpoint'
    t.bigint 'oauth_application_id'
    t.string 'environment'
    t.string 'description'
    t.jsonb 'request_params', default: {}
    t.jsonb 'request_headers', default: {}
    t.string 'http_method'
    t.jsonb 'response_body', default: {}
    t.string 'status_code'
    t.integer 'request_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[oauth_application_id request_type],
            name: 'index_api_request_logs_on_oauth_application_id_and_request_type'
  end
end
