class UserMailer < ActionMailer::Base
  default :from => "contacto@joincic.com.ve"
  
  def enviarHash (participante)
    @hash   = Digest::SHA1.hexdigest(participante.id.to_s + SALT)
    @nombre = participante.nombreCompleto
    @id     = participante.id
    mail(:to => participante.correo, :subject => "Confirmación de registro")
  end
end
