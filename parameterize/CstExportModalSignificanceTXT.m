function CstExportModalSignificanceTXT(mws, exportpath, NumberOfModesCMA)

for k = 1:NumberOfModesCMA
        ExportFileName = ['Mode ', num2str(k)];
        Tree = ['1D Results\Characteristic Mode Analysis\Modal Significance\Modal Significance [', ExportFileName, ']'];
        SelectTreeItem = invoke(mws,'SelectTreeItem',Tree);
        ASCIIExport = invoke(mws,'ASCIIExport');
        invoke(ASCIIExport,'Reset');
        invoke(ASCIIExport,'SetVersion','2010');
        fileName = [exportpath, ExportFileName, '.txt'];
        invoke(ASCIIExport,'FileName',fileName);
        invoke(ASCIIExport,'Execute');
end

end