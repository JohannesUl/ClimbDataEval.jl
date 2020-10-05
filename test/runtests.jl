using ClimbDataEval
using Test


@testset "ClimbDataEval.jl" begin
    @test ClimbDataEval.my_f(2,3) == 7
    @test ClimbDataEval.my_f(3,3) == 9
end


