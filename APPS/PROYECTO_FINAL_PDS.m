
function varargout = PROYECTO_FINAL_PDS(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PROYECTO_FINAL_PDS_OpeningFcn, ...
                   'gui_OutputFcn',  @PROYECTO_FINAL_PDS_OutputFcn, ...
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
function BotonSalir_Callback(hObject, eventdata, handles)
exit;

function PROYECTO_FINAL_PDS_OpeningFcn(hObject, eventdata, handles, varargin)

%CREANDO CARPETAS BASE DE DATOS

mkdir BASEIMAGEN
mkdir AUDIOS
mkdir BDIMAGEN
mkdir BD
%%
axes(handles.axes1);
path = '../assets/fiee.jpg';
img = imread(path);
imshow(img);
axis off;
axes(handles.axessan);
path = '../assets/MARCO.jpg';
img = imread(path);
imshow(img);
axis off;
handles.output = hObject;
guidata(hObject, handles);

% Get default command line output from handles structure
function varargout = PROYECTO_FINAL_PDS_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes on button press in CARGAR.
function CARGAR_Callback(hObject, eventdata, handles)
global Identificate;
global folder;
global folder2;
global imagen;
global variable;
Identificate=get(handles.identificate,'string');
if (isempty(Identificate))
    msgbox('Indetificate primero');
    return
else

    [filename path]=uigetfile(('*.jpg'),'abrir imagen');
    folder=strcat([pwd ,'\BASEIMAGEN\']);
    folder2=strcat([pwd ,'\BASEDERECOLECCION\']);
    imagen=imread(strcat(path,filename));
    axes(handles.axes12);
    imshow(imagen);
    variable =0;
end

% --- Executes on button press in GUARDAR.
function GUARDAR_Callback(hObject, eventdata, handles)
global identificate;
global folder;
global imagen;

identificate=get(handles.identificate,'string');
if (isempty(identificate))
    msgbox('Ingresa contraseña');
    return
else
   
    [filename path]=uigetfile(('*.jpg'),'abrir imagen');
    folder=strcat([ pwd ,'\BDIMAGEN\']);
    imagen=imread(strcat(path,filename));
    axes(handles.axes9);
    imshow(imagen);
end

function identificate_Callback(hObject, eventdata, handles)
% hObject    handle to identificate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function identificate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to identificate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GRABAR.
function GRABAR_Callback(hObject, eventdata, handles)
global fs
global x
global nombre_archivo
global nombre;

nombre=get(handles.contra,'string');%guardar variable de texto 
if (isempty(nombre)) %en caso no se digite nada en el cuadro de texto 
    msgbox('Escriba la contraseña');%mensaje que indica que el cuadro de texto esta vacio
    return %retornar al punto inicial
else
  
fs=11025; %frecuencia de muestreo
audio = audiorecorder(fs,16,1,-1); %grabar el audio
disp('Start speaking.')% Indica inicio de grabación
msgbox('Comience a grabar');
recordblocking(audio, 3); %duracion de grabacion 3 segundos
disp('End of Recording.'); %Indica fin de la grabación
msgbox('Fin de la grabación');
x = getaudiodata(audio,'int16');% almacenar una data
ts=1/fs;%tiempo de muestreo
ti=3;%tiempo de grabacion 
t=0:ts:ti-ts; %tiempo 
b=[1 -0.95]; %vector filtro
xf=filter(b,1,x); %Proceso de filtrado
len = length(x); %longitud del vector
X=abs(fft(x));%transformada de fourier
k=0:len-1; %variable
hertz2=k.*(8000/len); %hertz4

audiowrite(strcat([ pwd '\BD\', 'voz.wav']),x,fs);%OBSERVACION
nombre_archivo =get(handles.contra,'String');%guardar archivo con el nombre del texto escrito
set(handles.axes3); % Establece los ejes de graficación
axes(handles.axes3);% Grafica en los axes
plot(t,x);grid on; %grafica de la señal grabada para contraseña
set(handles.axes4); % Establece los ejes de graficación
axes(handles.axes4);%Grafica en los axes
plot(t,xf);grid on; % grafica el filtrado
set(handles.axes5); % Establece los ejes de graficación
axes(handles.axes5);%Grafica en los axes
plot(hertz2(1:len/2),X(1:len/2));grid on; %grafica diagrama de espectros
%----- Mensaje Fin de Grabacion
msgbox('Grabación Terminada');%mensaje de cuadro de texto
play(audio)
end

% --- Executes on button press in ESCRIBIR.
function ESCRIBIR_Callback(hObject, eventdata, handles)

clc %limpia la pantalla
global Identificate;%Establecer variables globales
global y fs; %Establecer variables globales
Identificate=get(handles.identificate,'string');
if (isempty(Identificate))
    msgbox('Indetificate primero');
    return
else

fs=11025; %frecuencia de muestreo
ti=3; %Tiempo de grabacion
recObj = audiorecorder(fs,16,1,-1); %grabacion del audio
disp('Start speaking.')% Indica inicio de grabación
msgbox('Comience a grabar');
recordblocking(recObj, ti); %Duracion de grabacion 
msgbox('Fin de la grabación');
disp('End of Recording.'); %Indica fin de la grabación
y = getaudiodata(recObj,'int16');% recObj se traduce en una variable
ts=1/fs;%tiempo de muestreo
t=0:ts:ti-ts;%tiempo de grabacion
b=[1 -0.95];% vector filtrado
yf=filter(b,1,y); %Proceso de filtrado
len = length(y); %longitud del vector
Y=abs(fft(y));%transformada de fourier 
k=0:len-1; %variable 
hertz=k.*(8000/len);%hertz 
 
audiowrite(strcat([ pwd '\AUDIOS\', 'vozUsuario.wav']),y,fs);%escribir el audio 
set(handles.axes6); % Establece los ejes de graficación
axes(handles.axes6);% Grafica en los axes
plot(t,y);grid on; % Grafica señal de dictado de grabacion
set(handles.axes7); % Establece los ejes de graficación
axes(handles.axes7);% Grafica en los axes
plot(t,yf);grid on; % Grafica de filtrado del ditado de grabacion 
set(handles.axes8); % Establece los ejes de graficación
axes(handles.axes8);% Grafica en los axes
plot(hertz(1:len/2),Y(1:len/2));grid on; %Grafica del espectro
msgbox('Grabación Terminada');%----- Mensaje Fin de Grabacion
handles.y=y;%guardar una variable en global
guidata(hObject,handles)%para poder utilizarlo 
end


function contra_Callback(hObject, eventdata, handles)

function contra_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Pan_DeleteFcn(hObject, eventdata, handles)



% --- Executes on button press in REPRODUCIR.
function REPRODUCIR_Callback(hObject, eventdata, handles)
[y,fs]=audioread([pwd '\AUDIOS\', 'vozUsuario.wav']); %Lectura del archivo grabado
soundsc(y,fs); %Reproducción de archivo grabado


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
global nombre_archivo;
global x;
global fs;
global imagen;
global nombre;
global folder;

audiowrite(strcat([pwd '\BD\', nombre_archivo ,' .wav']),x,fs);%escibir audio con el    nombre de del audio (ESCRIBIR CONTRASEÑA)
imwrite(imagen,fullfile(folder,strcat(nombre,'.jpg')));%escibir audio con el    nombre de la imagen  (ESCRIBIR CONTRASEÑA)
set (handles.contra, 'string', ' ');
  msgbox('Si desea  volver a grabar una nueva contraseña debe escribir una contraseña, o sino omita este mensaje');

% --- Executes on button press in CONFIRMAR.
function CONFIRMAR_Callback(hObject, eventdata, handles)
global imagen;
global Identificate;
global folder;
global A11;
global A22;
global K1;
global maxs;
global K6
global variable;


if variable ~= 1

imwrite(imagen,fullfile(folder,strcat(Identificate,'.jpg')));
imwrite(imagen,fullfile(folder,strcat('imagenUsuario.jpg')));
imagen_usuariom=imread([pwd '\BASEIMAGEN\', 'imagenUsuario.jpg']);
imagen_usuario=imresize(imagen_usuariom,[400 400]);
A22=rgb2gray(imagen_usuario);
set(handles.axes13); % Establece los ejes de graficación
axes(handles.axes13);
imshow(A22);
n22=imcrop(A22,[0 0 200 250]);
lee_imagen = dir([pwd '\BDIMAGEN\' '*.jpg']);
min_error=0.005;
for s = 1:length(lee_imagen)%recorre número de imagines guardados en el directorio
    imagen_nom = lee_imagen(s).name; %Obtiene el nombre de las imagenes
    imagen_bdm= imread(strcat([pwd '\BDIMAGEN\' imagen_nom]));%juntar cadenas strcat o concatenar
    imagen_bd=imresize(imagen_bdm,[400 400]);
    A11=rgb2gray(  imagen_bd);
n11=imcrop(A11,[0 0 200 250]);
K1=corr2(n11,n22);
 if K1 > min_error
     min_error=K1;
 end
end
 K6=min_error;
 
if K6>=0.96
    maxs=round(K1);
[y,fs]=audioread([pwd '\AUDIOS\', 'vozUsuario.wav']);%Leer un archivo de audio
N=length(y); %calcula el tamaño del vector
f=(0:N-1)*fs/N;

[nombre21, transf_usuario, transff_bd,  min_error]=LeerDirectorio2();
if min_error < 10
 set(handles.axes10); % Establece los ejes de graficación
axes(handles.axes10);
  imshow(A11);
    set (handles.text22, 'string', upper(nombre21(1:end-4))); % Muestra la letra comparada
   
     msgbox(' BIENVENIDO A CASA');
else
    set (handles.text22, 'string', ' ');
    msgbox('Advertencia, usted no esta autorizado');
    K6=0;
   
end

else 
    set (handles.contra, 'string', ' ');
    set (handles.identificate, 'string', ' ');
      
   msgbox('Advertencia, usted no esta autorizado');
   K6=0;

end
else 
     msgbox('Carga');
end
K6
a=K6
 set(handles.axes11); %Establece el axes para graficar
    axes(handles.axes11); %Axes habilitado para graficar
PUERTA=tf([0.01 0.1],[0.005 0.06 0.1001]);
tiempo=0:0.001:4;
YY=step(a*PUERTA,tiempo);
plot(tiempo,YY)
title('ACTIVACION DE LA PUERTA');
xlabel('TIEMPO');
ylabel('VOLTAJE');


   
% --- Executes on button press in VALIDAR.
function VALIDAR_Callback(hObject, eventdata, handles)
global variable;

variable=1;
rmdir([pwd '\BASEIMAGEN\'],'s')
%rmdir('C:\Users\angello\Desktop\Reconocimiento_de_voz\Programa_Reconocimiento_de_voz\BASEIMAGEN','s')
%cla(handles.identificate, 'string', ' ');
cla (handles.text22, 'reset');
  cla(handles.identificate, 'reset');
    cla (handles.contra, 'reset');
cla(handles.axes3,'reset')
cla(handles.axes4,'reset')
cla(handles.axes5,'reset')
cla(handles.axes6,'reset')
cla(handles.axes7,'reset')
cla(handles.axes8,'reset')
cla(handles.axes9,'reset')
cla(handles.axes10,'reset')
cla(handles.axes11,'reset')
cla(handles.axes12,'reset')
cla(handles.axes13,'reset')
mkdir BASEIMAGEN


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
[y,fs]=audioread([pwd '\BD\', 'voz.wav']); %Lectura del archivo grabado
soundsc(y,fs); %Reproducción de archivo grabado
