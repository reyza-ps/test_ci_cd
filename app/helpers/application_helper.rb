module ApplicationHelper
  include Pagy::Frontend
  
  def flash_class(level)
    case level
    when :success then "green"
    when :notice then "green"
    when :alert then "yellow"
    when :error then "red"
    when :warning then "yellow"
    end
  end
end
