module ArticlesHelper
  include ActsAsTaggableOn::TagsHelper

  def find_version_author_name(version)
    user = User.find_version_author(version)
    user ? user.username : ''
  end

  def get_users_subscriptions(article)
    subscriptions = Subscription.all

    subscriptions.theme.each do |theme|
      if article.theme.id == theme.id
        notifie_users(subscriptions.user)
      end
    end
  end

  def notifie_users(users)
    users.each do |user|
      UserMailer.registration_confirmation(user).deliver
    end
  end

  def files(article)
    data = ''
    top = init_top
    image(article, data, top)
  end

  private

  def image(article, data, top)
    data +=
            if article.contents.present?
              top += init_top
              data_html('image', top)
            else
              ''
            end
    resume(article, data, top)
  end

  def resume(article, data, top)
    data +=
            if article.resume.present?
              top += init_top
              data_html('quote-right', top)
            else
              ''
            end
    video(article, data, top)
  end

  def video(article, data, top)
    data +=
            if article.videos.present?
              top += init_top
              data_html('youtube-play', top)
            else
              ''
            end
    pdf(article, data, top)
  end

  def pdf(article, data, top)
    data +=
            if article.paper.present?
              top += init_top
              data_html('file-pdf-o', top)
            else
              ''
            end
    print_html(data)
  end

  def init_top
    45
  end

  def data_html(what, top)
    "<div class='ribbon ribbon-orange' style=" + "'top: #{top}px;'>" + "<span><i class='fa fa-#{what}'></i></span></div>"
  end

  def print_html(data)
    data.to_s.html_safe
  end
end
