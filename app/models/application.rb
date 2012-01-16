class Application < ActiveRecord::Base

  
  # Veleurs utilisees dans les listes deroulante
  DEFAULT = 0
  ERROR   = -1

  # Types de reglement
  CHEQUE = 1
  ESPECE = 2
  
  # Taux TVA
  TVA_5_5 = 5.5
  TVA_19_6 = 19.6
  
  # Valeurs de listes deroulantes
  PULVE_DOSAGE_UNITS = [['L/Ha', 'L/Ha'], ['kg/Ha', 'kg/Ha']]
  PRODUIT_QUANTITE_UNITS = [['L', 'L'], ['kg', 'kg']]
  TAUX_TVA = [['-', DEFAULT], ['5,5%', TVA_5_5], ['19,6%', TVA_19_6]]
  TYPE_REGLEMENT = [['-', DEFAULT], ['Cheque', CHEQUE], ['Liquide', ESPECE]]

  SAISON_ID = Setting.find(1).saison_id
  SAISON = Setting.find(1).saison
  

  # HEADER_KEY = 0
  # HEADER_VALUE = 1
  # HEADER_UNIT = 2
  # HEADER_FILTER = 3
  # HEADER_TYPE = 4
  # HEADER_TRI = 5
  # HEADER_TRI_KEY = 6
  # HEADER_RED_GREEN = 7
  # HEADER_COLOR = 8
  
  LABOUR_HEAD = 
  [
    # KEY                       VALUE         UNIT    FILTER        TYPE          TRI     TRI_KEY
   	['star',                    'star',       '',     true,         :check_box,   true,   'star'            ], 
   	['id',                      'id',         '',     false,        false,        true,   'id'              ], 
   	['typecultures',            'Cultures',   '',     false,        false,        false,  ''                ], 
  	['category_name',           'categorie',  '',     false,        false,        true,   'category_id'     ], 
   	['user_name',               'Presta',     '',     false,        :text_field,  true,   'user_id'         ], 
    ['name',                    'nom',        '',     true,         :text_field,  true,   'name'            ], 
  	['cout_ha_passage',         'Cout Ha',    '€/Ha', false,        false,        true,   'cout_ha_passage' ],
  	['get_cout_total',          'Cout Total', '€',    false,        false,        false,  ''                ],
   	['print_date',              'date',       '',     false,        true,         true,   'date'            ],
   	['adu',                     'adu',        '',     true,         :check_box,   true,   'adu'             ], 
   	['get_desc_popup',          '?',          '',     false,        true,         true,   '"desc"'          ]
  ]
  
  PULVE_HEAD = 
  [
    # KEY                       VALUE         UNIT    FILTER        TYPE          TRI     TRI_KEY
   	['star',                    'star',       '',     true,         :check_box,   true,   'star'    ], 
   	['id',                      'id',         '',     false,        false,        true,   'id'      ], 
   	['typecultures',            'Cultures',   '',     false,        false,        false,  ''        ], 
    ['print_produits',          'Produits',   '',     :text_field,  false,        false,  ''        ], 
   	['user_name',               'Presta',     '',     false,        :text_field,  true,   'user_id' ], 
    ['name',                    'nom',        '',     true,         :text_field,  true,   'name'    ], 
   	['sum_surfaces',            'surface',    'ha',   true,         :text_field,  false,  ''        ], 
  # ['get_cout_ha',             'Cout Ha',    '€/ha', false,        false,        false,  ''        ], 
  # ['get_cout_total_passage',  'passage',    '€',    false,        false,        false,  ''        ], 
   	['get_cout_total_produits', 'produits',   '€',    false,        false,        false,  ''        ], 
   	['print_date',              'date',       '',     false,        true,         true,   'date'    ],
   	['adu',                     'adu',        '',     true,         :check_box,   true,   'adu'     ], 
   	['get_info_popup',          '?',          '',     false,        true,         true,   '"info"'  ]
  ]

  VENTE_HEAD = 
  [
    # KEY                   VALUE         UNIT    FILTER        TYPE          TRI     TRI_KEY           GREEN_RED COLOR
    ['star',                'star',       '',     true,         :check_box,   true,   'star',           false,    'black'],
  # ['pp_paye',             'paye',       '',     true,         :check_box,   true,   'paye',           false,    'black'], 
   	['id',                  'id',         '',     false,        false,        true,   'id',             false,    'grey'],
  	['category_name',       'Categorie',  '',     false,        false,        true,   'category_id',    false,    'grey'],
  	['user_name',           'Prestataire','',     false,        false,        true,   'user_id',        false,    'black'],
  	['name',                'nom',        '',     false,        false,        true,   'name',           false,    'black'],
  	['prix',                'Prix',       '€',    false,        false,        true,   'prix',           false,    'black'],
    ['ref',                 'Ref',        '',     false,        false,        true,   'ref',            false,    'grey'],
  	['print_date',          'date',       '',     false,        false,        true,   'date',           false,    'grey'],
    ['adu',                 'adu',        '',     true,         :check_box,   true,   'adu',            false,    'black'], 
   	['get_info_popup',      '?',          '',     false,        true,         true,   '"info"',         false,    'black']
  ]

  FACTURE_HEAD = 
  [
    # KEY                   VALUE         UNIT    FILTER        TYPE          TRI     TRI_KEY           GREEN_RED COLOR
    ['star',                'star',       '',     true,         :check_box,   true,   'star',           false,    'black'], 
    ['pp_paye',             'paye',       '',     true,         :check_box,   true,   'paye',           false,    'black'], 
   	['id',                  'id',         '',     false,        false,        true,   'id',             false,    'grey'],
  	['category_name',       'Categorie',  '',     false,        false,        true,   'category_id',    false,    'grey'],
    # ['factcat_name',      'class',      '',     false,        false,        true,   'factcat_id',     false,    'grey'],
  	['print_factype',       'compta',     '',     false,        false,        true,   'factype_id',     false,    'grey'],
  	['type',                'type',       '',     false,        false,        true,   'type',           false,    'grey'],
  	['user_name',           'Prestataire','',     false,        false,        true,   'user_id',        false,    'black'],
  	['name',                'nom',        '',     false,        false,        true,   'name',           false,    'black'],
  	['cout',                'Cout',       '€',    false,        false,        true,   'cout',           false,    'black'],
  # ['get_cout_total',      'Comptable',  '€',    false,        false,        true,   'get_cout_total', true,     'black'],
    ['ref_client',          'Ref Client', '',     false,        false,        true,   'ref_client',     false,    'black'],
    ['ref',                 'Ref',        '',     false,        false,        true,   'ref',            false,    'grey'],
  	['print_date',          'date',       '',     false,        false,        true,   'date',           false,    'grey'],
    ['adu',                 'adu',        '',     true,         :check_box,   true,   'adu',            false,    'black'], 
   	['get_info_popup',      '?',          '',     false,        true,         true,   '"info"',         false,    'black']
  ]

  FACTURE_HEAD_PAYEES = 
  [
    # KEY                   VALUE         UNIT    FILTER        TYPE          TRI     TRI_KEY           GREEN_RED COLOR
    ['star',                'star',       '',     true,         :check_box,   true,   'star',           false,    'black'], 
    ['pp_paye',             'paye',       '',     true,         :check_box,   true,   'paye',           false,    'black'], 
  	['category_name',       'Categorie',  '',     false,        false,        true,   'category_id',    false,    'grey'],
  	['user_name',           'Presta',     '',     false,        false,        true,   'user_id',        false,    'black'],
  	['name',                'nom',        '',     false,        false,        true,   'name',           false,    'black'],
  	['cout',                'Cout',       '€',    false,        false,        true,   'cout',           false,    'black'],
    ['ref_client',          'Ref Client', '',     false,        false,        true,   'ref_client',     false,    'black'],
    ['ref',                 'Ref',        '',     false,        false,        true,   'ref',            false,    'grey'],
  	['print_date',          'date',       '',     false,        false,        true,   'date',           false,    'grey'],
   	['get_info_popup',      '?',          '',     false,        true,         true,   '"info"',         false,    'black']
  ]

  PRODUIT_HEAD = 
  [
    # KEY                       VALUE         UNIT    FILTER        TYPE          TRI     TRI_KEY
    ['star',                    'star',       '',     true,         :check_box,   true,   'star'        ],
    ['adu',                     'adu',        '',     true,         :check_box,   true,   'adu'         ],
    ['stock_vs_used_pp',        'S',          '',     true,         false,        false,  ''            ],
   	['id',                      'id',         '',     false,        false,        true,   'id'          ],
   	['category_name',           'categorie',  '',     false,        :text_field,  true,   'category_id' ],
   	['name',                    'nom',        '',     true,         :text_field,  true,   'name'        ],
    ['get_cout_total',          'Achat',      '€',    false,        false,        false,  ''            ], 
   	['get_quantite',            'Quantite',   '',     false,        false,        false,  ''            ],
   	['unit',                    '',           '',     false,        false,        true,   'unit'        ],

    ['get_stock',               'Stock',      '',     false,        false,        false,  ''            ], 
   	['unit',                    '',           '',     false,        false,        true,   'unit'        ],
    ['stock_percent_pp',        'reste',      '%',    true,         false,        false,  ''            ],

    ['get_prix_unitaire',       'Prix',       '',     false,        false,        false,  ''            ],
    ['get_prix_unitaire_unit',  '',           '',     false,        false,        false,  ''            ], 
    ['number_of_use',           '',           '',     false,        false,        false,  ''            ]
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
