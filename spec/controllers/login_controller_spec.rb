require 'rails_helper'

RSpec.describe LoginController, type: :controller do

  describe 'Login' do
    context 'POST #login' do
      it 'when success' do
        create(:user, name: 'Dandi Pangestu', email: 'dandi@gmail.com', password: '1234')

        post :login, params: { email: 'dandi@gmail.com', password: '1234' }

        expect(response.status).to eq 200
        expect(response_body['data']).to include('token')
      end

      it 'when invalid credentials' do
        create(:user, name: 'Dandi Pangestu', email: 'dandi@gmail.com', password: '1234')

        post :login, params: { email: 'dand@gmail.com', password: '1234' }

        expect(response.status).to eq 401
        expect(response_body['data']['message']).to eq 'Unauthorized'
      end
    end

    def response_body
      JSON.parse(response.body)
    end
  end
end
