class MessagesController < ApplicationController

  def create
    if new_message.save
      redirect_to new_message, :notice => 'Message was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    if message.update_attributes(params[:message])
      redirect_to message, :notice => 'Message was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    message.destroy
    redirect_to messages_url
  end
  
  # Instancias y Helpers(lo ve la vista)
  def authors
    @authors ||= Author.all
  end
  helper_method :authors
  
  def categories
    @categories ||= Category.all
  end
  helper_method :categories
  
  def message
    @message ||= Message.find(params[:id])
  end
   helper_method :message
   
  def messages
    @messages ||= Message.search(message_query, message_author_id, message_category_id, message_sub_category_id, params[:page])
  end
  helper_method :messages
   
  def message_author_id
    (params[:message]||{})[:author_id]
  end
  helper_method :message_author_id
  
  def message_author_categories
    @message_author_categories ||= Author.find(message_author_id).categories rescue []
  end
  helper_method :message_author_categories
  
  def message_category_id
    (params[:message]||{})[:category_id]
  end
  helper_method :message_category_id
  
  def message_category_sub_categories
    message.category.sub_categories rescue []
  end
  helper_method :message_category_sub_categories
  
  def message_query
    (params[:message]||{})[:query]
  end
  helper_method :message_query
  
  def message_sub_category_id
  (params[:message]||{})[:sub_category_id]
  end
  helper_method :message_sub_category_id
  
  def new_message
    @new_message ||= Message.new(params[:message])
  end
  helper_method :new_message
  
  def sub_categories
    @sub_categories ||= SubCategory.where(:category_id => message_category_id)
  end
  helper_method :sub_categories

end
