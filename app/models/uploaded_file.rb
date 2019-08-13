class UploadedFile < ApplicationRecord
  has_attached_file :file
  validates :file, :model_type, presence: true

  enum status: { pending: 0, in_progress: 1, processed: 2, error: -1 }
  validates_attachment_content_type :file, content_type: ['text/plain', 'text/csv', 'application/vnd.ms-excel']
end
