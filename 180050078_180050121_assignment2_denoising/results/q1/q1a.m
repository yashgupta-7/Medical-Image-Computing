I_noise=double(imread('../../data/mri_image_noise_level_high.png'));
I=double(imread('../../data/mri_image_noiseless.png'));
I_recon=I_noise;
% imshow(I,[])
sz=size(I);
% sz=[8,8];
N=sz(1);
M=sz(2);
s=0.2;
cnt=0;
k=2.9;
alpha=1/(1+k);
alpha2=1.2*alpha;
alpha3=0.8*alpha;
k2=(1-alpha2)/alpha2;
k3=(1-alpha3)/alpha3;
% para=1/(1+alpha);
gamma=2.1;
gamma2=1.2*gamma;
gamma3=0.8*gamma;
a=[]
g=[]
t=[];
% while(alpha<50)
%     gamma=0.1;
% while(gamma<10)
% %     alpha=0.1;
I_recon=I_noise;
s=0.2
val=[];
while(s>0.00000000001)
%     diff
% cnt
% s
    [prob,grad]=g1(k,I_recon,I_noise);
    val=[val sum(sum(prob))];
    I_new=I_recon-s*grad;
    [prob2,grad2]=g1(k,I_new,I_noise);
    if(sum(sum(prob2))<sum(sum(prob)))
        I_recon=I_new;
        s=s*1.1;
        diff=(sum(sum(prob))-sum(sum(prob2)))/sum(sum(prob));
    else
        s=s/2;
    end
    cnt=cnt+1
%     cnt
    
end
cnt

% % 
% alpha
% gamma
tm=sqrt(sum(sum((I-I_recon).*(I-I_recon))))/sqrt(sum(sum(I.*I)))

% t=[t tm];
% a=[a alpha];
% g=[g gamma];
% 
% gamma=gamma+0.5;
% end
% alpha=alpha+0.1;
% end
 figure()
 title('denoised')
imshow(I_recon,[])
% plot(val)
rmse_mine=sqrt(sum(sum((I-I_recon).*(I-I_recon))))/sqrt(sum(sum(I.*I)))
rmse_noisy=sqrt(sum(sum((I-I_noise).*(I-I_noise))))/sqrt(sum(sum(I.*I)))
