function onConnectScope(~,~)

global gui;
global systemParameters;

try
    if systemParameters.ScopeType == 1 % VISA scope
        if isempty(systemParameters.ScopeObj),
            % If scope has not been connected
            systemParameters.ScopeObj = instrfind('Type', 'visa-usb', 'RsrcName', systemParameters.ScopeAddress, 'Tag', '');
            % Create the VISA object if it does not exist
            % otherwise use the object that was found.
            if isempty(systemParameters.ScopeObj),
                systemParameters.ScopeObj = visa('AGILENT', systemParameters.ScopeAddress);
            else
                fclose(systemParameters.ScopeObj);
                systemParameters.ScopeObj = systemParameters.ScopeObj(1);
            end
            % Set the buffer size
            systemParameters.ScopeObj.InputBufferSize = 8000000;
            % Set the timeout value
            systemParameters.ScopeObj.Timeout = 10;
            % Set the Byte order
            systemParameters.ScopeObj.ByteOrder = 'littleEndian';
            fopen(systemParameters.ScopeObj);
            % Update button appearance and text
            set(gui.connectScope,'BackgroundColor',[0 0.498 0]);
            set(gui.connectScope,'String','Disconnect Scope');
            set(gui.ScopeType, 'Enable', 'off');
            set(gui.ScopeAddress, 'Enable', 'off');
            % Run setup commands
            %         fprintf(systemParameters.ScopeObj, '*RST'); % Reset instrument
            %         operationComplete = str2double(query(systemParameters.ScopeObj,'*OPC?'));
            %         while ~operationComplete
            %             operationComplete = str2double(query(systemParameters.ScopeObj,'*OPC?'));
            %         end
            fprintf(systemParameters.ScopeObj, ':ACQuire:RSIGnal OUT');
            instrumentError = query(systemParameters.ScopeObj,':SYSTEM:ERR?');
            while ~(isequal(instrumentError,['+0,"No error"' char(10)]) || isequal(instrumentError,['0' char(10)])),
                disp(['Instrument Error: ' instrumentError]);
                instrumentError = query(systemParameters.ScopeObj,':SYSTEM:ERR?');
            end
        elseif ~isempty(systemParameters.ScopeObj),
            % If scope is already connected, disconnect
            fclose(systemParameters.ScopeObj);
            systemParameters.ScopeObj = [];
            % Update button appearance and text
            set(gui.connectScope,'BackgroundColor',[0.847 0.161 0]);
            set(gui.connectScope,'String','Connect Scope');
            set(gui.ScopeType, 'Enable', 'on');
            set(gui.ScopeAddress, 'Enable', 'on');
            
        end
    elseif systemParameters.ScopeType == 2 %% PHOTONTORRENT_AA scope
        
        if isempty(systemParameters.ScopeObj)
            
            props = regexp(systemParameters.ScopeAddress,'::','split');
            
            if( isempty(systemParameters.ScopeObj))
                if(strcmpi('photontorrent_aa', props(1)))
                    if(length(props) < 2)
                        systemParameters.ScopeObj = photontorrent_aa;
                    else
                        systemParameters.ScopeObj = photontorrent_aa(char(props(2)));
                    end
                end
                if(strcmpi('photontorrent_ab', props(1)))
                    if(length(props) < 2)
                        systemParameters.ScopeObj = photontorrnet_ab;
                    else
                        systemParameters.ScopeObj = photontorrent_ab(char(props(2)));
                    end
                end
                systemParameters.ScopeObj.setVoffset(systemParameters.SPADVoffset*1000)
                
                systemParameters.ScopeObj.SetVHV((15 / (100/(27/2))) * 1000);
                
                systemParameters.ScopeObj.setChipMode(systemParameters.SPADChipMode)
                
                set(gui.connectScope,'BackgroundColor',[0 0.498 0]);
                set(gui.connectScope,'String','Disconnect Scope')
                set(gui.ScopeType, 'Enable', 'off');
                set(gui.ScopeAddress, 'Enable', 'off');
                
            end
        else
            scopeObj = systemParameters.ScopeObj;
            if(isa(scopeObj, 'photontorrent_aa') || isa(scopeObj, 'photontorrent_ab') )
                scopeObj.close();
            end
            systemParameters.ScopeObj = [];
            set(gui.connectScope,'BackgroundColor',[0.847 0.161 0]);
            set(gui.connectScope,'String','Connect Scope');
            set(gui.ScopeType, 'Enable', 'on');
            set(gui.ScopeAddress, 'Enable', 'on');
            
        end
        
    end
catch ME,
    if(isfield(systemParameters, 'ScopeObj') && ~isempty(systemParameters.ScopeObj) && (isa(systemParameters.ScopeObj, 'photontorrent_aa') || isa(systemParameters.ScopeObj, 'photontorrent_ab')))
        systemParameters.ScopeObj.close();
    end
    systemParameters.ScopeObj = [];
    set(gui.connectScope,'BackgroundColor',[0.847 0.161 0]);
    set(gui.connectScope,'String','Connect Scope');
    set(gui.ScopeType, 'Enable', 'on');
    set(gui.ScopeAddress, 'Enable', 'on');
    
    errordlg(ME.message,'Error');
end