require 'rails_helper'

RSpec.describe "articles/new", type: :view do
  before(:each) do
    assign(:article, Article.new(
      :title => "MyString",
      :description => "MyText",
      :theme_id => 1,
      :abstract => "MyText",
      :user_id => 1
    ))
  end

  it "renders new article form" do
    render

    assert_select "form[action=?][method=?]", articles_path, "post" do

      assert_select "input#article_title[name=?]", "article[title]"

      assert_select "textarea#article_description[name=?]", "article[description]"

      assert_select "input#article_theme_id[name=?]", "article[theme_id]"

      assert_select "textarea#article_abstract[name=?]", "article[abstract]"

      assert_select "input#article_user_id[name=?]", "article[user_id]"
    end
  end
end
