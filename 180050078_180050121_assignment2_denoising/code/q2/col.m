I=double(imread('../results/q2_quad/recons.png'));
I=I/255;
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ]; 
imagesc (single (I));
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar