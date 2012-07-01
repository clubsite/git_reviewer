require 'spec_helper'

describe "licenses/edit" do
  before(:each) do
    @license = assign(:license, stub_model(License,
      :name => "MyString",
      :homepage => "MyString",
      :current_version => "MyString",
      :previous_version => "MyString",
      :license => "MyString",
      :previous_license => "MyString"
    ))
  end

  it "renders the edit license form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => licenses_path(@license), :method => "post" do
      assert_select "input#license_name", :name => "license[name]"
      assert_select "input#license_homepage", :name => "license[homepage]"
      assert_select "input#license_current_version", :name => "license[current_version]"
      assert_select "input#license_previous_version", :name => "license[previous_version]"
      assert_select "input#license_license", :name => "license[license]"
      assert_select "input#license_previous_license", :name => "license[previous_license]"
    end
  end
end
