# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120507222652) do

  create_table "materiales_pop", :force => true do |t|
    t.string  "nombre",   :limit => 20, :null => false
    t.integer "cantidad",               :null => false
  end

  create_table "mesas_de_trabajo", :force => true do |t|
    t.string  "titulo",          :limit => 25,                    :null => false
    t.string  "tema",            :limit => 25,                    :null => false
    t.string  "descripcion",                                      :null => false
    t.date    "dia",                                              :null => false
    t.time    "hora_ini",                                         :null => false
    t.time    "hora_fin",                                         :null => false
    t.string  "lugar",           :limit => 25,                    :null => false
    t.integer "capacidad",                                        :null => false
    t.text    "requerimientos",                                   :null => false
    t.boolean "sorteada",                      :default => false, :null => false
    t.integer "ponente_id"
    t.integer "patrocinante_id"
  end

  create_table "organizadores", :force => true do |t|
    t.string  "usuario",      :limit => 15,                    :null => false
    t.string  "clave",        :limit => 15,                    :null => false
    t.integer "cedula",                                        :null => false
    t.string  "nombre",       :limit => 15,                    :null => false
    t.string  "apellido",     :limit => 15,                    :null => false
    t.date    "fecha_nac",                                     :null => false
    t.string  "telefono",     :limit => 11,                    :null => false
    t.string  "correo",       :limit => 50,                    :null => false
    t.string  "direccion",    :limit => 50,                    :null => false
    t.string  "institucion",  :limit => 5,                     :null => false
    t.integer "nivel",                                         :null => false
    t.string  "tipo_nivel",   :limit => 9,                     :null => false
    t.string  "coordinacion", :limit => 15,                    :null => false
    t.boolean "coordinador",                :default => false, :null => false
    t.string  "seg_nombre",   :limit => 15
    t.string  "seg_apellido", :limit => 15
  end

  create_table "participantes", :force => true do |t|
    t.integer  "cedula",                                        :null => false
    t.string   "nombre",       :limit => 15,                    :null => false
    t.string   "apellido",     :limit => 15,                    :null => false
    t.date     "fecha_nac",                                     :null => false
    t.string   "telefono",     :limit => 11,                    :null => false
    t.string   "correo",       :limit => 50,                    :null => false
    t.string   "direccion",    :limit => 50,                    :null => false
    t.string   "institucion",  :limit => 20,                    :null => false
    t.integer  "nivel",                                         :null => false
    t.string   "tipo_nivel",   :limit => 9,                     :null => false
    t.integer  "zona_id",                                       :null => false
    t.integer  "entrada",                                       :null => false
    t.boolean  "comida",                     :default => false, :null => false
    t.boolean  "eliminado",                  :default => false, :null => false
    t.datetime "created_at",                                    :null => false
    t.string   "seg_nombre",   :limit => 15
    t.string   "seg_apellido", :limit => 15
    t.integer  "deposito"
  end

  create_table "participantes_mates", :force => true do |t|
    t.integer "participante_id",                    :null => false
    t.integer "material_pop_id",                    :null => false
    t.boolean "entregado",       :default => false, :null => false
  end

  create_table "participantes_mesas", :force => true do |t|
    t.integer  "participante_id",                       :null => false
    t.integer  "mesa_de_trabajo_id",                    :null => false
    t.integer  "prioridad",                             :null => false
    t.boolean  "seleccionado",       :default => false, :null => false
    t.datetime "created_at",                            :null => false
    t.integer  "puesto"
  end

  create_table "patrocinantes", :force => true do |t|
    t.string  "rif",        :limit => 12, :null => false
    t.string  "nombre",     :limit => 30, :null => false
    t.integer "aporte",                   :null => false
    t.integer "plan_id",                  :null => false
    t.text    "comentario"
    t.binary  "logo"
  end

  create_table "planes", :force => true do |t|
    t.string  "nombre",     :limit => 10, :null => false
    t.integer "precio",                   :null => false
    t.text    "beneficios",               :null => false
  end

  create_table "ponencias", :force => true do |t|
    t.string  "titulo",          :limit => 25, :null => false
    t.string  "tema",            :limit => 25, :null => false
    t.string  "descripcion",                   :null => false
    t.date    "dia",                           :null => false
    t.time    "hora_ini",                      :null => false
    t.time    "hora_fin",                      :null => false
    t.text    "requerimientos",                :null => false
    t.integer "ponente_id",                    :null => false
    t.integer "patrocinante_id"
  end

  create_table "ponentes", :force => true do |t|
    t.integer "cedula",                     :null => false
    t.string  "nombre",       :limit => 15, :null => false
    t.string  "apellido",     :limit => 15, :null => false
    t.string  "telefono",     :limit => 11, :null => false
    t.string  "correo",       :limit => 50, :null => false
    t.string  "institucion",  :limit => 20, :null => false
    t.string  "seg_nombre",   :limit => 15
    t.string  "seg_apellido", :limit => 15
    t.string  "telefono2",    :limit => 11
  end

  create_table "preguntas", :force => true do |t|
    t.string  "mensaje",         :null => false
    t.integer "participante_id", :null => false
    t.integer "ponencia_id",     :null => false
    t.boolean "aceptada"
  end

  create_table "premios", :force => true do |t|
    t.string  "nombre",          :limit => 25, :null => false
    t.integer "rifa_id",                       :null => false
    t.integer "participante_id"
    t.integer "patrocinante_id"
  end

  create_table "rifas", :force => true do |t|
    t.string "nombre", :limit => 20, :null => false
  end

  create_table "zonas", :force => true do |t|
    t.string  "nombre",    :limit => 10, :null => false
    t.integer "capacidad",               :null => false
  end

end
