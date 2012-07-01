require 'spec_helper'

describe "licenses/show" do
  before(:each) do
    @license = assign(:license, stub_model(License,
      :name => "Name",
      :homepage => "Homepage",
      :current_version => "Current Version",
      :previous_version => "Previous Version",
      :license => "License",
      :previous_license => "Previous License"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Homepage/)
    rendered.should match(/Current Version/)
    rendered.should match(/Previous Version/)
    rendered.should match(/License/)
    rendered.should match(/Previous License/)
  end
end
