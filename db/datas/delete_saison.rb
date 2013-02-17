# _______________________________________
#  ATTENTION                            \
#  CE CODE SUPPRIME                     \
#   - UNE SAISON (model saison)         \
#   - LES PARCELLES DE LA SAISON        \
#                                       \
# DECOMMANTER LE CODE POUR UTILISER     \
# ______________________________________\
  
# Choix de la Saison
saison = Saison.find_by_year('2013')
name = saison.name

if (saison.factures || saison.pulves || saison.ventes)
  puts "LA SAISON POSSEDE DES OBJETS vente ou facture ou pulve"
  puts "PAS DE DESTRUCTION !"
else    
  # DESTRUCTION DES PARCELLES
  # detruit aussi les zonetopas car 
  saison.parcelles.delete_all

  # DESTRUCTION DE LA SAISON
  saison.delete

  puts "LA SAISON #{name} ET SES PARCELLES SONT SUPPRIMEES"

end

