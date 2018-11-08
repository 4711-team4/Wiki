# For blocking the users in the list 
Rack::Attack.blocklist("Block users whose IP comes from the restricted IP LIST") do |request|
       	# Requests are blocked if the return value is truthy
	# Put in the list here in place of demoBannedIPList
	# Rails.configuration.demoBannedIPList.include?(request.ip)
end
