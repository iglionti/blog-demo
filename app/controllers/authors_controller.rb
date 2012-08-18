class AuthorsController < ApplicationController

  def create
      if new_author.save
        redirect_to new_author, :notice => 'Author was successfully created.'
      else
        render :action => "new" 
      end
  end
  
  def update
   
      if author.update_attributes(params[:author])
       redirect_to author, :notice => 'Author was successfully updated.'
      else
       render :action => "edit" 
      end
  end
    
  def destroy
    author.destroy
    redirect_to authors_url
  end
  
  def categories
    render :layout => false
  end
# Instancias
  def author
  @author ||= Author.find(params[:id]) rescue nil
  end
  helper_method :author
  
  def author_categories
    @author_categories ||= author.categories rescue []
  end
  helper_method :author_categories
  
  def authors
  @authors ||= Author.search(params[:query], params[:page])
  end
  helper_method :authors
  
  def new_author
  @new_author ||= Author.new(params[:author])
  end
  helper_method :new_author
end
