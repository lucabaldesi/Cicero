require_dependency 'cicero'

class SpeechesController < ApplicationController
	before_filter :authenticate, :only => [:destroy]

	def sandbox
		f = open("lib/greet.bnf")
		@grammar = ""
		f.each_line do |line|
			@grammar += line
		end
		@grammar_name = "Hello linguists"
	end

	def create
		@grammar = params[:grammar]
		@grammar_name = params[:name]
		cic = CicerO.build(@grammar)
		if cic
			if params[:save]
				authenticate
				@user = get_user
				if @user
					@speech = Speech.new({name: @grammar_name, grammar: @grammar, user: @user})
					if cic && @speech.save
						redirect_to @speech
						return
					else
						@error = "grammar name is already in use"
						render "sandbox"
						return
					end
				end
			else
				@speech = "Cicero says"
				@words = cic.speak()
				render "sandbox"
				return
			end
		else
			@error = "grammar is not syntactically correct"
			render "sandbox"
			return
		end
	end

	def show
		@speech = Speech.find_by_name(params[:id])
		if @speech
			cic = CicerO.build(@speech.grammar)
			@words = cic.speak()
		else
			@error = "Fai cacare"
		end
	end

	def index
		@speaches = Speech.all
	end

	def destroy
		@s = Speech.find_by_name(params[:id])
		if @current_user.speech.include? @s
			Speech.destroy(@s)
			@info = "Speech destroyed"
		else
			@error = "Speech "+@s.to_s+" does not belong to you"
		end
		redirect_to @current_user	
	end
end
