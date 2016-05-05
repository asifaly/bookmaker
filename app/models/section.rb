class Section < ActiveRecord::Base
  belongs_to :chapter, dependent: :destroy
  validates :title, presence: true
end
