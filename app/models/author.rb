class Author < ActiveRecord::Base

  default_scope order("authors.name")
  has_many :messages, :dependent => :destroy

  validates :name,
    :presence => true

  validates :email,
    :presence => true,
    :uniqueness => true

  validates :phone,
    :presence => true
    

  delegate :size, :to => :messages, :prefix => true
  self.per_page = 10
  
# Agrego imagen.
   has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  def has_image?
    self.image.attachment_file_name ? true : false rescue false
#    (!self.image.blank?||self.image.file?) rescue false
  end

  def categories
    self.messages.map(&:category).
      compact. # Saco los nil
      uniq. # No repite
      sort_by(&:name) rescue []
  end  
  
  def sub_categories category_id
    self.categories.detect{|category| category_id.to_i == category.id}. # Traigo la categoria actual
    sub_categories. # Sub categorias
    flatten. # Junto los sub-arrays
    compact.uniq.reject{|sub_category| sub_category.blank?}.sort_by(&:name) rescue []
  end
  
  def self.search query, page
    where("authors.name LIKE :query OR authors.email LIKE :query" ,:query => "%#{query}%").paginate(:page => page)
  end

  def image_url(style=:large)
    self.image.url(style) rescue nil
  end

  def thumb
    image_url(:thumb)
  end

  def small
    image_url(:small)
  end

  def large
    image_url(:large)
  end

  def flash_thumb
    image_url(:flash_thumb)
  end
end
