class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate_user, only: [:create]

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render_access_token(user.id, :ok)
    else
      render_error 'Invalid email or password', :unprocessable_entity
    end
  end
end
