% ¥¶¿ÌmodalSignificance
% load modalSig.mat.
close all;
Frequency = Frequency(:,1);
for k = 1: count
        figure(11);
        hold on
        plot(Frequency, modalSig1(:,k));
        figure(12);
        hold on
        plot(Frequency, modalSig2(:,k));
        figure(13);
        hold on
        plot(Frequency, modalSig3(:,k));
end

%%
x = 4:2:16;
% optModalSig1 = find(modalSig1 == max(modalSig1),1);
[row1, ~] = find(modalSig1 == max(modalSig1));
[row2, ~] = find(modalSig2 == max(modalSig2));
figure(98);
plot(x,Frequency(row1),'-*');
hold on
plot(x,Frequency(row2),'-*');

for k = 1:6
        ind11 = row1(k);
        ind12 = row1(k+1);
        modal1k(k) = (Frequency(ind11) - Frequency(ind12));
        
        ind21 = row1(k);
        ind22 = row1(k+1);
        modal2k(k) = (Frequency(ind21) - Frequency(ind22));
end