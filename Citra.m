function varargout = Citra(varargin)

% CITRA MATLAB code for Citra.fig
%      CITRA, by itself, creates a new CITRA or raises the existing
%      singleton*.
%
%      H = CITRA returns the handle to a new CITRA or the handle to
%      the existing singleton*.
%
%      CITRA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CITRA.M with the given input arguments.
%
%      CITRA('Property','Value',...) creates a new CITRA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Citra_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Citra_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Citra

% Last Modified by GUIDE v2.5 29-May-2023 14:38:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Citra_OpeningFcn, ...
                   'gui_OutputFcn',  @Citra_OutputFcn, ...
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


% --- Executes just before Citra is made visible.
function Citra_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Citra (see VARARGIN)

% Choose default command line output for Citra
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Citra wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Citra_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
    global I;
    global G;
    [nama , alamat] = uigetfile({'*.jpg';'*.jpeg';'*.bmp';'*.png';'*.tif'},'Browse Image'); %mengambil data
    alamatimage=fullfile(alamat,nama);
    set(handles.edbrowse,'String',alamatimage);%mengisi handles pathfile
    I=imread(alamatimage);%membaca data yg dipilih
    w=size(I,1);
    h=size(I,2);

    set(handles.edw,'String',num2str(w));%menfisi height
    set(handles.edh,'String',num2str(h));
    
    handles.Img=I; %gambar terpilih disimpan ke I
    guidata(hObject, handles); %mengarahkan gcbo ke objek yg fungsinya sedang di eksekusi
    axes(handles.gambarAwal); %akses akses1
    imshow(I,[]); %menampilkan gambar
    G=I; %menyimpan data I ke G, jd isinya sama G dg I, nanti G yang berubah karena image processingnya

    red = G(:,:,1); % Red channel
    green = G(:,:,2); % Green channel
    blue = G(:,:,3); % Blue channel
    axes(handles.histAwal);
    h = histogram(red(:),256);
    h.FaceColor = [1 0 0];
    h.EdgeColor = 'r';
    hold on
    h = histogram(green(:),256);
    h.FaceColor = [0 1 0];
    h.EdgeColor = 'g';
    h = histogram(blue(:),256);
    h.FaceColor = [0 0 1];
    h.EdgeColor = 'b';
    xlabel('Intensitas Piksel');
    ylabel('Frekuensi');
    title(handles.histAwal, 'Histogram Citra Asli'); % Menambahkan judul pada axes "histHasil"
    title(handles.gambarAwal, 'Citra Asli'); % Menambahkan judul pada axes "gambarHasil"

% --- Executes on button press in resize.
function resize_Callback(hObject, eventdata, handles)
    set(handles.resize,'Value',1)
    Img = handles.Img;

    n1=get(handles.edh2,'String');
    n2=get(handles.edw2,'String');

    in1=str2num(n1);
    in2=str2num(n2);

    Z=imresize(Img,[in1,in2]);
    axes(handles.gambarHasil)
    cla('reset')
    imshow(Z);
    
    % h=msgbox('Sukses Load Image','Success','help');

    red = Z(:,:,1); % Red channel
    green = Z(:,:,2); % Green channel
    blue = Z(:,:,3); % Blue channel
    axes(handles.histHasil);
    cla('reset')
    h = histogram(red(:),256);
    h.FaceColor = [1 0 0];
    h.EdgeColor = 'r';
    hold on;
    h = histogram(green(:),256);
    h.FaceColor = [0 1 0];
    h.EdgeColor = 'g';
    h = histogram(blue(:),256);
    h.FaceColor = [0 0 1];
    h.EdgeColor = 'b';
    xlabel('Intensitas Piksel');
    ylabel('Frekuensi');
    title(handles.histHasil, 'Histogram Citra Resize'); % Menambahkan judul pada axes "histHasil"
    title(handles.gambarHasil, 'Citra Resize'); % Menambahkan judul pada axes "gambarHasil"



function edh2_Callback(hObject, eventdata, handles)
% hObject    handle to edh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edh2 as text
%        str2double(get(hObject,'String')) returns contents of edh2 as a double


% --- Executes during object creation, after setting all properties.
function edh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edw2_Callback(hObject, eventdata, handles)
% hObject    handle to edw2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edw2 as text
%        str2double(get(hObject,'String')) returns contents of edw2 as a double


