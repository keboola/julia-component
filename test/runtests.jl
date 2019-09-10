using Test
using KeboolaConnectionComponent

@testset "config.read" begin
    @test KeboolaConnectionComponent.getAction() == "run"
end
