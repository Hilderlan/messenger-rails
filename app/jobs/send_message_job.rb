class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    html = ApplicationController.render_with_signed_in_user(partial: 'messages/message', locals: {message: message})

    ActionCable.server.broadcast "room_channel_#{message.room_id}", html: html
  end
end
