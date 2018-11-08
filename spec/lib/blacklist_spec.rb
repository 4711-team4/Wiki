require 'rspec'

describe 'Initializing Blacklist' do
  context 'No file created' do
    it 'should create a new blacklist file' do
      Blacklist.new false
      expect(File.exist? Rails.root.join('config/blacklist')).to eq true
    end
  end
  context 'Black list file created' do
    it 'should load in ip addresses' do

    end
  end
end

describe 'Saving IPs to blacklist' do

end