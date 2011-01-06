require File.join(File.expand_path(File.dirname(__FILE__)), "./spec_helper")

describe Tender, "#configure" do
  it "should set the auth_token attribute" do
    Tender.configure { |tender| tender.auth_token = "MyTestT" }
    Tender.auth_token.should == "MyTestT"
  end
end
