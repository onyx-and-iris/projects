def extract(reformatted, word)
    extract = []
    find_lines = reformatted.find_all do |line| 
        line.include? word
    end

    find_lines
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

    puts(extracted)
end

if $PROGRAM_NAME == __FILE__
    main
end
