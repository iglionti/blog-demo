class AddSubCategoryIdToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :sub_category_id, :integer

  end
end
