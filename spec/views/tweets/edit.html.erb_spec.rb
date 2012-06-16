require 'spec_helper'

describe "tweets/edit" do
  before(:each) do
    @tweet = assign(:tweet, stub_model(Tweet,
      :belng_to => "MyString",
      :tweet_text => "MyString",
      :likes => 1
    ))
  end

  it "renders the edit tweet form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tweets_path(@tweet), :method => "post" do
      assert_select "input#tweet_belng_to", :name => "tweet[belng_to]"
      assert_select "input#tweet_tweet_text", :name => "tweet[tweet_text]"
      assert_select "input#tweet_likes", :name => "tweet[likes]"
    end
  end
end
