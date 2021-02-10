function [] = girar(angle)
%load('app_data/settings.mat','intervalo_angular'); %Cargo el intervalo angular configurado
angulo_actual = ET250_3D('get',0); %Leo la Posición actual

% angle = angulo_actual + intervalo_angular;
% if angle ==360
%     angle = 0;
% end

moviendo = 1;
ET250_3D('set', angle);

%%%DELAY PARA ESPERAR QUE TERMINE DE GIRAR
angle_current = ET250_3D('get', 0);
while angle_current ~= angle
tic 
while toc < 1; 
end; 
angle_current = ET250_3D('get', 0);
end
%%%FIN DE DELAY PARA ESPERAR QUE GIRE
end