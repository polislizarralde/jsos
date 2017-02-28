# jsos.jl

This package is inspired on SOSTOOLS.

# Requirements

In order to run the examples we will need to install dependencies.
```julia
Pkg.update()
Pkg.clone("git://github.com/blegat/MultivariatePolynomials.jl")
Pkg.clone("git://github.com/JuliaOpt/PolyJuMP.jl")
Pkg.clone("git://github.com/JuliaOpt/SumOfSquares.jl")
Pkg.add("FactCheck")
Pkg.add("SCS")
Pkg.add("CSDP")
Pkg.update()
```

To interact with plots please install:

```julia
Pkg.update()
Pkg.add("IJulia")
Pkg.add("Interact")
Pkg.add("Reactive")
Pkg.add("Compose")
Pkg.add("Gadfly")
Pkg.add("PyPlot")
Pkg.add("Winston")
```
# Quick Start

Download the code of this repository:

```bash
$ git clone https://github.com/polislizarralde/jsos.git
$ cd jsos
```

Check for the sources, examples in the `test` folder.
