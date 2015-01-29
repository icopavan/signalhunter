function output_tms_vc(reader, processed)
%TMS_VC_OUTPUT Function to standardize the output for TMS + VC processing
%   This function uses an Excel template file to wrie the output variables

sub_name = reader.sub_name;
leg = reader.leg;
order_TMS = reader.order_TMS;

% initialization of variables to be plotted
% vol_contrac_start = processed.vol_contrac_start;
% vol_contrac_end = processed.vol_contrac_end;
% stim = processed.stim;
% superimposed_window = processed.superimposed_window;
superimposed_F = processed.superimposed_F;
superimposed_B = processed.superimposed_B;
% max_C_I = processed.max_C_I;
max_C = processed.max_C;
max_B = processed.max_B;
% baseline_duration_contrac = processed.baseline_duration_contrac;
% contrac_neurostim = processed.contrac_neurostim;
% win_neuro = processed.win_neuro;
contrac_neurostim_max = processed.contrac_neurostim_max;
contrac_neurostim_min = processed.contrac_neurostim_min;

stim_contrac_start_p = processed.stim_contrac_start_p;
% stim_contrac_end = processed.stim_contrac_end;
% stim_contrac_start = processed.stim_contrac_start;
neurostim_max = processed.neurostim_max;
% B_before_neurostim = processed.B_before_neurostim;
neurostim_B = processed.neurostim_B;
neurostim_max_I = processed.neurostim_max_I;
HRT_abs = processed.HRT_abs;

M_wave_start_I = processed.M_wave_start_I;
M_wave_end_I = processed.M_wave_end_I;
max_M_wave_I = processed.max_M_wave_I;
min_M_wave_I = processed.min_M_wave_I;

% contrac_neurostim = processed.contrac_neurostim;
M_wave_ex_max_I = processed.M_wave_ex_max_I;
M_wave_ex_min_I = processed.M_wave_ex_min_I;
M_wave_ex_start_I = processed.M_wave_ex_start_I;
M_wave_ex_end_I = processed.M_wave_ex_end_I;

TMS_stim = processed.TMS_stim;
% win_pre_stim = processed.win_pre_stim;
EMG_recov_point = processed.EMG_recov_point;
M_wave_MEP_max_I = processed.M_wave_MEP_max_I;
M_wave_MEP_min_I = processed.M_wave_MEP_min_I;
M_wave_MEP_start_I = processed.M_wave_MEP_start_I;
M_wave_MEP_end_I = processed.M_wave_MEP_end_I;

M_wave_MEP_max = processed.M_wave_MEP_max;
M_wave_MEP_min = processed.M_wave_MEP_min;
RMS = processed.RMS;
serie_num = processed.serie_num;


signal = processed.signal;
data = signal.data;
% Time = signal.time;
isi = signal.isi;


filename = [sub_name '_' leg '.xlsx'];
% loading output template
[output_file, ouput_path, ~] = uiputfile({'*.xls;*.xlsx','MS Excel Files (*.xls,*.xlsx)'},...
    'Export data', filename);
file_output = [ouput_path output_file];

if exist(file_output, 'file') == 0
    
    [output_tempfile, output_temppath, ~] = uigetfile({'*.xls;*.xlsx','MS Excel Files-files (*.xls,*.xlsx)'},...
        'Select the output file template');
    template_output = [output_temppath output_tempfile];
    copyfile(template_output, file_output, 'f');
    output_txt = cell(948,2);
    output_txt(:,1) = {sub_name};
    output_txt(:,2) = {leg};
    xlswrite(file_output,output_txt,'Force Values','A2')
    xlswrite(file_output,output_txt,'M_wave MEP RMS','A2')
    xlswrite(file_output,output_txt,'MVC_2min','A2')
    
end

% for excel sheet 'force value'
output_1 = [max_C(1) - max_B(1) ; superimposed_F(1) - superimposed_B(1) ; ...
    superimposed_B(1) - max_B(1) ; neurostim_max(1) - neurostim_B(1) ; ...
    (neurostim_max_I(1) - stim_contrac_start_p(1))* isi ; (HRT_abs(1) - neurostim_max_I(1))* isi ; ...
    neurostim_max(2) - neurostim_B(2) ; (neurostim_max_I(2) - stim_contrac_start_p(2))* isi ; ...
    (HRT_abs(2) - neurostim_max_I(2))* isi];
