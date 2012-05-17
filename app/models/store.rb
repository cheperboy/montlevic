class Store < ActiveRecord::Base
IMPORT = 'import'
PATH   = "#{RAILS_ROOT}/public/system/files"
FOLDER = "original"
CONTENT_TYPE_XLS = "application/vnd.ms-excel"
  has_attached_file :file

  def self.clean
    Store.all.each do |record|
      if record.tag.eql?(IMPORT)
        # delete the file from the file system
        record.file = nil
        record.save
        #delete the record from the database
        record.delete
      end
    end
  end
  
  #must be called before storing a file for import. 
  # allow only 1 file at a time in the FS
  def save_to_db(type)
    self.tag = type
    self.save
  end
  
  def self.get_file_for_import_content_old
    record = Store.find(:first, :conditions => { :tag => IMPORT})
    if !record.nil? && record.file_file_size.to_i > 0 && record.file_content_type.eql?(CONTENT_TYPE_XLS)
      file = File.read("#{PATH}/#{record.id}/#{FOLDER}/#{record.file_file_name}")
      puts "file #{file.to_s}"
    else
      puts "file.file_size < 0 OR file.nil"
    end
  end
  
  def self.get_file_for_import
    record = Store.find(:first, :conditions => { :tag => IMPORT})
    if !record.nil? && record.file_file_size.to_i > 0 && record.file_content_type.eql?(CONTENT_TYPE_XLS)
      file = File.open("#{PATH}/#{record.id}/#{FOLDER}/#{record.file_file_name}")
      puts "file #{file.to_s}"
      return file
    else
      puts "file.file_size < 0 OR file.nil"
    end
  end
  
  def self.get_file_for_import_path
    record = Store.find(:first, :conditions => { :tag => IMPORT})
    if !record.nil? && record.file_file_size.to_i > 0 && record.file_content_type.eql?(CONTENT_TYPE_XLS)
      file_path = "#{PATH}/#{record.id}/#{FOLDER}/#{record.file_file_name}"
      puts "file_path #{file_path.to_s}"
    else
      puts "file.file_size < 0 OR file.nil"
    end
  end

end
