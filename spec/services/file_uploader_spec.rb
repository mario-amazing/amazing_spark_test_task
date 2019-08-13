require 'rails_helper'

RSpec.describe FileUploader do
  describe '.call' do
    let(:csv_file) { File.new(Rails.root + 'spec/fixtures/csv/products/sample.csv') }

    let(:params) do
      {
        model_type: 'SampleType',
        file: csv_file
      }
    end
    subject { described_class.call(params) }

    context 'with valid params' do
      it { expect{ subject.errors.full_messages }.to change{ UploadedFile.count}.from(0).to(1) }
    end

    context 'with invalid params' do
      let(:params) {}
      let(:expected_errors) { ["File can't be blank", "Model type can't be blank"] }

      it { expect(subject.errors.full_messages).to eq(expected_errors) }
    end
  end
end