if order_TMS == 1;
    output_2 = [max_C(2) - max_B(2) ; superimposed_F(2) - superimposed_B(2) ; ...
        superimposed_B(2) - max_B(2) ; contrac_neurostim_max(2) - contrac_neurostim_min(2) ; ...
        contrac_neurostim_min(2) - max_B(2) ; neurostim_max(3) - neurostim_B(3) ; ...
        (neurostim_max_I(3) - stim_contrac_start_p(3))* isi ; (HRT_abs(3) - neurostim_max_I(3))* isi];
    output_3 = [max_C(3) - max_B(3) ; superimposed_F(3) - superimposed_B(3) ; ...
        superimposed_B(3) - max_B(3) ; contrac_neurostim_max(3) - contrac_neurostim_min(3) ; ...
        contrac_neurostim_min(3) - max_B(3)];
    output_4 = [max_C(4) - max_B(4) ; superimposed_F(4) - superimposed_B(4) ; ...
        superimposed_B(4) - max_B(4) ; contrac_neurostim_max(4) - contrac_neurostim_min(4) ; ...
        contrac_neurostim_min(4) - max_B(4)];
else
    output_2 = [max_C(2) - max_B(2) ; contrac_neurostim_max(1) - contrac_neurostim_min(1) ; ...
        contrac_neurostim_min(1) - max_B(2) ; superimposed_F(2) - superimposed_B(2) ; ...
        superimposed_B(2) - max_B(2) ; neurostim_max(3) - neurostim_B(3) ; ...
        (neurostim_max_I(3) - stim_contrac_start_p(3))* isi ; (HRT_abs(3) - neurostim_max_I(3))* isi];
    output_3 = [max_C(3) - max_B(3) ; contrac_neurostim_max(2) - contrac_neurostim_min(2) ; ...
        contrac_neurostim_min(2) - max_B(3) ; superimposed_F(3) - superimposed_B(3) ; ...
        superimposed_B(3) - max_B(3) ];
    output_4 = [max_C(4) - max_B(4) ; contrac_neurostim_max(3) - contrac_neurostim_min(3) ; ...
        contrac_neurostim_min(3) - max_B(4) ; superimposed_F(4) - superimposed_B(4) ; ...
        superimposed_B(4) - max_B(4) ];
end


% for excel sheet 'M-wave MEP RMS'
output_13 = [data(max_M_wave_I(2,2),2) - data(min_M_wave_I(2,2),2) ; ...
    abs(min_M_wave_I(2,2) - max_M_wave_I(2,2)) * isi ; ...
    trapz(abs(data(max_M_wave_I(2,2):min_M_wave_I(2,2),2))) ; ...
    trapz(abs(data(M_wave_start_I(2,2):M_wave_end_I(2,2),2))) ; ...
    data(max_M_wave_I(2,3),3) - data(min_M_wave_I(2,3),3) ; ...
    abs(min_M_wave_I(2,3) - max_M_wave_I(2,3)) * isi ; ...
    trapz(abs(data(max_M_wave_I(2,3):min_M_wave_I(2,3),3))) ; ...
    trapz(abs(data(M_wave_start_I(2,3):M_wave_end_I(2,3),3))) ; ...
    data(max_M_wave_I(2,4),4) - data(min_M_wave_I(2,4),4) ; ...
    abs(min_M_wave_I(2,4) - max_M_wave_I(2,4)) * isi ; ...
    trapz(abs(data(max_M_wave_I(2,4):min_M_wave_I(2,4),4))) ; ...
    trapz(abs(data(M_wave_start_I(2,4):M_wave_end_I(2,4),4))) ];
