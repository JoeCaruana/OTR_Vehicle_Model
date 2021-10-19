function dxdt = nonlinear_damper(t,x,k,c1,c3,m)

% m*d2x/dt2+c1*dx/dt+c3*(dx/dt)^3-k*x = 0
dxdt = zeros(2,1);
dxdt(1) = x(2);
dxdt(2) = 1/m.*(k.*x(1)-c1.*x(2)-c3.*x(2).^3);
end