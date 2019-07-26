require 'rails_helper'

RSpec.describe ProfileController, type: :controller do

  describe 'Profile' do

    context 'GET #profile' do
      it 'when success'  do
        user = create(:user, name: 'Dandi Pangestu', email: 'dandi@gmail.com', password: '1234')
        token = JsonWebToken.encode(user_id: user.id)

        request.headers['Authorization'] = token

        get :show

        expect(response.status).to eq 200
        expect(response_body['data']['name']).to eq user.name
        expect(response_body['data']['email']).to eq user.email
      end
    end

    def response_body
      JSON.parse(response.body)
    end
  end
end
