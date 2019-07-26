require 'rails_helper'

RSpec.describe RegisterController, type: :controller do

  describe 'Register' do
    context 'POST #register' do
      it 'when email already exists' do
        create(:user, email: 'dandi@gmail.com')

        post :register, params: { user: { name: 'Dandi Pangestu', email: 'dandi@gmail.com', password: '123' } }

        expect(response.status).to eq 422
        expect(response_body['data']['message']).to eq 'Email already exists'
      end

      it 'when error bad request' do
        post :register, params: { user: { email: 'dandi@gmail.com', password: '123' } }

        expect(response.status).to eq 400
      end

      it 'when success' do
        post :register, params: { user: { name: 'Dandi Pangestu', email: 'dandi@gmail.com', password: '123' } }

        expect(response.status).to eq 200
        expect(response_body['data']).to include('token')
      end
    end

    def response_body
      JSON.parse(response.body)
    end
  end
end
