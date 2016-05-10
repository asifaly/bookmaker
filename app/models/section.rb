class Section < ActiveRecord::Base
  belongs_to :chapter, dependent: :destroy
  validates :title, presence: true

  before_create :set_position

  default_scope {order(position: :asc)}

  private

   def set_position
     self.position = (self.chapter.sections[-2].try(:position) || 0) + 1
   end
end
