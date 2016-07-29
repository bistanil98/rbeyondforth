require 'test_helper'
require 'generators/event/event_generator'

class EventGeneratorTest < Rails::Generators::TestCase
  tests EventGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
