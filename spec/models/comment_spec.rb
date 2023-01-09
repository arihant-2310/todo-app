require 'rails_helper'

describe Comment, type: :model do
  describe 'Validations' do
    context 'content' do
      it { should validate_presence_of(:content) }
    end
  end

  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:task).class_name('Task') }
  end
end