% --- Executes during object creation, after setting all properties.
function edw2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edw2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% global frame

    [nama_file_simpan, path_simpan] = uiputfile({'*.jpg', 'JPG Image (.jpg)'}, 'Menyimpan Citra');

    if isequal(nama_file_simpan, 0) || isequal(path_simpan, 0)
        msgbox('Image is not saved', 'Foto_Editor')
    else
        % F = getframe(handles.gambarHasil);
        % img = frame2im(F);
        img = getimage(handles.gambarHasil); % Mengambil gambar dari gambarAkhir
        imwrite(img, fullfile(path_simpan, nama_file_simpan), 'jpg');
        msgbox('Image is saved', 'Foto_Editor')
    end

    axes(handles.gambarHasil)


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
    axes(handles.gambarAwal)
    cla('reset')
    axes(handles.histAwal)
    cla('reset')
    axes(handles.gambarHasil)
    cla('reset')
    axes(handles.histHasil)
    cla('reset')
    



function edbrowse_Callback(hObject, eventdata, handles)
% hObject    handle to edbrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edbrowse as text
%        str2double(get(hObject,'String')) returns contents of edbrowse as a double


% --- Executes during object creation, after setting all properties.
function edbrowse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edbrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Grayscale.
function Grayscale_Callback(hObject, eventdata, handles)
 set(handles.Grayscale,'Value',1)

    Img = handles.Img;
    Gray = rgb2gray(Img);

    axes(handles.gambarHasil)
    cla('reset')
    imshow(Gray)

    axes(handles.histHasil)
    cla('reset')
    h = histogram(Gray(:),256);
        h.FaceColor = [0.5 0.5 0.5];
        h.EdgeColor = [0.5 0.5 0.5];

    xlabel('Intensitas Piksel');
    ylabel('Frekuensi');
    title(handles.histHasil, 'Histogram Citra Grayscale'); % Menambahkan judul pada axes "histHasil"
    title(handles.gambarHasil, 'Citra Grayscale'); % Menambahkan judul pada axes "gambarHasil"

% --- Executes on button press in negative.
function negative_Callback(hObject, eventdata, handles)
    set(handles.negative,'Value',1)
    % Image Complement
    Img = handles.Img;
    Img_Comp = imcomplement(Img);

    axes(handles.gambarHasil)
    cla('reset')
    imshow(Img_Comp)

    red = Img_Comp(:,:,1); % Red channel
    green = Img_Comp(:,:,2); % Green channel
    blue = Img_Comp(:,:,3); % Blue channel
    axes(handles.histHasil);
    cla('reset')
    h = histogram(red(:),256);
    h.FaceColor = [1 0 0];
    h.EdgeColor = 'r';
    hold on;
    h = histogram(green(:),256);
    h.FaceColor = [0 1 0];
    h.EdgeColor = 'g';
    h = histogram(blue(:),256);
    h.FaceColor = [0 0 1];
    h.EdgeColor = 'b';
    xlabel('Intensitas Piksel');
    ylabel('Frekuensi');
    title(handles.histHasil, 'Histogram Citra Negative'); % Menambahkan judul pada axes "histHasil"
    title(handles.gambarHasil, 'Citra Negative'); % Menambahkan judul pada axes "gambarHasil"


% --- Executes on button press in biner.
function biner_Callback(hObject, eventdata, handles)
    set(handles.biner,'Value',1) % Mengatur nilai tombol "Biner" menjadi 1
    Img = handles.Img; % Mendapatkan citra dari handles
    Gray = rgb2gray(Img); % Mengubah citra menjadi citra grayscale
    BW = imbinarize(Gray); % Mengubah citra grayscale menjadi citra biner dengan metode thresholding
    
    axes(handles.gambarHasil) % Mengakses axes "gambarHasil"
    cla('reset') % Menghapus konten sebelumnya dari axes
    imshow(BW) % Menampilkan citra biner pada axes
    
    axes(handles.histHasil) % Mengakses axes "histHasil"
    cla('reset') % Menghapus konten sebelumnya dari axes
    h = histogram(BW(:),256); % Membuat histogram citra grayscale
    h.FaceColor = [0.5 0.5 0.5]; % Mengatur warna wajah histogram
    h.EdgeColor = [0.5 0.5 0.5]; % Mengatur warna tepi histogram
    
    xlabel('Intensitas Piksel'); % Menambahkan label sumbu x
    ylabel('Frekuensi'); % Menambahkan label sumbu y
    
    title(handles.histHasil, 'Histogram Citra Biner'); % Menambahkan judul pada axes "histHasil"
    title(handles.gambarHasil, 'Citra Biner'); % Menambahkan judul pada axes "gambarHasil"


function tingkat_Callback(hObject, eventdata, handles)
% hObject    handle to tingkat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tingkat as text
%        str2double(get(hObject,'String')) returns contents of tingkat as a double


