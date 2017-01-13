class PaymentPresenter
  attr_accessor :payments

  def initialize(payments)
    @payments = payments
  end

  def sum
    payments.sum(&:value)
  end
end