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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160516031042) do

  create_table "grupos", force: :cascade do |t|
    t.string "login", limit: 20, null: false
    t.string "clave", limit: 20, null: false
  end

  create_table "jo_ip", primary_key: "jo_ip_id", force: :cascade do |t|
    t.string "jo_ip_dir", limit: 255, null: false
  end

  create_table "jo_other", primary_key: "jo_other_id", force: :cascade do |t|
    t.string "jo_other_topic", limit: 255, null: false
  end

  create_table "jo_topic", primary_key: "jo_topic_id", force: :cascade do |t|
    t.integer "jo_topic_value", limit: 4, null: false
  end

  create_table "materiales_pop", force: :cascade do |t|
    t.string  "nombre",   limit: 20, null: false
    t.integer "cantidad", limit: 4,  null: false
  end

  create_table "mesas_de_trabajo", force: :cascade do |t|
    t.string  "titulo",          limit: 255,                   null: false
    t.string  "tema",            limit: 50,                    null: false
    t.string  "descripcion",     limit: 255,                   null: false
    t.date    "dia",                                           null: false
    t.time    "hora_ini",                                      null: false
    t.time    "hora_fin",                                      null: false
    t.string  "lugar",           limit: 50,                    null: false
    t.integer "capacidad",       limit: 4,                     null: false
    t.text    "requerimientos",  limit: 65535,                 null: false
    t.boolean "sorteada",                      default: false, null: false
    t.integer "ponente_id",      limit: 4
    t.integer "patrocinante_id", limit: 4
  end

  create_table "organizadores", force: :cascade do |t|
    t.string  "usuario",      limit: 15,                 null: false
    t.string  "clave",        limit: 15,                 null: false
    t.string  "nombre",       limit: 15,                 null: false
    t.string  "apellido",     limit: 15,                 null: false
    t.string  "correo",       limit: 50,                 null: false
    t.string  "institucion",  limit: 5,                  null: false
    t.string  "coordinacion", limit: 15,                 null: false
    t.boolean "coordinador",             default: false, null: false
    t.string  "seg_nombre",   limit: 15
    t.string  "seg_apellido", limit: 15
    t.boolean "eliminado"
  end

  create_table "participantes", force: :cascade do |t|
    t.integer  "cedula",             limit: 4,                   null: false
    t.string   "nombre",             limit: 15,                  null: false
    t.string   "apellido",           limit: 15,                  null: false
    t.date     "fecha_nac",                                      null: false
    t.string   "telefono",           limit: 11,                  null: false
    t.string   "correo",             limit: 50,                  null: false
    t.string   "direccion",          limit: 50,                  null: false
    t.string   "institucion",        limit: 20,                  null: false
    t.integer  "nivel",              limit: 4,                   null: false
    t.string   "tipo_nivel",         limit: 9,                   null: false
    t.integer  "zona_id",            limit: 4,                   null: false
    t.integer  "entrada",            limit: 4,                   null: false
    t.boolean  "comida",                         default: false, null: false
    t.boolean  "eliminado",                      default: false, null: false
    t.datetime "created_at",                                     null: false
    t.string   "seg_nombre",         limit: 15
    t.string   "seg_apellido",       limit: 15
    t.integer  "deposito",           limit: 4
    t.integer  "grupo_id",           limit: 4
    t.string   "carrera",            limit: 255
    t.boolean  "esEstudiante"
    t.boolean  "interesadoPasantia"
    t.string   "periodoPasantia",    limit: 255
    t.string   "intereses",          limit: 255
    t.string   "experiencia",        limit: 255
    t.integer  "organizador_id",     limit: 4
    t.string   "nacionalidad",       limit: 255
  end

  create_table "participantes_mates", force: :cascade do |t|
    t.integer "participante_id", limit: 4,                 null: false
    t.integer "material_pop_id", limit: 4,                 null: false
    t.boolean "entregado",                 default: false, null: false
  end

  create_table "participantes_mesas", force: :cascade do |t|
    t.integer  "participante_id",    limit: 4,                 null: false
    t.integer  "mesa_de_trabajo_id", limit: 4,                 null: false
    t.boolean  "seleccionado",                 default: false, null: false
    t.datetime "created_at",                                   null: false
    t.integer  "puesto",             limit: 4
  end

  create_table "participantes_rifas", id: false, force: :cascade do |t|
    t.integer "participante_id", limit: 4, null: false
    t.integer "rifa_id",         limit: 4, null: false
  end

  create_table "patrocinantes", force: :cascade do |t|
    t.string  "rif",        limit: 12,    null: false
    t.string  "nombre",     limit: 30,    null: false
    t.integer "aporte",     limit: 4,     null: false
    t.integer "plan_id",    limit: 4,     null: false
    t.text    "comentario", limit: 65535
    t.binary  "logo",       limit: 65535
  end

  create_table "planes", force: :cascade do |t|
    t.string  "nombre",     limit: 10,    null: false
    t.integer "precio",     limit: 4,     null: false
    t.text    "beneficios", limit: 65535, null: false
  end

  create_table "ponencias", force: :cascade do |t|
    t.string  "titulo",          limit: 255,   null: false
    t.string  "tema",            limit: 50,    null: false
    t.string  "descripcion",     limit: 255,   null: false
    t.date    "dia",                           null: false
    t.time    "hora_ini",                      null: false
    t.time    "hora_fin",                      null: false
    t.text    "requerimientos",  limit: 65535, null: false
    t.integer "ponente_id",      limit: 4,     null: false
    t.integer "patrocinante_id", limit: 4
  end

  create_table "ponentes", force: :cascade do |t|
    t.string "nombre",       limit: 15, null: false
    t.string "apellido",     limit: 15, null: false
    t.string "telefono",     limit: 11, null: false
    t.string "correo",       limit: 50, null: false
    t.string "institucion",  limit: 20, null: false
    t.string "seg_nombre",   limit: 15
    t.string "seg_apellido", limit: 15
  end

  create_table "preguntas", force: :cascade do |t|
    t.string  "mensaje",         limit: 255, null: false
    t.integer "participante_id", limit: 4,   null: false
    t.integer "ponencia_id",     limit: 4,   null: false
    t.boolean "aceptada"
  end

  create_table "premios", force: :cascade do |t|
    t.string  "nombre",          limit: 25, null: false
    t.integer "rifa_id",         limit: 4,  null: false
    t.integer "participante_id", limit: 4
    t.integer "patrocinante_id", limit: 4
  end

  create_table "problemas", force: :cascade do |t|
    t.string   "titulo",         limit: 255
    t.text     "enunciado",      limit: 65535
    t.text     "entradas",       limit: 65535
    t.text     "salidas",        limit: 65535
    t.datetime "fin_de_entrega"
    t.datetime "updated_at"
  end

  create_table "programas", force: :cascade do |t|
    t.integer  "problema_id", limit: 4,                            null: false
    t.integer  "grupo_id",    limit: 4,                            null: false
    t.string   "estado",      limit: 255,   default: "procesando"
    t.binary   "data",        limit: 65535
    t.string   "filename",    limit: 255
    t.string   "mime_type",   limit: 255
    t.datetime "created_at"
  end

  create_table "rifas", force: :cascade do |t|
    t.string  "nombre",  limit: 20, null: false
    t.integer "ammount", limit: 4,  null: false
    t.integer "limit",   limit: 4
  end

  create_table "sugerencias", force: :cascade do |t|
    t.string   "texto",      limit: 255, null: false
    t.string   "nombre",     limit: 30
    t.string   "correo",     limit: 25
    t.datetime "created_at",             null: false
  end

  create_table "zonas", force: :cascade do |t|
    t.string  "nombre",    limit: 10, null: false
    t.integer "capacidad", limit: 4,  null: false
  end

end
