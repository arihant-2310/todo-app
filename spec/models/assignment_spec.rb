require 'rails_helper'

describe Assignment, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User').required(true) }
    it { should belong_to(:task).class_name('Task').required(true) }
  end
end
