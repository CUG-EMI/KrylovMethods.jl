using SimpleIterativeSolvers
using Base.Test


println("=== Testing bicgstb for real matrix === ")
A  = sprandn(100,100,.1) + 10*speye(100)
D  = diag(A)
Af(x) = A*x 
M(x)  = D.\x
rhs = randn(100)

x1 = bicgstb(A,rhs,tol=1e-6)
x2 = bicgstb(Af,rhs,tol=1e-6)
x3 = bicgstb(Af,rhs,tol=1e-6,maxIter=100,x=randn(size(rhs)))
x5 = bicgstb(Af,rhs,tol=1e-6,maxIter=100,M1=M)

@test norm(A*x1[1]-rhs)/norm(rhs) < 1e-6
@test norm(A*x2[1]-rhs)/norm(rhs) < 1e-6
@test norm(A*x3[1]-rhs)/norm(rhs) < 1e-6
@test norm(A*x5[1]-rhs)/norm(rhs) < 1e-6
@test norm(x2[1]-x1[1])/norm(x1[1]) < 1e-12
@test norm(x3[1]-x1[1])/norm(x1[1]) < 1e-5

println("Testing bicgstb for complex matrix")
A  = sprandn(100,100,.1) + 10*speye(100) + im*(sprandn(100,100,.1) + 10*speye(100) )
D  = diag(A)
Af(x) = A*x 
M(x)  = D.\x
rhs = randn(100)

x1 = bicgstb(A,rhs,tol=1e-6)
x2 = bicgstb(Af,rhs,tol=1e-6)
x3 = bicgstb(Af,rhs,tol=1e-6,maxIter=100,x=randn(size(rhs)))
x4 = bicgstb(Af,rhs,tol=1e-6,maxIter=100,M1=M)

@test norm(A*x1[1]-rhs)/norm(rhs) < 1e-6
@test norm(A*x2[1]-rhs)/norm(rhs) < 1e-6
@test norm(A*x3[1]-rhs)/norm(rhs) < 1e-6
@test norm(A*x4[1]-rhs)/norm(rhs) < 1e-6
@test norm(x2[1]-x1[1])/norm(x1[1]) < 1e-12
@test norm(x3[1]-x1[1])/norm(x1[1]) < 1e-5

println("=== BICGSTB: All tests passed ===")