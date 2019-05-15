function CoverCurve(mws, endLine)
% Component.New "component1" 
component = invoke(mws, 'Component');
invoke(component, 'New', 'component1');

% With CoverCurve
%      .Reset 
%      .Name "solid1" 
%      .Component "component1" 
%      .Material "PEC" 
%      .Curve "curve1:line15" 
%      .DeleteCurve "False" 
%      .Create
% End With

CoverCurve = invoke(mws, 'CoverCurve');
invoke(CoverCurve, 'Reset');
invoke(CoverCurve, 'Name','solid1');
invoke(CoverCurve, 'Component','component1');
invoke(CoverCurve, 'Material','PEC');
line = convertCharsToStrings(sprintf('curve1:%s',endLine));
invoke(CoverCurve, 'Curve', line);
invoke(CoverCurve, 'DeleteCurve','False');
invoke(CoverCurve, 'Create');