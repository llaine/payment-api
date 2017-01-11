require 'rails_helper'

RSpec.describe PaymentPresenter do
  describe '#payments' do
    it 'has a payment parameter' do
      payments = [{value: 1}, {value: 2}]
      p = PaymentPresenter.new(payments)

      expect(p.payments).to eq(payments)
    end
  end

  describe '#sum' do
    it 'sum all the payment\'s value' do
      payments = [Payment.new(value: 1), Payment.new(value: 2)]
      p = PaymentPresenter.new(payments)

      expect(p.sum).to eq(3)
    end

    it 'works with negative values' do
      payments = [Payment.new(value: 100), Payment.new(value: -100)]
      p = PaymentPresenter.new(payments)

      expect(p.sum).to eq(0)
    end
  end
end
