module Errors
    class DLLNotFoundError < StandardError
        def message
            "Could not find DLL for this voicemeeter version"
        end
    end

    class LoginError < StandardError
        def message
            "Failed to login, success return value:"
        end
    end

    class APIError < StandardError
        def message
            "Callback Function Error, return value:"
        end
    end

    class BoundsError < StandardError
        def message
            "Value out of bounds"
        end
    end

    class VersionError < StandardError
        def message
            "Wrong Voicemeeter version"
        end
    end

    class ParamComError < StandardError
        def message
            "Command not supported"
        end
    end

    class ParamTypeError < StandardError
    end
end