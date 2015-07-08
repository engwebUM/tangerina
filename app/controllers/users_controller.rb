class UsersController < Clearance::UsersController
  before_action :set_user, only: :show
  autocomplete :user, :username, scopes: :normal
  def index
    @users = User.all.paginate(page: params[:page], per_page: 3)
  end

  def show
    @posts = ArticleReview.where(user_id: @user.id)
    @favorites = ArticleReview.favorited(@user.id)
    @subscriptions = Subscription.where(user_id: @user.id)
  end

  private

  # rubocop:disable all
  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    username = user_params.delete(:username)
    user_info(email, password, username)
  end
  # rubocop:disable all

  def user_info(email, password, username)
    first_name = user_params.delete(:first_name)
    last_name = ser_params.delete(:last_name)
    city = ser_params.delete(:city)
    country = ser_params.delete(:country)
    occupation = ser_params.delete(:occupation)
    about = ser_params.delete(:about)
    date_birth = ser_params.delete(:date_birth)
    photo = ser_params.delete(:photo)
    clearance_configuration(email, password, username, first_name, last_name, city, country, occupation, about, date_birth, photo)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def clearance_configuration(email, password, username, first_name, last_name, city, country, occupation, about, date_birth, photo)
    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.username = username
      user.first_name = first_name
      user.last_name = last_name
      user.city = city
      user.country = country
      user.occupation = occupation
      user.about = about
      user.date_birth = date_birth
      user.photo = photo
    end
  end
end
