module ArticlesHelper
  include ActsAsTaggableOn::TagsHelper

  def find_version_author_name(version)
    user = User.find_version_author(version)
    user ? user.username : ''
  end
end
