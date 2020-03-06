Im_noise=double(imread('../../data/histology_noisy.png'));
Im=double(imread('../../data/histology_noiseless.png'));
prs = [1/(1+0.3) 1/(1+0.6) 1/(1+0.3)];


fin_I = Im; 

for k=1:3
    I_noise = Im_noise(:,:,k);
    I = Im(:,:,k);
    
    I_recon=I_noise;
%     imshow(I,[]);
    sz=size(I);
    N=sz(1);
    M=sz(2);

%     rmsei = [];
    objk = [];
%     for i=1:100
        I_recon=I_noise;
        par = prs(k);
        alpha = (1-par)/par;%%0.1*3; %%%%2.9 for high,5.3 for medium, 6.7 for low
        s=0.02;
        cnt=0;
        diff=1;
        while(s>0.0000000000001)
            [prob,grad]=g1(alpha,I_recon,I_noise);
            objk = [objk sum(sum(prob))];
            I_new=I_recon-s*grad;
            [prob2,grad2]=g1(alpha,I_new,I_noise);
            if(sum(sum(prob2))<sum(sum(prob)))
                I_recon=I_new;
                s=s*1.1;
                diff=(sum(sum(prob))-sum(sum(prob2)))/sum(sum(prob));
            else
                s=s/2;
            end
            cnt=cnt+1; 
        end
        
%         rmsei = [rmsei sqrt(sum(sum((I-I_recon).*(I-I_recon))))/sqrt(sum(sum(I.*I)))];
%     end
    
    figure();
    plot(objk);
    title(strcat('objFunc - ',num2str(k)));
    
    fin_I(:,:,k) = I_recon;
    rmse_mine=sqrt(sum(sum((I-I_recon).*(I-I_recon))))/sqrt(sum(sum(I.*I)));
    fprintf(strcat('rmse_my',num2str(k),' = ',num2str(rmse_mine)));
    fprintf('\n');
    rmse_noisy=sqrt(sum(sum((I-I_noise).*(I-I_noise))))/sqrt(sum(sum(I.*I)));
    fprintf(strcat('rmse_noisy',num2str(k),' = ',num2str(rmse_noisy)));
    fprintf('\n');
end


myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ]; 

fig = figure();
hold on
axis on
% subplot(1,3,1);
fig = figure();
Im=Im/255;
imagesc (single (Im));
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
title('original');

% subplot(1,3,2);
fig = figure();
Im_noise=Im_noise/255;
imagesc (single (Im_noise));
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
title('noisy');
% subplot(1,3,3);
fig = figure();
fin_I=fin_I/255;
imagesc (single (fin_I));
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
title('reconstructed');

rmse_mine=sqrt(sum(sum(sum((Im-fin_I).*(Im-fin_I)))))/sqrt(sum(sum(sum(Im.*Im))));
fprintf(strcat('rmse_my',' = ',num2str(rmse_mine)));
fprintf('\n');
rmse_noisy=sqrt(sum(sum(sum((Im-Im_noise).*(Im-Im_noise)))))/sqrt(sum(sum(sum(Im.*Im))));
fprintf(strcat('rmse_noisy',' = ',num2str(rmse_noisy)));
fprintf('\n');