class Application < ActiveRecord::Base

  PULVE_DOSAGE_UNITS = [['L/Ha', 'L/Ha'], ['kg/Ha', 'kg/Ha']]
  PRODUIT_QUANTITE_UNITS = [['L', 'L'], ['kg', 'kg']]

  SAISON_ID = Setting.find(1).saison_id
  SAISON = Setting.find(1).saison
  
  # HEADER_KEY = 0
  # HEADER_VALUE = 1
  # HEADER_UNIT = 2
  # HEADER_FILTER = 3
  # HEADER_TYPE = 4
  # HEADER_TRI = 5
  # HEADER_TRI_KEY = 6
  
  LABOUR_HEAD = 
  [
    # KEY               VALUE         UNIT    FILTER        TYPE          TRI     TRI_KEY
   	['star',            'star',       '',     true,         :check_box,   true,   'star'            ], 
   	['adu',             'adu',        '',     true,         :check_box,   true,   'adu'             ], 
   	['id',              'id',         '',     false,        false,        true,   'id'              ], 
   	['typecultures',    'Cultures',   '',     false,        false,        false,  ''                ], 
  	['category_name',   'categorie',  '',     false,        false,        true,   'category_id'     ], 
   	['user_name',       'Presta',     '',     false,        :text_field,  true,   'user_id'         ], 
    ['name',            'nom',        '',     true,         :text_field,  true,   'name'            ], 
  	['cout_ha_passage', 'Cout Ha',    '€/Ha', false,        false,        true,   'cout_ha_passage' ],
   	['print_date',      'date',       '',     false,        true,         true,   'date'            ],
   	['get_desc_popup',  '?',          '',     false,        true,         true,   '"desc"'          ]
  ]
  
  PULVE_HEAD = 
  [
    # KEY               VALUE         UNIT    FILTER        TYPE          TRI     TRI_KEY
   	['star',            'star',       '',     true,         :check_box,   true,   'star'    ], 
   	['adu',             'adu',        '',     true,         :check_box,   true,   'adu'     ], 
   	['id',              'id',         '',     false,        false,        true,   'id'      ], 
   	['typecultures',    'Cultures',   '',     false,        false,        false,  ''        ], 
    ['print_produits',  'Produits',   '',     :text_field,  false,        false,  ''        ], 
   	['user_name',       'Presta',     '',     false,        :text_field,  true,   'user_id' ], 
    ['name',            'nom',        '',     true,         :text_field,  true,   'name'    ], 
   	['sum_surfaces',    'surface',    'ha',   true,         :text_field,  false,  ''        ], 
   	['get_cout_ha',     'Cout Ha',    '€/ha', false,        false,        false,  ''        ], 
   	['print_date',      'date',       '',     false,        true,         true,   'date'    ],
   	['get_desc_popup',  '?',          '',     false,        true,         true,   '"desc"'  ]
  ]

  FACTURE_HEAD = [
  	['star',            'star',       ''], 
  	['adu',             'adu',        ''], 
  	['id',              'id',         ''], 
  	['category_name',   'cat',        ''], 
  	['factcat_name',    'class',      ''], 
  	['print_factype',   'compta',     ''], 
  	['type',            'type',       ''], 
  	['user_name',       'Presta', ''], 
  	['name',            'nom', ''], 
  	['cout',            'Cout', '€'], 
    ['ref_client',      'Ref Client', '€'], 
    ['ref',             'Ref', '€'], 
  	['print_date',      'date', '']]


   PRODUIT_HEAD = [
    ['star', 'star', '', true, :check_box], 
    ['adu', 'adu', '', true, :check_box], 
    ['stock_lower_than_used_display', 'S', '', true], 
   	['id', 'id', '', false], 
   	['category_name', 'categorie', '', false, :text_field], 
   	['name', 'nom', '', true, :text_field], 
   	['get_quantite', 'Quantite', '', false], 
   	['unit', '', '', false],
    # ['get_stock', 'Stock', '', false], 
    # ['unit', '', '', false],
    ['get_prix_unitaire', 'Prix', '', false], 
    ['get_prix_unitaire_unit', '', '', false],
    ['number_of_use', '', '', false]
   	]

  
  # Used in Print.rb
  def get_value_or_blank(var, value)
    val = var[value.to_sym]
    return (pretty_csv(val))
  end
  
  # Used in Print.rb
  # Info : same methode declared in Application-helper
  def pretty_csv(val)
    precision = 1
    return nil if (val.equal?(0))
    return nil if (val == 0.0)
    return val.to_i if (val == val.to_i)
    return val if precision == 0
    return (val * 10 ** precision).round.to_f / 10 ** precision
  end
  
end
