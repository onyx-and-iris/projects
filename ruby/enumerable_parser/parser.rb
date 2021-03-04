class ParseBook
	include Enumerable
	
	attr_accessor :lines
	attr_reader :books
	
	def books=(value)
		if value.empty?
			raise "No books to parse!"
		end
		@books = value
	end
	
	def initialize(files)
		self.books = files
		@lines = []
	end
	
	def each
		@lines.each do |line|
			yield line
		end
	end
	
	def get_text
		@books.each do |book|
			File.open(book) do |file|
				these_lines = file.readlines
				@lines.concat(these_lines)
			end
		end
	end 
end


def main(args)
	word = "John"
	print_format = "\n==================================="
	files = Dir.glob('*.txt')
	
	parser = ParseBook.new(files)

	parser.get_text
	
	if args.include? "include"
		puts "Lines that include #{word} #{print_format}"
		puts parser.find_all { |line| line.include? word }
	elsif args.include? "exclude"
		puts "Lines that don't include #{word} #{print_format}"
		puts parser.reject { |line| line.include? word }
	elsif args.include? "sort"
		puts "Sort lines #{print_format}"
		puts parser.sort
	end
end

if __FILE__ == $PROGRAM_NAME
	args = ARGV

	main(args)
end
