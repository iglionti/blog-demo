class CategoriesController < ApplicationController
 
  def create
        if new_category.save
          redirect_to new_category, :notice => 'Category was successfully created.'
        else
          render :action => "new" 
        end
  end
  
  def update
   
      if category.update_attributes(params[:category])
        redirect_to category, :notice => 'Category was successfully updated.' 
      else
        render :action => "edit"
      end
  end

  def destroy
    category.destroy
    redirect_to categories_url
  end
  
  def sub_categories
    render :layout => false
  end
  
 # Instances
 
  def categories
  @categories ||= Category.search(params[:query], params[:page])
  end
  helper_method :categories
 
  def category
  @category ||= Category.find(params[:id]) rescue nil
  end
  helper_method :category
  
  def category_sub_categories
    @category_sub_categories ||= Author.find(params[:author_id]).sub_categories(params[:id])
  end
  helper_method :category_sub_categories
  
  def new_category
  @new_category ||= Category.new(params[:category])
  end
  helper_method :new_category
 
end
