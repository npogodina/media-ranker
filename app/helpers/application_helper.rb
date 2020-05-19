module ApplicationHelper
  def flash_class(level)
    case level
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-warning"
    end
  end
end
