class Message < ActiveRecord::Base

  # Ordenado alfabeticamente para .all
  default_scope includes(:author).order("authors.name, messages.title")
  scope :with_a, where("title LIKE ?", "%a%")
  
  #Relaciones
  belongs_to :author
  belongs_to :category
  belongs_to :sub_category
  
  #Validaciones
  validates :title,
    :presence => true,
    :uniqueness => true

  validates :content,
    :presence => true

  validates :author_id,
    :presence => true
    
  #Delegates
  delegate :name, :to => :author, :prefix => true
  delegate :name, :to => :category, :prefix => true
  delegate :name, :to => :sub_category, :prefix => true
  delegate :sub_categories, :to => :category, :prefix => true
  
  #Paginacion
  self.per_page = 10
  
  #Search
  def self.search query, author_id, category_id, sub_category_id, page
    results = where("messages.title LIKE :query OR messages.content LIKE :query", :query => "%#{query}%")
    results = results.where(:author_id => author_id) unless author_id.to_i.zero?
    results = results.where(:category_id => category_id) unless category_id.to_i.zero?
    results = results.where(:sub_category_id => sub_category_id) unless sub_category_id.to_i.zero?
    results.paginate(:page => page)
  end
end
