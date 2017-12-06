module Web::Controllers::News
  class Show
    include Web::Action
	expose :rep
    def call(params)
	
	@rep = NewsRepository.new.take(300)
	puts(@rep.first.to_h)		
    end
  end
end
