class ProcessProductCsvFilesWorker
  include Sidekiq::Worker

  # It'll resolve the issue with processing huge files and will add retry functionality and multi-thread processing
  def perform
    ProductCsvFilesHandler.call
  end
end
