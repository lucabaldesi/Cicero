require 'digest'
require 'active_record'

class ActiveRecord::Base
	define_singleton_method :credentials do |name, pwd|
#		raise NameError unless self.attribute_names.include? name.to_s
#		raise NameError unless self.attribute_names.include? pwd.to_s
		define_method :set_pass_shadow do |secret|
			write_attribute pwd, Digest::SHA1.hexdigest("#{secret}")
		end
		alias_method "#{pwd}=".to_sym, :set_pass_shadow 

		define_singleton_method :authenticate do |u,s|
			candidate = __send__("find_by_#{name}", u)
			if candidate
				candidate = nil unless Digest::SHA1.hexdigest("#{s}") == candidate.__send__(pwd) 
			end
			candidate
		end
	end
end

