module ApplicationHelper

  # Retorna un titulo por defecto
  def title
    base_title = "Sistema JOINCIC"
    if @title
      @title
    else
      base_title
    end
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :uni => params[:uni], :query => params[:query]}, {:class => css_class}
  end
end
