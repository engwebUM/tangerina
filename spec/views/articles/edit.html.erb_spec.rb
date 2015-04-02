require 'rails_helper'

RSpec.describe "articles/edit", type: :view do
  before(:each) do
    @article = assign(:article, Article.create!(
      :title => "MyString",
      :description => "MyText",
      :theme_id => 1,
      :abstract => "MyText",
      :user_id => 1
    ))
  end

  it "renders the edit article form" do
    render

    assert_select "form[action=?][method=?]", article_path(@article), "post" do

      assert_select "input#article_title[name=?]", "article[title]"

      assert_select "textarea#article_description[name=?]", "article[description]"

      assert_select "input#article_theme_id[name=?]", "article[theme_id]"

      assert_select "textarea#article_abstract[name=?]", "article[abstract]"

      assert_select "input#article_user_id[name=?]", "article[user_id]"
    end
  end
end
