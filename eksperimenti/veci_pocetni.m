Nx = 100;
T = 0.5;
nu = 0.2;
int = 20;
x = linspace(0,1,Nx+1)';
dx = x(2)-x(1);
Nt = ceil(2*nu*T*Nx^2);
amplitude = [1, 5, 10, 50];

set(0, 'defaultaxesfontname', 'Helvetica');
set(0, 'defaulttextfontname', 'Helvetica');
set(0, 'defaultaxesfontsize', 12);
set(0, 'defaulttextfontsize', 12);
lineWidth = 2;

% različiti početni uslovi – eksplicitna šema
figure('Position',[100 100 1200 400]);
for k = 1:length(amplitude)
    u0 = zeros(Nx+1,1);
    u0(31:70) = amplitude(k);
    [u_exp, t_exp] = eksplicitna(u0,T,Nx,Nt,nu,int);

    subplot(2,2,k);
    imagesc(t_exp, x, u_exp);
    axis xy; colorbar;
    xlabel('t'); ylabel('x');
    title(['Eksplicitna, A = ', num2str(amplitude(k))],'FontSize',16,'FontWeight','normal');
end

% različiti početni uslovi – implicitna šema
figure('Position',[100 100 1200 400]);
for k = 1:length(amplitude)
    u0 = zeros(Nx+1,1);
    u0(31:70) = amplitude(k);
    [u_imp, t_imp] = implicitna(u0,T,Nx,Nt,nu,int);

    subplot(2,2,k);
    imagesc(t_imp, x, u_imp);
    axis xy; colorbar;
    xlabel('t'); ylabel('x');
    title(['Polu-implicitna, A = ', num2str(amplitude(k))],'FontSize',16,'FontWeight','normal');
end

% poređenje – eksplicitna šema
figure; hold on;
for k = 1:length(amplitude)
    u0 = zeros(Nx+1,1);
    u0(31:70) = amplitude(k);
    [u_exp, ~] = eksplicitna(u0,T,Nx,Nt,nu,int);
    plot(x, u_exp(:,end), 'LineWidth', lineWidth);
end
legend(arrayfun(@(A) ['A=', num2str(A)], amplitude, 'UniformOutput', false), ...
       'FontSize',12,'Location','northeast');
title('Eksplicitna šema – različite amplitude','FontSize',16,'FontWeight','normal');
xlabel('x'); ylabel('u(x,T)'); grid on;

% poređenje – implicitna šema
figure; hold on;
for k = 1:length(amplitude)
    u0 = zeros(Nx+1,1);
    u0(31:70) = amplitude(k);
    [u_imp, ~] = implicitna(u0,T,Nx,Nt,nu,int);
    plot(x, u_imp(:,end), 'LineWidth', lineWidth);
end
legend(arrayfun(@(A) ['A=', num2str(A)], amplitude, 'UniformOutput', false), ...
       'FontSize',12,'Location','northeast');
title('Polu-implicitna šema – različite amplitude','FontSize',16,'FontWeight','normal');
xlabel('x'); ylabel('u(x,T)'); grid on;
