require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET #index' do
    #before { get '/v1/users', headers: auth_headers(current_user) }
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'returns all books' do
      book1 = Fabricate(:book)
      book2 = Fabricate(:book)
      get :index
      expect(assigns(:books)).to eq([book1, book2])
    end
  end

  describe 'POST #create' do
    before do
      payload = { user_id: user.id, exp: 7.days.from_now.to_i }
      token = JWT.encode(payload, Rails.application.secrets.secret_key_base)
      request.headers['Authorization'] = "Bearer #{token}"
    end
    context 'with authenticated user' do
      let(:user) { Fabricate(:user) }

      before { allow(controller).to receive(:current_user).and_return(user) }

      context 'with valid params' do
        it 'creates a new book' do
          expect {
            post :create, params: { book: Fabricate.attributes_for(:book) }
          }.to change(Book, :count).by(1)
        end

        it 'assigns a newly created book as @book' do
          post :create, params: { book: Fabricate.attributes_for(:book) }
          expect(assigns(:book)).to be_a(Book)
          expect(assigns(:book)).to be_persisted
        end

        it 'returns a success response' do
          post :create, params: { book: Fabricate.attributes_for(:book) }
          expect(response).to have_http_status(:created)
        end
      end
    end  
  end
end