output_5 = [RMS(1,2) ; RMS(1,3) ; RMS(1,4)];
output_6 = [data(M_wave_ex_max_I(2,2),2)-data(M_wave_ex_min_I(2,2),2) ; ...
    abs(M_wave_ex_max_I(2,2) - M_wave_ex_min_I(2,2)) * isi ; ...
    trapz(abs(data(M_wave_ex_max_I(2,2):M_wave_ex_min_I(2,2),2))) ; ...
    trapz(abs(data(M_wave_ex_start_I(2,2):M_wave_ex_end_I(2,2),2))) ; ...
    data(M_wave_ex_max_I(2,3),3)-data(M_wave_ex_min_I(2,3),3) ; ...
    abs(M_wave_ex_max_I(2,3) - M_wave_ex_min_I(2,3)) ; ...
    trapz(abs(data(M_wave_ex_max_I(2,3):M_wave_ex_min_I(2,3),3))) ; ...
    trapz(abs(data(M_wave_ex_start_I(2,3):M_wave_ex_end_I(2,3),3))) ; ...
    data(M_wave_ex_max_I(2,4),4)-data(M_wave_ex_min_I(2,4),4) ; ...
    abs(M_wave_ex_max_I(2,4) - M_wave_ex_min_I(2,4)) ; ...
    trapz(abs(data(M_wave_ex_max_I(2,4):M_wave_ex_min_I(2,4),4))) ; ...
    trapz(abs(data(M_wave_ex_start_I(2,4):M_wave_ex_end_I(2,4),4)))];
output_7 = [M_wave_MEP_max(1,2) - M_wave_MEP_min(1,2) ; ...
    abs(M_wave_MEP_min_I(1,2) - M_wave_MEP_max_I(1,2)) * isi ; ...
    trapz(abs(data(M_wave_MEP_max_I(1,2):M_wave_MEP_min_I(1,2),2))); ...
    trapz(abs(data(M_wave_MEP_start_I(1,2):M_wave_MEP_end_I(1,2),2))); ...
    (EMG_recov_point(1,2) - TMS_stim (1)) * isi ; ...
    NaN ; ...
    M_wave_MEP_max(1,3) - M_wave_MEP_min(1,3) ; ...
    abs(M_wave_MEP_min_I(1,3) - M_wave_MEP_max_I(1,3)) * isi ; ...
    trapz(abs(data(M_wave_MEP_max_I(1,3):M_wave_MEP_min_I(1,3),3))); ...
    trapz(abs(data(M_wave_MEP_start_I(1,3):M_wave_MEP_end_I(1,2),3))); ...
    (EMG_recov_point(1,3) - TMS_stim (1)) * isi ; ...
    NaN ; ...
    M_wave_MEP_max(1,4) - M_wave_MEP_min(1,4) ; ...
    abs(M_wave_MEP_min_I(1,4) - M_wave_MEP_max_I(1,4)) * isi ; ...
    trapz(abs(data(M_wave_MEP_max_I(1,4):M_wave_MEP_min_I(1,4),4))); ...
    trapz(abs(data(M_wave_MEP_start_I(1,4):M_wave_MEP_end_I(1,4),4))); ...
    (EMG_recov_point(1,4) - TMS_stim (1)) * isi ; ...
    NaN ];
output_8 = [data(max_M_wave_I(3,2),2) - data(min_M_wave_I(3,2),2) ; ...
    abs(min_M_wave_I(3,2) - max_M_wave_I(3,2)) * isi ; ...
    trapz(abs(data(max_M_wave_I(3,2):min_M_wave_I(3,2),2))) ; ...
    trapz(abs(data(M_wave_start_I(3,2):M_wave_end_I(3,2),2))) ; ...
    data(max_M_wave_I(3,3),3) - data(min_M_wave_I(3,3),3) ; ...
    abs(min_M_wave_I(3,3) - max_M_wave_I(3,3)) * isi ; ...
    trapz(abs(data(max_M_wave_I(3,3):min_M_wave_I(3,3),3))) ; ...
    trapz(abs(data(M_wave_start_I(3,3):M_wave_end_I(3,3),3))) ; ...
    data(max_M_wave_I(3,4),4) - data(min_M_wave_I(3,4),4) ; ...
    abs(min_M_wave_I(3,4) - max_M_wave_I(3,4)) * isi ; ...
    trapz(abs(data(max_M_wave_I(3,4):min_M_wave_I(3,4),4))) ; ...
    trapz(abs(data(M_wave_start_I(3,4):M_wave_end_I(3,4),4))) ];
