#!/usr/local/bin/julia

using MultivariatePolynomials
using JuMP
using PolyJuMP
using SumOfSquares

using ArgParse

function try_import(name::Symbol)
    try
        @eval import $name
        return true
    catch e
        return false
    end
end

scs = try_import(:SCS)
csdp = try_import(:CSDP)

isscs(solver) = contains(string(typeof(solver)),"SCSSolver")

# Semidefinite solvers
sdp_solvers = Any[]

# Need 54000 iterations for sosdemo3 to pass on Linux 64 bits
# With 55000, sosdemo3 passes for every platform except Windows 64 bits on AppVeyor
scs && push!(sdp_solvers, SCS.SCSSolver(eps=1e-6, max_iters=60000, verbose=0))

csdp && push!(sdp_solvers, CSDP.CSDPSolver(printlevel=1, maxiter=60000, axtol=1.0e-8, atytol=1.0e-8))



function main(args)
  global sdp_solvers

  s = ArgParseSettings("Example 4 for argparse.jl: " *
                         "more tweaking of the arg fields: " *
                         "dest_name, metvar, range_tested, " *
                         "alternative actions.")

  @add_arg_table s begin
    "--opt1"
      action = :append_const   # appends 'constant' to 'dest_name'
      arg_type = ByteString    # the only utility of this is restricting the dest array type
      constant = "O1"
      dest_name = "O_stack"    # this changes the destination
      help = "append O1"
  end

  s.epilog = """
    freeSir.jl
    """

  parsed_args = parse_args(args, s)
  println("Parsed args:")
  for (key,val) in parsed_args
    println("  $key  =>  $(repr(val))")
  end

  println("calling the solvers")
  for solver in sdp_solvers
    @polyvar x[1:2]
    μ = 0.2
    β = 0.5
    γ = 0.6
    s = 1.
    i = 0.
    R0 = β / ( μ + γ )

    # Constructing the vector field dx/dt = f

    f = [μ - β * (x[1] + s) * (x[2] + i) - μ * (x[1] + s),
        β * (x[1] + s) * (x[2] + i) - (μ + γ) * (x[2] + i)]

    #f = [0.06 - 0.01 * (x[1] + 1.) * x[2] - 0.06 * (x[1] + 1.),
    #    0.01 * (x[1] + 1.) * x[2] - (0.06 + 0.5) * x[2]]

    #println(f)

    m = Model(solver = solver)

    # The Lyapunov function V(x):
    Z = x.^2
    @polyvariable m V Z

    @polyconstraint m V >= 1e-16 * sum(x.^2)

    # dV/dx*f <= 0
    P = dot(differentiate(V, x), f)
    @polyconstraint m P <= 0
    @polyconstraint m x[1] * ( x[1] + 1) <= 0
    @polyconstraint m x[2] * ( x[2] - 1) <= 0

    println(x)

    println("este es el modelo final")
    print(m)
    println("valor de la funcion objetivo", getobjectivevalue(m))

    status = solve(m);

    flyapunov = getvalue(V)
    println("Lyapunov function using $(typeof(solver))")

    println(flyapunov)
    println("Derivada Orbital")
    println(dot(differentiate(flyapunov, x), f))
    println(status)

    println("Basic Reproductive Number")
    println(R0)



      #status --> :Optimal

    #removemonomials(getvalue(V), Z) --> zero(Polynomial{true, Float64})
  end
end

main(ARGS)
