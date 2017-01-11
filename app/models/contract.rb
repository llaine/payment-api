class Contract < ApplicationRecord
  has_many :payments, dependent: :destroy
end
