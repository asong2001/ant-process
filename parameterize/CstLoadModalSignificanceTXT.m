function [Frequency, ModalSignificance] = CstLoadModalSignificanceTXT(exportPath, NumberOfModesCMA)

for k = 1:NumberOfModesCMA
        filenameTXT = [exportPath, 'Mode ', num2str(k), '.txt'];
        fid   = fopen(filenameTXT,'r');
        scannedSparam = textscan(fid, '%f %f', 'Delimiter','Whitespace','HeaderLines',2);
        fclose(fid);
        SP = cell2mat(scannedSparam);
        Frequency(:,k) = SP(:,1);
        ModalSignificance(:,k) = SP(:,2);
end

end