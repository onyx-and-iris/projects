require "rake/testtask"

task default: %w[basic:pass]

namespace :basic do
    Rake::TestTask.new :pass do |task|
        desc "PASS tests for type BASIC"
        task.pattern = "test/basic/pass/*_minitest.rb"
        task.warning = false 
    end

    Rake::TestTask.new :errors do |task|
        desc "ERROR tests for type BASIC"
        task.pattern = "test/basic/errors/*_minitest.rb"
        task.warning = false 
    end

    Rake::TestTask.new :macros do |task|
        desc "Isolate Macrobutton tests for type BASIC"
        task.pattern = "test/basic/pass/macrobutton_*.rb"
        task.warning = false 
    end

    Rake::TestTask.new :setandget do |task|
        desc "Isolate Setter and Getter tests for type BASIC"
        task.pattern = "test/basic/pass/setandget*.rb"
        task.warning = false 
    end

    Rake::TestTask.new :alias do |task|
        desc "Isolate Setter and Getter tests for type BASIC"
        task.pattern = "test/basic/pass/*_withalias_minitest.rb"
        task.warning = false 
    end 

    Rake::TestTask.new :vban do |task|
        desc "Isolate VBAN tests for type BASIC"
        task.pattern = "test/basic/pass/setvban*.rb"
        task.warning = false 
    end 
end

namespace :banana do
    Rake::TestTask.new :pass do |task|
        desc "PASS tests for type BANANA"
        task.pattern = "test/banana/pass/*_minitest.rb"
        task.warning = false 
    end
    
    Rake::TestTask.new :errors do |task|
        desc "ERROR tests for type BANANA"
        task.pattern = "test/banana/errors/*_minitest.rb"
        task.warning = false 
    end

    Rake::TestTask.new :macros do |task|
        desc "Isolate Macrobutton tests for type BANANA"
        task.pattern = "test/banana/pass/macrobutton_*.rb"
        task.warning = false 
    end
    
    Rake::TestTask.new :setandget do |task|
        desc "Isolate Setter and Getter tests for type BANANA"
        task.pattern = "test/banana/pass/setandget*.rb"
        task.warning = false 
    end 

    Rake::TestTask.new :vban do |task|
        desc "Isolate VBAN tests for type BANANA"
        task.pattern = "test/banana/pass/setvban*.rb"
        task.warning = false 
    end 
end

namespace :potato do
    Rake::TestTask.new :pass do |task|
        desc "PASS tests for type POTATO"
        task.pattern = "test/potato/pass/*_minitest.rb"
        task.warning = false 
    end

    Rake::TestTask.new :errors do |task|
        desc "ERROR tests for type POTATO"
        task.pattern = "test/potato/errors/*_minitest.rb"
        task.warning = false 
    end

    Rake::TestTask.new :macros do |task|
        desc "Isolate Macrobutton tests for type POTATO"
        task.pattern = "test/potato/pass/macrobutton_*.rb"
        task.warning = false 
    end

    Rake::TestTask.new :setandget do |task|
        desc "Isolate Setter and Getter tests for type POTATO"
        task.pattern = "test/potato/pass/setandget*.rb"
        task.warning = false 
    end 

    Rake::TestTask.new :vban do |task|
        desc "Isolate VBAN tests for type POTATO"
        task.pattern = "test/potato/pass/setvban*.rb"
        task.warning = false 
    end 
end
