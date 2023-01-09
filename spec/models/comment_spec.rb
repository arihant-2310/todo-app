require 'rails_helper'

describe Comment, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_least(2) }
    it { should validate_length_of(:content).is_at_most(150) }
  end

  describe 'associations' do
    it { should belong_to(:user).class_name('User').required(true) }
    it { should belong_to(:task).class_name('Task').required(true) }
  end
end
