class HomeController < ApplicationController
   before_filter :deny_access

  def index
  end
end
