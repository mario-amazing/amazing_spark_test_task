module Spree
  module Admin
    module MyProductDecorator
      def upload_csv_files
        @uploaded_file = UploadedFile.new(model_type: Spree::Product.name)
      end
    end
  end
end

Spree::Admin::ProductsController.prepend Spree::Admin::MyProductDecorator
