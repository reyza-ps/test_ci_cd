class Partner::ApiRequestLog < LogsDb
  belongs_to :oauth_application, class_name: 'Partner::Application', foreign_key: :oauth_application_id, optional: true

  scope :by_applications, lambda { |application_ids|
    where('oauth_application_id IN (?)', application_ids)
      .where(request_type: 'incoming')
  }
  scope :by_today, lambda { |application_ids|
    by_applications(application_ids)
      .where(created_at: Time.current.beginning_of_day..Time.current.end_of_day)
      .where(request_type: 'incoming')
      .order(id: :desc)
  }
  scope :by_this_week, lambda { |application_ids|
    by_applications(application_ids)
      .where(created_at: Date.today.beginning_of_week..Date.today.end_of_week)
      .where(request_type: 'incoming')
      .order(id: :desc)
  }
  scope :by_this_months, lambda { |application_ids|
    by_applications(application_ids)
      .where(created_at: Time.current.beginning_of_month..Date.today.end_of_month)
      .where(request_type: 'incoming')
      .order(id: :desc)
  }

  # incoming : partner requesting our API
  # outgoing : we requesting partner API
  enum request_type: %i[incoming outgoing]

  def self.ransackable_attributes(_auth_object = nil)
    %w[oauth_application_name created_at description endpoint environment http_method id
       oauth_application_id request_headers request_params request_type response_body status_code updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['oauth_application']
  end
end

# == Schema Information
#
# Table name: api_request_logs
#
#  id                   :bigint           not null, primary key
#  description          :string
#  endpoint             :string
#  environment          :string
#  http_method          :string
#  request_headers      :jsonb
#  request_params       :jsonb
#  request_type         :integer
#  response_body        :jsonb
#  status_code          :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  oauth_application_id :bigint
#
# Indexes
#
#  index_api_request_logs_on_oauth_application_id_and_request_type  (oauth_application_id,request_type)
#
