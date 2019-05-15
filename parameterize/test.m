clc;
x = 1:100;
y = x.^2;

figure(1);
plot(x,y);

y2 = x.^0.5;
figure(2);
plot(x,y2);
