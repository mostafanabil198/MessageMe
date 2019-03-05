class MessagesController < ApplicationController
  before_action :require_user
  def create
    message = current_user.messages.build(message_params)
    if message.save
      # redirect_to root_path
      ActionCable.server.broadcast "chatroom_channel",
                                    msg_block: new_message(message)

    end
  end

  private
  def message_params
    params.require(:message).permit(:body)
  end

  def new_message(message)
    render(partial:"message", locals: {message: message})
  end
end
