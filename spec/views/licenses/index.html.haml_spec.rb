require 'spec_helper'

describe "licenses/index" do
  before(:each) do
    assign(:licenses, [
      stub_model(License,
        :name => "Name",
        :homepage => "Homepage",
        :current_version => "Current Version",
        :previous_version => "Previous Version",
        :license => "License",
        :previous_license => "Previous License"
      ),
      stub_model(License,
        :name => "Name",
        :homepage => "Homepage",
        :current_version => "Current Version",
        :previous_version => "Previous Version",
        :license => "License",
        :previous_license => "Previous License"
      )
    ])
  end

  it "renders a list of licenses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Homepage".to_s, :count => 2
    assert_select "tr>td", :text => "Current Version".to_s, :count => 2
    assert_select "tr>td", :text => "Previous Version".to_s, :count => 2
    assert_select "tr>td", :text => "License".to_s, :count => 2
    assert_select "tr>td", :text => "Previous License".to_s, :count => 2
  end
end
