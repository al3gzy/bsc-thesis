Nx = 100; Nt = 1000; T  = 1.0; nu = 0.01/pi; int = 10;
x = linspace(-1,1,Nx+1)';
u0 = -sin(pi*x);

[u_exp, t_exp] = eksplicitna(u0, T, Nx, Nt, nu, int);
[u_imp, t_imp] = implicitna(u0, T, Nx, Nt, nu, int);

save("-mat-binary", "burgers_data.mat", "x", "u_exp", "t_exp", "u_imp", "t_imp");