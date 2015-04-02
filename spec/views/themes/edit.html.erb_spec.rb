require 'rails_helper'

RSpec.describe "themes/edit", type: :view do
  before(:each) do
    @theme = assign(:theme, Theme.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit theme form" do
    render

    assert_select "form[action=?][method=?]", theme_path(@theme), "post" do

      assert_select "input#theme_name[name=?]", "theme[name]"
    end
  end
end
