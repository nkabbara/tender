require File.join(File.expand_path(File.dirname(__FILE__)), "../spec_helper")

describe Tender::Discussion, "#create" do
  before(:each) do
    Tender.auth_token = "xxx"
    @cat_id = 123654
  end

  def stub_post
    resp = {}
    resp.stub!(:code).and_return(201)
    HTTParty.stub!(:post).and_return(resp);
  end

  def discussion_url(cat_id)
    "https://api.tenderapp.com/zipzoomauto/categories/#{cat_id}/discussions"
  end

  it "shoud create a discussion in the specified category" do
    stub_post
    HTTParty.should_receive(:post).with(discussion_url(@cat_id), anything())
    Tender::Discussion.create(@cat_id, :body => "hi")
  end

  it "create a discussion with the default options" do
    stub_post
    defaults = {
      :title => "",
      :skip_spam => true,
      :public => false,
      :body => "hi",
      :author_email => "support@zipzoomauto.com",
      :author_name => "Support API"
    }

    HTTParty.should_receive(:post).with(discussion_url(@cat_id), hash_including(:body => defaults))
    Tender::Discussion.create(@cat_id, :body => "hi")
  end

  it "should update the default options with passed options" do
    stub_post
    options = {
      :title => "Ma title!",
      :skip_spam => true,
      :public => false,
      :body => "Ma body!",
      :author_email => "support@zipzoomauto.com",
      :author_name => "SUPPORT API"
    }

    HTTParty.should_receive(:post).with(discussion_url(@cat_id), hash_including(:body => options))
    Tender::Discussion.create(@cat_id, options)
  end

  it "should require :body option" do
    lambda {
      Tender::Discussion.create(@cat_id)
    }.should raise_error(RuntimeError, ":body is a required option")
  end

  it "should raise TenderError if response is not success" do
    res = [["some_field", "can't be blank"]]
    res.stub!(:code).and_return(400)
    HTTParty.should_receive(:post).and_return(res)
    lambda {
      Tender::Discussion.create(@cat_id, :body => "hi")
    }.should raise_error(Tender::TenderError, "some_field can't be blank")
  end

  context "response" do
    before(:each) do
      Tender.auth_token = "zzz"
    end

    it "should be a discussion resource" do
      resp = {"queue_href" => "some url"}
      resp.stub!(:code).and_return(201)
      HTTParty.should_receive(:post).and_return(resp)
      resp = Tender::Discussion.create(@cat_id, :body => "hi")
      resp['queue_href'].should == "some url"
    end

    it "should be queueable" do
      register_uri(
        :code => 201, 
        :uri  => discussion_url(@cat_id),
        :body => %{{ "queue_href" : "http://queue.com/{queue_id}" }}
      )
      queue_id = 123
      resp     = Tender::Discussion.create(@cat_id, :body => "hi")
      Tender::Queue.should_receive(:add).with("http://queue.com/{queue_id}", 321)
      resp.queue(321)
    end
  end

  it "should require an auth token" do
    Tender.auth_token = ""
    lambda {
      Tender::Discussion.create(@cat_id, :body => "hey body!")
    }.should raise_error(RuntimeError, "Currently only token authorization is supported. An auth token is required.")
  end

end
