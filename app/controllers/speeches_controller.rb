require_dependency 'cicero'

class SpeechesController < ApplicationController
	def sandbox
		f = open("lib/greet.bnf")
		@grammar = ""
		f.each_line do |line|
			@grammar += line
		end
		@grammar_name = "Hello linguists"
	end

	def trysandbox
		@grammar = params[:grammar]
		@grammar_name = params[:name]
		cic = CicerO.build(@grammar)
		if cic
			@speech = cic.speak()
		else
			@error = "grammar is not syntactically correct"
		end
		render "sandbox"
	end
end
