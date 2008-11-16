class MessagesController < ApplicationController
  before_filter :setup_imap
  before_filter :authenticate
  
  after_filter :close_imap
  
  
  def show
    @imap.examine(params[:mailbox])
    ids = @imap.search(['HEADER', 'Message-Id', "<#{params[:id]}>"])
    #@headers["Content-Type"] = 'message/rfc822'
    render :text => "Format: #{params[:format]}" #@imap.fetch(ids.first, "RFC822")[0].attr["RFC822"], :content_type => 'message/rfc822'
  end
end
