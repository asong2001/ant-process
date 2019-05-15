%% 启动特征模分析

function startIntegralEq(mws, NumberOfModesCMA, StartFrequencyCMA)

ChangeSolverType = invoke(mws,'ChangeSolverType',"HF IntegralEq");

% ---------VBA---------%

% 设置频率范围
% Solver.FrequencyRange "2", "3"

% 设置特征模分析
% ChangeSolverType "HF IntegralEq"
% Mesh.SetCreator "High Frequency"
FDSolver = invoke(mws, 'FDSolver');
invoke(FDSolver, 'Reset');

Mesh = invoke(mws,'Mesh');
invoke(Mesh,'SetCreator','High Frequency');

invoke(FDSolver, "SetMethod","Surface", "General purpose" );
invoke(FDSolver, "OrderTet","Second" );
invoke(FDSolver, "OrderSrf","First" );
invoke(FDSolver, "Stimulation","CMA", "All" );
invoke(FDSolver, "ResetExcitationList");
invoke(FDSolver, "AutoNormImpedance","False" );
invoke(FDSolver, "NormingImpedance","50" );
invoke(FDSolver, "ModesOnly","False" );
invoke(FDSolver, "ConsiderPortLossesTet","True"  );
invoke(FDSolver, "SetShieldAllPorts","False"  );
invoke(FDSolver, "AccuracyHex","1e-6"  );
invoke(FDSolver, "AccuracyTet","1e-4"  );
invoke(FDSolver, "AccuracySrf","1e-3"  );
invoke(FDSolver, "LimitIterations","False" );
invoke(FDSolver, "MaxIterations","0"  );
invoke(FDSolver, "SetCalcBlockExcitationsInParallel","True", "True","");
invoke(FDSolver, "StoreAllResults","False"  );
invoke(FDSolver, "StoreResultsInCache","False" );
invoke(FDSolver, "UseHelmholtzEquation","True"  );
invoke(FDSolver, "LowFrequencyStabilization","True" );
invoke(FDSolver, "Type","Auto"  );
invoke(FDSolver, "MeshAdaptionHex","False"  );
invoke(FDSolver, "MeshAdaptionTet","True"  );
invoke(FDSolver, "AcceleratedRestart","True"  );
invoke(FDSolver, "FreqDistAdaptMode","Distributed"  );
invoke(FDSolver, "NewIterativeSolver","True"  );
invoke(FDSolver, "TDCompatibleMaterials","False" );
invoke(FDSolver, "ExtrudeOpenBC","False"  );
invoke(FDSolver, "SetOpenBCTypeHex","Default" );
invoke(FDSolver, "SetOpenBCTypeTet","Default"  );
invoke(FDSolver, "AddMonitorSamples","True"  );
invoke(FDSolver, "CalcStatBField","False"  );
invoke(FDSolver, "CalcPowerLoss","True"  );
invoke(FDSolver, "CalcPowerLossPerComponent","False" );
invoke(FDSolver, "StoreSolutionCoefficients","True"  );
invoke(FDSolver, "UseDoublePrecision","False"  );
invoke(FDSolver, "UseDoublePrecision_ML","True" );
invoke(FDSolver, "MixedOrderSrf","False"  );
invoke(FDSolver, "MixedOrderTet","False"  );
invoke(FDSolver, "PreconditionerAccuracyIntEq","0.15"  );
invoke(FDSolver, "MLFMMAccuracy","Default"  );
invoke(FDSolver, "MinMLFMMBoxSize","0.3"  );
invoke(FDSolver, "UseCFIEForCPECIntEq","True" );
invoke(FDSolver, "UseFastRCSSweepIntEq","false"  );
invoke(FDSolver, "UseSensitivityAnalysis","False"  );
invoke(FDSolver, "RemoveAllStopCriteria","Hex");
invoke(FDSolver, "AddStopCriterion","All S-Parameters", "0.01", "2", "Hex", "True");
invoke(FDSolver, "AddStopCriterion","Reflection S-Parameters", "0.01", "2", "Hex", "False" );
invoke(FDSolver, "AddStopCriterion","Transmission S-Parameters", "0.01", "2", "Hex", "False" );
invoke(FDSolver, "RemoveAllStopCriteria","Tet" );
invoke(FDSolver, "AddStopCriterion","All S-Parameters", "0.01", "2", "Tet", "True" );
invoke(FDSolver, "AddStopCriterion","Reflection S-Parameters", "0.01", "2", "Tet", "False" );
invoke(FDSolver, "AddStopCriterion","Transmission S-Parameters", "0.01", "2", "Tet", "False" );
invoke(FDSolver, "AddStopCriterion","All Probes", "0.05", "2", "Tet", "True" );
invoke(FDSolver, "RemoveAllStopCriteria","Srf" );
invoke(FDSolver, "AddStopCriterion","All S-Parameters", "0.01", "2", "Srf", "True" );
invoke(FDSolver, "AddStopCriterion","Reflection S-Parameters", "0.01", "2", "Srf", "False" );
invoke(FDSolver, "AddStopCriterion","Transmission S-Parameters", "0.01", "2", "Srf", "False" );
invoke(FDSolver, "SweepMinimumSamples","3"  );
invoke(FDSolver, "SetNumberOfResultDataSamples","1001" );
invoke(FDSolver, "SetResultDataSamplingMode","Automatic"  );
invoke(FDSolver, "SweepWeightEvanescent","1.0");
invoke(FDSolver, "AccuracyROM","1e-4"  );
invoke(FDSolver, "AddSampleInterval","3", "3", "1", "Single", "False"  );
invoke(FDSolver, "MPIParallelization","False" );
invoke(FDSolver, "UseDistributedComputing","False" );
invoke(FDSolver, "NetworkComputingStrategy","RunRemote" );
invoke(FDSolver, "NetworkComputingJobCount","3" );
invoke(FDSolver, "UseParallelization","True" );
invoke(FDSolver, "MaxCPUs","96" );
invoke(FDSolver, "MaximumNumberOfCPUDevices","4" );
invoke(FDSolver, "HardwareAcceleration","False" );
invoke(FDSolver, "MaximumNumberOfGPUs","1" );


