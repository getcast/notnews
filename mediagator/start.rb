require_relative 'extractor'
Dir["extractors/*.rb"].each do |file|
	require_relative file
end

require_relative 'repository'
Dir["repositories/*.rb"].each do |file|
	require_relative file
end

require_relative 'subscriber'
Dir["subscribers/*.rb"].each do |file|
	require_relative file
end

require_relative 'pooler'
require_relative 'database'
require_relative 'application'
require_relative 'configDSL'
require_relative 'config'

Application.run