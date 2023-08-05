%update field (selected and target cell) based on probabilities of human
%killing human and human killing zombies (zombies infecting humans)

function NewField = updateField(s, t, phz, phh, Field)
    NewField = Field;
    if( Field(s(1),s(2)) == 1)
        %human targetng zombie cell
        if( Field(t(1),t(2)) == -1 ) 
            if(binornd(1,phz) == 1)
                NewField(s(1),s(2)) = 0;
                NewField(t(1),t(2)) = 1;
            else
                NewField(s(1),s(2)) = -1;
                NewField(t(1),t(2)) = -1;
            end
        %human targeting human cell
        elseif( Field(t(1),t(2)) == 1)
            if(binornd(1,phh) == 1)
                NewField(s(1),s(2)) = 0;
                NewField(t(1),t(2)) = 1;
            else
                NewField(s(1),s(2)) = 1;
                NewField(t(1),t(2)) = 1;
            end
        %human targeting empty cell
        else 
            NewField(s(1),s(2)) = 0;
            NewField(t(1),t(2)) = 1;
        end
    
    elseif(Field(s(1),s(2)) == -1)
        %zombie targeting human 
        if( Field(t(1),t(2)) == 1 ) 
            if(binornd(1,phz) == 1)
                NewField(s(1),s(2)) = 0;
                NewField(t(1),t(2)) = 1;
            else
                NewField(s(1),s(2)) = -1;
                NewField(t(1),t(2)) = -1;
            end
        %zombie targeting empty cell
        elseif( Field(t(1),t(2)) == 0)
            NewField(s(1),s(2)) = 0;
            NewField(t(1),t(2)) = -1;
        %zombie targeting zombie cell
        else 
            NewField(s(1),s(2)) = -1;
            NewField(t(1),t(2)) = -1;
        end
    end
end