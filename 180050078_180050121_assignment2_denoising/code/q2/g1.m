% load('soft.m');

function [prob,grad] = g1(alpha,I,I_ref)
    I1=circshift(I,[0,1]);
    I2=circshift(I,[0,-1]);
    I3=circshift(I,[1,0]);
    I4=circshift(I,[-1,0]);
    prob=alpha*((I-I_ref).*(I-I_ref))+((I-I1).*(I-I1))+((I-I2).*(I-I2))+((I-I3).*(I-I3))+((I-I4).*(I-I4));
    grad=alpha*2*(I-I_ref)+2*(I-I1)+2*(I-I2)+2*(I-I3)+2*(I-I4);
%     val=alpha*I;
end