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

ActiveRecord::Schema.define(:version => 20130128234241) do

  create_table "simples", :force => true do |t|
    t.string  "name"
    t.integer "age"
    t.string  "slug"
  end

  create_table "translatables", :force => true do |t|
    t.string "dummy"
  end

  create_table "translatables_i18n", :force => true do |t|
    t.integer "translatable_id", :null => false
    t.string  "locale",          :null => false
    t.string  "name",            :null => false
    t.integer "age",             :null => false
    t.string  "slug",            :null => false
  end

  create_table "withouts", :force => true do |t|
    t.string "name"
  end

end
