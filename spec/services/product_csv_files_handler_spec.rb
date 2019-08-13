require 'rails_helper'

RSpec.describe ProductCsvFilesHandler do
  describe '.call' do
    let!(:uploaded_file) { FactoryBot.create(:uploaded_file) }

    subject { described_class.call }

    context 'with valid cvs file' do
      it 'correctly sets product and related models' do
        expect{ subject }
          .to change { Spree::ShippingCategory.count }.from(0).to(1)
          .and change { Spree::Product.count }.from(0).to(3)
          .and change { Spree::Variant.count }.from(0).to(3)
      end
    end

    context 'with invalid cvs file' do
      let!(:uploaded_file) { FactoryBot.create(:uploaded_file, :with_invalid_csv_file) }

      it 'reverts changes with AR transaction' do
        expect{ subject }
          .to not_change { Spree::ShippingCategory.count }
          .and not_change { Spree::Product.count }
          .and not_change { Spree::Variant.count }
      end
    end
  end
end
