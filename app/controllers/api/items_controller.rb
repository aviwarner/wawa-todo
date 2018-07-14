class Api::ItemsController < ApiController
  before_action :authenticated?

  def index
    items = Item.where("list_id = ?", params[:list_id])
    render json: items, each_serializer: ItemSerializer
  end

  def create
    item = Item.new(item_params)
    item.list_id = params[:list_id]
    if item.save
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: item
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def item_params
    params.require(:item).permit(:text, :complete)
  end
end

# curl -X PUT -u buymagicfish@gmail.com:asdfjkl -d "item[complete]=true" -d "item[text]=A completed test" http://localhost:3000/api/users/1/lists/2/
# curl -X PUT -u buymagicfish@gmail.com:asdfjkl -d "item[completed]=true" http://localhost:3000/api/items/6
# curl -u buymagicfish@gmail.com:asdfjkl http://localhost:3000/api/lists/2/items
