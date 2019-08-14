class ProcessProductCsvFilesWorker
  include Sidekiq::Worker

  def perform
    ProductCsvFilesHandler.call
  end
end
