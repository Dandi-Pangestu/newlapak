require 'rails_helper'

RSpec.describe ProductController, type: :controller do

  describe 'Product' do
    before(:each) do
      @user = create(:user, name: 'Dandi Pangestu', email: 'dandi@gmail.com', password: '1234')
      @token = JsonWebToken.encode(user_id: @user.id)
    end

    context 'Product #index' do
      it 'when success' do
        create_list(:product, 3)

        request.headers['Authorization'] = @token

        get :index

        expect(response.status).to eq 200
        expect(response_body).to include('data')
      end
    end

    context 'Product #show' do
      it 'when success' do
        product = create(:product)

        request.headers['Authorization'] = @token

        get :index, params: { id: product.id }

        expect(response.status).to eq 200
        expect(response_body).to include('data')
      end
    end

    def response_body
      JSON.parse(response.body)
    end
  end
end
