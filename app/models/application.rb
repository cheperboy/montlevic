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
    # KEY                       VALUE         UNIT    FILTER        TYPE          TRI     TRI_KEY
   	['star',                    'star',       '',     true,         :check_box,   true,   'star'            ], 
   	['adu',                     'adu',        '',     true,         :check_box,   true,   'adu'             ], 
   	['id',                      'id',         '',     false,        false,        true,   'id'              ], 
   	['typecultures',            'Cultures',   '',     false,        false,        false,  ''                ], 
  	['category_name',           'categorie',  '',     false,        false,        true,   'category_id'     ], 
   	['user_name',               'Presta',     '',     false,        :text_field,  true,   'user_id'         ], 
    ['name',                    'nom',        '',     true,         :text_field,  true,   'name'            ], 
  	['cout_ha_passage',         'Cout Ha',    '€/Ha', false,        false,        true,   'cout_ha_passage' ],
  	['get_cout_total',          'Cout Total', '€',    false,        false,        false,  ''                ],
   	['print_date',              'date',       '',     false,        true,         true,   'date'            ],
   	['get_desc_popup',          '?',          '',     false,        true,         true,   '"desc"'          ]
  ]
  
  PULVE_HEAD = 
  [
    # KEY                       VALUE         UNIT    FILTER        TYPE          TRI     TRI_KEY
   	['star',                    'star',       '',     true,         :check_box,   true,   'star'    ], 
   	['adu',                     'adu',        '',     true,         :check_box,   true,   'adu'     ], 
   	['id',                      'id',         '',     false,        false,        true,   'id'      ], 
   	['typecultures',            'Cultures',   '',     false,        false,        false,  ''        ], 
    ['print_produits',          'Produits',   '',     :text_field,  false,        false,  ''        ], 
   	['user_name',               'Presta',     '',     false,        :text_field,  true,   'user_id' ], 
    ['name',                    'nom',        '',     true,         :text_field,  true,   'name'    ], 
   	['sum_surfaces',            'surface',    'ha',   true,         :text_field,  false,  ''        ], 
   	['get_cout_ha',             'Cout Ha',    '€/ha', false,        false,        false,  ''        ], 
   	['get_cout_total_passage',  'passage',    '€',    false,        false,        false,  ''        ], 
   	['get_cout_total_produits', 'produits',   '€',    false,        false,        false,  ''        ], 
   	['print_date',              'date',       '',     false,        true,         true,   'date'    ],
   	['get_desc_popup',          '?',          '',     false,        true,         true,   '"desc"'  ]
  ]

  FACTURE_HEAD = 
  [
    # KEY                       VALUE         UNIT    FILTER        TYPE          TRI     TRI_KEY
  	['star',                    'star',       '',     true,         :check_box,   true,   'star'        ], 
  	['adu',                     'adu',        '',     true,         :check_box,   true,   'adu'         ],
   	['id',                      'id',         '',     false,        false,        true,   'id'          ], 
  # ['typecultures',            'Cultures',   '',     false,        false,        false,  ''            ], 
  	['category_name',           'Categorie',  '',     false,        false,        true,   'category_id' ],
  	['factcat_name',            'class',      '',     false,        false,        true,   'factcat_id'  ], 
  	['print_factype',           'compta',     '',     false,        false,        true,   'factype_id'  ],
  	['type',                    'type',       '',     false,        false,        true,   'type'     ],
  	['user_name',               'Presta',     '',     false,        false,        true,   'user_id'     ],
  	['name',                    'nom',        '',     false,        false,        true,   'name'        ],
  	['cout',                    'Cout',       '€',    false,        false,        true,   'cout'        ],
    ['ref_client',              'Ref Client', '',     false,        false,        true,   'ref_client'  ],
    ['ref',                     'Ref',        '',     false,        false,        true,   'ref'         ], 
  	['print_date',              'date',       '',     false,        false,        true,   'date'        ]
  ]

  PRODUIT_HEAD = 
  [
    # KEY                       VALUE         UNIT    FILTER        TYPE          TRI     TRI_KEY
    ['star',                    'star',       '',     true,         :check_box,  true,    'star'        ],
    ['adu',                     'adu',        '',     true,         :check_box,  true,    'adu'         ],
    ['stock_vs_used_pp',        'S',          '',     true,         false,        false,  ''            ],
   	['id',                      'id',         '',     false,        false,        true,   'id'          ],
   	['category_name',           'categorie',  '',     false,        :text_field, true,    'category_id' ],
   	['name',                    'nom',        '',     true,         :text_field, true,    'name'        ],
   	['get_quantite',            'Quantite',   '',     false,        false,        true,   'quantity'    ],
   	['unit',                    '',           '',     false,        false,        true,   'unit'        ],
    ['get_stock',               'Stock',      '',     false,        false,        false,  ''            ], 
    ['get_cout_total',          'Achat',      '€',    false,        false,        false,  ''            ], 
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