%% integrate solver
IESolver = invoke(mws, 'IESolver');
% With IESolver
invoke(IESolver, "Reset");
invoke(IESolver, "UseFastFrequencySweep","False" );
invoke(IESolver, "UseIEGroundPlane","False" );
invoke(IESolver, "SetRealGroundMaterialName","");
invoke(IESolver, "CalcFarFieldInRealGround","False");
invoke(IESolver, "RealGroundModelType","Auto" );
invoke(IESolver, "PreconditionerType","Auto" );
invoke(IESolver, "ExtendThinWireModelByWireNubs","False");
% End With
%
% With FDSolver
IESolver = invoke(mws, "IESolver");
invoke(IESolver, "SetFMMFFCalcStopLevel","0" );
invoke(IESolver, "SetFMMFFCalcNumInterpPoints","6"  );
invoke(IESolver, "UseFMMFarfieldCalc","True"  );
invoke(IESolver, "SetCFIEAlpha","0.500000"  );
invoke(IESolver, "LowFrequencyStabilization","False"  );
invoke(IESolver, "LowFrequencyStabilizationML","True" );
invoke(IESolver, "Multilayer","False"  );
invoke(IESolver, "SetiMoMACC_I","0.0001"  );
invoke(IESolver, "SetiMoMACC_M","0.0001"  );
invoke(IESolver, "DeembedExternalPorts","True" );
invoke(IESolver, "SetOpenBC_XY","True"  );
invoke(IESolver, "OldRCSSweepDefintion","False"  );
invoke(IESolver, "SetAccuracySetting","Medium"  );
invoke(IESolver, "CalculateSParaforFieldsources","True" );
invoke(IESolver, "ModeTrackingCMA","True"  );
invoke(IESolver, "NumberOfModesCMA",num2str(NumberOfModesCMA));
invoke(IESolver, "StartFrequencyCMA",num2str(StartFrequencyCMA));
invoke(IESolver, "SetAccuracySettingCMA","Default" );
invoke(IESolver, "FrequencySamplesCMA","0"  );
invoke(IESolver, "SetMemSettingCMA","Auto"  );
% End With
%
FDSolver = invoke(mws,'FDSolver');
invoke(FDSolver,'Start');
