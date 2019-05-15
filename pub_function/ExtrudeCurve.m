% 给目标的curve加上金属层之类的
function ExtrudeCurve(mws, Curve)
% With ExtrudeCurve
%      .Reset 
%      .Name "solid1" 
%      .Component "component1" 
%      .Material "PEC" 
%      .Thickness "0.0" 
%      .Twistangle "0.0" 
%      .Taperangle "0.0" 
%      .DeleteProfile "True" 
%      .Curve "curve1:polygon1" 
%      .Create
% End With
plane = invoke(mws, 'ExtrudeCurve');
invoke(plane, 'Reset');
invoke(plane, 'Name','solid1');
invoke(plane, 'Component','component1');
invoke(plane, 'Material','PEC');
invoke(plane, 'Thickness','0.0');
invoke(plane, 'Twistangle','0.0');
invoke(plane, 'Taperangle','0.0');
invoke(plane, 'DeleteProfile','False');
invoke(plane, 'Curve',Curve);
invoke(plane, 'Create');
release(plane);
end