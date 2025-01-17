function gui = arrangeSMPAMTab(gui)

gui.SMPAMU = uiextras.Grid('Parent',gui.SMPAM,'Spacing',5);
gui.SMPAMD = uiextras.Grid('Parent',gui.SMPAM,'Spacing',5);
set(gui.SMPAM, 'Sizes', [7*32 + 20 -1]);


handle = uicontrol('Parent',gui.SMPAMU, ...
    'Style','text', ...
    'FontSize',10,...
    'String','Output CH1+:');
javaHandle = findjobj(handle);
align(handle, 'None', 'Middle'); 
%javaHandle.setVerticalAlignment(javax.swing.SwingConstants.CENTER);
handle = uicontrol('Parent',gui.SMPAMU, ...
    'Style','text', ...
    'FontSize',10,...
    'String','Output CH1-:');
javaHandle = findjobj(handle);
align(handle, 'None', 'Middle'); 
%javaHandle.setVerticalAlignment(javax.swing.SwingConstants.CENTER);
handle = uicontrol('Parent',gui.SMPAMU, ...
    'Style','text', ...
    'FontSize',10,...
    'String','Output CH2+:');
javaHandle = findjobj(handle);
align(handle, 'None', 'Middle'); 
%javaHandle.setVerticalAlignment(javax.swing.SwingConstants.CENTER);
handle = uicontrol('Parent',gui.SMPAMU, ...
    'Style','text', ...
    'FontSize',10,...
    'String','Output CH2-:');
javaHandle = findjobj(handle);
align(handle, 'None', 'Middle'); 
%javaHandle.setVerticalAlignment(javax.swing.SwingConstants.CENTER);
uiextras.Empty('Parent', gui.SMPAMU);

handle = uicontrol('Parent',gui.SMPAMU, ...
    'Style','text', ...
    'FontSize',10,...
    'String','Max. Modulation Order:');
javaHandle = findjobj(handle);
align(handle, 'None', 'Middle'); 
%javaHandle.setVerticalAlignment(javax.swing.SwingConstants.CENTER);
% handle = uicontrol('Parent',gui.SMPAMU, ...
%     'Style','text', ...
%     'FontSize',10,...
%     'String','Adaptive Threshold:');
% javaHandle = findjobj(handle);
% javaHandle.setVerticalAlignment(javax.swing.SwingConstants.CENTER);
uiextras.Empty('Parent', gui.SMPAMU);

gui.outputChannel1PSMPAM = uicontrol('Parent',gui.SMPAMU, ...
    'Style','popupmenu', ...
    'String',{'CH1','CH2','CH3','CH4','FN1','FN2'},...
    'FontSize',10, ...
    'Callback',@onOutputChannel1PSMPAM);
gui.outputChannel1NSMPAM = uicontrol('Parent',gui.SMPAMU, ...
    'Style','popupmenu', ...
    'String',{'CH1','CH2','CH3','CH4','FN1','FN2'},...
    'FontSize',10, ...
    'Value',2, ...
    'Enable','off', ...
    'Callback',@onOutputChannel1NSMPAM);
gui.outputChannel2PSMPAM = uicontrol('Parent',gui.SMPAMU, ...
    'Style','popupmenu', ...
    'String',{'CH1','CH2','CH3','CH4','FN1','FN2'},...
    'FontSize',10, ...
    'Value',3, ...
    'Callback',@onOutputChannel2PSMPAM);
gui.outputChannel2NSMPAM = uicontrol('Parent',gui.SMPAMU, ...
    'Style','popupmenu', ...
    'String',{'CH1','CH2','CH3','CH4','FN1','FN2'},...
    'FontSize',10, ...
    'Value',4, ...
    'Enable','off', ...
    'Callback',@onOutputChannel2NSMPAM);
uiextras.Empty('Parent', gui.SMPAMU);

gui.maxConstellationSizeSMPAM = uicontrol('Parent', gui.SMPAMU, ...
    'Style', 'popupmenu', ...
    'FontSize', 10, ...
    'String',{'2','4','8','16','32','64','128','256','512','1024'}, ... 
    'Callback',@onMaxConstelllationSMPAM);
% gui.adaptiveThresholdSMPAM = uicontrol('Parent', gui.SMPAMU, ...
%     'Style', 'checkbox', ...
%     'Callback', @onAdaptiveThresholdSMPAM);
uiextras.Empty('Parent', gui.SMPAMU);

uicontrol('Parent',gui.SMPAMD, ...
    'Style','pushbutton',...
    'String','Generate Signal',...
    'FontSize',10,...
    'Callback',@onGenerateSignalSMPAM);
uicontrol('Parent',gui.SMPAMD, ...
    'Style','pushbutton',...
    'String','Capture & Demodulate Signal',...
    'FontSize',10,...
    'Callback',@onCaptureDemodulateSignalSMPAM);
uicontrol('Parent',gui.SMPAMD, ...
    'Style','pushbutton',...
    'String','Plot Data',...
    'FontSize',10,...
    'Callback',@onPlotDataSMPAM);
uicontrol('Parent',gui.SMPAMD, ...
    'Style','pushbutton',...
    'String','Save Data',...
    'FontSize',10,...
    'Callback',@onSaveDataSMPAM);


set(gui.SMPAMU, 'ColumnSizes', [-1 -1], 'RowSizes', [32 32 32 32 32 32 32]);
set(gui.SMPAMD, 'ColumnSizes', [-1 -1], 'RowSizes', [-1 -1]);