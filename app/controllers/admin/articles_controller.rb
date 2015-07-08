module Admin
  class ArticlesController < AdminController
    before_action :require_login, :authorize

    def index
      @articles = Article.all
    end
  end
end
