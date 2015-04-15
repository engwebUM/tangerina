class UsersController < Clearance::UsersController

  private

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    username = user_params.delete(:username)
    reviser = user_params.delete(:reviser)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.username = username
      user.reviser = reviser
    end
  end
end
