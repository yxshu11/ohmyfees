class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  # Get the message and send the SMS out through Twilio API
  def send_message(message) # Should get number to send to in real production
    client = Twilio::REST::Client.new ENV["twi_acc_SID"], ENV["twi_auth_token"]
    client.messages.create( from: ENV["twi_from"],
                            to: ENV["twi_to"],
                            body: message)
  end

end
