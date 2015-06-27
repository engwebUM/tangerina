class UsersController < Clearance::UsersController
  before_action :set_user, only: :show
  autocomplete :user, :username, scopes: :normal
  def index
    @users = User.all
  end

  def show
    @posts = ArticleReview.where(user_id: @user.id)
    @favorites = ArticleReview.joins(articles: :favorites).where(user_id: @user.id)
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

  def set_user
    @user = User.find(params[:id])
  end

  def clearance_configuration(email, password, username, reviser, user_type)
    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.username = username
      user.reviser = reviser
      user.user_type = user_type
    end
  end
end
