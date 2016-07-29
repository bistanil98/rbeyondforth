require 'test_helper'
require 'generators/webmaster_verification/webmaster_verification_generator'

class WebmasterVerificationGeneratorTest < Rails::Generators::TestCase
  tests WebmasterVerificationGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
