using Xkcd221, Test, Random

@testset begin

    rng = Xkcd221RNG()

    @test rng.seed == 4
    c = copy(rng)
    @test c.seed == 4
    copy!(c, rng)
    @test c.seed == 4
    @test c !== rng
    @test c == rng
    @test hash(c) == hash(rng)
    @test hash(c) == hash(rng)
    @test hash(c, UInt(123)) == hash(rng, UInt(123))

    @testset for T in Base.BitInteger_types
        @test rand(rng, T) == 4
    end

    @testset for T in Base.BitInteger_types
        @test rand(rng, T(0):T(10)) == 4
        @test rand(rng, T(3):T(10)) == 7
        @test rand(rng, T(0):T(3)) == 1
        @test rand(rng, T(1):T(2)) == 1
        @test rand(rng, T(10):-1:T(1)) == 6
        @test rand(rng, T(21):-3:T(4)) == 9
        @test rand(rng, T(21):-3:T(14)) == 21
        @test rand(rng, T(21):-3:T(12)) == 18
    end
    @test rand(rng, 0:0) == 0
    @test rand(rng, 12.0:-3:2.0) == 9.0

    a = [1:10;]
    shuffle!(rng, a)
    @test a == [4,3,1,2,6,7,8,9,10,5]

end

