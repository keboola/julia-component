using Test
using KeboolaConnectionComponent
import JSON

function createconfig(data)
    path = mktempdir();
    ENV["KBC_DATADIR"] = path
    open(path * "/config.json", "w") do file
        JSON.print(file, data, 4)
    end
    path
end

function getconfigdata()
    Dict(
        "storage" => Dict(
            "input" => Dict(
                "tables" => [
                    Dict(
                        "source" => "in.c-main.data",
                        "destination" => "sample.csv"
                    )
                ]
            ),
            "output" => Dict(
                "tables" => [
                    Dict(
                        "source" => "sample.csv",
                        "destination" => "out.c-main.data"
                    )
                ]
            )
        ),
        "parameters" => Dict(
            "packages" => ["matrix"],
            "script" => ["this is a syntax error"]
        )
    )
end

@testset "datadir" begin
    @test KeboolaConnectionComponent.datadir() == "/data/"

    ENV["KBC_DATADIR"] = "/my-data"
    @test KeboolaConnectionComponent.datadir() == "/my-data/"
    delete!(ENV, "KBC_DATADIR")

    ENV["KBC_DATADIR"] = "/my-data/"
    @test KeboolaConnectionComponent.datadir() == "/my-data/"
    delete!(ENV, "KBC_DATADIR")
end

@testset "config.file" begin
    path = createconfig(Dict("a" => "b"))
    ENV["KBC_DATADIR"] = path
    @test KeboolaConnectionComponent.config().action == "run"
    delete!(ENV, "KBC_DATADIR")

    path = mktempdir();
    ENV["KBC_DATADIR"] = path
    open(path * "/config.json", "w") do file
        write(file, "not a valid json")
    end
    @test_throws ErrorException KeboolaConnectionComponent.config().action == "run"
    delete!(ENV, "KBC_DATADIR")

    @test_throws SystemError KeboolaConnectionComponent.config().action == "run"
end

@testset "config.read" begin
    path = createconfig(getconfigdata())
    ENV["KBC_DATADIR"] = path
    config = KeboolaConnectionComponent.config()
    @test config.action == "run"
    @test config.parameters == Dict(
        "packages" => ["matrix"],
        "script" => ["this is a syntax error"]
    )
    @test config.storage == Dict(
        "input" => Dict(
            "tables" => [
                Dict(
                    "source" => "in.c-main.data",
                    "destination" => "sample.csv"
                )
            ]
        ),
        "output" => Dict(
            "tables" => [
                Dict(
                    "source" => "sample.csv",
                    "destination" => "out.c-main.data"
                )
            ]
        )
    )
    @test config.authorization == Dict()
    delete!(ENV, "KBC_DATADIR")
end
