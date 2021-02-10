% Control por red de la tabla rotativa Outline ET250-3D 
% Desarrollo: DI (FH) Pfeifenberger Lukas

function [angle] = ET250_3D(cmd, angle)

u = udp('192.168.1.34',7000);   %IP address and port
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

        %Calculo por el camino mas corto
        angle_delta = angle-angle_current;
        if angle_delta > 180
            angle_delta = angle_delta - 360;
        end
        if angle_delta < -180
            angle_delta = angle_delta + 360;
        end
        cmd(1) = uint8( 1.5-sign(angle_delta)/2 );                %1st byte = direccion
        cmd(2) = uint8( floor(abs(angle_delta*10)/256) );         %Angulo en grado*10
        cmd(3) = uint8( mod(floor(abs(angle_delta*10)),256) );    %Angulo en grado*10
        cmd(4) = 0;

        fwrite(u,cmd)
        x = dec2hex(fread(u,2));                            %Recibe la respuesta

    case 'get'
        %Solicita la posicion actual
        fwrite(u,hex2dec(['04';'00';'00';'04']))
        x = fread(u,7);
        angle = (x(4)*256+x(5))/10;
end
fclose(u)