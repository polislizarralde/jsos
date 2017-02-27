# Adapted from:
# SOSDEMO2 --- Lyapunov Function Search
# Section 3.2 of SOSTOOLS User's Manual

for solver in sdp_solvers

  @polyvar x[1:2]
  #μ = 0.06
  #β = 0.01
  #γ = 0.5
  #s = 1.
  #i = 0.
  #r = 0.
  #ϵ = 2.2204 * 10^-16

  # Constructing the vector field dx/dt = f
  #f = [μ - β * (x[1] + s) * (x[2] + i) - μ * (x[1] + s),
  #    β * (x[1] + s) * (x[2] + i) - (μ + γ) * (x[2] + i)]

  f = [0.06 - 0.01 * (x[1] + 1.) * x[2] - 0.06 * (x[1] + 1.),
      0.01 * (x[1] + 1.) * x[2] - (0.06 + 0.5) * x[2]]

  println(f)

  m = Model(solver = solver)

  println(m)

  # The Lyapunov function V(x):
  Z = x.^2
  @polyvariable m V Z

  @polyconstraint m V >= 1e-16 * sum(x.^2)

  # dV/dx*f <= 0
  P = dot(differentiate(V, x), f)
  @polyconstraint m P <= 0

  status = solve(m);

  flyapunov = getvalue(V)
  println("Lyapunov function using $(typeof(solver))")

  println(flyapunov)
  println(status)

  #status --> :Optimal

  #removemonomials(getvalue(V), Z) --> zero(Polynomial{true, Float64})
end
