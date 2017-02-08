function varargout = MedIT(varargin)
% MEDIT MATLAB code for MedIT.fig
%      MEDIT, by itself, creates a new MEDIT or raises the existing
%      singleton*.
%
%      H = MEDIT returns the handle to a new MEDIT or the handle to
%      the existing singleton*.
%
%      MEDIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MEDIT.M with the given input arguments.
%
%      MEDIT('Property','Value',...) creates a new MEDIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MedIT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MedIT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MedIT

% Last Modified by GUIDE v2.5 06-Mar-2016 00:40:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MedIT_OpeningFcn, ...
                   'gui_OutputFcn',  @MedIT_OutputFcn, ...
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


% --- Executes just before MedIT is made visible.
function MedIT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MedIT (see VARARGIN)

% Choose default command line output for MedIT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MedIT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MedIT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

%[File_Name, Path_Name] = uigetfile('C:\Users\Arnab Saha\Desktop')
 % axes('handles.axes1'){'*.*'},'Select file'
  %    imshow([Path_Name,File_Name])
  %[filename,pathname]=uigetfile('C:\Users\Arnab Saha\Desktop');
  %  Filename=fullfile(pathname,filename);
%var=strcat(pathname,filename);
i%=imread(var);
%g=rgb2gray(i);
%axes(handles.axes1);
%imshow(g, 'Parent', handles.axes1);

%title('CHEST X-RAY');
 
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

[filename,pathname]=uigetfile('C:\Users\Arnab Saha\Desktop\MedIT');
    Filename=fullfile(pathname,filename);
var=strcat(pathname,filename);
i=imread(var);
g=rgb2gray(i);
axes(handles.axes1);
imshow(g, 'Parent', handles.axes1);

title('THE UPLOADED CHEST X-RAY');
j=g>120;

for pi=1:401
for k=1:500
if j(pi,k)==0
j(pi,k)=1;
else
break;
end
end
end

for ui=1:401
for kw=500:-1:1
if j(ui,kw)==0
j(ui,kw)=1;
else
break;
end
end
end

for ui=395:-1:1
for kw=5:500
if j(ui,kw)==0
j(ui,kw)=1;
else
break;
end
end
end
 se=strel('line',20,90);
 pra = imdilate(j,se);
  pra2 = imdilate(pra,se);
 pra3 = imerode(pra2,se);
 axes(handles.axes2);
imshow(pra3, 'Parent', handles.axes2);
title('THE MORPHED IMAGE');
ar=190;
count=0;
a = zeros(1,10);
q=1;
for k=1:500
if pra3(ar,k)==0 && count==0
a(q) = k;
count=1;
q=q+1;
elseif pra3(ar,k)==1 && count==1
a(q)=k;
q=q+1;
count=0;
end
end

first = a(1);
for i=2:10
    if (a(i)-a(1))>15
        second=a(i);
        t=i;
        break;
    end
end    

for i=t:10
    if (a(i)-a(t))>15
        third=a(i);
        w=i;
        break;
    end
end  

for i=w:10
    if (a(i)-a(w))>15
        fourth=a(i);
        break;
    end
end 

l1=third-second;
l2=fourth-first;
h=l1*100/l2;
l3=int16(h);
if l3 < 50
    
set(findobj('Tag','t'),'String',strcat('Your Cardiothoracic Ratio is  :  ', num2str(l3),'       %   NO NEED TO WORRY. YOUR HEART IS IN A HEALTHY STATE. '));
else
    set(findobj('Tag','t'),'String',strcat('Your Cardiothoracic Ratio is  :   ', num2str(l3),'     %   THERE EXISTS PRELIMINARY SYMPTOMS OF HEART DISEASE. PLEASE CONSULT A CARDIOLOGIST.  '));
    
end

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
