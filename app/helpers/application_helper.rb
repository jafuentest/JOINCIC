module ApplicationHelper

# Retorna un titulo por defecto
	def title
		base_title = "Sistema JOINCIC"
    base_title if @title.nil?
	end
end
