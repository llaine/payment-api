require 'rails_helper'

RSpec.describe PaymentsController do
  describe '#create' do
    before(:all) do
      Contract.create!
    end

    it 'create a payment for the right contract' do
      post :create, params: { contract_id: Contract.first.id }, format: :json
      newest_payment = Payment.last
      expect(Payment).to exist
      expect(newest_payment.contract_id).to eq(Contract.first.id)
    end
  end


  context '#index' do

  end
end
