require "spec_helper"

describe "Requesting a cat" do
  before :all do
    root = "#{Rails.root}/public"
    Dir["#{root}/test/*.gif"].sample(5).each do |path|
      Cat.create! url: path.sub(root, '')
    end
  end
  after(:all) { Cat.delete_all }

  before :each do
    @user = create :user
    log_in @user
  end

  it "fulfills a cat request" do
    expect( @user.cat_requests ).to be_empty

    click_on "Cat Me"
    req = @user.cat_requests.last

    expect( req.cat ).to be_present
    expect( Air.shell.history.last ).to match /open.*#{req.cat.download_path}/
  end
end
