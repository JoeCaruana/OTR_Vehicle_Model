function [angleVec] = alignAxis(v1,v2)
r = v2 - v1;
magR = norm(r);
a = acosd(r(1)/magR);
b = acosd(r(2)/magR);
c = acosd(r(3)/magR);
angleVec = [a b c];
end