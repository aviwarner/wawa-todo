class Api::ListsController < ApiController
  before_action :authenticated?

  def create
    list = List.new(list_params)
    list.user_id = params[:user_id]
    if list.save
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    list = List.find(params[:id])
    if list.update(list_params)
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      list = List.find(params[:id])
      list.destroy
      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render json: { "error": "List not found" }, status: :not_found
    end
  end

  private
  def list_params
    params.require(:list).permit(:name, :private)
  end
end

#  tests
# curl -u buymagicfish@gmail.com:asdfjkl -X DELETE http://localhost:3000/api/users/1/lists/1/
# curl -X PUT -u buymagicfish@gmail.com:asdfjkl -d 'list[private]=true' http://localhost:3000/api/users/1/lists/2/
# curl -X PUT -u buymagicfish@gmail.com:asdfjkl -d "list[private]=false" http://localhost:3000/api/users/1/lists/2/
# curl -X PUT -u buymagicfish@gmail.com:asdfjkl -d '{ "list[private]": true }' http://localhost:3000/api/users/1/lists/2/
