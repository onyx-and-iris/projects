def extract(reformatted, word)
    """ more verbose method """
    extract = []
    extract = reformatted.find_all do |line| 
        line.include? word
    end

    extract
end

def extract_map(reformatted, word)
    """ using map and inplace reject """
    extract = reformatted.map { |line| line if line.include? word}
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

def main
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

    extracted = extract(reformatted, 'Lord')
    puts("Lines with LORD in them:")
    puts print_format
    puts extracted

    extracted = extract_map(reformatted, 'Jesus')
    puts("Lines with JESUS in them:")
    puts print_format
    puts extracted
end

if $PROGRAM_NAME == __FILE__
    main
end
