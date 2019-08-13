module Spree
  module Admin
    module ProductDecorator
      def upload_csv_files
      end
    end
  end
end

Spree::Admin::ProductsController.prepend Spree::Admin::ProductDecorator
