# Xkcd221.jl

[![][CI-img]][CI-url]

A hyper-fast truthful implementation of [XKCD-221](https://xkcd.com/221/)
[PRNG](https://en.wikipedia.org/wiki/Pseudorandom_number_generator) compatible with Julia Random API.

<details>
<summary>If you do not know, now you know.</summary>

![xkcd221](https://imgs.xkcd.com/comics/random_number.png)

</details>

## Usage

In your tests, simply initialize an RNG with a given seed, and use it instead of the default provided one, e.g.

```julia
julia> using Xkcd221

julia> rng = Xkcd221RNG()
Xkcd221RNG(0x0000000000000004)

julia> rand(rng, Int)
4

julia> rand(rng, Int, 3, 3)
3×3 Matrix{Int64}:
 4  4  4
 4  4  4
 4  4  4

julia> @benchmark rand($rng, UInt32)
BenchmarkTools.Trial: 10000 samples with 1000 evaluations.
 Range (min … max):  2.653 ns … 22.204 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     2.656 ns              ┊ GC (median):    0.00%
 Time  (mean ± σ):   2.667 ns ±  0.256 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

    ▅ ▇  █ ▄  ▂ ▁ ▁              ▆ ▇  ▅ ▂    ▁               ▂
  █▁█▁█▁▁█▁█▁▁█▁█▁█▁▁▆▁▄▁▁▃▁▆▁▇▁▁█▁█▁▁█▁█▁▁█▁█▁▆▁▁▅▁▄▁▁▅▁▆▁▄ █
  2.65 ns      Histogram: log(frequency) by time     2.68 ns <

 Memory estimate: 0 bytes, allocs estimate: 0.
```

## Acknowledgments

Thanks to [Rafael Fourquet](https://github.com/rfourquet) for his work on Julia Random API.

[CI-img]: https://github.com/wildart/Xkcd221/actions/workflows/CI.yml/badge.svg
[CI-url]: https://github.com/wildart/Xkcd221/actions/workflows/CI.yml

