% Control por red de la tabla rotativa Outline ET250-3D 
% Desarrollo: DI (FH) Pfeifenberger Lukas
% Modificado por Mariano Arouxet para uso propio

function [angle,x ] = ET250_3D(cmd, angle)
load('app_data/settings.mat','mesa_ip');
ip = mesa_ip.ip_mesa; 
u = udp(ip,7000);   %IP address and port
fopen(u)
switch cmd
    case 'stop'
        fwrite(u,hex2dec(['03';'00';'00';'03']))            %Envio de parar
        x = dec2hex(fread(u,2));                            %Recibe la respuesta
    case 'set'
        %Solicita la posicion actual
        fwrite(u,hex2dec(['04';'00';'00';'04']))
        x = fread(u,7);
        angle_current = (x(4)*256+x(5))/10;

        
if angle>=360%Variado para pemitir girar >360
    angle_delta = angle+angle_current; %Para el caso de la medición continua hago que se acumule el ángulo que debe girar
    
else
        
        angle_delta = angle-angle_current;
                    
%Calculo por el camino mas corto
            if angle_delta > 180
                angle_delta = angle_delta - 360;
            end
            if angle_delta < -180
                angle_delta = angle_delta + 360;
            end
end
        cmd(1) = uint8( 1.5-sign(angle_delta)/2 );                %1st byte = direccion
        cmd(2) = uint8( floor(abs(angle_delta*10)/256) );         %Angulo en grado*10
        cmd(3) = uint8( mod(floor(abs(angle_delta*10)),256) );    %Angulo en grado*10
        cmd(4) = 0;

        fwrite(u,cmd)
        x = dec2hex(fread(u,2));                           %Recibe la respuesta

    case 'get'
        %Solicita la posicion actual
        fwrite(u,hex2dec(['04';'00';'00';'04']))
        x = fread(u,7);
        angle = (x(4)*256+x(5))/10;
        
    case 'zero'
        fwrite(u,hex2dec(['05';'00';'00';'05']))

end
fclose(u)