require 'rails_helper'

describe User, type: :model do
  describe 'associations' do
    it { should have_many(:tasks).class_name('Task').dependent(:destroy)  }
    it { should have_many(:comments).class_name('Comment').dependent(:destroy)  }
    it { should have_many(:assignments).class_name('Assignment').dependent(:destroy)  }
    it { should have_many(:assigned_tasks).through(:assignments).source(:task) }
  end
end
