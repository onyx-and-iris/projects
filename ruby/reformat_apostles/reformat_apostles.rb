require "highline/import"


class Reformat
    attr_accessor :book, :book_name, :book_version
    attr_reader :phrase, :response, :files

    """ validator writer methods """
    def phrase=(value)
        if value.to_s.empty?
            raise "Error phrase should not be blank!"
        end
        @phrase = value
    end

    def response=(value)
        unless (1.. @files.length).include? value.to_i
            raise "Error please choose a number from the list"
        end
        @response = value
    end

    def files=(value)
        if value.nil? || value.empty?
            raise "No books in local repository."
        end
        @files = value
    end

    def initialize(phrase = "Default")
        self.phrase = phrase
        self.files = Dir.glob('*.txt')
    end

    def format_only
        newbook = "book.txt"
    
        reformatted = get_book
    
        File.open(newbook, "w+") do |book|
            book.puts(reformatted)
        end
        reformatted
    end

    def extract(reformatted)
        """ using map and inplace reject """
        extract = reformatted.map { |line| line if line.include? @phrase }
        extract.reject! { |line| line.nil? || line.empty? }
    end

    def reformat_as(lines)
        """ American Standard parser """
        reformat = []
        lines.each_with_index do |line, index|
            nextline = lines[index + 1]

            if /^\d:\d|^\d\d:\d/.match? line
                if (nextline.to_s.strip.empty? || (/^\w/.match? nextline))
                    reformat << "#{line.strip()} #{nextline}"
                end
            end
        end
        reformat
    end

    def reformat_kj(lines)
        """ King James parser """
        reformat = []
        lines.each_with_index do |line, index|
            nextline = lines[index + 1]

            if /^\[\d\]|^\[\d\d\]|^#{@book_name}.\d/.match? line
                if (nextline.to_s.strip.empty? || (/^\w/.match? nextline))
                    reformat << "#{line.strip()} #{nextline}"
                end
            end
        end
        reformat
    end

    def reformat_we(lines)
        """ World English parser """
        reformat = []
        lines.each_with_index do |line, index|
            nextline = lines[index + 1]

            if /^\d:|^\d\d:/.match? line
                if (nextline.to_s.strip.empty? || (/^\w/.match? nextline))
                    reformat << "#{line.strip()} #{nextline}"
                end
            end
        end
        reformat
    end

    def get_book
        """
        Get required book from prompt, then read text from file (acquired
        through apostles.py), then pass to text to the appropriate parser
        """
        @files.reject! { |file| file.include? "book" }
        @files.each_with_index { |file, index| puts "#{index + 1}: #{file}" }

        self.response = ask "Which book to search? (give number):"
        @book = @files[@response.to_i - 1]
        set_bookname_bookver()

        lines = []
        File.open(@book) do |text|
            lines = text.readlines
        end

        if @book_version.eql? "American Standard"
            reformat_as(lines)
        elsif @book_version.eql? "King James"
            reformat_kj(lines)
        elsif @book_version.eql? "World English"
            reformat_we(lines)
        end
    end

    def set_bookname_bookver()
        """ set book_name and book_version from requested book """
        this_book = @book.split('_')
        this_book.map! { |string| string.capitalize() }
        this_book[2].slice!('.txt')
        @book_name = this_book[2]
        @book_version = "#{this_book[0]} #{this_book[1]}"
    end
end

def main(phrase)
    parse_book = Reformat.new(phrase)
    reformatted = parse_book.format_only

    extracted = parse_book.extract(reformatted)
    
    puts "Lines that contain the phrase '#{phrase}' "\
    "from the book of #{parse_book.book_name} "\
    "version #{parse_book.book_version}\n"\
    "==========================================="
    puts extracted
end

if __FILE__ == $PROGRAM_NAME
    args = ARGV

    if args == "r"
        reformat = Reformat.new()
        reformat.format_only
    else
        phrase = args.join(' ')
        main(phrase)
    end
end
