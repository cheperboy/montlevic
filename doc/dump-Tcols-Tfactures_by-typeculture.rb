@Tlabours.inspect

{
 :total=>{:sum=>1638.3}, 
 :ha=>{:sum=>10.0}, 
 :categories
 1=>{
	:ha_passage=>10.0, :total=>1638.3, :ha=>10.0, 
	1=>{:total=>1638.3, :ha=>10.0}, 
	:parcelles=>{1=>{:name=>"Ble", :surface=>163.83}}, 
	:parcelles_size=>1, 
	:name=>"moisson", 
	:id=>1, 
	:surface_total=>163.83
	}
}

@Tfactures.inspect
{
 :total=>{1=>1000.0, 2=>0, 3=>0, :sum=>1000.0}, 
 :ha=>{1=>6.1038881767686, 2=>0, 3=>0, :sum=>6.1038881767686}, 
 2=>
  {
  :total=>1000.0, 
  :category=>1, 
  :ha=>6.1038881767686, 
  1=> { :total=>1000.0, :cout_sans_charges=>0, :ha=>6.1038881767686}, 
  :parcelles=>{1=>{:name=>"Ble", :surface=>163.83}}, 
  :cout=>1000.0, 
  :parcelles_size=>1, 
  :name=>"Debit 1", 
  :id=>2, 
  :surface_total=>163.83
  }
}



@Cols.inspect
{
 :benef=>   {:total=>-2638.3, :ha=>-16.1038881767686}, 
 :charges=> {:total=>2638.3, :ha=>16.1038881767686},
 :length=>1, 
 1=>
  {
  :benef=>
   {
    :total=>{1=>0, 2=>0, 3=>0, :sum=>-2638.3}, 
    :ha=>{1=>0, 2=>0, 3=>0, :sum=>-16.1038881767686}}, 
    :ventes=>
     {
      :total=>{:sum=>0}, :ha=>{:sum=>0}
     }, 
    :factures=>{:total=>{1=>0, 2=>0, 3=>0, :sum=>1000.0}, :ha=>{1=>0, 2=>0, 3=>0, :sum=>6.1038881767686}}, 
    :pulves=>{:total=>{:sum=>0.0}, :ha=>{:sum=>0.0}}, 
    :rang=>1, 
    :name=>"Ble",
    :labours=>{:total=>{:sum=>1638.3}, :ha=>{:sum=>10.0}}, :id=>1, 
    :charges=>{:total=>{1=>1000.0, 2=>0, 3=>0, :sum=>2638.3}, :ha=>{1=>6.1038881767686, 2=>0, 3=>0, :sum=>16.1038881767686}},
    :surface=>163.83
   }, 
  :vente_total=>0, 
  :vente_ha=>0, 
  :ids=>[1], 
  :col_model=>Typeculture(id: integer, name: string)
}




@Tcols[1].to_yaml
--- 
:benef: 
  :total: 
    1: 0
    2: 0
    3: 0
    :sum: -2638.3
  :ha: 
    1: 0
    2: 0
    3: 0
    :sum: -16.1038881767686
:ventes: 
  :total: 
    :sum: 0
  :ha: 
    :sum: 0
:factures: 
  :total: 
    1: 0
    2: 0
    3: 0
    :sum: 1000.0
  :ha: 
    1: 0
    2: 0
    3: 0
    :sum: 6.1038881767686
:pulves: 
  :total: 
    :sum: 0.0
  :ha: 
    :sum: 0.0
:rang: 1
:name: Ble
:labours: 
  :total: 
    :sum: 1638.3
  :ha: 
    :sum: 10.0
:id: 1
:charges: 
  :total: 
    1: 0
    2: 0
    3: 0
    :sum: 2638.3
  :ha: 
    1: 0
    2: 0
    3: 0
    :sum: 16.1038881767686
:surface: 163.83


