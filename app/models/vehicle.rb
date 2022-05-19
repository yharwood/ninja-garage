class Vehicle < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo

  CATEGORIES = ['Itasha', 'Decotora', 'Bosozoku_Bike']

  validates :brand, presence: true
  validates :model, presence: true
  validates :category, inclusion: { in: CATEGORIES }
  validates :location, presence: true
  validates :price, presence: true
  validates :description, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_category_and_location,
    against: [:category],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
