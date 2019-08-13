require 'rails_helper'

RSpec.describe UploadedFile, type: :model do
  context 'validates' do
    it { should validate_presence_of(:file) }
    it { should validate_presence_of(:model_type) }

    it { should have_attached_file(:file) }
  end
end

