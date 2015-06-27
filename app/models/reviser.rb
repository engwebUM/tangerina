class Reviser < ActiveRecord::Base
  belongs_to :user
  belongs_to :theme

  validates :theme_id, uniqueness: { scope: :user_id }
end
