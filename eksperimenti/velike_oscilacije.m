Nx = 200;
T = 0.05;
nu = 0.05;
int = 20;
Nt = ceil(2*nu*T*Nx^2);
Nt = ceil(100 * Nt);
x = linspace(0,1,Nx+1)';
u0 = 7*sin(15*pi*x) + 5*sin(20*pi*x);

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
title('Početni uslov');
xlabel('x'); ylabel('u(x,0)');
axis([0 1 min(u0) max(u0)]); % ose prilagođene samo ovom subplotu
grid on;

subplot(1,3,2);
plot(x,u_exp(:,1),'LineWidth',lineWidth);
title('Eksplicitna šema');
xlabel('x'); ylabel('u(x,t)');
axis([0 1 min(u_exp(:,1)) max(u_exp(:,1))]); % zasebna osa
grid on;

subplot(1,3,3);
plot(x,u_imp(:,1),'LineWidth',lineWidth);
title('Polu-implicitna šema');
xlabel('x'); ylabel('u(x,t)');
axis([0 1 min(u_imp(:,1)) max(u_imp(:,1))]); % zasebna osa
grid on;


% gif – eksplicitna šema
gifname_exp = 'velike_osc-eksplicitna.gif';
figure('Position',[100 100 600 400]);

for k = 1:20:size(u_exp,2)
    plot(x, u_exp(:,k), 'LineWidth', 2);
    axis([0 1 -12 12]); grid on;
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
gifname_imp = 'velike_osc-implicitna.gif';
figure('Position',[100 100 600 400]);

for k = 1:20:size(u_imp,2)
    plot(x, u_imp(:,k), 'LineWidth', 2);
    axis([0 1 -12 12]); grid on;
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
axis xy; colorbar;
xlabel('t'); ylabel('x');
title('Eksplicitna šema','FontSize',14,'FontWeight','normal');

subplot(1,2,2);
imagesc(t_imp, x, u_imp);
axis xy; colorbar;
xlabel('t'); ylabel('x');
title('Polu-implicitna šema','FontSize',14,'FontWeight','normal');

% poređenje krajnjeg vremena
figure;
plot(x,u_exp(:,end),'-',x,u_imp(:,end),'--','LineWidth',lineWidth);
legend('Eksplicitna','Polu-implicitna','FontSize',12,'Location','northeast');
title('Poređenje na kraju vremena','FontSize',16,'FontWeight','normal');
xlabel('x'); ylabel('u(x,T)'); grid on;

% promena parametara
nus = [0.05, 0.1, 0.2, 0.5];
lineStyles = {'-','--',':','-.'};
figure; hold on;
for i = 1:length(nus)
    [u_tmp,~] = eksplicitna(u0,T,Nx,Nt,nus(i),int);
    plot(x,u_tmp(:,end),'LineWidth',lineWidth,'LineStyle',lineStyles{i});
end
legend('nu=0.05','nu=0.1','nu=0.2','nu=0.5','FontSize',12,'Location','northeast');
grid on;
title('Viskoznost i eksplicitna šema','FontSize',16,'FontWeight','normal');
xlabel('x'); ylabel('u(x,T)');
