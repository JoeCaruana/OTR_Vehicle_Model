%Author : Joseph
%Date : 2021-08-05
%This file updates all the variables within the model from the Calibration
%excel fil .
clear;
clc;
%Load Excel Variables into workspace
vehicleParams = readtable('VehicleData.xlsx');
for i=1:height(vehicleParams)
temp = char(table2cell(vehicleParams(i,1)));
temp = extractAfter(temp,'_');
    eval([char(table2cell(vehicleParams(i,1))) '=[' char(string(table2cell(vehicleParams(i,2)))) ',' char(string(table2cell(vehicleParams(i,3)))) ',' char(string(table2cell(vehicleParams(i,4)))) '];']);
end

hpl_f_lca_inboard_axis = alignAxis(hpl_f_lca_front,hpl_f_lca_rear);
hpl_f_uca_inboard_axis = alignAxis(hpl_f_uca_front,hpl_f_uca_rear);
hpl_f_damperAxis = hpl_f_damper_inboard + 0.5*(hpl_f_damper_outboard-hpl_f_damper_inboard)