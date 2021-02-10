
c_mics_total = str2double(get(handles.c_mics_total,'String'));
c_mics_simultaneo = str2double(get(handles.c_mics_simultaneas,'String'));
c_fuentes_total = str2double(get(handles.c_fuentes_total,'String'));
c_fuentes_simultaneo = str2double(get(handles.c_fuentes_simultaneas,'String'));

p1 = get(handles.prioridad1,'Value');
p2 = get(handles.prioridad2,'Value');
p3 = get(handles.prioridad3,'Value'); 
l1 = get(handles.luego1,'Value');
l2 = get(handles.luego2,'Value');
l3 = get(handles.luego3,'Value');

if      p1 ==1 && l2 == 1   %Caso en el que se varía MAS los microfonos (con muestra cambiada UNA vez)
    
    C0 = 2;
    
    if mod(c_mics_total,c_mics_simultaneo) == 0
        C1 = c_mics_total/c_mics_simultaneo;
    else
        C1 = fix(c_mics_total/c_mics_simultaneo) +1;
    end
    for i = 1:C1
        C1_text{i} = strcat('COMBINACION MICS_',num2str(i));
    end
    
    if mod(c_fuentes_total,c_fuentes_simultaneo) == 0
        C2 = c_fuentes_total/c_fuentes_simultaneo;
    else
        C2 = fix(c_fuentes_total/c_fuentes_simultaneo) +1;
    end
    
    for i = 1:C2
        C2_text{i} = strcat('COMBINACION FUENTE_',num2str(i));
    end
    
    C3 = 2;
    
    C3_text = {'SIN MUESTRA', 'CON MUESTRA'};
    
elseif  p1 ==1 && l3 == 1   %Caso en el que se varía MAS la fuente (con muestra cambiada UNA vez)
    
    C0 = 2;
    
    if mod(c_fuentes_total,c_fuentes_simultaneo) == 0
        C1 = c_fuentes_total/c_fuentes_simultaneo;
    else
        C1 = fix(c_fuentes_total/c_fuentes_simultaneo) +1;
    end
    
    for i = 1:C1
        C1_text{i} = strcat('COMBINACION FUENTE_',num2str(i));
    end
    
    if mod(c_mics_total,c_mics_simultaneo) == 0
        C2 = c_mics_total/c_mics_simultaneo;
    else
        C2 = fix(c_mics_total/c_mics_simultaneo) +1;
    end
    
     for i = 1:C1
        C2_text{i} = strcat('COMBINACION MICS_',num2str(i));
    end
    
    C3 = 2;
    
    C3_text = {'SIN MUESTRA', 'CON MUESTRA'};
    
elseif  p2 ==1 && l1 == 1   %Caso en el que se varía MÁS los microfonos (con fuente cambiada UNA vez)
    
    C0 = 2;
    
    if mod(c_mics_total,c_mics_simultaneo) == 0
        C1 = c_mics_total/c_mics_simultaneo;
    else
        C1 = fix(c_mics_total/c_mics_simultaneo) +1;
    end
    
    for i = 1:C1
        C1_text{i} = strcat('COMBINACION MICS_',num2str(i));
    end
    
    C2 = 2;
    
    C2_text = {'SIN MUESTRA', 'CON MUESTRA'};
     
    if mod(c_fuentes_total,c_fuentes_simultaneo) == 0
        C3 = c_fuentes_total/c_fuentes_simultaneo;
    else
        C3 = fix(c_fuentes_total/c_fuentes_simultaneo) +1;
    end
    
    for i = 1:C3
        C3_text{i} = strcat('COMBINACION FUENTE_',num2str(i));
    end
    
elseif  p2 ==1 && l3 == 1 %Caso en el que se varía MÄS la muestra (con la fuente cambiada UNA vez)
   
    C0 = 2;
     
    C1 = 2;
    
    C1_text = {'SIN MUESTRA', 'CON MUESTRA'};
   
    if mod(c_mics_total,c_mics_simultaneo) == 0
        C2 = c_mics_total/c_mics_simultaneo;
    else
        C2 = fix(c_mics_total/c_mics_simultaneo) +1;
    end
    
    for i = 1:C1
        C2_text{i} = strcat('COMBINACION MICS_',num2str(i));
    end
        
    if mod(c_fuentes_total,c_fuentes_simultaneo) == 0
        C3 = c_fuentes_total/c_fuentes_simultaneo;
    else
        C3 = fix(c_fuentes_total/c_fuentes_simultaneo) +1;
    end
    
    for i = 1:C3
        C3_text{i} = strcat('COMBINACION FUENTE_',num2str(i));
    end
    
elseif  p3 ==1 && l1 == 1  %Caso en el que se varía MAS la fuente (con los microfonos cambiado una vez)
    
    C0 = 2;
    
    if mod(c_fuentes_total,c_fuentes_simultaneo) == 0
        C1 = c_fuentes_total/c_fuentes_simultaneo;
    else
        C1 = fix(c_fuentes_total/c_fuentes_simultaneo) +1;
    end
    
    for i = 1:C1
        C1_text{i} = strcat('COMBINACION FUENTE_',num2str(i));
    end
    
    C2 = 2;
    
    C2_text = {'SIN MUESTRA', 'CON MUESTRA'};
    
    
    if mod(c_mics_total,c_mics_simultaneo) == 0
        C3 = c_mics_total/c_mics_simultaneo;
    else
        C3 = fix(c_mics_total/c_mics_simultaneo) +1;
    end
    
    for i = 1:C3
        C3_text{i} = strcat('COMBINACION MICS_',num2str(i));
    end
    
elseif  p3 ==1 && l2 == 1   %caso en el que se varía MAS la muestra (con los microfonos cambiado una vez)
   
    C0 = 2;
     
    C1 = 2;
    
    C1_text = {'SIN MUESTRA', 'CON MUESTRA'};
   
   
    if mod(c_fuentes_total,c_fuentes_simultaneo) == 0
        C2 = c_fuentes_total/c_fuentes_simultaneo;
    else
        C2 = fix(c_fuentes_total/c_fuentes_simultaneo) +1;
    end
    
    for i = 1:C2
        C2_text{i} = strcat('COMBINACION FUENTE_',num2str(i));
    end
    
    if mod(c_mics_total,c_mics_simultaneo) == 0
        C3 = c_mics_total/c_mics_simultaneo;
    else
        C3 = fix(c_mics_total/c_mics_simultaneo) +1;
    end
    
    for i = 1:C3
        C3_text{i} = strcat('COMBINACION MICS_',num2str(i));
    end
    
end
mediciones = C1*C2*C3*C0;
medicion = cell(mediciones,4);

i_C1 = 1;
i_C2 = 1;
i_C3 = 1;
for i =1:mediciones
    if mod(i,2)==0;
        medicion{i,4} = 'GIRANDO';
    else
        medicion{i,4} = 'SIN GIRAR';
    end
    
    
    medicion(i,3) = C1_text(i_C1);
    if mod(i,C0) == 0 
            i_C1 = i_C1 + 1;
    end
            
    if i_C1 == C1+1;
        i_C1 = 1;
    end
        
     medicion(i,2) = C2_text(i_C2);
    if mod(i,C0*C1) == 0 
            i_C2 = i_C2 + 1;
    end
            
    if i_C2 == C2+1;
        i_C2 = 1;
    end
    
    medicion(i,1) = C3_text(i_C3);
    if mod(i,C0*C1*C2) == 0 
            i_C3 = i_C3 + 1;
    end
            
    if i_C3 == C3+1;
        i_C3 = 1;
    end
end

orden = medicion;
save('app_data/current.mat','orden','-append');
