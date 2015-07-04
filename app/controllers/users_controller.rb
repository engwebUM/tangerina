class UsersController < Clearance::UsersController
  before_action :set_user, only: :show
  autocomplete :user, :username, scopes: :normal
  def index
    @users = User.all.paginate(page: params[:page], per_page: 3)
  end

  def show
    @posts = ArticleReview.where(user_id: @user.id)
    @favorites = ArticleReview.joins(articles: :favorites).where(user_id: @user.id)
    @subscriptions = Subscription.where(user_id: @user.id)
  end

  private

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    username = user_params.delete(:username)

    clearance_configuration(email, password, username)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def clearance_configuration(email, password, username)
    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.username = username
    end
  end
end
