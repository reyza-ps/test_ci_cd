module ApplicationHelper
  include Pagy::Frontend
  
  def flash_class(level)
    bg = ''
    text = ''
    btn = ''
    case level
    when :success, :notice
      bg = "rounded-md bg-green-50 p-4 mb-5"
      text = "text-sm font-medium text-green-800"
      btn = "closealertbutton inline-flex rounded-md bg-green-50 p-1.5 text-green-500 hover:bg-green-100 focus:outline-none focus:ring-2 focus:ring-green-600 focus:ring-offset-2 focus:ring-offset-green-50"
    when :alert, :warning 
      bg = "rounded-md bg-yellow-50 p-4 mb-5"
      text = "text-sm font-medium text-yellow-800"
      btn = "closealertbutton inline-flex rounded-md bg-yellow-50 p-1.5 text-yellow-500 hover:bg-yellow-100 focus:outline-none focus:ring-2 focus:ring-yellow-600 focus:ring-offset-2 focus:ring-offset-yellow-50"
    when :error
      bg = "rounded-md bg-red-50 p-4 mb-5"
      text = "text-sm font-medium text-red-800"
      btn = "closealertbutton inline-flex rounded-md bg-red-50 p-1.5 text-red-500 hover:bg-red-100 focus:outline-none focus:ring-2 focus:ring-red-600 focus:ring-offset-2 focus:ring-offset-red-50"
    end
    {
      background: bg, text: text, button: btn
    }
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

  # def badge(value)
  #   <span class='inline-flex items-center rounded-full bg-blue-100 px-2.5 py-0.5 text-xs font-medium text-purple-800'>Badge</span> 
  # end
end