output_9 = [data(M_wave_ex_max_I(3,2),2)-data(M_wave_ex_min_I(3,2),2) ; ...
    abs(M_wave_ex_max_I(3,2) - M_wave_ex_min_I(3,2)) * isi ; ...
    trapz(abs(data(M_wave_ex_max_I(3,2):M_wave_ex_min_I(3,2),2))) ; ...
    trapz(abs(data(M_wave_ex_start_I(3,2):M_wave_ex_end_I(3,2),2))) ; ...
    data(M_wave_ex_max_I(3,3),3)-data(M_wave_ex_min_I(3,3),3) ; ...
    abs(M_wave_ex_max_I(3,3) - M_wave_ex_min_I(3,3)) ; ...
    trapz(abs(data(M_wave_ex_max_I(3,3):M_wave_ex_min_I(3,3),3))) ; ...
    trapz(abs(data(M_wave_ex_start_I(3,3):M_wave_ex_end_I(3,3),3))) ; ...
    data(M_wave_ex_max_I(3,4),4)-data(M_wave_ex_min_I(3,4),4) ; ...
    abs(M_wave_ex_max_I(3,4) - M_wave_ex_min_I(3,4)) ; ...
    trapz(abs(data(M_wave_ex_max_I(3,4):M_wave_ex_min_I(3,4),4))) ; ...
    trapz(abs(data(M_wave_ex_start_I(3,4):M_wave_ex_end_I(3,4),4)))];
output_10 = [M_wave_MEP_max(2,2) - M_wave_MEP_min(2,2) ; ...
    abs(M_wave_MEP_min_I(2,2) - M_wave_MEP_max_I(2,2)) * isi ; ...
    trapz(abs(data(M_wave_MEP_max_I(2,2):M_wave_MEP_min_I(2,2),2))); ...
    trapz(abs(data(M_wave_MEP_start_I(2,2):M_wave_MEP_end_I(2,2),2))); ...
    (EMG_recov_point(2,2) - TMS_stim (2)) * isi ; ...
    NaN ; ...
    M_wave_MEP_max(2,3) - M_wave_MEP_min(2,3) ; ...
    abs(M_wave_MEP_min_I(2,3) - M_wave_MEP_max_I(2,3)) * isi ; ...
    trapz(abs(data(M_wave_MEP_max_I(2,3):M_wave_MEP_min_I(2,3),3))); ...
    trapz(abs(data(M_wave_MEP_start_I(2,3):M_wave_MEP_end_I(2,2),3))); ...
    (EMG_recov_point(2,3) - TMS_stim (2)) * isi ; ...
    NaN ; ...
    M_wave_MEP_max(2,4) - M_wave_MEP_min(2,4) ; ...
    abs(M_wave_MEP_min_I(2,4) - M_wave_MEP_max_I(2,4)) * isi ; ...
    trapz(abs(data(M_wave_MEP_max_I(2,4):M_wave_MEP_min_I(2,4),4))); ...
    trapz(abs(data(M_wave_MEP_start_I(2,4):M_wave_MEP_end_I(2,4),4))); ...
    (EMG_recov_point(2,4) - TMS_stim (2)) * isi ; ...
    NaN ];
output_11 = [data(M_wave_ex_max_I(4,2),2)-data(M_wave_ex_min_I(4,2),2) ; ...
    abs(M_wave_ex_max_I(4,2) - M_wave_ex_min_I(4,2)) * isi ; ...
    trapz(abs(data(M_wave_ex_max_I(4,2):M_wave_ex_min_I(4,2),2))) ; ...
    trapz(abs(data(M_wave_ex_start_I(4,2):M_wave_ex_end_I(4,2),2))) ; ...
    data(M_wave_ex_max_I(4,3),3)-data(M_wave_ex_min_I(4,3),3) ; ...
    abs(M_wave_ex_max_I(4,3) - M_wave_ex_min_I(4,3)) ; ...
    trapz(abs(data(M_wave_ex_max_I(4,3):M_wave_ex_min_I(4,3),3))) ; ...
    trapz(abs(data(M_wave_ex_start_I(4,3):M_wave_ex_end_I(4,3),3))) ; ...
    data(M_wave_ex_max_I(4,4),4)-data(M_wave_ex_min_I(4,4),4) ; ...
    abs(M_wave_ex_max_I(4,4) - M_wave_ex_min_I(4,4)) ; ...
    trapz(abs(data(M_wave_ex_max_I(4,4):M_wave_ex_min_I(4,4),4))) ; ...
    trapz(abs(data(M_wave_ex_start_I(4,4):M_wave_ex_end_I(4,4),4)))];
