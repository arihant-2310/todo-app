require 'rails_helper'

describe Comment, type: :model do
  describe 'Validations' do
    context 'content' do
      it { should validate_presence_of(:content) }
    end
  end
end
