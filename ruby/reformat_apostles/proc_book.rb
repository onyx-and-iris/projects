def extract(reformatted, word)
    """ using map and inplace reject """
    extract = reformatted.map { |line| line if line.include? word }
    extract.reject! { |line| line.nil? || line.empty? }
end

def reformat(lines)
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

def main(word)
    book = "book.txt"
    newbook = "newbook.txt"
    print_format = "================================"

    lines = []
    File.open(book) do |text|
        lines = text.readlines
    end

    reformatted = reformat(lines)

    if !File.file?(newbook)
        File.open(newbook, "w+") do |book|
            book.puts(reformatted)
        end
    end

    extracted = extract(reformatted, word)
    puts("Lines with #{word} in them:")
    puts print_format
    puts extracted
end

if __FILE__ == $PROGRAM_NAME
    args = ARGV
    word = args[0]

    main(word)
end
