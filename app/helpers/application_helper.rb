module ApplicationHelper

# Retorna un titulo por defecto
	def title
		base_title = "Sistema JOINCIC"
    base_title if @title.nil?
	end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :uni => params[:uni]}, {:class => css_class}
  end
end
