function varargout = uav_cmd(varargin)
% UAV_CMD MATLAB code for uav_cmd.fig
%      UAV_CMD, by itself, creates a new UAV_CMD or raises the existing
%      singleton*.
%
%      H = UAV_CMD returns the handle to a new UAV_CMD or the handle to
%      the existing singleton*.
%
%      UAV_CMD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UAV_CMD.M with the given input arguments.
%
%      UAV_CMD('Property','Value',...) creates a new UAV_CMD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before uav_cmd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to uav_cmd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help uav_cmd

% Last Modified by GUIDE v2.5 23-Sep-2017 22:15:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @uav_cmd_OpeningFcn, ...
                   'gui_OutputFcn',  @uav_cmd_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before uav_cmd is made visible.
function uav_cmd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to uav_cmd (see VARARGIN)

% Choose default command line output for uav_cmd
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes uav_cmd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = uav_cmd_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
takeoff1 = rospublisher('/bebop1/takeoff','std_msgs/Empty');
takeoff2 = rospublisher('/bebop2/takeoff','std_msgs/Empty');
msg = rosmessage(takeoff1);
send(takeoff1,msg);
pause(1);
send(takeoff2,msg);
pause(1);

clear takeoff1 takeoff2;
disp('Takeoff!')


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
land1 = rospublisher('/bebop1/land','std_msgs/Empty');
land2 = rospublisher('/bebop2/land','std_msgs/Empty');
msg = rosmessage(land1);
send(land1,msg);
pause(1);
send(land2,msg);
pause(1);
clear land1 land2;
disp('Landing!')


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Emergency!!!');
reset1 = rospublisher('/bebop1/reset','std_msgs/Empty');
reset2 = rospublisher('/bebop2/reset','std_msgs/Empty');
msg = rosmessage(reset1);
send(reset1,msg);
pause(1);
send(reset2,msg);
pause(1);
clear reset1 reset2;
