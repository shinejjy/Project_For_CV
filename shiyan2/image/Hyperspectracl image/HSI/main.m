
addpath('./X2Cube/X2Cube')
I=imread('0110.png');
DataCube=X2Cube(I);
for i=1:16
imshow(DataCube(:,:,i),[])
pause(1)
end