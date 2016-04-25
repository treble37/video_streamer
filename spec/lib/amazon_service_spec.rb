require 'rails_helper'

RSpec.describe AmazonService do
  it "should call s3_key with non-nil properties" do
    user = FactoryGirl.create(:user)
    expect { AmazonService.s3_key(user, "2100", "title") }.not_to raise_error
    expect { AmazonService.s3_key(nil, "2100", "title") }.to raise_error(ArgumentError)
    expect { AmazonService.s3_key(user, nil, "title") }.to raise_error(ArgumentError)
    expect { AmazonService.s3_key(user, "2100", nil) }.to raise_error(ArgumentError)
  end
end
