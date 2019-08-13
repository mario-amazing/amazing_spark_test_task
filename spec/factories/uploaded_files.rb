 FactoryBot.define do
   factory :uploaded_file do
     status { 'pending' }
     file { File.new(Rails.root + 'spec/fixtures/csv/products/valid_product_file.csv') }
     model_type { 'Spree::Product' }
   end

   trait :with_invalid_csv_file do
     file { File.new(Rails.root + 'spec/fixtures/csv/products/invalid_product_file.csv') }
   end
 end
