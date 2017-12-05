class Application
	@@poolers = []

	def self.run
		threads = []
		@@poolers.each do |pooler|
			t = Thread.new { pooler.pool }
			t.run
			threads << t
		end

		threads.each do |t|
			t.join
		end
	end
end