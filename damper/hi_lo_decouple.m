clear
clc
close all
%% Load damper tables
cd 'C:\Users\Tarek\Documents\GitHub\OTR_Vehicle_Model\damper\plot images\plotdata'
load('c12_high_0.mat')
load('c12_high_1.mat')
load('c12_high_2.mat')
load('c12_high_3.mat')
load('c12_high_4.mat')
load('c12_low_0.mat')
load('c12_low_2.mat')
load('c12_low_4.mat')
load('c12_low_6.mat')
load('c12_low_10.mat')
load('c12_low_15.mat')
load('c12_low_25.mat')
load('preload_data.mat')
load('r12_high_0.mat')
load('r12_high_1.mat')
load('r12_high_2.mat')
load('r12_high_3.mat')
load('r12_high_4.mat')
load('r12_low_0.mat')
load('r12_low_2.mat')
load('r12_low_4.mat')
load('r12_low_6.mat')
load('r12_low_10.mat')
load('r12_low_15.mat')
load('r12_low_25.mat')

cd 'C:\Users\Tarek\Documents\GitHub\OTR_Vehicle_Model\damper\'
%% Find breakpoints for hi-lo transition
data.preload(1).vel = preload_data(1,1);
data.preload(1).preload = preload_data(1,2);
data.preload(2).vel = preload_data(2,1);
data.preload(2).preload = preload_data(2,2);
for id = 3:length(preload_data)
    data.preload(id).vel = preload_data(id,1);
    data.preload(id).preload = preload_data(id,2);
end
%% Organize data
% compression
data.c12.high(1).id = 4.3;
data.c12.high(1).vel = c12_high_4(:,1);
data.c12.high(1).force = c12_high_4(:,2);
data.c12.high(2).id = 3;
data.c12.high(2).vel = c12_high_3(:,1);
data.c12.high(2).force = c12_high_3(:,2);
data.c12.high(3).id = 2;
data.c12.high(3).vel = c12_high_2(:,1);
data.c12.high(3).force = c12_high_2(:,2);
data.c12.high(4).id = 1;
data.c12.high(4).vel = c12_high_1(:,1);
data.c12.high(4).force = c12_high_1(:,2);
data.c12.high(5).id = 0;
data.c12.high(5).vel = c12_high_0(:,1);
data.c12.high(5).force = c12_high_0(:,2);

for idx = 1:7
    idy = [0 2 4 6 10 15 25];
    idy = idy(idx);
%     compression
    data.c12.low(idx).id = idy;
    mstr = sprintf('data.c12.low(%d).vel = c12_low_%d(:,1);',[idx,idy]);
    eval(mstr)
    mstr = sprintf('data.c12.low(%d).force = c12_low_%d(:,2);',[idx,idy]);
    eval(mstr);
%     rebound
    data.r12.low(idx).id = idy;
    mstr = sprintf('data.r12.low(%d).vel = r12_low_%d(:,1);',[idx,idy]);
    eval(mstr)
    mstr = sprintf('data.r12.low(%d).force = r12_low_%d(:,2);',[idx,idy]);
    eval(mstr);
end

% rebound
data.r12.high(1).id = 4.3;
data.r12.high(1).vel = r12_high_4(:,1);
data.r12.high(1).force = r12_high_4(:,2);
data.r12.high(2).id = 3;
data.r12.high(2).vel = r12_high_3(:,1);
data.r12.high(2).force = r12_high_3(:,2);
data.r12.high(3).id = 2;
data.r12.high(3).vel = r12_high_2(:,1);
data.r12.high(3).force = r12_high_2(:,2);
data.r12.high(4).id = 1;
data.r12.high(4).vel = r12_high_1(:,1);
data.r12.high(4).force = r12_high_1(:,2);
data.r12.high(5).id = 0;
data.r12.high(5).vel = r12_high_0(:,1);
data.r12.high(5).force = r12_high_0(:,2);
%% define low speed dampening segements
% compression
for idx = 1:7
	idy = [0 2 4 6 10 15 25];
    idy = idy(idx);
%     compression
    limit = length(find(data.c12.low(idx).force<data.preload(1).preload));
    c12.low(idx).id = idy;
	if limit == 0 %#ok<ALIGN>
        c12.low(idx).force = data.c12.low(idx).force;
        c12.low(idx).vel = data.c12.low(idx).vel;
    else
        c12.low(idx).force = data.c12.low(idx).force(1:limit);
        c12.low(idx).vel = data.c12.low(idx).vel(1:limit);
    end
