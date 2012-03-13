module ApplicationHelper

# Retorna un título por defecto
	def title
		base_title = "Sistema JOINCIC"
    base_title if @title.nil?
	end
end
