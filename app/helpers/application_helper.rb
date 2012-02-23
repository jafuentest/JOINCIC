module ApplicationHelper

# Retorna un título por defecto
	def title
		base_title = "JOINCIC-Sistema"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
end
