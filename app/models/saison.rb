class Saison < ActiveRecord::Base

    has_many :parcelles
    has_many :labours
    has_many :pulves
    has_many :factures
    has_many :reportables

    has_one :setting    
end
