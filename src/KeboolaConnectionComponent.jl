module KeboolaConnectionComponent

import JSON
include("TableManifest.jl")

"""
`KeboolaConnectionComponent.getAction()` => `String`

Returns the component [action](https://developers.keboola.com/extend/common-interface/actions/).
"""
function getAction()
    s = "{\"action\" : \"run\"}"
    j = JSON.parse(s)
    return j["action"]
end

end # module
