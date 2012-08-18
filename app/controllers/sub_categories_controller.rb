class SubCategoriesController < ApplicationController

  def create
      if new_sub_category.save
       redirect_to new_sub_category, :notice => 'Sub category was successfully created.' 
      else
       render :action => "new"       
      end
  end

  def update
      if sub_category.update_attributes(params[:sub_category])
       redirect_to sub_category, :notice => 'Sub category was successfully updated.' 
      else
        render :action => "edit"
      end
  end

  def destroy
   sub_category.destroy
   redirect_to sub_categories_url 
  end
  
# Instances
  def categories
  @categories ||= Category.all
  end
  helper_method :categories
  
  def category_id
  (params[:category]||{})[:category_id]
  end
  helper_method :category_id
      
  def new_sub_category
  @new_sub_category ||= SubCategory.new(params[:sub_category])
  end
  helper_method :new_sub_category  
  
  def sub_categories
  @sub_categories ||= SubCategory.search(params[:query], params[:page])
  end
  helper_method :sub_categories
  
  def sub_category
  @sub_category ||= SubCategory.find(params[:id])
  end
  helper_method :sub_category
     
end
