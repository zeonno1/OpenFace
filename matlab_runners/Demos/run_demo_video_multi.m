% A demo how to run a multi-face face tracker

clear;

if(isunix)
    executable = '"../../build/bin/FaceLandmarkVidMulti"';
else
    executable = '"../../x64/Release/FaceLandmarkVidMulti.exe"';
end

output = './demo_vid/';

if(~exist(output, 'file'))
    mkdir(output)
end
    
in_files = dir('../../samples/multi_face.avi');

model = 'model/main_clnf_general.txt'; % Trained on in the wild and multi-pie data (a CLNF model)

% Uncomment the below models if you want to try them
%model = 'model/main_clnf_wild.txt'; % Trained on in-the-wild data only

%model = 'model/main_clm_general.txt'; % Trained on in the wild and multi-pie data (less accurate SVR/CLM model)
%model = 'model/main_clm_wild.txt'; % Trained on in-the-wild

% Create a command that will run the tracker on set of videos, 
% and visualize the output (-verbose)
command = sprintf('%s -mloc "%s" -verbose', executable, model);

% add all videos to single argument list (so as not to load the model anew
% for every video)
for i=1:numel(in_files)
    inputFile = ['../../samples/', in_files(i).name];        
    command = cat(2, command, [' -f "' inputFile '" ']);
end

% Call the executable
if(isunix)
    unix(command);
else
    dos(command);
end