class FileUploader
  def self.call(params)
    UploadedFile.create params
  end
end
