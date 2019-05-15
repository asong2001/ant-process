%% 江犇翔学长帮忙完成了去噪声的部分。

close all

I0 = imread('2.jpg');
I1 = rgb2gray(I0);
I1 = imresize(I1,0.5,'bicubic');
I1 = double(I1);

I1 = 255-I1;
figure;imshow(I1,[]);

% I01(I01<120) = 0;
% I01(I01>130) = 0;
% I01(I01>0) = 1;

% I2 = imclose(I01,strel('square',8));
% figure;imshow(I01,[]);

I2 = I1;
I2(I2<=100) = 0;
I2(I2>100) = 1;
figure;imshow(I2,[]);

I3 = imclose(I2,strel('square',3));
I3 = imopen(I3,strel('square',10));


figure;imshow(I3,[]);

I4 = I3 - imerode(I3,strel('square',6));
figure;imshow(I4,[]);

figure;
C = detectHarrisFeatures(I4);
imshow(I4),title('Corner角点图'),
hold on
plot(C.Location(:,1), C.Location(:,2), 'ro');
hold off

X = round(C.Location(:,2));
Y = round(C.Location(:,1));
I5 = zeros(size(I4));
for n = 1:size(X,1)
    I5(X(n),Y(n)) = 1;
end
I5 = imdilate(I5,strel('square',6));
% I5 = bwmorph(I5,'thin',inf);
figure;imshow(I5,[]);
I6 = bwlabel(I5);
figure;imshow(I6,[]);
I7 = zeros(size(I6));
for n = 1:max(I6(:))
    Ir = I6;
    Ir(Ir ~= n) = 0;
    Ir(Ir == n) = 1;
    [Irx,Iry] = find(Ir);
    Irmx = round(mean(Irx));
    Irmy = round(mean(Iry));
    I7(Irmx,Irmy) = 1;
end


% I5 =  imdilate(I4,strel('square',10));
% I5 = bwmorph(I5,'thin',inf);
% figure;imshow(I5,[]);

% 
% 
% 
% 
% I1 = rgb2gray(I0);
% figure;
% imshow(I1,[]);
% I2 = imbinarize(I1);
% 
% figure;
% imshow(I2,[]);
% 
% figure;
% imshow(I0,[]);
