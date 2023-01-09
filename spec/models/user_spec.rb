require 'rails_helper'

describe User, type: :model do
  describe 'associations' do
    it { should have_many(:tasks).class_name('Task').dependent(:destroy)  }
    it { should have_many(:comments).class_name('Comment').dependent(:destroy)  }
    it { should have_many(:assignments).class_name('Assignment').dependent(:destroy)  }
    it { should have_many(:assigned_tasks).through(:assignments).source(:task) }
  end

  describe 'all_tasks' do
    it 'returns only created tasks' do
      user = User.new(uid: 'uid', provider: 'google', email: 'random@random.com', password: 'password', full_name: 'name')
      task = Task.create(user:, name: 'task1', description: 'description')

      all_tasks = user.all_tasks

      expect(all_tasks.size).to eq(1)
      expect(all_tasks.first).to eq task
    end

    it 'returns only assigned tasks' do
      user1 = User.new(uid: 'uid', provider: 'google', email: 'random@random.com', password: 'password', full_name: 'name')
      user2 = User.new(uid: 'uid2', provider: 'google', email: 'random2@random.com', password: 'password', full_name: 'name2')

      task = Task.create(user: user1, name: 'task1', description: 'description')
      Assignment.create(user: user2, task:)
      all_tasks = user2.all_tasks

      expect(all_tasks.size).to eq(1)
      expect(all_tasks.first).to eq task
    end

    it 'returns all unique created and assigned tasks' do
      user = User.new(uid: 'uid', provider: 'google', email: 'random@random.com', password: 'password', full_name: 'name')

      task = Task.create(user: user, name: 'task1', description: 'description')
      Assignment.create(user: user, task:)
      all_tasks = user.all_tasks

      expect(all_tasks.size).to eq(1)
      expect(all_tasks.first).to eq task
    end
  end
end
