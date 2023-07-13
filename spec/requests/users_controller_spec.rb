require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all users to @users' do
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      get :index
      expect(assigns(:users)).to match_array([user1, user2])
    end

    it 'returns JSON data' do
      get :index
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post :create, params: { name: 'John', email: 'john@example.com', password: 'password',user_name: 'jhon23' }
        }.to change(User, :count).by(1)
      end

      it 'returns a JSON response with the new user' do
        post :create, params: { name: 'John', email: 'john@example.com', password: 'password', user_name: 'jhon23'}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to eq(User.last.to_json)
      end
    end
  end  
end  
