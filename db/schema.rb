# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100330165713) do

  create_table "categories", :force => true do |t|
    t.integer  "upcategory_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "charges", :id => false, :force => true do |t|
    t.integer "toto"
  end

  create_table "facdivs", :force => true do |t|
    t.integer  "facture_id",  :null => false
    t.integer  "saison_id",   :null => false
    t.integer  "category_id"
    t.integer  "star"
    t.integer  "adu"
    t.integer  "user_id"
    t.string   "name"
    t.float    "cout"
    t.string   "ref_client"
    t.integer  "ref"
    t.date     "date"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "factcats", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "factoparcelles", :force => true do |t|
    t.integer  "parcelle_id"
    t.integer  "facture_id"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "factures", :force => true do |t|
    t.integer  "saison_id",     :null => false
    t.integer  "category_id"
    t.integer  "factcat_id"
    t.integer  "factype_id"
    t.integer  "reportable_id"
    t.string   "type",          :null => false
    t.integer  "star"
    t.integer  "adu"
    t.date     "date"
    t.integer  "user_id"
    t.string   "name"
    t.float    "cout"
    t.string   "ref_client"
    t.integer  "ref"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "factypes", :force => true do |t|
    t.string   "name"
    t.string   "display"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labours", :force => true do |t|
    t.integer  "saison_id",                    :null => false
    t.integer  "category_id",                  :null => false
    t.integer  "user_id",                      :null => false
    t.date     "date",                         :null => false
    t.string   "name",                         :null => false
    t.float    "cout_ha_passage"
    t.text     "desc"
    t.integer  "star",            :limit => 2
    t.integer  "adu",             :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labtofactures", :force => true do |t|
    t.integer  "facture_id"
    t.integer  "labour_id"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labtoparcelles", :force => true do |t|
    t.integer  "parcelle_id"
    t.integer  "labour_id"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "myusers", :force => true do |t|
    t.string  "login"
    t.string  "password"
    t.integer "admin",    :limit => 2
  end

  create_table "parcelles", :force => true do |t|
    t.integer  "saison_id",      :null => false
    t.integer  "typeculture_id", :null => false
    t.string   "name",           :null => false
    t.float    "surface"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pulves", :force => true do |t|
    t.integer  "saison_id",       :null => false
    t.integer  "category_id",     :null => false
    t.integer  "user_id",         :null => false
    t.date     "date",            :null => false
    t.string   "name",            :null => false
    t.float    "dosage"
    t.float    "prix_littre"
    t.float    "cout_ha_passage"
    t.float    "cout_fixe"
    t.integer  "star"
    t.integer  "adu"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "putofactures", :force => true do |t|
    t.integer  "facture_id", :null => false
    t.integer  "pulve_id",   :null => false
    t.integer  "value",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "putoparcelles", :force => true do |t|
    t.integer  "parcelle_id", :null => false
    t.integer  "pulve_id",    :null => false
    t.float    "value",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "saisons", :force => true do |t|
    t.string  "name", :null => false
    t.string  "start_year"
    t.text    "desc"
  end

  create_table "settings", :force => true do |t|
    t.integer "saison_id",                   :null => false
    t.integer "value_parcelle", :limit => 2
    t.integer "detail_desc",    :limit => 2
    t.integer "detail_ref",     :limit => 2
  end

  create_table "typecultures", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "upcategories", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ventes", :force => true do |t|
    t.integer  "category_id", :null => false
    t.integer  "saison_id",   :null => false
    t.float    "prix",        :null => false
    t.date     "date",        :null => false
    t.integer  "user_id",     :null => false
    t.string   "name",        :null => false
    t.integer  "ref"
    t.string   "ref_client"
    t.integer  "star"
    t.integer  "adu"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ventoparcelles", :force => true do |t|
    t.integer "vente_id",    :null => false
    t.integer "parcelle_id", :null => false
    t.float   "value",       :null => false
  end

  create_table "verifs", :force => true do |t|
    t.string "name"
  end

  create_table "zones", :force => true do |t|
    t.string   "name",       :null => false
    t.float    "surface",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zonetopas", :force => true do |t|
    t.integer  "parcelle_id", :null => false
    t.integer  "zone_id",     :null => false
    t.float    "value",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
