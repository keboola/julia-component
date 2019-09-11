module KeboolaConnectionComponent

import JSON
include("Config.jl")

"""
`KeboolaConnectionComponent.datadir()` => `String`

Returns the path to the [data directory](https://developers.keboola.com/extend/common-interface/folders/).
"""
function datadir()
    path = get(ENV, "KBC_DATADIR", "/data/")
    if !isdirpath(path)
        path = path * "/"
    end
    path
end

"""
`KeboolaConnectionComponent.config()` => `Config`

Returns the processed configuration.
"""
function config()
    open(joinpath(datadir(), "config.json"), "r") do file
        data = JSON.parse(file)
        Config(
            get(data, "action", "run"),
            get(data, "parameters", Dict()),
            get(data, "storage", Dict()),
            get(data, "image_parameters", Dict()),
            get(data, "authoziation", Dict()),
        )
    end
end

end # module
