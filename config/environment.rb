# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Change the default time format for the whole system
# ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(
#   :default => '%m/%d/%Y',
#   :date_time12  => "%m/%d/%Y %I:%M%p",
#   :date_time24  => "%m/%d/%Y %H:%M",
# )
