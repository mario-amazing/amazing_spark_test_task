class CreateUploadedFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :uploaded_files do |t|
      t.string :model_type
      t.attachment :file
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
