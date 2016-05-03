class Chapter < ActiveRecord::Base
  has_many :sections
  belongs_to :book
  validates :title, presence: true
end
