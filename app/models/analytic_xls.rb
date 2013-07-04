Spreadsheet.client_encoding = 'LATIN1//TRANSLIT//IGNORE'
class Analytic_xls < ActiveRecord::Base
  # ANCESTRY_MAX 4
  attr_accessor :book, 
                :bold
  
  def initialize
    # formatting
    @bold = Spreadsheet::Format.new :weight => :bold
  end
  
  def write
    self.book = Spreadsheet::Workbook.new
    sheet = self.book.create_worksheet
    sheet.name = "Resultat #{session[:current_saison_id].name}"
    sheet.row(0).concat %w{Name Country Acknowlegement}
    fill_sheet(sheet)
  end

  def fill_sheet(sheet)
    # set_header(sheet)

    sheet.row(1).concat %w{1 2 3 4}
    sheet[1,1] = '=A1+10'
  end
  
  def set_header(sheet)
    tab = []
    # ANCESTRY_MAX.times do tab << ''
    sheet.row(0).concat ['', tab ]
  end
  
  
  
end
