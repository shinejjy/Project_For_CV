
I=imread('D:\QK\paper\tracking data\HSI\train\rider1\rider1\HSI\0110.png');
DataCube=X2Cube(I);
for i=1:16
imshow(DataCube(:,:,i),[])
pause(1)
end