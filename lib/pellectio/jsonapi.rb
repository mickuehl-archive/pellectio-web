

def extract_data(result, relationship=nil)

	data = result['data']['attributes']

	if relationship
		data[relationship] = extract_relationship_data result, relationship
	end

	return data
end

def extract_relationship_data(result, relationship)

	attributes = {}
	result['included'].each do |included|
		attributes[included['id']] = included['attributes']
		attributes[included['id']]['uid'] = included['id']
	end

	collection = []
	result['data']['relationships'][relationship]['data'].each do |data|
		collection << attributes[data['id']]
	end

	return collection
end
