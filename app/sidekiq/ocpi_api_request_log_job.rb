class OcpiApiRequestLogJob
  include Sidekiq::Job

  def perform(args = {})
    CreateApiLogRequest.new(args.with_indifferent_access).perform
  end
end
