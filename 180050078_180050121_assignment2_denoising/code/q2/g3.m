function [prob,grad] = g3(gamma,alpha,I,I_ref)
    I1=circshift(I,[0,1]);
    I2=circshift(I,[0,-1]);
    I3=circshift(I,[1,0]);
    I4=circshift(I,[-1,0]);
    t1 = alpha*((I-I_ref).*(I-I_ref));
    t2 = gamma*(abs(I-I1)+abs(I-I2)+abs(I-I3)+abs(I-I4));
    t3 = gamma*gamma*(log(1+abs(I-I1)/gamma)+log(1+abs(I-I2)/gamma)+log(1+abs(I-I3)/gamma)+log(1+abs(I-I4)/gamma));
    prob = t1 + t2 - t3;
    grad = alpha*2*(I-I_ref)+gamma*((I-I1)./(gamma+abs(I-I1))+(I-I2)./(gamma+abs(I-I2))+(I-I3)./(gamma+abs(I-I3))+(I-I4)./(gamma+abs(I-I4)));
end