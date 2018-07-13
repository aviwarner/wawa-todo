class Api::UsersController < ApiController
  before_action :authenticated?

  def index
    users = User.all
    render json: users, each_serializer: UserSerializer
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      user = User.find(params[:id])
      user.destroy
      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render json: { "error": "User not found" }, status: :not_found
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end

# Destroy test
# curl -u buymagicfish@gmail.com:asdfjkl -X DELETE http://localhost:3000/api/users/3/
