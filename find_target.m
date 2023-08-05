%function returning index of selected cell and target cell
function [selected,target] = find_target(Field,size)

    %select non-empty cell at random
    notEmpty = false;
    while(~notEmpty)
        row = randi(size);
        col = randi(size);
        if(Field(row,col) ~= 0)
            notEmpty = true;
        end
    end
    selected = [row,col];
    
    %find the neigbour (adjacent) cells for the selected cell 
    if(row == 1)
        if(col == 1)
            Neighbor = [row col; row col+1; row+1 col; row+1 col+1];
        elseif(col == size)
            Neighbor = [row col; row col-1; row+1 col; row+1 col-1];
        else
            Neighbor = [row col; row col+1; row col-1; row+1 col; row+1 col+1; row+1 col-1];
        end

    elseif(row == size)
        if(col == 1)
            Neighbor = [row col; row col+1; row-1 col; row-1 col+1];  
        elseif(col == size)
            Neighbor = [row col; row col-1; row-1 col; row-1 col-1];
        else
            Neighbor = [row col; row col+1; row col-1; row-1 col; row-1 col+1; row-1 col-1];     
        end

    elseif(col == 1)
        Neighbor = [row col; row col+1; row-1 col; row-1 col+1; row+1 col; row+1 col+1];
    
    elseif(col == size)
        Neighbor = [row col; row col-1; row-1 col; row-1 col-1; row+1 col; row+1 col-1];
        
    else 
        Neighbor = [row col; row col+1; row col-1; row+1 col; row+1 col+1; row+1 col-1; row-1 col; row-1 col+1; row-1 col-1];
    end
    
    %number of neighboring cells
    Neighbor_amount = height(Neighbor);

    Neighbor_scores = zeros(Neighbor_amount,1);
    Neighbor_prob = zeros(Neighbor_amount,1);
    total_score = 0;
    
    %find the score associated with selected cell to target cell movement
    for i = 1:Neighbor_amount
        currentCellValue = Field(Neighbor(1,1),Neighbor(1,2));
        targetCellValue = Field(Neighbor(i,1),Neighbor(i,2));
        %use calc_score function to calcuate the scores 
        Neighbor_scores(i) = calc_score(currentCellValue,targetCellValue);
        total_score = total_score + Neighbor_scores(i);
    end
    
    %normalized score values
    for i = 1:Neighbor_amount
        Neighbor_prob(i) = (Neighbor_scores(i))/total_score;
    end
    
    %pick target cell depending on the normalized score (probability)
    random_target = rand;
    prob_sum = 0;
   
    for i = 1:Neighbor_amount
        prob_sum = prob_sum + Neighbor_prob(i);
        if random_target <= prob_sum
            target = Neighbor(i,:);
            break;
        end
    end  
end