output_12 = [M_wave_MEP_max(3,2) - M_wave_MEP_min(3,2) ; ...
    abs(M_wave_MEP_min_I(3,2) - M_wave_MEP_max_I(3,2)) * isi ; ...
    trapz(abs(data(M_wave_MEP_max_I(3,2):M_wave_MEP_min_I(3,2),2))); ...
    trapz(abs(data(M_wave_MEP_start_I(3,2):M_wave_MEP_end_I(3,2),2))); ...
    (EMG_recov_point(3,2) - TMS_stim (3)) * isi ; ...
    NaN ; ...
    M_wave_MEP_max(3,3) - M_wave_MEP_min(3,3) ; ...
    abs(M_wave_MEP_min_I(3,3) - M_wave_MEP_max_I(3,3)) * isi ; ...
    trapz(abs(data(M_wave_MEP_max_I(3,3):M_wave_MEP_min_I(3,3),3))); ...
    trapz(abs(data(M_wave_MEP_start_I(3,3):M_wave_MEP_end_I(3,2),3))); ...
    (EMG_recov_point(3,3) - TMS_stim (3)) * isi ; ...
    NaN ; ...
    M_wave_MEP_max(3,4) - M_wave_MEP_min(3,4) ; ...
    abs(M_wave_MEP_min_I(3,4) - M_wave_MEP_max_I(3,4)) * isi ; ...
    trapz(abs(data(M_wave_MEP_max_I(3,4):M_wave_MEP_min_I(3,4),4))); ...
    trapz(abs(data(M_wave_MEP_start_I(3,4):M_wave_MEP_end_I(3,4),4))); ...
    (EMG_recov_point(3,4) - TMS_stim (3)) * isi ; ...
    NaN ];

switch serie_num
    case 1
        cell_to_write = {'H7';'H16';'H24';'H29'};
        cell_to_write_2 = {'I14';'I26';'I29';'I41';'I59';'I71';'I83';'I101';'I113'};
    case 2
        cell_to_write = {'H34';'H43';'H51';'H56'};
        cell_to_write_2 = {'I131';'I143';'I146';'I158';'I176';'I188';'I200';'I218';'I230'};
    case 3
        cell_to_write = {'H61';'H70';'H78';'H83'};
        cell_to_write_2 = {'I248';'I260';'I263';'I275';'I293';'I305';'I317';'I335';'I347'};
    case 4
        cell_to_write = {'H88';'H97';'H105';'H110'};
        cell_to_write_2 = {'I365';'I377';'I380';'I392';'I410';'I422';'I434';'I452';'I464'};
    case 5
        cell_to_write = {'H115';'H124';'H132';'H137'};
        cell_to_write_2 = {'I482';'I494';'I497';'I509';'I527';'I539';'I551';'I569';'I581'};
    case 6
        cell_to_write = {'H142';'H151';'H159';'H164'};
        cell_to_write_2 = {'I599';'I611';'I614';'I626';'I644';'I656';'I668';'I686';'I698'};
    case 7
        cell_to_write = {'H169';'H178';'H186';'H191'};
        cell_to_write_2 = {'I716';'I728';'I731';'I743';'I761';'I773';'I785';'I803';'I815'};
    case 8
        cell_to_write = {'H196';'H205';'H213';'H218'};
        cell_to_write_2 = {'I833';'I845';'I848';'I860';'I878';'I890';'I902';'I920';'I932'};
end

xlswrite(file_output,output_1,'Force Values',cell_to_write{1})
xlswrite(file_output,output_2,'Force Values',cell_to_write{2})
xlswrite(file_output,output_3,'Force Values',cell_to_write{3})
xlswrite(file_output,output_4,'Force Values',cell_to_write{4})
xlswrite(file_output,output_13,'M_wave MEP RMS',cell_to_write_2{1})
xlswrite(file_output,output_5,'M_wave MEP RMS',cell_to_write_2{2})
xlswrite(file_output,output_6,'M_wave MEP RMS',cell_to_write_2{3})
xlswrite(file_output,output_7,'M_wave MEP RMS',cell_to_write_2{4})
xlswrite(file_output,output_8,'M_wave MEP RMS',cell_to_write_2{5})
xlswrite(file_output,output_9,'M_wave MEP RMS',cell_to_write_2{6})
xlswrite(file_output,output_10,'M_wave MEP RMS',cell_to_write_2{7})
xlswrite(file_output,output_11,'M_wave MEP RMS',cell_to_write_2{8})
xlswrite(file_output,output_12,'M_wave MEP RMS',cell_to_write_2{9})


end

