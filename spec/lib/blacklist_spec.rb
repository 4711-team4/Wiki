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

describe 'Removing Ips from the black list '

