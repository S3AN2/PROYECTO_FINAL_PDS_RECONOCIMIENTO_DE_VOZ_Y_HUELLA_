
%----- Función Normalizar -----
% Función que será utilizada en los siguientes procesos
function [audio_normalizado]=normalizar(audio)
audio=audio(:,1);
maximo=max(abs(audio));
n=length(audio); %calcula el tamaño del vector
audio_normalizado=zeros(n,1);
    for i=1:1:n
    audio_normalizado(i)=audio(i)/maximo;
    end
end