Nx = 100;
T = 0.5;
nu = 0.2;
Nt = ceil(2*nu*T*Nx^2);
int = 20;

x = linspace(0,1,Nx+1)';
u0 = zeros(Nx+1,1);
u0(31:70) = 15;

[u_exp, t_exp] = eksplicitna(u0,T,Nx,Nt,nu,int);
[u_imp, t_imp] = implicitna(u0,T,Nx,Nt,nu,int);

set(0, 'defaultaxesfontname', 'Helvetica');
set(0, 'defaulttextfontname', 'Helvetica');
set(0, 'defaultaxesfontsize', 12);
set(0, 'defaulttextfontsize', 12);
lineWidth = 2;

% početno stanje
figure('Position',[100 100 1500 400]);

subplot(1,3,1);
plot(x,u0,'LineWidth',lineWidth);
title('Početni uslov','FontSize',14,'FontWeight','normal');
axis([0 1 -2 16]); grid on;
xlabel('x'); ylabel('u(x,0)');

subplot(1,3,2);
plot(x,u_exp(:,1),'LineWidth',lineWidth);
title('Eksplicitna šema','FontSize',14,'FontWeight','normal');
axis([0 1 -2 16]); grid on;
xlabel('x'); ylabel('u(x,t)');

subplot(1,3,3);
plot(x,u_imp(:,1),'LineWidth',lineWidth);
title('Polu-implicitna šema','FontSize',14,'FontWeight','normal');
axis([0 1 -2 16]); grid on;
xlabel('x'); ylabel('u(x,t)');

% gif – eksplicitna šema
gifname_exp = 'eksplicitna.gif';
figure('Position',[100 100 600 400]);

for k = 1:5:size(u_exp,2)
    plot(x, u_exp(:,k), 'LineWidth', 2);
    axis([0 1 -2 16]); grid on;
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
gifname_imp = 'implicitna.gif';
figure('Position',[100 100 600 400]);

for k = 1:5:size(u_imp,2)
    plot(x, u_imp(:,k), 'LineWidth', 2);
    axis([0 1 -2 16]); grid on;
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
figure;

subplot(1,2,1);
imagesc(t_exp, x, u_exp);
axis xy; colorbar; xlabel('t'); ylabel('x');
title('Eksplicitna šema','FontSize',14,'FontWeight','normal');

subplot(1,2,2);
imagesc(t_imp, x, u_imp);
axis xy; colorbar; xlabel('t'); ylabel('x');
title('Polu-implicitna šema','FontSize',14,'FontWeight','normal');

% poređenje krajnjeg vremena
figure;
plot(x,u_exp(:,end),'-',x,u_imp(:,end),'--','LineWidth',lineWidth);
legend('Eksplicitna','Polu-implicitna','FontSize',12,'Location','northeast');
title('Poređenje na kraju vremena','FontSize',16,'FontWeight','normal');
xlabel('x'); ylabel('u(x,T)'); grid on;

% promena parametara
nus = [0.05, 0.1, 0.2, 0.5];
figure; hold on;
for i = 1:length(nus)
    [u_tmp,~] = eksplicitna(u0,T,Nx,Nt,nus(i),int);
    plot(x,u_tmp(:,end),'LineWidth',lineWidth);
end
legend('nu=0.05','nu=0.1','nu=0.2','nu=0.5','FontSize',12,'Location','northeast');
grid on;
title('Viskoznost i eksplicitna šema','FontSize',16,'FontWeight','normal');
xlabel('x'); ylabel('u(x,T)');
