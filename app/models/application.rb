class Application < ActiveRecord::Base
  
  # Veleurs utilisees dans les listes deroulante
  DEFAULT  = 0
  ERROR    = -1

  # Types de reglement
  CHEQUE   = 1
  ESPECE   = 2
  
  # Taux TVA
  TVA_5_5  = 5.5
  TVA_19_6 = 19.6
  
  # Valeurs de listes deroulantes
  PULVE_DOSAGE_UNITS     = [['L/Ha', 'L/Ha'], ['kg/Ha', 'kg/Ha']]
  PRODUIT_QUANTITE_UNITS = [['L', 'L'], ['kg', 'kg']]
  TAUX_TVA               = [['-', DEFAULT], ['5,5%', TVA_5_5],  ['19,6%', TVA_19_6]]
  TYPE_REGLEMENT         = [['-', DEFAULT], ['Cheque', CHEQUE], ['Liquide', ESPECE]]
  TAUX_INVEST            = [['-', DEFAULT], ['3 ans', 36],      ['10 ans', 120],      ['15 ans', 180]]
  VENTE_UNITS            = [['na', nil], ['quintaux', 'qt'], ['tonnes', 't'], ['kg', 'kg'], ['bottes', 'b']]

  # SAISON_ID = GetSession.current_saison_id
  # SAISON    = GetSession.current_saison
  
  #for navigation in headers
  HEADER_KEY   = 0
  HEADER_VALUE = 1

  # HEADER_KEY       = 0
  # HEADER_VALUE     = 1
  # HEADER_UNIT      = 2
  # HEADER_FILTER    = 3
  # HEADER_TYPE      = 4
  # HEADER_TRI       = 5
  # HEADER_TRI_KEY   = 6
  # HEADER_RED_GREEN = 7
  # HEADER_COLOR     = 8
  
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
   	['star',                    'star',       '',     true,         'ignorecase', true,   'star'    ], 
   	['id',                      'id',         '',     true,         'numeric',    true,   'id'      ], 
   	['typecultures',            'Cultures',   '',     true,         'ignorecase', true,  ''        ], 
    ['print_produits',          'Produits',   '',     true,         'ignorecase', true,  ''        ], 
   	['user_name',               'Presta',     '',     true,         'ignorecase', true,   'user_id' ], 
    ['name',                    'nom',        '',     true,         'ignorecase', true,   'name'    ], 
   	['sum_surfaces',            'surface',    'ha',   true,         'numeric',    true,  ''        ], 
  # ['get_cout_ha',             'Cout Ha',    '€/ha', true,         'ignorecase', true,  ''        ], 
  # ['get_cout_total_passage',  'passage',    '€',    true,         'ignorecase', true,  ''        ], 
   	['get_cout_total_produits', 'produits',   '€',    true,         'numeric',    true,  ''        ], 
   	['print_date',              'date',       '',     true,         'ignorecase', true,   'date'    ],
   	['adu',                     'adu',        '',     false,        'ignorecase', true,   'adu'     ], 
   	['get_info_popup',          '?',          '',     false,        'ignorecase', true,   '"info"'  ]
  ]

  VENTE_HEAD = 
  [
    # KEY                     VALUE           UNIT    FILTER        TYPE              TRI     TRI_KEY           GREEN_RED COLOR
    ['star',                  'star',         '',     false,        'ignorecase',     true,   'star',           false,    'black'],
    ['stock',                 'stock',        '',     false,        'ignorecase',     true,   'stock',          false,    'black'],
  # ['pp_paye',               'paye',         '',     true,         'ignorecase',     true,   'paye',           false,    'black'], 
   	['id',                    'id',           '',     true,         'numeric',        true,   'id',             false,    'grey'],
  	['category_name',         'Categorie',    '',     true,         'ignorecase',     true,   'category_id',    false,    'grey'],
  	['user_name',             'Prestataire',  '',     true,         'ignorecase',     true,   'user_id',        false,    'black'],
  	['name',                  'nom',          '',     true,         'ignorecase',     true,   'name',           false,    'black'],
  	['prix',                  'Prix',         '€',    true,         'numeric',        true,   'prix',           false,    'black'],
  	['prix_unitaire',         'Prix Unitaire','',     true,         'numeric',        true,   'prix_unitaire',  false,    'black'],
    ['get_prix_unitaire_unit','',           '',     false,        false,        false,   ''            ], 
  	['quantite',              'Quantite',     '',     true,         'numeric',        true,   'quantite',       false,    'black'],
  	['unit',                  '',             '',     true,         'numeric',        true,   'unit',           false,    'black'],
    ['ref',                   'Ref',          '',     true,         'ignorecase',     true,   'ref',            false,    'grey'],
  	['print_date',            'date',         '',     false,        'ignorecase',     true,   'date',           false,    'grey'],
    ['adu',                   'adu',          '',     false,        'ignorecase',     true,   'adu',            false,    'black'], 
   	['get_info_popup',        '?',            '',     false,        'ignorecase',     true,   '"info"',         false,    'black']
  ]

  FACTURE_HEAD = 
  [
    # KEY                   VALUE         UNIT    FILTER        TYPE            TRI     TRI_KEY           GREEN_RED COLOR
    ['star',                'star',       '',     false,        'ignorecase',   true,   'star',           false,    'black'], 
    # ['pp_paye',             'paye',       '',     false,        'ignorecase',   true,   'paye',           false,    'black'], 
   	['id',                  'id',         '',     true,         'numeric',      true,   'id',             false,    'grey'],
  	['category_name',       'Categorie',  '',     true,         'ignorecase',   true,   'category_id',    false,    'grey'],
    # ['factcat_name',      'class',      '',     true,         'ignorecase',   true,   'factcat_id',     false,    'grey'],
  	['print_factype',       'compta',     '',     true,         'ignorecase',   true,   'factype_id',     false,    'grey'],
  	['type',                'type',       '',     true,         'ignorecase',   true,   'type',           false,    'grey'],
  	['user_name',           'Prestataire','',     true,         'ignorecase',   true,   'user_id',        false,    'black'],
  	['name',                'nom',        '',     true,         'ignorecase',   true,   'name',           false,    'black'],
  	['cout',                'Cout',       '€',    true,         'numeric',      true,   'cout',           false,    'black'],
  # ['get_cout_total',      'Comptable',  '€',    true,         'ignorecase',   true,   'get_cout_total', true,     'black'],
    ['ref_client',          'Ref Client', '',     true,         'ignorecase',   true,   'ref_client',     false,    'black'],
    ['ref',                 'Ref',        '',     true,         'ignorecase',   true,   'ref',            false,    'grey'],
  	['print_date',          'date',       '',     true,         'ignorecase',   true,   'date',           false,    'grey'],
    ['adu',                 'adu',        '',     false,        'ignorecase',   true,   'adu',            false,    'black'], 
   	['get_info_popup',      '?',          '',     false,        'ignorecase',   true,   '"info"',         false,    'black']
  ]

  FACTURE_MULTIPLE_HEAD = 
  [
    # KEY                   VALUE         UNIT    FILTER        TYPE            TRI     TRI_KEY           GREEN_RED COLOR
   	['id',                  'id',         '',     true,         'numeric',      true,   'id',             false,    'grey'],
  	['category_name',       'Categorie',  '',     true,         'ignorecase',   true,   'category_id',    false,    'grey'],
  	['type',                'type',       '',     true,         'ignorecase',   true,   'type',           false,    'grey'],
  	['user_name',           'Prestataire','',     true,         'ignorecase',   true,   'user_id',        false,    'black'],
  	['name',                'nom',        '',     true,         'ignorecase',   true,   'name',           false,    'black'],
  	['cout',                'Cout',       '€',    true,         'numeric',      true,   'cout',           false,    'black'],
  	['print_date',          'date',       '',     true,         'ignorecase',   true,   'date',           false,    'grey'],
    ['star',                'star',       '',     false,        'ignorecase',   true,   'star',           false,    'black'], 
    ['adu',                 'adu',        '',     false,        'ignorecase',   true,   'adu',            false,    'black'], 
   	['get_info_popup',      '?',          '',     false,        'ignorecase',   true,   '"info"',         false,    'black']
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
    ['star',                            'star',       '',     false,        'default',    true,   'star'        ],
    ['stock_vs_used_pp',                'S',          '',     false,         false,        true,   ''            ],
   	['id',                              'id',         '',     true,         'numeric',    true,   'id'          ],
   	['category_name',                   'categorie',  '',     true,         'default',    true,   'category_id' ],
   	['name',                            'nom',        '',     true,         'default',    true,   'name'        ],
    ['get_cout_total',                  'Achat',      '€',    true,         'numeric',    true,   ''            ], 
   	['get_quantite',                    'Quantite',   '',     true,         'numeric',    true,   ''            ],
   	['unit',                            '',           '',     true,         false,        true,   'unit'        ],

    ['get_stock',                       'Stock',      '',     true,         'numeric',    true,   ''            ], 
   	['unit',                            '',           '',     false,        false,        true,   'unit'        ],
    ['stock_percent_pp',                'reste',      '%',    true,         'numeric',    true,   ''            ],

    ['get_prix_unitaire_avant_remise',  'Prix',       '',     true,         'numeric',    true,   ''            ],
    ['get_prix_unitaire',               'Remise',     '',     true,         'numeric',    true,   ''            ],
    ['get_prix_unitaire_unit',          '',           '',     false,        false,        false,   ''            ], 
    ['number_of_use',                   'passages',   '',     false,        'numeric',    true,   ''            ],
    ['adu',                             'adu',        '',     false,        'default',    true,   'adu'         ]
  ]
      
  # XLS format excel
  XLS_FORMAT_TETE = Spreadsheet::Format.new  :color => :black,
                                  :weight => :bold,
                                  :size => 12
  XLS_FORMAT_GRAS = Spreadsheet::Format.new :weight => :bold



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
