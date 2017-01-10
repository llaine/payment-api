class Payment < ApplicationRecord
  belongs_to :contract, required: true

  scope :date_filter, -> (from_date, to_date) {
    where('time >= ? AND time <= ?', from_date, to_date)
  }
end
