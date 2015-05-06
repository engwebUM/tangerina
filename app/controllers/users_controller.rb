class UsersController < Clearance::UsersController
  

  def index
    @users = User.all
  end

  def show
    
  end

  private

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    username = user_params.delete(:username)
    reviser = user_params.delete(:reviser)
    user_type = user_params.delete(:user_type)

    clearance_configuration(email, password, username, reviser, user_type)
  end

  def clearance_configuration(email, password, username, reviser)
    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.username = username
      user.reviser = reviser
      user.user_type = user_type
    end
  end
end
