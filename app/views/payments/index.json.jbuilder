json.sum @payment_presenter.sum
json.items do
  json.array! @payment_presenter.payments, partial: 'payments/payment', as: :payment
end

