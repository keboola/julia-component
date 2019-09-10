module Config
import JSONbuil
include("TableManifest.jl")

function intialize()
    s = "{\"action\" : \"run\"}"
    j = JSON.parse(s)
    return j["action"]
end

end
