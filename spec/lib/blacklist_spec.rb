require 'rspec'

describe 'Initializing Blacklist' do
  context 'No file created' do
    it 'should create a new blacklist file' do
      Blacklist.new false
      expect(File.exist? Rails.root.join('config/blacklist')).to eq true
    end
  end
  context 'Black list file created, and is not empty' do
    it 'should load in ip addresses' do
      list = Blacklist.new true
      expect(list.all_banned_ip.size).not_to eq 0
    end
  end
end

describe 'Saving IPs to blacklist' do
  it 'should add a ip' do
    black_list = Blacklist.new false
    black_list.add_ip '127.0.0.1'
    expect(black_list.is_blacklisted? '127.0.0.1').to eq true
    expect(black_list.all_banned_ip.size).to eq 1
  end
end

describe 'If newline characters found' do
  it 'Should remove the newlines' do
   list= Blacklist.new true
   if list.return_list.include? "\n"
      expect(list.all_banned_ip.include? ("\n")).not_to eq true
    else
      list.return_list.push("\n")
      list.return_list.push("\n")
      expect(list.all_banned_ip.include? ("\n")).not_to eq true
   end
  end
end


describe 'Updates in list' do
 it 'should update the file' do
   list= Blacklist.new true
   list.save_list
   list.return_list.each do |item|
   expect((File.read(Rails.root.join('config/blacklist'))).include? item).to eq true
 end
 end
end

describe 'Removing Ips from the black list' do
  context 'there is an ip in the blacklist file' do
    black_list = Blacklist.new true
    if black_list.all_banned_ip.empty?
      black_list.add_ip('1.1.1.1')
      black_list.save_list
    end
    it 'should remove the ip from the file' do
      black_list = Blacklist.new true
      original_size = black_list.all_banned_ip.size
      black_list.remove_ip('1.1.1.1')
      expect(black_list.all_banned_ip.size).to_not eq original_size
    end
  end
end
