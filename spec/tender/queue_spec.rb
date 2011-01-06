require File.join(File.expand_path(File.dirname(__FILE__)), "../spec_helper")

describe Tender::Queue, "#add" do
  it "should add a discussion to a queue" do
    Tender.auth_token = "x"
    register_uri
    Tender::Queue.add("http://discussion/queue/{queue_id}", 123)
  end

  it "should raise TenderError if response is not successful" do
    register_uri(:code => 400, :body => "Some error")
    lambda {
      Tender::Queue.add("http://discussion/queue/{queue_id}", 123)
    }.should raise_error(Tender::TenderError, "Discussion was not added to queue. Response was: Some error")
  end
end
