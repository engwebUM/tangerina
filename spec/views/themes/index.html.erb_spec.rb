require 'rails_helper'

RSpec.describe "themes/index", type: :view do
  before(:each) do
    assign(:themes, [
      Theme.create!(
        :name => "Name"
      ),
      Theme.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of themes" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
