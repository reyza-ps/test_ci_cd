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

  def log_class(status_code)
    if (status_code.eql?('200') || status_code.eql?('201'))
      'green'
    else
      'red'
    end
  end

  def sidebar_class(link_path)
    if current_page?(link_path)
      "bg-gray-50 text-indigo-600 group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold"
    else
      "text-gray-700 hover:text-indigo-600 hover:bg-gray-50 group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold"
    end
  end
end
