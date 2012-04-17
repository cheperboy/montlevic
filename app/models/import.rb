class Import < ActiveRecord::Base
  attr_accessor :all_valid, :row_num, :datas

  class Retour
    attr_reader :valid, :data, :errors 
    def initialize(valid=true)
      @valid  = valid
      @data   = nil
      @errors = nil
    end
  
    def <<(option)
      @options << option
    end
  end
    
  # ----- Constantes -----
  XLS_ROW_NUM         = 0
  XLS_NAME            = 1
  XLS_USER            = 2
  XLS_COUT_HA_PASSAGE = 3

  def initialize(elt_type)
    @all_valid = true
    @row_num   = 0
    @datas     = {} 
    @datas[elt_type] = [] #elements 
    @datas[:errors]  = [] #errors 
    @datas[:warnings]  = [] #warnings 
  end

  def calculate
    @row_num += 1
  end 
  
  def read_sheet(sheet)
    puts "read_sheet" 
    @row_num = 0
    sheet.each do |row|
      unless (row[XLS_NAME].nil? || row[XLS_ROW_NUM].eql?('#'))
        @row_num += 1
        puts "\trow: #{@row_num}" 
        @datas[:errors][@row_num] = [] #details sur les erreurs si valid==false
        @datas[:warnings][@row_num] = [] #details sur les erreurs si valid==false
        pulve = Pulve.new()
        user_id = get_user_id(row[XLS_USER], @row_num)
        cout_ha_passage = get_cout_ha_passage(row[XLS_COUT_HA_PASSAGE], @row_num)
        pulve.update_attributes(
          :name            => row[XLS_NAME], 
          :user_id         => user_id, 
          :cout_ha_passage => cout_ha_passage) 

        check_pulve_already_imported(pulve, @row_num)
        @datas[:pulves] << pulve
        unless @datas[:errors][@row_num].empty?
          puts "\tErrors:" 
          @datas[:errors][@row_num].each {|msg| puts "\t\t- #{msg}"}
        else
          # ret[:all_valid] = true
          puts "\t\tvalid"
        end
      end
    end
    puts "@row_num#{@row_num}"
    return()
  end

private

  def add_error(error, id)
    @datas[:errors][id] << "#{error}"
    @all_valid = false
  end

  def add_warning(error, id)
    @datas[:warnings][id] << "#{error}"
    @all_valid = false
  end

  def error_already_exist(error, id)
    errors = []
    errors << error
    return ((@datas[:errors][id] & errors).size>0)
  end
  
  def warning_already_exist(warning, id)
    warnings = []
    warnings << warning
    return ((@datas[:warnings][id] & warnings).size>0)
  end
  
  def get_user_id(user_code, id)
    if user = User.find_by_code("user_code")
      return user.id
    else
      error = 'user not found'
      add_error(error, id)
      return nil
    end
  end
  
  def get_cout_ha_passage(cout_ha_passage, id)
    if (cout_ha_passage.class.eql?(Integer) || cout_ha_passage.class.eql?(Float))
      return cout_ha_passage
    else
      error = "cout_ha_passage n'est pas un nombre"
      add_error(error, id)
      return nil
    end
  end
  
  def check_pulve_already_imported(element, id)
    Pulve.find_by_saison(:all).each do |pulve|
      puts "pulve :#{pulve.name}"
      if (pulve.name.eql?(element.name))
        error = "semble etre deja importe"
        add_warning(error, id) unless warning_already_exist(error, id)
      end
    end
  end
  
  def self.load_sheet(name)
    book = Spreadsheet.open Rails.root.join('doc', 'xls_import', 'pulves.xls')
    raise 'book not found' if book.nil?
    sheet = book.worksheet name
    raise 'book not found' if sheet.nil?
    return sheet
  end

  def find_user_old(code)
    ret = retour.new()
    if user = User.find_by_code(code)
      ret.data = user
    else
      ret.errors = 'user not found'
      ret.valid = false
    end
    return ret
  end


end