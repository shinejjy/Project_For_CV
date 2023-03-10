str00='k.jpg'; % input image
str0='harris'; % output images
str3=strcat(str0,'gx.bmp'); % ditto
str4=strcat(str0,'gy.bmp'); % ditto
str5=strcat(str0,'signal.bmp'); % ditto
str6=strcat(str0,'maxima.bmp'); % ditto
str7=strcat(str0,'corners.bmp'); % ditto
frame=imread(str00);
grey=rgb2gray(frame);
r0=frame(:,:,1); g0=frame(:,:,2); b0=frame(:,:,3);
[iy,ix]=size(grey);
t0=int16(r0); % note that this image space is int16 rather than uint8
t1=uint8(zeros(iy,ix)); t2=uint8(zeros(iy,ix));
t3=uint8(zeros(iy,ix)); t4=uint8(zeros(iy,ix));
% define elements for 5x5 and 7x7 windows
wx=[0, 1,1,0,-1,-1,-1,0,1, 2,2,1,0,-1,-2,-2,-2,-1,0,1,2];
wy=[0, 0,-1,-1,-1,0,1,1,1, 0,-1,-2,-2,-2,-1,0,1,2,2,2,1];
vx=[0, 1,1,0,-1,-1,-1,0,1, 2,2,2,1,0,-1,-2,-2,-2,-2,-2,...
-1,0,1,2,2,3,3,1,0,-1,-3,-3,-3,-1,0,1,3];
vy=[0, 0,-1,-1,-1,0,1,1,1, 0,-1,-2,-2,-2,-2,-2,-1,0,1,2,...
2,2,2,2,1,0,-1,-3,-3,-3,-1,0,1,3,3,3,1];
% find intensity gradients
gdiv=5; % must be at least 4 or 5
wsizegrad=3;
border=(wsizegrad-1)/2;
for y=1+border:iy-border
for x=1+border:ix-border % NB variables are int16
P4=t0(y-1,x-1); P3=t0(y-1,x); P2=t0(y-1,x+1);
P5=t0(y ,x-1); P0=t0(y ,x); P1=t0(y ,x+1);
P6=t0(y+1,x-1); P7=t0(y+1,x); P8=t0(y+1,x+1);
gx=(P2+2*P1+P8)-(P4+2*P5+P6);
gy=(P2+2*P3+P4)-(P6+2*P7+P8);
tt1=gx/gdiv+128; tt2=gy/gdiv+128;
if tt1>255, tt1=255; elseif tt1<0, tt1=0; end
if tt2>255, tt2=255; elseif tt2<0, tt2=0; end
t1(y,x)=uint8(tt1);
t2(y,x)=uint8(tt2);
end
end
figure, imshow(grey)
figure, imshow(t1)
figure, imshow(t2)
imwrite(uint8(t1),str3);