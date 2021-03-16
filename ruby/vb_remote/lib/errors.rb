module Errors
    class DLLNotFoundError < StandardError
        def message
            "Could not find DLL. Is Voicemeeter installed correctly?"
        end
    end

    class LoginError < StandardError
        def message
            "Failed to login, success return value:"
        end
    end

    class LogoutError < StandardError
        def message
            "There was an error logging out"
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

    class TestingError < StandardError
    end
end
