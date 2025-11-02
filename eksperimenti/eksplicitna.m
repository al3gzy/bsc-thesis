function [u_s, t_s] = eksplicitna(u0, T, Nx, Nt, nu, int)
    dx = 1/Nx;
    dt = T/Nt;

    x = linspace(0,1,Nx+1)';
    u = u0;
    u_novo = u;

    num_s = floor(Nt/int);
    u_s = zeros(Nx+1,num_s);
    t_s = zeros(1,num_s);
    k = 1;

    for n = 1:Nt
        u_staro = u;

        for j = 2:Nx
            ux = (u_staro(j+1)-u_staro(j-1))/(2*dx);
            uxx = (u_staro(j+1)-2*u_staro(j)+u_staro(j-1))/(dx^2);
            u_novo(j) = u_staro(j) + dt*(-u_staro(j)*ux + nu*uxx);
        end

        u = u_novo;

        if mod(n,int)==0
            u_s(:,k) = u;
            t_s(k) = n*dt;
            k = k+1;
        end
    end
end
