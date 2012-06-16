require 'spec_helper'

describe "tweets/show" do
  before(:each) do
    @tweet = assign(:tweet, stub_model(Tweet,
      :belng_to => "Belng To",
      :tweet_text => "Tweet Text",
      :likes => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Belng To/)
    rendered.should match(/Tweet Text/)
    rendered.should match(/1/)
  end
end
