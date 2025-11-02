function [u_s, t_s] = poluimplicitna(u0, T, Nx, Nt, nu, int)
    dx = 1/Nx;
    dt = T/Nt;

    x = linspace(0,1,Nx+1)';
    u = u0;

    E = ones(Nx-1,1);
    A = nu/dx^2 * spdiags([E -2*E E], -1:1, Nx-1, Nx-1);
    I = speye(Nx-1);
    L = I - dt*A;

    tol = dt^2;
    max_iter = 50;

    num_s = floor(Nt/int);
    u_s = zeros(Nx+1,num_s);
    t_s = zeros(1,num_s);
    k = 1;

    for n = 1:Nt
        u_old = u;
        V = u_old(2:end-1);

        for iter = 1:max_iter
            V_full = [0; V; 0];
            Vx = (V_full(3:end)-V_full(1:end-2))/(2*dx);
            R = u_old(2:end-1) + dt*(-V.*Vx);
            V_new = L\R;

            if norm(V_new-V,Inf) < tol
                break
            end
            V = V_new;
        end

        u(2:end-1) = V_new;
        u(1)=0; u(end)=0;

        if mod(n,int)==0
            u_s(:,k) = u;
            t_s(k) = n*dt;
            k = k+1;
        end
    end
end
