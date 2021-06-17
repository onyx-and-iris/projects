module Errors
    class ConnectionErrors < StandardError; end
    class LoginError < ConnectionErrors
        def message
            "Failed to login, success return value:"
        end
    end
    class LogoutError < ConnectionErrors
        def message
            "There was an error logging out"
        end
    end
    class VBTypeError < ConnectionErrors
        def on_launch
            "Login was requested but no Voicemeeter type was provided,
            nor was Voicemeeter running. To fix do either of the following:
            a) Provide a Voicemeeter type when you call Remote.new
            b) Ensure that Voicemeeter is running before your program starts"
        end

        def message
            "Unknown Voicemeeter type"
        end
    end


    class InstallErrors < StandardError; end
    class DLLPathNotFoundError < InstallErrors
        def message
            "Could not fetch DLL path. Is Voicemeeter installed correctly?"
        end
    end    
    class DLLNotFoundError < InstallErrors
        def message
            "Could not find DLL. Is Voicemeeter installed correctly?"
        end
    end
    class EXENotFoundError < InstallErrors
        def message
            "Could not find EXE. Is Voicemeeter installed correctly?"
        end
    end


    class BaseErrors < StandardError; end
    class CAPIError < BaseErrors
        def initialize(value)
            @value = value
        end

        def message
            "Callback Function Error, return value: #{@value}"
        end
    end
    class BoundsError < BaseErrors
        def initialize(identifier)
            @identifier = identifier
        end

        def message
            "#{@identifier} out of range"
        end
    end
    class VersionError < BaseErrors
        def message
            "Wrong Voicemeeter version"
        end
    end
    class CommandError < BaseErrors
        def message
            "Command not supported"
        end
    end
    class ValueTypeError < BaseErrors
        def initialize(rec, exp)
            @rec = rec
            @exp = exp
        end

        def message
            "Incorrect value type, received #{@rec}, expected type #{@exp}"
        end
    end
    class ParamValueError < BaseErrors
        def message
            "Parameter value out of range"
        end
    end


    class IOErrors < StandardError; end
    class WriteError < IOErrors
        def message
            "Parameter is read only"
        end
    end
    class ReadError < IOErrors
        def message
            "Parameter is write only"
        end
    end
end
