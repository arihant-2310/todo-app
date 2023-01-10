require 'rails_helper'

describe TasksController, type: :request do
  describe 'GET /tasks' do
    context 'with login' do
      before do
        user = User.new(uid: 'uid', provider: 'google', email: 'random@random.com', password: 'password', full_name: 'name')
        sign_in user
        get tasks_path
      end

      it 'renders index template with a successful response' do
        expect(response).to be_successful
        expect(response).to render_template :index
      end
    end
  end
end
