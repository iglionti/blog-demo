class SubCategory < ActiveRecord::Base
  default_scope order("sub_categories.name")
  scope :with_a, where("title LIKE ?", "%a%")
  belongs_to :category
  has_many :messages
  
   validates :name,
  :presence => true,
  :uniqueness => true
  
  self.per_page = 10
   def self.search query, page
  where("sub_categories.name LIKE :query",:query => "%#{query}%").paginate(:page => page)
  end
  
end
