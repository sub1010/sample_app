require 'spec_helper'

describe "tweets/index" do
  before(:each) do
    assign(:tweets, [
      stub_model(Tweet,
        :belng_to => "Belng To",
        :tweet_text => "Tweet Text",
        :likes => 1
      ),
      stub_model(Tweet,
        :belng_to => "Belng To",
        :tweet_text => "Tweet Text",
        :likes => 1
      )
    ])
  end

  it "renders a list of tweets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Belng To".to_s, :count => 2
    assert_select "tr>td", :text => "Tweet Text".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
