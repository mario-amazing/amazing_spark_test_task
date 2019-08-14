require "csv"

class ProductCsvFilesHandler
  class << self
    CSV_SPLITER = ';'.freeze

    def call
      # find_each will resolve out of memory issue
      UploadedFile.pending.find_each do |uploaded_file|
        ActiveRecord::Base.transaction do
          # using the pessimistic lock to prevent the multi-trading issue. Alternative
          # variant is optimistic lock(depends on the task)
          uploaded_file.lock!
          uploaded_file.update_attributes(status: 'in_progress')

          handle_products(uploaded_file.file.path)

          uploaded_file.update_attributes(status: 'processed')
        end

      rescue StandardError => e
        # Could be moved into transaction if need anyway process file with
        # errors
        uploaded_file.update_attributes(status: 'error')
      end
    end

    private

    def handle_products(file_path)
      # foreach will resolve "handle huge files without freezing the whole app for hours"
      CSV.foreach(file_path, headers: true, header_converters: :symbol, col_sep: CSV_SPLITER) do |row|
        shipping_category = Spree::ShippingCategory.find_or_create_by(name: 'test_task')
        product = Spree::Product.create!(
          name: row[:name],
          description: row[:description],
          slug: row[:slug],
          available_on: row[:availability_date],
          price: row[:price],
          shipping_category: shipping_category
        )
        product.variants.create(
          cost_price: row[:price]
        )
      end
    end
  end
end
