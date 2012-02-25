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

ActiveRecord::Schema.define(:version => 20120223210915) do

  create_table "materiales_pop", :force => true do |t|
    t.string   "nombre"
    t.integer  "cantidad"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizadores", :force => true do |t|
    t.string  "usuario"
    t.string  "clave"
    t.integer "ci_org"
    t.string  "nombre"
    t.string  "seg_nombre"
    t.string  "apellido"
    t.string  "seg_apellido"
    t.date    "fecha_nac"
    t.integer "telefono"
    t.string  "correo"
    t.string  "direccion"
    t.string  "institucion"
    t.integer "nivel"
    t.string  "coordinacion"
    t.boolean "coordinador"
  end

  create_table "participantes", :force => true do |t|
    t.integer  "ci_par"
    t.string   "nombre"
    t.string   "seg_nombre"
    t.string   "apellido"
    t.string   "seg_apellido"
    t.date     "fecha_nac"
    t.integer  "telefono"
    t.string   "correo"
    t.string   "direccion"
    t.string   "institucion"
    t.integer  "nivel"
    t.boolean  "comida"
    t.integer  "id_zona"
    t.boolean  "eliminado"
    t.datetime "created_at"
  end

  create_table "participantes_mates", :force => true do |t|
    t.integer "id_par"
    t.integer "id_mat"
    t.boolean "entregado"
  end

  create_table "preguntas", :force => true do |t|
    t.string   "pregunta"
    t.integer  "id_par"
    t.integer  "id_pon"
    t.datetime "created_at"
  end

  create_table "zonas", :force => true do |t|
    t.string   "nombre"
    t.integer  "capacidad"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
