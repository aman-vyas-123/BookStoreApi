class Book < ApplicationRecord
  validates :title, :author, :price, presence: true
  validates :title, uniqueness: true
  validates :price,  numericality: { greater_than: 0 }
  belongs_to :user

  scope :published_in_last_year, -> { where("published_at >= ?", 1.year.ago) }
end
