class Category < ActiveRecord::Base

# Ordenado
  default_scope order("categories.name")
  scope :with_a, where("title LIKE ?", "%a%")
  has_many :messages
  has_many :sub_categories
  has_many :authors 
# Validaciones
  validates :name,
  :presence => true,
  :uniqueness => true
# Paginacion 
  self.per_page = 10
# Buscador
  def self.search query, page
  where("categories.name LIKE :query",:query => "%#{query}%").paginate(:page => page)
  end
end
