%calculate score (s = selected cell value, t = target cell value)
function score = calc_score(s,t)
    if(s == 0)
        score = 0;
    elseif(s == -1 && t == 0)
        score = 2;
    elseif(s == -1 && t == -1)
        score = 1;
    %highest score if selected cell is zombie and target is human 
    elseif(s == -1 && t == 1)
        score = 3;
    elseif(s == 1 && t == 0)
        score = 2;
    elseif(s == 1 && t == -1)
        score = 1;
    elseif(s == 1 && t == 1)
        score = 2;
    end
end