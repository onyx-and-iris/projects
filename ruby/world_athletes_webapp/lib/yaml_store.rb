require 'yaml/store'

class AthleteStore
    def initialize(file_name)
        @store = YAML::Store.new(file_name)
    end

    def save(runner)
        @store.transaction do
            unless runner.id
                max_id = @store.roots.max || 0
                runner.id = max_id + 1
            end
            @store[runner.id] = runner
        end
    end

    def find(id)
        @store.transaction do
            @store[id]
        end
    end

    def show
        @store.transaction do
            @store.roots.map { |id| @store[id] }
        end
    end
end

