function modalSignificance = getModalSignificance(mws)
TreeItem = "1D Results\Characteristic Mode Analysis\Modal Significance";

DSResultTree = invoke(mws, 'DSResultTree');
IDs = invoke(DSResultTree, 'GetResultIDsFromTreeItem', TreeItem);
modalSignificance = invoke(DSResultTree, 'GetResultFromTreeItem', TreeItem);
