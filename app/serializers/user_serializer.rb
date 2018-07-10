class UserSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :email, :lists_count

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end

  def lists_count
    lists = List.where("user_id = ?", object.id)
    lists.length
  end
end
