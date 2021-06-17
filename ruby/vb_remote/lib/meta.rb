module Make_Accessors
    def make_accessor_bool(*params)
        params.each do |method|
            define_singleton_method("#{method}") do |arg=nil|
                return self.getter("#{method}") if arg.nil?
                send("#{method}=", arg)
            end
            define_singleton_method("#{method}=") do |arg|
                self.setter("#{method}", arg)
            end
        end
    end

    def make_accessor_float(*params)
        params.each do |method|
            define_singleton_method("#{method}") do |arg=nil|
                return self.getter("#{method}") if arg.nil?
                send("#{method}=", arg)
            end
            define_singleton_method("#{method}=") do |arg|
                self.setter("#{method}", arg)
            end
        end
    end

    def make_accessor_int(*params)
        params.each do |method|
            define_singleton_method("#{method}") do |arg=nil|
                return self.getter("#{method}") if arg.nil?
                send("#{method}=", arg)
            end
            define_singleton_method("#{method}=") do |arg|
                self.setter("#{method}", arg)
            end
        end
    end

    def make_accessor_buttons(*params)
        params.each_with_index do |method, index|
            define_singleton_method("#{method}") do |arg=nil|
                return self.getter(index+1) if arg.nil?
                send("#{method}=", arg)
            end
            define_singleton_method("#{method}=") do |arg|
                self.setter(arg, index+1)
            end
        end
    end

    def make_setter_action(*params)
        params.each do |method|
            define_singleton_method("#{method}=") do
                self.setter("#{method}")
            end
        end
    end

    def make_accessor_standard(*params)
        params.each do |method|
            define_singleton_method("#{method}") do
                return self.getter("#{method}")
            end
            define_singleton_method("#{method}=") do |arg|
                self.setter("#{method}", arg)
            end
        end
    end

    def make_accessor_in_is_readonly(*params)
        params.each do |method|
            define_singleton_method("#{method}") do
                if method == :bit
                    return self.getter(__method__.to_s) == 1 ? 16 : 24
                end
                return self.getter("#{method}")
            end
            define_singleton_method("#{method}=") do |arg|
                raise IOError::WriteError if self.direction == "in"
                if method == :bit
                    self.setter("#{method}", arg == 16 ? 1 : 2)
                else
                    self.setter("#{method}", arg)
                end
            rescue IOError => error
                puts "#{error.class}: #{error.message} in #{__callee__}"
                raise
            end
        end
    end
end
