class Book < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :title, uniqueness: { scope: :user_id, message: "The same book can't be added more than once by the same owner" }, presence: true
  validates :ISBN, presence: true
  validates :category, inclusion: { in: ["Kids", "Romance", "Sci-Fi and Fantasy", "Non-fiction", "Classics", "Comics", "Mystery and Crime"], allow_nil: false}, presence: true

  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end
end