% --- Executes during object creation, after setting all properties.
function tingkat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tingkat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in blur.
function blur_Callback(hObject, eventdata, handles)
    % Mendapatkan nilai tingkat blur dari field teks "tingkat"
    tingkatBlur = str2double(get(handles.tingkat, 'String'));

    % Melakukan operasi blur pada citra menggunakan nilai tingkatBlur
    Img = handles.Img;
    Img_Blur = imgaussfilt(Img, tingkatBlur);

    axes(handles.gambarHasil)
    cla('reset')
    imshow(Img_Blur)

    red = Img_Blur(:,:,1);
    green = Img_Blur(:,:,2);
    blue = Img_Blur(:,:,3);

    axes(handles.histHasil);
    cla('reset')
    h = histogram(red(:), 256);
    h.FaceColor = [1 0 0];
    h.EdgeColor = 'r';
    hold on;
    h = histogram(green(:), 256);
    h.FaceColor = [0 1 0];
    h.EdgeColor = 'g';
    h = histogram(blue(:), 256);
    h.FaceColor = [0 0 1];
    h.EdgeColor = 'b';
    xlabel('Intensitas Piksel');
    ylabel('Frekuensi');
    title(handles.histHasil, 'Histogram Citra Blur');
    title(handles.gambarHasil, 'Citra Blur');

% --- Executes on button press in smooth.
function smooth_Callback(hObject, eventdata, handles)
    % Mendapatkan nilai tingkat smooth dari field teks "tingkat"
    tingkatSmooth = str2double(get(handles.tingkat, 'String'));

    % Melakukan operasi smoothing pada citra menggunakan nilai tingkatSmooth
    Img = handles.Img;
    Img_Smooth = imguidedfilter(Img, 'DegreeOfSmoothing', tingkatSmooth);

    axes(handles.gambarHasil)
    cla('reset')
    imshow(Img_Smooth)

    red = Img_Smooth(:,:,1);
    green = Img_Smooth(:,:,2);
    blue = Img_Smooth(:,:,3);

    axes(handles.histHasil);
    cla('reset')
    h = histogram(red(:), 256);
    h.FaceColor = [1 0 0];
    h.EdgeColor = 'r';
    hold on;
    h = histogram(green(:), 256);
    h.FaceColor = [0 1 0];
    h.EdgeColor = 'g';
    h = histogram(blue(:), 256);
    h.FaceColor = [0 0 1];
    h.EdgeColor = 'b';
    xlabel('Intensitas Piksel');
    ylabel('Frekuensi');
    title(handles.histHasil, 'Histogram Citra Smoothing');
    title(handles.gambarHasil, 'Citra Smoothing');


