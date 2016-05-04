class Chapter < ActiveRecord::Base
  has_many :sections
  belongs_to :book
  validates :title, presence: true

  before_create :set_position

   default_scope {order(position: :asc)}

   private

   def set_position
     self.position = (self.book.chapters[-2].try(:position) || 0) + 1
   end

end
