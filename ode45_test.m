clc 
clear

m = logspace(0,1,3);
k = 1;
c1 = 0.1;
c3 = 0.1;
tspan = [0 5];
x0 = [10 0];

for i = 1:length(m)
    sol = ode15s(@(t,x) nonlinear_damper(t,x,k,c1,c3,m(i)),tspan,x0);
    graph(i).x = sol.x;
    graph(i).y = sol.y;
end

for i = 1:length(m)
    plot(graph(i).x,graph(i).y(1,:),'-o')
    hold on
    plot(graph(i).x,graph(i).y(2,:),'-*')
end
hold off
legend ('pos','vel')
