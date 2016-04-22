module Persona
  def nombreCompleto
    "#{nombre} #{apellido}"
  end

  def nombres
    seg_nombre.nil? ? nombre : "#{nombre} #{seg_nombre}"
  end

  def apellidos
    seg_apellido.nil? ? apellido : "#{apellido} #{seg_apellido}"
  end
end
