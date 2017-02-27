# jsos.jl

This package is inspired on SOSTOOLS.

# Requirements

In order to run the examples we will need to install dependencies.
```julia
julia> Pkg.clone("git://github.com/blegat/MultivariatePolynomials.jl")
julia> Pkg.clone("git://github.com/JuliaOpt/PolyJuMP.jl")
julia> Pkg.clone("git://github.com/JuliaOpt/SumOfSquares.jl")
julia> Pkg.add("FactCheck")
julia> Pkg.add("SCS")
julia> Pkg.add("CSDP")
julia> Pkg.update()
```

To interact with plots please install:

```julia
julia> Pkg.update()
julia> Pkg.add("IJulia")
julia> Pkg.add("Interact")
julia> Pkg.add("Reactive")
julia> Pkg.add("Compose")
julia> Pkg.add("Gadfly")
julia> Pkg.add("PyPlot")
julia> Pkg.add("Winston")
```
# Quick Start

Download the code of this repository:

```bash
$ git clone https://github.com/polislizarralde/jsos.git
$ cd jsos
```

Check for the sources, examples in the `test` folder.