end
for idx = 1:7
	idy = [0 2 4 6 10 15 25];
    idy = idy(idx);
%     rebound
    limit = length(find(data.r12.low(idx).force>data.preload(end).preload));
    r12.low(idx).id = idy;
	if limit == 0 %#ok<ALIGN>
        r12.low(idx).force = data.r12.low(idx).force;
        r12.low(idx).vel = data.r12.low(idx).vel;
    else
        r12.low(idx).force = data.r12.low(idx).force(1:limit);
        r12.low(idx).vel = data.r12.low(idx).vel(1:limit);
    end
end
%% Plot 4.3 hi-lo low speed parameter sweep
figure
for idx = 1:7
    plot(data.c12.low(idx).vel,data.c12.low(idx).force)
    hold on
end
%% Plot low speed damping segments
close all
for idx = 1:7
    plot(c12.low(idx).vel,c12.low(idx).force)
    hold on
    plot(r12.low(idx).vel,r12.low(idx).force)
end
%% Define high speed damping segements
for idx = 1:5
    limit = length(find(data.c12.high(idx).force<data.preload(idx).preload));
    c12.high(idx).id = data.c12.high(idx).id;
    c12.high(idx).force = data.c12.high(idx).force(limit+1:end);
    c12.high(idx).vel = data.c12.high(idx).vel(limit+1:end);
    c12.high(idx).vel = c12.high(idx).vel - c12.high(idx).vel(1);
    
%     plot
    plot(c12.high(idx).vel,c12.high(idx).force)
    hold on
end

% curve fit 3-0 high speed curves using poly1
velx = 1:c12.high(1).vel(end);
for idx = 2:5
    pp(idx,:) = polyfit(c12.high(idx).vel,c12.high(idx).force,1);
    c12.high(idx).gradient = pp(idx,1);
    c12.high(idx).trendline = polyval(pp(idx,:),velx);
%     plot
    plot(velx,c12.high(idx).trendline,'--r')
    hold on 
end
hold off
grid minor
grid on
%% scatter3 for completed hi-lo sweeps
% scatter3(x,y,z)
x = [];
for idx = 1:7
    idtemp = data.c12.low(idx).id*ones(length(data.c12.low(idx).force),1);
    x = vertcat(x,idtemp);
end
y = cell2mat({data.c12.low.vel}.');
z = cell2mat({data.c12.low.force}.');
scatter3(x,y,z);
hold on

% convert to surface with fitting
f = fittype('biharmonicinterp');
[sf,gof] = fit([x,y],z,f);
plot(sf,[x,y],z)
xlim([0 25])
ylim([0 254.77])
zlim([-50 780.6])
%% Plot hi-lo damping together
close all
for idx = 1:7
plot(c12.low(idx).vel,c12.low(idx).force)
hold on
plot(c12.low(idx).vel(end)+c12.high(1).vel,...
    c12.high(1).force)
end
hold off
xlim([0 254.77])
ylim([-50 780.6])

legend('lo','hi')
%% trying to clean breakpoints for lowspeed
f = fittype('cubicspline');
for int = 1:length(c12.low)
    figure
    [sf,gof] = fit(c12.low(int).x,c12.low(int).y,f);
    sprintf('r%d = %.5f',[int,gof.rsquare])
    plot(sf,c12.low(int).x,c12.low(int).y)
end
%%
% Extra stuff for Jo
% Integrate each low speed curve
int(1) = trapz(x0,y0);
int(2) = trapz(x2,y2);
int(3) = trapz(x4,y4);
int(4) = trapz(x6,y6);
int(5) = trapz(x10,y10);
int(6) = trapz(x15,y15);
% int(7) = trapz(x25,y25);
figure
x = 1:length(int);
plot(x0,y0,x2,y2,x4,y4,x6,y6,x10,y10,x15,y15,x25,y25) 

figure
scatter(x,int)
p = polyfit(x,int,1);
hold on
yp = polyval(p,x);
plot(x,yp,'r')
hold off
legend('trapz','reg fit','Location','northwest')

% residuals
r = int-yp;
figure
plot(x,r)
magr = norm(r);
absmaxr = max(abs(r));

