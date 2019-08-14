module Spree
  module Admin
    class UploadFilesController < Spree::Admin::BaseController
      def create
        file_uploader = FileUploader.call(uploaded_file_params)

        errors = file_uploader.errors
        if errors.blank?
          ProcessProductCsvFilesWorker.perform_async
          flash[:success] = I18n.t('helpers.success')
        else
          flash[:error] = errors.messages
        end
        redirect_back(fallback_location: root_path)
      end

      private

      def uploaded_file_params
        params.require(:uploaded_file).permit(:model_type, :file)
      end
    end
  end
end
