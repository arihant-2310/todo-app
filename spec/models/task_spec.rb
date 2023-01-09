require 'rails_helper'

describe Task, type: :model do
  describe 'Validations' do
    context 'name' do
      it { should validate_presence_of(:name) }
      it { should validate_length_of(:name).is_at_least(3) }
      it { should validate_length_of(:name).is_at_most(50) }
    end

    context 'description' do
      it { should validate_length_of(:description).is_at_least(10) }
      it { should validate_length_of(:description).is_at_most(150) }
    end

    context 'status' do
      it { should define_enum_for(:status).with_values({ not_started: 0, in_progress: 1, blocked: 2, done: 3 }) }
    end
  end

  describe 'associations' do
    it { should belong_to(:user).class_name('User').required(true) }
    it { should have_many(:comments).class_name('Comment').dependent(:destroy)  }
    it { should have_many(:assignments).class_name('Assignment').dependent(:destroy)  }
    it { should have_many(:assignees).through(:assignments).source(:user) }
    it { should accept_nested_attributes_for(:assignments).allow_destroy(true) }
  end
end
