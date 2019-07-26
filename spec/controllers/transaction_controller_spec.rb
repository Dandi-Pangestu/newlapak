require 'rails_helper'

RSpec.describe TransactionController, type: :controller do

  describe 'Transaction' do
    before(:each) do
      @user = create(:user, name: 'Dandi Pangestu', email: 'dandi@gmail.com', password: '1234')
      @token = JsonWebToken.encode(user_id: @user.id)

      @product1 = create(:product, stock: 200)
      @product2 = create(:product, stock: 100)
    end

    context 'Transaction #store' do
      it 'when qty doesnt insufficient' do
        request.headers['Authorization'] = @token

        post :store, params: { transaction: { items: [ { product_id: @product1.id, qty: 290 } ] } }

        expect(response.status).to eq 422
        expect(response_body['data']['messages'][0]).to eq 'Qty ' + @product1.name + ' doesnt insufficient'
      end

      it 'when success' do
        request.headers['Authorization'] = @token

        post :store, params: { transaction: { items: [ { product_id: @product1.id, qty: 100 } ] } }

        expect(response.status).to eq 200
        expect(response_body['data']['message']).to eq 'Success'
      end
    end

    context 'Transaction #cancel' do
      it 'when status is not pending' do
        request.headers['Authorization'] = @token

        post :store, params: { transaction: { items: [ { product_id: @product1.id, qty: 100 } ] } }

        current_transaction = Transaction.first
        current_transaction.status = 1
        current_transaction.save!

        post :cancel, params: { id: current_transaction.id }

        expect(response.status).to eq 422
        expect(response_body['data']['message']).to eq 'Transaction must be pending'
      end

      it 'when success' do
        request.headers['Authorization'] = @token

        post :store, params: { transaction: { items: [ { product_id: @product1.id, qty: 100 } ] } }

        current_transaction = Transaction.first

        post :cancel, params: { id: current_transaction.id }

        expect(response.status).to eq 200
        expect(response_body['data']['message']).to eq 'Success'
      end
    end

    def response_body
      JSON.parse(response.body)
    end
  end
end
