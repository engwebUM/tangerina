require 'rails_helper'

RSpec.describe "favorites/edit", type: :view do
  before(:each) do
    @favorite = assign(:favorite, Favorite.create!(
      :article_id => 1,
      :user_id => 1
    ))
  end

  it "renders the edit favorite form" do
    render

    assert_select "form[action=?][method=?]", favorite_path(@favorite), "post" do

      assert_select "input#favorite_article_id[name=?]", "favorite[article_id]"

      assert_select "input#favorite_user_id[name=?]", "favorite[user_id]"
    end
  end
end
