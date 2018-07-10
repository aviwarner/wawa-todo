class ListSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :name, :private, :user_id, :items_count

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end

  def items_count
    items = Item.where("list_id = ?", object.id)
    items.length
  end
end