function mirror_Callback(hObject, eventdata, handles)
% hObject    handle to mirror (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Mendapatkan citra yang akan dimirror
    Img = handles.Img;

    % Mendapatkan pilihan dari objek "mirror"
    contents = cellstr(get(hObject, 'String'));
    selectedOption = contents{get(hObject, 'Value')};

    % Melakukan operasi mirror pada citra
    switch selectedOption
        case 'Gambar Awal'
            Img_Mirror = Img;
        case 'Horizontal'
            Img_Mirror = flip(Img, 2);
        case 'Vertical'
            Img_Mirror = flip(Img, 1);
    end

    % Menampilkan citra hasil mirror
    axes(handles.gambarHasil)
    cla('reset')
    imshow(Img_Mirror)

    % Menampilkan histogram citra hasil mirror
    red = Img_Mirror(:,:,1);
    green = Img_Mirror(:,:,2);
    blue = Img_Mirror(:,:,3);

    axes(handles.histHasil);
    cla('reset')
    h = histogram(red(:), 256);
    h.FaceColor = [1 0 0];
    h.EdgeColor = 'r';
    hold on;
    h = histogram(green(:), 256);
    h.FaceColor = [0 1 0];
    h.EdgeColor = 'g';
    h = histogram(blue(:), 256);
    h.FaceColor = [0 0 1];
    h.EdgeColor = 'b';
    xlabel('Intensitas Piksel');
    ylabel('Frekuensi');
    title(handles.histHasil, 'Histogram Citra Mirror');
    title(handles.gambarHasil, 'Citra Mirror');


function mirror_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mirror (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in rotate.
function rotate_Callback(hObject, eventdata, handles)
% hObject    handle to rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Mendapatkan citra yang akan dirotasi
    Img = handles.Img;

    % Mendapatkan pilihan dari objek "rotate"
    contents = cellstr(get(hObject, 'String'));
    selectedOption = contents{get(hObject, 'Value')};

    % Melakukan operasi rotasi pada citra
    switch selectedOption
        case 'Gambar Awal'
            Img_Rotate = imrotate(Img,360);
        case 'Rotate 90'
            Img_Rotate = imrotate(Img, 90);
        case 'Rotate 180'
            Img_Rotate = imrotate(Img, 180);
        case 'Rotate 270'
            Img_Rotate = imrotate(Img, 270);
    end

    % Menampilkan citra hasil rotasi
    axes(handles.gambarHasil)
    cla('reset')
    imshow(Img_Rotate)

    % Menampilkan histogram citra hasil rotasi
    red = Img_Rotate(:,:,1);
    green = Img_Rotate(:,:,2);
    blue = Img_Rotate(:,:,3);

    axes(handles.histHasil);
    cla('reset')
    h = histogram(red(:), 256);
    h.FaceColor = [1 0 0];
    h.EdgeColor = 'r';
    hold on;
    h = histogram(green(:), 256);
    h.FaceColor = [0 1 0];
    h.EdgeColor = 'g';
    h = histogram(blue(:), 256);
    h.FaceColor = [0 0 1];
    h.EdgeColor = 'b';
    xlabel('Intensitas Piksel');
    ylabel('Frekuensi');
    title(handles.histHasil, 'Histogram Citra Rotate');
    title(handles.gambarHasil, 'Citra Rotate');




% --- Executes during object creation, after setting all properties.
function rotate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in edge.
function edge_Callback(hObject, eventdata, handles)
    % Mendapatkan citra yang akan diproses
    Img = handles.Img;
    % Mendapatkan pilihan metode deteksi tepi dari field popupmenu "edge"
    
    contents = cellstr(get(hObject, 'String'));
    selectedOption = contents{get(hObject, 'Value')};
    % Konversi citra ke grayscale jika perlu
    if size(Img, 3) > 1
        Img = rgb2gray(Img);
    end

    % Melakukan deteksi tepi berdasarkan metode yang dipilih
    switch selectedOption
        case 'Robert'
            % Metode Robert
            edgeImg = edge(Img, 'roberts');
            titleStr = 'Deteksi Tepi Robert';
        case 'Canny'
            % Metode Canny
            edgeImg = edge(Img, 'canny');
            titleStr = 'Deteksi Tepi Canny';
        case 'Prewitt'
            % Metode Prewitt
            edgeImg = edge(Img, 'prewitt');
            titleStr = 'Deteksi Tepi Prewitt';
    end

    % Menampilkan citra hasil deteksi tepi
    axes(handles.gambarHasil)
    cla('reset')
    imshow(edgeImg)
    title(handles.gambarHasil, titleStr);

    % Menampilkan histogram citra hasil deteksi tepi
    axes(handles.histHasil);
    cla('reset')
    h = histogram(edgeImg(:), 2);
    h.FaceColor = [0 0 0];
    h.EdgeColor = 'k';
    xlabel('Intensitas Piksel');
    ylabel('Frekuensi');
    title(handles.histHasil, 'Histogram Deteksi Tepi');

function edge_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function red_Callback(hObject, eventdata, handles)
% hObject    handle to red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of red as text
%        str2double(get(hObject,'String')) returns contents of red as a double


% --- Executes during object creation, after setting all properties.
function red_CreateFcn(hObject, eventdata, handles)
% hObject    handle to red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function green_Callback(hObject, eventdata, handles)
% hObject    handle to green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of green as text
%        str2double(get(hObject,'String')) returns contents of green as a double


% --- Executes during object creation, after setting all properties.
function green_CreateFcn(hObject, eventdata, handles)
% hObject    handle to green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function blue_Callback(hObject, eventdata, handles)
% hObject    handle to blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of blue as text
%        str2double(get(hObject,'String')) returns contents of blue as a double


% --- Executes during object creation, after setting all properties.
function blue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in submit.
function submit_Callback(hObject, eventdata, handles)
% hObject    handle to submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Mendapatkan nilai konsentrasi Red dari field teks "red"
    konsentrasiRed = str2double(get(handles.red, 'String'));

    % Mendapatkan nilai konsentrasi Green dari field teks "green"
    konsentrasiGreen = str2double(get(handles.green, 'String'));

    % Mendapatkan nilai konsentrasi Blue dari field teks "blue"
    konsentrasiBlue = str2double(get(handles.blue, 'String'));

    % Gunakan nilai konsentrasi Red, Green, dan Blue sesuai kebutuhan Anda

    % Contoh penggunaan:
    % Misalnya, ingin mengubah konsentrasi warna menjadi merah dengan mengalikan nilai Red dengan 2
    Img = handles.Img;
    Img_Red = Img(:, :, 1) * konsentrasiRed;
    Img_Green = Img(:, :, 2) * konsentrasiGreen;
    Img_Blue = Img(:, :, 3) * konsentrasiBlue;

    % Gabungkan kembali komponen warna menjadi citra RGB yang baru
    Img_New = cat(3, Img_Red, Img_Green, Img_Blue);

    % Tampilkan citra yang baru pada axes atau tempat yang diinginkan
    axes(handles.gambarHasil);
    imshow(Img_New);

    % Hitung histogram citra yang baru
    red_new = Img_New(:,:,1);
    green_new = Img_New(:,:,2);
    blue_new = Img_New(:,:,3);

    axes(handles.histHasil);
    cla('reset')
    h = histogram(red_new(:), 256);
    h.FaceColor = [1 0 0];
    h.EdgeColor = 'r';
    hold on;
    h = histogram(green_new(:), 256);
    h.FaceColor = [0 1 0];
    h.EdgeColor = 'g';
    h = histogram(blue_new(:), 256);
    h.FaceColor = [0 0 1];
    h.EdgeColor = 'b';
    xlabel('Intensitas Piksel');
    ylabel('Frekuensi');
    title(handles.histHasil, 'Histogram Citra Setelah Mengubah Konsentrasi Warna');

% --- Executes on button press in brightness.
function brightness_Callback(hObject, eventdata, handles)
% hObject    handle to brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    tingkatbrightness = str2double(get(handles.tingkat, 'String')); % Mengambil nilai tingkat dari input
    
    Img = handles.Img;

    % Menambah atau mengurangi brightness
    imageDataBrightness = Img + tingkatbrightness;

    % Memastikan nilai piksel berada dalam rentang 0-255
    imageDataBrightness(imageDataBrightness > 255) = 255;
    imageDataBrightness(imageDataBrightness < 0) = 0;

    % Menampilkan citra hasil brightness
    axes(handles.gambarHasil);
    imshow(imageDataBrightness);
    
    red = imageDataBrightness(:,:,1);
    green = imageDataBrightness(:,:,2);
    blue = imageDataBrightness(:,:,3);

    axes(handles.histHasil);
    cla('reset')
    h = histogram(red(:), 256);
    h.FaceColor = [1 0 0];
    h.EdgeColor = 'r';
    hold on;
    h = histogram(green(:), 256);
    h.FaceColor = [0 1 0];
    h.EdgeColor = 'g';
    h = histogram(blue(:), 256);
    h.FaceColor = [0 0 1];
    h.EdgeColor = 'b';
    xlabel('Intensitas Piksel');
    ylabel('Frekuensi');
    title(handles.histHasil, 'Histogram Citra Brightness');
    title(handles.gambarHasil, 'Citra Brightness');

% --- Executes on selection change in noise.
function noise_Callback(hObject, eventdata, handles)
    % Get the selected noise type from the popup menu
    contents = cellstr(get(hObject,'String'));
    selected_noise = contents{get(hObject,'Value')};
    % Mendapatkan citra yang akan diproses
    Img = handles.Img;

    % Apply the selected noise to the image
    noisy_image = Img;
    switch selected_noise
        case 'Salt and Pepper'
            noisy_image = imnoise(Img, 'salt & pepper',0.1);
            titleStr = 'Citra Hasil Noise Salt & Pepper';
        case 'Gaussian'
            noisy_image = imnoise(Img, 'gaussian');
            titleStr = 'Citra Hasil Noise Gaussian';
        case 'Speckle'
            noisy_image = imnoise(Img, 'speckle');
            titleStr = 'Citra Hasil Noise Specke';
    end
    % Menampilkan citra hasil deteksi tepi
    axes(handles.gambarHasil)
    cla('reset')
    imshow(noisy_image)
    title(handles.gambarHasil, titleStr);
    
     % Menampilkan citra hasil Noise
    red = noisy_image(:,:,1); % Red channel
    green = noisy_image(:,:,2); % Green channel
    blue = noisy_image(:,:,3); % Blue channel
    axes(handles.histHasil);
    cla('reset')
    h = histogram(red(:),256);
    h.FaceColor = [1 0 0];
    h.EdgeColor = 'r';
    hold on;
    h = histogram(green(:),256);
    h.FaceColor = [0 1 0];
    h.EdgeColor = 'g';
    h = histogram(blue(:),256);
    h.FaceColor = [0 0 1];
    h.EdgeColor = 'b';
    xlabel('Intensitas Piksel');
    ylabel('Frekuensi');
    title(handles.histHasil, 'Histogram Noise');

% --- Executes during object creation, after setting all properties.
function noise_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to noise (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
