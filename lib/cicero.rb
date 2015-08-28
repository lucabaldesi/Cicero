require 'treetop'

def int_poisson(lambda)
	l = Math.exp(-lambda)
	k = 0
	p = 1
	while p >= l
		k += 1
		u = rand
		p = p *u
	end
	return k - 1
end


class CicerO
	def self.build(grammar, max_recursion = 100)
		Treetop.load "lib/pbnf"
		parser = PseudoBNFParser.new
		res = parser.parse(grammar)
		if res
			return CicerO.new res.content, max_recursion
		else
			return nil
		end
	end

	def speak()
		bucket_dst = [@root]
		progress = true
		bucket_src = []
		loop_count = 0
		
		while progress and loop_count < @max_recursion
			progress = false
			bucket_src = bucket_dst
			bucket_dst = []
			while bucket_src.length > 0
				el = bucket_src.shift()
				# puts "pick element " + el
				if @syn_cat.include? el
					line = get_evolution_line(@syn_cat[el])
					while line.length > 0
						neo = get_name_with_multiplicity(line.shift())
						# puts "pushing " + neo
						neo.each do |n|
							bucket_dst.push(n)
						end
					end
					progress = true
				else
					bucket_dst.push(el)
				end
			end
			# puts "now bucket_dst is " + bucket_dst.to_s
			loop_count += 1
		end
		if loop_count >= @max_recursion
			puts "[WARNING] max recursion level reached"
		end
		(bucket_dst).join(" ")
	end

	def initialize(grammar_arrays, max_recursion)
		@grammar = grammar_arrays.join("").to_s
		@root = @grammar.split(":")[0]
		@max_recursion = 100
		set_syntax_categories(grammar_arrays)
	end

	private 
	def set_syntax_categories(treetoptree)
		@syn_cat = {}
		root = nil
		treetoptree.each do |line|
			key = line[0].split(":")[0]	
			root = key unless root
			@syn_cat[key] = {}
			rules = line[0].split(":")[1].split("|")	
			prob = 0
			rules.each do |rule|
				els = rule.delete(";").split(" ")
				prob += els[0].to_f
				@syn_cat[key][prob] = els[1, els.length-1]
			end
		end
	end

	def get_evolution_line(lines)
		rnd = rand()
		prob = 0
		i = 0
		while rnd > prob and i < lines.length
			prob = lines.keys[i]
			i += 1
		end

		if rnd <= prob and i <= lines.length
			return lines[prob].dup
		else
			return []
		end
	end

	def get_name_with_multiplicity(name)
		time = 1
		res = [name]
		if name.end_with? "+"
			time = int_poisson(2)
			time = 1 if time == 0
			res = [name.delete("+")] * time
		end
		if name.end_with? "*"
			time = int_poisson(2)
			res = [name.delete("*")] * time
		end
		return res
	end
end

if __FILE__ == $0 and ARGV.length > 0
	f = open(ARGV[0])
	data = ""
	f.each_line do |line|
		data += line
	end

	cic = CicerO.build(data)
	if cic
		s = cic.speak()
		puts s
	else
		puts "[ERROR] while parsing"
	end
end
