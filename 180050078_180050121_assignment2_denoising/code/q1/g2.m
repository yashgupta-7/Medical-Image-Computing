% load('soft.m');

function [prob,grad] = g2(alpha,gamma,I,I_ref)
%     matr=gamma*ones(size(I));
    I1=circshift(I,[0,1]);
    I2=circshift(I,[0,-1]);
    I3=circshift(I,[1,0]);
    I4=circshift(I,[-1,0]);
    prob=alpha*((I-I_ref).*(I-I_ref));
    grad=alpha*2*(I-I_ref);
    sz=size(I);
    N=sz(1);
    M=sz(2);
    I_t=I-I1;
    sz=size(I);
    for i=1:N
        for j=1:M
            if(abs(I_t(i,j))<gamma)
                prob(i,j)=prob(i,j)+0.5*I_t(i,j)*I_t(i,j);
                grad(i,j)=grad(i,j)+I_t(i,j);
            else
                prob(i,j)=prob(i,j)+gamma*abs(I_t(i,j))-0.5*gamma*gamma;
                grad(i,j)=grad(i,j)+gamma*sign(I_t(i,j));
            end
        end
    end
    
     I_t=I-I2;
    sz=size(I);
    for i=1:N
        for j=1:M
            if(abs(I_t(i,j))<gamma)
                prob(i,j)=prob(i,j)+0.5*I_t(i,j)*I_t(i,j);
                grad(i,j)=grad(i,j)+I_t(i,j);
            else
                prob(i,j)=prob(i,j)+gamma*abs(I_t(i,j))-0.5*gamma*gamma;
                grad(i,j)=grad(i,j)+gamma*sign(I_t(i,j));
            end
        end
    end
    
     I_t=I-I3;
    sz=size(I);
    for i=1:N
        for j=1:M
            if(abs(I_t(i,j))<gamma)
                prob(i,j)=prob(i,j)+0.5*I_t(i,j)*I_t(i,j);
                grad(i,j)=grad(i,j)+I_t(i,j);
            else
                prob(i,j)=prob(i,j)+gamma*abs(I_t(i,j))-0.5*gamma*gamma;
                grad(i,j)=grad(i,j)+gamma*sign(I_t(i,j));
            end
        end
    end
    
     I_t=I-I4;
    sz=size(I);
    for i=1:N
        for j=1:M
            if(abs(I_t(i,j))<gamma)
                prob(i,j)=prob(i,j)+0.5*I_t(i,j)*I_t(i,j);
                grad(i,j)=grad(i,j)+I_t(i,j);
            else
                prob(i,j)=prob(i,j)+gamma*abs(I_t(i,j))-0.5*gamma*gamma;
                grad(i,j)=grad(i,j)+gamma*sign(I_t(i,j));
            end
        end
    end
    
%     prob=alpha*((I-I_ref).*(I-I_ref))+((I-I1).*(I-I1))+((I-I2).*(I-I2))+((I-I3).*(I-I3))+((I-I4).*(I-I4));
%     grad=alpha*2*(I-I_ref)+2*(I-I1)+2*(I-I2)+2*(I-I3)+2*(I-I4);
%     val=alpha*I;
end