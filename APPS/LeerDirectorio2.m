    
function [nombre21, transf_usuario, transff_bd ,min_error] = LeerDirectorio2()
voz_usuario=audioread([pwd '\AUDIOS\', 'vozUsuario.wav']);
norm_usuario=normalizar(voz_usuario);
transf_usuario=abs((fft(norm_usuario))); %transformada rapida de Fourier
%Esto nos permitira manejar los errores cuando la voz no se encuentre en
%nuestra BD
min_error=100000;
nombre21=' ';
transff_bd=1;
%
lee_audios = dir([pwd '\BD\' '*.wav']); %dir es para enumerar los archivos de la carpeta
for k = 1:length(lee_audios)%recorre número de audios guardados en el directorio
    audio_nom = lee_audios(k).name; %Obtiene el nombre de los audios
    
    if ~strcmp(audio_nom,[pwd '\AUDIOS\' 'vozUsuario.wav'])%strcmp comparar cadenas
       
      voz_bd = audioread(strcat([pwd '\BD\' audio_nom]));%juntar cadenas strcat o concatenar
          
        norm_voz_bd=normalizar(voz_bd);
        transf_voz_bd=abs((fft(norm_voz_bd)));

%         error=mean(abs(transf_voz_bd - transf_usuario));%mean valor medio
% error_cuadratico=error.^2;
% actual_error=sum(error_cuadratico);
    
        actual_error=mean(abs(transf_voz_bd - transf_usuario));%mean valor medio
        if actual_error < min_error  
            min_error=actual_error;
            nombre21=audio_nom;
       
            transff_bd=transf_voz_bd;
        end         
    end    
   
end
