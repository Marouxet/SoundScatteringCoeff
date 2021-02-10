function [angulo_text] = graphCurrentAngle(pointer,figure)
load('app_data/current.mat','nmedicion');
load('app_data/current.mat','angle');
load('app_data/settings.mat','intervalo_angular');
i = 1;
pos_actual = find(nmedicion{i}==pointer,1);

while(isempty(pos_actual))
i = i+1;
pos_actual = find(nmedicion{i}==pointer,1);
end
   
    if length(angle{i}) == 1;
        axes(figure)
        set(cla,'Visible','Off')
        angulo_text = 'Sin Girar';
    else
    
        angulo_text = angle{i}(pos_actual);
        angulo = angulo_text*pi/180;
        axes(figure)
        set(cla,'Visible','On');
        compass(exp(1i*angulo));
    end

    
end


%end
