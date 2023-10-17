class CreatePartnerApiRequestLog < ActiveRecord::Migration[6.0]
  def change
    create_table :api_request_logs do |t|
      t.string :endpoint
      t.bigint :oauth_application_id
      t.string :environment
      t.string :description
      # request params
      t.jsonb :request_params, default: {}
      # request headers
      t.jsonb :request_headers, default: {}
      t.string :http_method

      # response body
      t.jsonb :response_body, default: {}
      t.string :status_code

      t.integer :request_type

      t.timestamps
    end
    add_index :api_request_logs, %i[oauth_application_id request_type]
  end
end
