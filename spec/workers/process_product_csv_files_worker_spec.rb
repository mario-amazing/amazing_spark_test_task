require 'rails_helper'

RSpec.describe ProcessProductCsvFilesWorker, type: :worker do
  it 'creates new sidekiq job' do
    expect {
      described_class.perform_async
    }.to change(described_class.jobs, :size).by(1)
  end

  it do
    Sidekiq::Testing.inline! do
      expect(ProductCsvFilesHandler).to receive(:call)

      described_class.perform_async
    end
  end
end
