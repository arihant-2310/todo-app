require 'rails_helper'

describe Comment, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:content) }

    it 'is not valid if content length is less than 2 characters' do
      comment = Comment.new(content: 'x', task: Task.new, user: User.new)

      expect(comment).to_not be_valid
      expect(comment.errors.full_messages.first).to eq 'Content is too short (minimum is 2 characters)'
    end

    it 'is not valid if content length is more than 150 characters' do
      comment = Comment.new(content: 'x' * 151 , task: Task.new, user: User.new)

      expect(comment).to_not be_valid
      expect(comment.errors.full_messages.first).to eq 'Content is too long (maximum is 150 characters)'
    end

    it 'is not valid if user is not present' do
      comment = Comment.new(content: 'x' * 151 , task: Task.new)

      expect(comment).to_not be_valid
      expect(comment.errors.full_messages.first).to eq 'User must exist'
    end

    it 'is not valid if task is not present' do
      comment = Comment.new(content: 'x' * 151 , user: User.new)

      expect(comment).to_not be_valid
      expect(comment.errors.full_messages.first).to eq 'Task must exist'
    end
  end

  describe 'associations' do
    it { should belong_to(:user).class_name('User').required(true) }
    it { should belong_to(:task).class_name('Task').required(true) }
  end
end
