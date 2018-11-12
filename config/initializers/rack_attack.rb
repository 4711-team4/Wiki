# For blocking the users in the list 
Rack::Attack.blocklist("Block users whose IP comes from the restricted IP LIST") do |request|
       	# Requests are blocked if the return value is truthy
	File.readlines(Rails.root.join('config/blacklist')).grep(/#{Regexp.quote(request.ip)}/).any?
end
