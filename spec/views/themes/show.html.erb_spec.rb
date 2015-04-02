require 'rails_helper'

RSpec.describe "themes/show", type: :view do
  before(:each) do
    @theme = assign(:theme, Theme.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
