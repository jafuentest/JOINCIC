xml.instruct!
xml.paritcipantes do
  @participantes.each do |participante|
    xml.participante do
      xml.cedula participante.cedula
      xml.nombre participante.nombre
      xml.apellido participante.apellido
    end
  end
end
