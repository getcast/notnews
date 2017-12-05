require 'sequel'

class Database
	def self.config connection, &blk
		@@DB =
		  if connection.instance_of? Hash
				Sequel.connect(**connection) 
			else
				Sequel.connect(connection)
			end
		@@DB.instance_eval &blk
	end

	def self.[] relation
		@@DB[relation]
	end
end