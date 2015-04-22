class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]


  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.all
    @themes = Theme.all
    @themes_subscribed = Subscription.select("theme_id").where(user_id:current_user)
    @articles = Article.joins(:theme).where(:theme_id => @themes_subscribed)

  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    #@subscriptions = SubscriptionsSearch.new(Subscription.find(params[:id]))
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
    @themes = Theme.all
  end

  # GET /subscriptions/1/edit
  def edit
    @themes = Theme.all
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  
  def themes_subscribed
    @subscriptions = Subscription.all
    themes = []

    @subscriptions.each do |subscription|
      if subscription.user.id == current_user.id
        themes << subscription.theme.name
      end
    end  
    themes
  end

 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:theme_id, :user_id,themes_attributes: [ :name ])
    end

    
end
