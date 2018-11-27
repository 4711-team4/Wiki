# For blocking the users in the list 


Rack::Attack.blocklisted_response = lambda{ |_env| [ 403, { "Content-Type" => "text/plain" }, [ "You have been blocked from the system. If you think this has been done in error, please contact Admin. Thank you." ] ]} 
Rack::Attack.blocklist("Block users whose IP comes from the restricted IP LIST") do |request|
       	# Requests are blocked if the return value is truthy
	File.readlines(Rails.root.join('config/blacklist')).grep(/#{Regexp.quote(request.ip)}/).any?
end
