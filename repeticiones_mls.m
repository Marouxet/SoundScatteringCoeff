function [  angle , repet, duracion ] = repeticiones_mls( N )

%N es el orden de la se�al MLS en formato num�rico

        load('app_data/settings.mat','vel_rotacion');
        load('app_data/settings.mat','SampleRate');

        %C�lculo de las repeticiones totales y �ngulo total para poder eleiminar el
        %primer ciclo

        repet = round((60/vel_rotacion)/((2^N -1)/SampleRate)) +1;
        angle_total = (repet*(2^N-1)/SampleRate)/(60/vel_rotacion)*360;

        error = (round(angle_total*10)/10 - fix(angle_total))*10;

        if error <=2
            angle = fix(angle_total);
        elseif error <=6
            angle = fix(angle_total) + 0.5;
        elseif error <=10
            angle = fix(angle_total) + 1;
        end
        
        duracion = repet*(2^N-1)/SampleRate;
end
