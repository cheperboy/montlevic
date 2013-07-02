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

ActiveRecord::Schema.define(:version => 20120209075723) do

  create_table "categories", :force => true do |t|
    t.integer  "factcat_id",                    :null => false
    t.integer  "upcategory_id",                 :null => false
    t.string   "name",                          :null => false
    t.string   "code",                          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.integer  "ancestry_depth", :default => 0
    t.string   "old_code"
    t.integer  "nowrite"
  end

  add_index "categories", ["ancestry"], :name => "index_categories_on_ancestry"

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
    t.string   "ref"
    t.date     "date"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "factcats", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "code",       :null => false
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "factoparcelles", :force => true do |t|
    t.integer  "saison_id"
    t.integer  "parcelle_id"
    t.integer  "facture_id"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "factures", :force => true do |t|
    t.integer  "saison_id",                   :null => false
    t.integer  "category_id"
    t.integer  "factcat_id"
    t.integer  "factype_id"
    t.integer  "reportable_id"
    t.string   "type",                        :null => false
    t.integer  "star"
    t.integer  "adu"
    t.date     "date"
    t.integer  "user_id"
    t.string   "name"
    t.float    "cout"
    t.string   "ref_client"
    t.string   "ref"
    t.text     "desc"
    t.text     "info"
    t.float    "tva"
    t.integer  "paye"
    t.integer  "reglement",      :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nb_month_amort"
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
    t.text     "info"
    t.integer  "star",            :limit => 2
    t.integer  "adu",             :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labtofactures", :force => true do |t|
    t.integer  "saison_id"
    t.integer  "facture_id"
    t.integer  "labour_id"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labtoparcelles", :force => true do |t|
    t.integer  "saison_id"
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
    t.string   "code"
    t.float    "surface"
    t.float    "surface_pac"
    t.text     "desc"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prodpaille", :force => true do |t|
    t.integer  "category_id",  :null => false
    t.integer  "saison_id",    :null => false
    t.integer  "user_id"
    t.string   "name",         :null => false
    t.integer  "star"
    t.integer  "typebotte"
    t.integer  "poids"
    t.float    "valorisation", :null => false
    t.integer  "adu"
    t.text     "desc"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prodpailletoparcelles", :force => true do |t|
    t.integer "saison_id",     :null => false
    t.integer "prodpaille_id", :null => false
    t.integer "parcelle_id",   :null => false
  end

  create_table "prodpailletoventes", :force => true do |t|
    t.integer "saison_id",     :null => false
    t.integer "prodpaille_id", :null => false
    t.integer "vente_id",      :null => false
  end

  create_table "produits", :force => true do |t|
    t.integer  "category_id", :null => false
    t.integer  "saison_id",   :null => false
    t.string   "name",        :null => false
    t.text     "desc"
    t.text     "info"
    t.string   "unit"
    t.integer  "star"
    t.integer  "adu"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "protofactures", :force => true do |t|
    t.integer  "saison_id"
    t.integer  "produit_id"
    t.integer  "facture_id"
    t.float    "prix_unit"
    t.float    "quantite"
    t.float    "stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pulves", :force => true do |t|
    t.integer  "saison_id",       :null => false
    t.integer  "user_id",         :null => false
    t.date     "date",            :null => false
    t.string   "name",            :null => false
    t.float    "cout_ha_passage"
    t.integer  "star"
    t.integer  "adu"
    t.text     "desc"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",     :null => false
  end

  create_table "putofactures", :force => true do |t|
    t.integer  "saison_id"
    t.integer  "facture_id", :null => false
    t.integer  "pulve_id",   :null => false
    t.float    "value",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "putoparcelles", :force => true do |t|
    t.integer  "saison_id",   :null => false
    t.integer  "parcelle_id", :null => false
    t.integer  "pulve_id",    :null => false
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "putoproduits", :force => true do |t|
    t.integer  "saison_id"
    t.integer  "pulve_id"
    t.integer  "produit_id"
    t.float    "dosage"
    t.float    "dosage_vrai"
    t.float    "quantite"
    t.integer  "destocker",   :limit => 2
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "saisons", :force => true do |t|
    t.string "name",         :null => false
    t.string "year"
    t.text   "desc"
    t.text   "sum_charges"
    t.text   "sum_produits"
  end

  create_table "settings", :force => true do |t|
    t.integer "saison_id",                                  :null => false
    t.integer "value_parcelle",                :limit => 2
    t.integer "detail_desc",                   :limit => 2
    t.integer "detail_ref",                    :limit => 2
    t.integer "float_precision"
    t.string  "text_area_size"
    t.integer "show_reportable",               :limit => 2
    t.integer "charges_include_maison",        :limit => 2
    t.integer "charges_include_invest",        :limit => 2
    t.integer "charges_include_stock_produit", :limit => 2
  end

  create_table "stores", :force => true do |t|
    t.string   "tag"
    t.datetime "file_updated_at"
    t.string   "file_content_type"
    t.string   "file_file_name"
    t.integer  "file_file_size"
  end

  create_table "typecultures", :force => true do |t|
    t.string "name", :null => false
    t.string "code", :null => false
  end

  create_table "upcategories", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",          :null => false
    t.string   "code",          :null => false
    t.string   "tel_fixe"
    t.string   "tel_portable"
    t.string   "tel_3"
    t.string   "adresse_1"
    t.string   "adresse_2"
    t.string   "adresse_cp"
    t.string   "adresse_ville"
    t.string   "societe"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ventes", :force => true do |t|
    t.integer  "category_id",   :null => false
    t.integer  "saison_id",     :null => false
    t.float    "prix",          :null => false
    t.float    "quantite"
    t.float    "prix_unitaire"
    t.float    "ajust"
    t.date     "date",          :null => false
    t.integer  "user_id",       :null => false
    t.string   "name",          :null => false
    t.string   "ref"
    t.string   "ref_client"
    t.integer  "star"
    t.integer  "adu"
    t.text     "desc"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "calcul_auto"
    t.string   "unit"
    t.integer  "poids_botte"
    t.integer  "stock"
  end

  create_table "ventoparcelles", :force => true do |t|
    t.integer "saison_id",   :null => false
    t.integer "vente_id",    :null => false
    t.integer "parcelle_id", :null => false
    t.float   "value",       :null => false
  end

  create_table "ventoproduits", :force => true do |t|
    t.integer  "saison_id"
    t.integer  "produit_id"
    t.integer  "vente_id"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "verifs", :force => true do |t|
    t.string "name"
  end

  create_table "zones", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "code",       :null => false
    t.float    "surface",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zonetopas", :force => true do |t|
    t.integer  "saison_id"
    t.integer  "parcelle_id", :null => false
    t.integer  "zone_id",     :null => false
    t.float    "value",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
