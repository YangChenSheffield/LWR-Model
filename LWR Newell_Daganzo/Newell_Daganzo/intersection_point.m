% calculate the intersection points of two lines

function [x_0,t_0] = Intersection(lamda1,lamda2,b1,b2)
       
    A=[1,-lamda1;1,-lamda2];
    b=[b1;b2];
    x=A \ b;
    x_0=x(1,1);
    t_0=x(2,1);

end
