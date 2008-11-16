# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def message_id_core(message_id)
    message_id.sub('<','').sub('>','')
  end
end
