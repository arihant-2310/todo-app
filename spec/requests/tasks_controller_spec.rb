require 'rails_helper'

describe TasksController, type: :request do
  context 'with login' do
    before do
      user = User.new(uid: 'uid', provider: 'google', email: 'random@random.com', password: 'password', full_name: 'name')
      sign_in user
    end

    describe 'GET /tasks' do
      it 'renders index template with a successful response' do
        get tasks_path

        expect(response).to be_successful
        expect(response).to render_template :index
      end
    end

    describe 'GET /tasks/new' do
      it 'renders new template with a successful response' do
        get new_task_path

        expect(response).to be_successful
        expect(response).to render_template :new
      end
    end
  end

  context 'without login' do
    describe 'GET /tasks' do
      it 'does not renders index template with a successful response' do
        get tasks_path

        expect(response).to_not be_successful
        expect(response).to_not render_template :index
      end
    end

    describe 'GET /tasks/new' do
      it 'does not renders new template with a successful response' do
        get new_task_path

        expect(response).to_not be_successful
        expect(response).to_not render_template :new
      end
    end
  end
end
