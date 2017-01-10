class PaymentPresenter
  attr_accessor :payments

  def initialize(payments)
    @payments = payments
  end

  def sum
    payments.map(&:value).map(&:to_i).reduce(0, :+)
  end
end