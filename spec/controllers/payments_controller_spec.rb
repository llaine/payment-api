require 'rails_helper'

RSpec.describe PaymentsController do

  before(:all) do
    Contract.create!
  end

  def index_payment(attributes={})
    get :index, params: { contract_id: Contract.first.id }.merge(attributes), format: :json
  end

  def create_payment(attributes={})
    post :create, params: { contract_id: Contract.first.id }.merge(attributes), format: :json
  end

  def edit_payment(attributes)
    put :update, params: { contract_id: Contract.first.id }.merge(attributes), format: :json
  end

  def delete_payment(attributes)
    delete :destroy, params: { contract_id: Contract.first.id }.merge(attributes), format: :json
  end


  describe '#index' do
    it 'get list of payment' do
      2.times { create_payment(value:100) }
      index_payment

      expect(assigns(:payments).length).to eq(2)
      expect(assigns(:payment_presenter).sum).to eq(200)
      expect(assigns(:payment_presenter).payments.count).to eq(2)
    end


    describe 'takes two optionnals parameters to filter by date' do
      before(:each) do
        create_payment(time: 1.months.ago)
        create_payment(time: 2.months.ago)
        create_payment(time: 3.months.ago)
      end

      it 'works' do
        index_payment(from: 1.months.ago, to: Date.today)
        expect(assigns(:payments).length).to eq(1)
      end

      it 'works' do
        index_payment(from: 2.months.ago, to: Date.today)
        expect(assigns(:payments).length).to eq(2)
      end

      it 'works' do
        index_payment(from: 3.months.ago, to: Date.today)
        expect(assigns(:payments).length).to eq(3)
      end

      it 'works' do
        index_payment(from: 3.months.ago, to: 2.months.ago)
        expect(assigns(:payments).length).to eq(2)
      end

      it 'works' do
        index_payment(from: 3.months.ago, to: 1.months.ago)
        expect(assigns(:payments).length).to eq(3)
      end

      it 'works' do
        index_payment(from: 3.months.ago, to: 3.months.ago)
        expect(assigns(:payments).length).to eq(1)
      end

      it 'works' do
        index_payment(from: 5.months.ago, to: 6.months.ago)
        expect(assigns(:payments).length).to eq(0)
      end
    end
  end

  describe '#create' do
    it 'create a payment for the right contract' do
      create_payment

      newest_payment = Payment.last
      expect(Payment).to exist
      expect(newest_payment.contract_id).to eq(Contract.first.id)
    end
  end

  describe '#update' do
    it 'update a current payment' do
      create_payment(value:100)
      newest_payment = Payment.last

      new_value = 300
      edit_payment(id: newest_payment.id, value: new_value)

      newest_payment_after_update = Payment.find(newest_payment.id)
      expect(newest_payment_after_update.value).to eq(new_value)
    end
  end

  describe '#delete' do
    it 'remove a current payment' do
      create_payment
      newest_payment = Payment.last

      delete_payment(id: newest_payment.id)

      expect {
        Payment.find(newest_payment.id)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
