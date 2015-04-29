class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  def index
    @subscriptions = Subscription.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 2)
    @articles = ArticleReview.joins(:articles).subscribed(current_user.id).paginate(:page => params[:page], :per_page => 2)
  end

  def show
  end

  def new
    @subscription = Subscription.new
    @themes = Theme.all
  end

  def edit
    @themes = Theme.all
  end

  def create
    @subscription = Subscription.new(subscription_params)
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully created.' }
        format.json { render :show, status: :created, location: @subscription }
      else
        new
        format.html { render :new }
        format.json { render json: @subscription.errors }
      end
    end
  end

  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully updated.' }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:theme_id, :user_id, :subject, :notify)
  end
end
