Nx = 100;
T = 0.5;
nu = 0.2;
int = 20;
Nt = ceil(2*nu*T*Nx^2);
x = linspace(0,1,Nx+1)';
u0 = sin(2*pi*x) + 0.5*sin(10*pi*x) + 0.25*sin(30*pi*x);

[u_exp, t_exp] = eksplicitna(u0,T,Nx,Nt,nu,int);
[u_imp, t_imp] = implicitna(u0,T,Nx,Nt,nu,int);

set(0, 'defaultaxesfontname', 'Helvetica');
set(0, 'defaulttextfontname', 'Helvetica');
set(0, 'defaultaxesfontsize', 12);
set(0, 'defaulttextfontsize', 12);
lineWidth = 2;

% prikaz početnog stanja
figure('Position',[100 100 1200 400]);

subplot(1,3,1);
plot(x,u0,'k','LineWidth',lineWidth);
title('Početni uslov (superpozicija)','FontSize',14,'FontWeight','normal');
xlabel('x'); ylabel('u(x,0)'); grid on;

subplot(1,3,2);
plot(x,u_exp(:,end),'-','LineWidth',lineWidth);
title('Eksplicitna šema','FontSize',14,'FontWeight','normal');
xlabel('x'); ylabel('u(x,T)'); grid on;

subplot(1,3,3);
plot(x,u_imp(:,end),'-','LineWidth',lineWidth);
title('Polu-implicitna šema','FontSize',14,'FontWeight','normal');
xlabel('x'); ylabel('u(x,T)'); grid on;


% gif – eksplicitna šema
gifname_exp = 'superp-eksplicitna.gif';
figure('Position',[100 100 600 400]);

for k = 1:5:size(u_exp,2)
    plot(x, u_exp(:,k), 'LineWidth', 2);
    axis([0 1 -1 1]); grid on;
    xlabel('x'); ylabel('u(x,t)');
    title(sprintf('Eksplicitna šema – t = %.3f', t_exp(k)));
    drawnow;

    frame = getframe(gcf);
    [im, ~] = frame2im(frame);

    % ručna konverzija u uint8 (bez image toolbox)
    if isa(im, "double")
        im = uint8(im * 255);
    end

    if k == 1
        imwrite(im, gifname_exp, "gif", "LoopCount", Inf, "DelayTime", 0.07);
    else
        imwrite(im, gifname_exp, "gif", "WriteMode", "append", "DelayTime", 0.07);
    end
end

% gif – polu-implicitna
gifname_imp = 'superp-implicitna.gif';
figure('Position',[100 100 600 400]);

for k = 1:5:size(u_imp,2)
    plot(x, u_imp(:,k), 'LineWidth', 2);
    axis([0 1 -1 1]); grid on;
    xlabel('x'); ylabel('u(x,t)');
    title(sprintf('Polu-implicitna šema – t = %.3f', t_imp(k)));
    drawnow;

    frame = getframe(gcf);
    [im, ~] = frame2im(frame);

    if isa(im, "double")
        im = uint8(im * 255);
    end

    if k == 1
        imwrite(im, gifname_imp, "gif", "LoopCount", Inf, "DelayTime", 0.07);
    else
        imwrite(im, gifname_imp, "gif", "WriteMode", "append", "DelayTime", 0.07);
    end
end

% površinski prikaz
figure('Position',[100 100 1200 400]);

subplot(1,2,1);
imagesc(t_exp, x, u_exp);
axis xy; colorbar;
xlabel('t'); ylabel('x');
title('Eksplicitna šema','FontSize',14,'FontWeight','normal');

subplot(1,2,2);
imagesc(t_imp, x, u_imp);
axis xy; colorbar;
xlabel('t'); ylabel('x');
title('Polu-implicitna šema','FontSize',14,'FontWeight','normal');
