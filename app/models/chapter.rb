class Chapter < ActiveRecord::Base
  has_many :sections
  belongs_to :book
  validates :title, presence: true

  before_create :set_position

   default_scope {order(position: :asc)}

  def sorted_section_ids=(ids_array)
    ids_array = JSON.parse(ids_array)
    grouped_sections = self.sections.where(id: ids_array).group_by(&:id)
    index_no = 1
    ids_array.each do |section_id|
      section_id = section_id.to_i
      section = grouped_sections[section_id][0]
      section.update_attribute(:position, index_no)

      index_no += 1
    end
  end

   private

   def set_position
     self.position = (self.book.chapters[-2].try(:position) || 0) + 1
   end

end
