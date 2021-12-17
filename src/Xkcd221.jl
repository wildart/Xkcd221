module Xkcd221

export Xkcd221RNG

using Random: Random, AbstractRNG, Sampler, SamplerType, LessThan

import Random: rand, seed!

mutable struct Xkcd221RNG <: AbstractRNG
    seed::UInt64
    Xkcd221RNG(seed::Integer = 4) = new(seed)
end

function Base.copy!(dst::Xkcd221RNG, src::Xkcd221RNG)
    dst.seed = src.seed
    dst
end

Base.copy(src::Xkcd221RNG) = Xkcd221RNG(src.seed)

Base.:(==)(x::Xkcd221RNG, y::Xkcd221RNG) = x.seed == y.seed

Base.hash(rng::Xkcd221RNG, h::UInt) = hash(rng.seed, 0x2bad40c9493e0718 % UInt ⊻ h)

## Sampling

rand(rng::Xkcd221RNG, ::SamplerType{UInt64}) = rng.seed

for T = [Bool, Base.BitInteger_types...]
    T === UInt64 && continue
    @eval rand(rng::Xkcd221RNG, ::SamplerType{$T}) = rand(rng, UInt64) % $T
end

Random.rng_native_52(::Xkcd221RNG) = UInt64

function rand(rng::Xkcd221RNG, sp::LessThan)
    x = rand(rng, sp.s)
    sp.sup < rng.seed ? x % sp.sup  : x
end

## Range Sampling

struct RangeSampler{T} <: Sampler{T}
    s::T
    m::UInt64
end

function RangeSampler(r::AbstractUnitRange{T}) where {T}
    isempty(r) && throw(ArgumentError("range must be non-empty"))
    m = (last(r) - first(r)) % unsigned(T) % UInt64
    RangeSampler(first(r), m)
end

function rand(rng::Xkcd221RNG, sp::RangeSampler{T}) where {T}
    x = !iszero(sp.m) ? ((sp.m>rng.seed ? rng.seed : (rng.seed%sp.m))) : 0
    (sp.s % UInt64 + x) % T
end

for T in Base.BitInteger_types
    @eval Sampler(::Type{Xkcd221RNG}, rg::AbstractUnitRange{$T}, ::Random.Repetition) = RangeSampler(rg)
end


end

