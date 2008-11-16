

class MailboxesController < ApplicationController
  
  before_filter :setup_imap
  before_filter :authenticate
  
  after_filter :close_imap
  
  def index
    @mailboxes = @imap.list('', '*').reject{|m| m.attr.include? :Noselect }.collect do |m| 
      status = @imap.status(m.name, ['MESSAGES', 'UNSEEN'])
      {:name => m.name, :messages => status['MESSAGES'], :unread => status['UNSEEN']}
    end
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.atom { render :template => 'mailboxes/index' }
    end
  end
  
  def show
    @imap.examine(params[:mailbox])
    ids = @imap.search(['ALL'])
    @emails = []
    ids[0..10].each do |id|
      @emails << TMail::Mail.parse(@imap.fetch(id, "RFC822")[0].attr["RFC822"])
    end
    
    
    respond_to do |format|
      format.html # show.html.erb
      format.atom { render :template => 'mailboxes/show' }
    end
  end
  
  
   
end
