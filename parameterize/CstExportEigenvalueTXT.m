function CstExportEigenvalueTXT(mws, exportpath)

SelectTreeItem = invoke(mws,'SelectTreeItem','1D Results\Characteristic Mode Analysis\Eigenvalue\Mode 1');
ASCIIExport = invoke(mws,'ASCIIExport');
invoke(ASCIIExport,'Reset');
invoke(ASCIIExport,'SetVersion','2010');
invoke(ASCIIExport,'FileName',exportpath);
invoke(ASCIIExport,'Execute');

end