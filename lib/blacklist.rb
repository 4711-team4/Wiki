# This will be the class that checks if
# a given ip is blacklisted

class Blacklist
  @@file_location = Rails.root.join('config/blacklist')
  #@!method assumes the black list file to be in the config folder
  #@param load_list: load the list at object creation, or later
  def initialize(load_list)
    @list_loaded = load_list
    @list = Array.new
    File.open(@@file_location,'w') unless File.exist?(@@file_location) # create the blacklist file if it isn't there
    reload_list if load_list
  end

  def add_ip(ip)
	  @list.push(ip.chomp("\n"))
  end

  #@!method will return nil if nothing was deleted
  def remove_ip(ip)
    @list.delete(ip)
  end

  def is_blacklisted?(ip)
    @list.include? ip
  end

  def reload_list
    File.open(@@file_location,'r') do |ip_addresses|
      ip_addresses.each_line do |ip|
        @list.push(ip)
      end
    end
  end

  def all_banned_ip
	  while @list.include? "\n" 
		  @list.delete("\n")
	 end
    @list
  end

  def save_list
    # write to the black list file
    File.open(@@file_location, 'w') do |f|
      f.write @list.join("\n")
    end
  end

end
