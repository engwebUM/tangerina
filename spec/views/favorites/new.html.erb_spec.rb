require 'rails_helper'

RSpec.describe "favorites/new", type: :view do
  before(:each) do
    assign(:favorite, Favorite.new(
      :article_id => 1,
      :user_id => 1
    ))
  end

  it "renders new favorite form" do
    render

    assert_select "form[action=?][method=?]", favorites_path, "post" do

      assert_select "input#favorite_article_id[name=?]", "favorite[article_id]"

      assert_select "input#favorite_user_id[name=?]", "favorite[user_id]"
    end
  end
end
