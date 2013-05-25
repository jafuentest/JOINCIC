module Persona
  def nombreCompleto
    nombre + " " + apellido
  end
  
  def nombres
    if seg_nombre.nil?
      return nombre
    end
    return nombre + " " + seg_nombre
  end
  
  def apellidos
    if seg_apellido.nil?
      return apellido
    end
    return apellido + " " + seg_apellido
  end
end
