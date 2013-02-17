# 1. deploiement
## 1.1 useful commands

creer la base, executer seeds.rb
	rake db:reset --trace

## 1.2 creer saison

creer les donnees de la saison:
google spreadsheet : editer fichier assollement avec generation code ruby
copier/coller colonne générée (ruby) dans fichier

	datas/saison_201X.rb

executer macros textmate 
> pour supprimer les "DELETE_BEFORE" et "DELETE_AFTER"

	Bundless/COMPTAGRI/replace_DELETE_BEFORE_AFTER

>pour remplacer les virgules des nombres flottants excel par des points
selectionner uniquement le code généré 

	Bundless/COMPTAGRI/replace_comma_by_point



