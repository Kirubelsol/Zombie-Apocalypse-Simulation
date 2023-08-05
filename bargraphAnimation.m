%function for bar graph animation plot
function bargraphAnimation(human,zombie,empty,step,file)

    xlabel = {'Human' ; 'Zombie'; 'Empty'};
    %delay between each time step for animation
    delay = 0.01;
    for i = 1:500:step
        y = [human(i), zombie(i), empty(i)];
        b = bar(y,'FaceColor','flat');
        b.CData(1,:) = [0 1 0];
        b.CData(2,:) = [1, 0, 0];
        b.CData(3,:) = [0, 0, 0];
        xticklabels(xlabel);
        ylabel('Normalized population');
        title(sprintf('Cell population Normalized\n Time step: %d', i),'Interpreter','Latex')
        pause(delay);
        
        %capture figure window, convert to RGB, then indexed image
        F = getframe(gcf);
        RGB = frame2im(F);
        [X,cmap] = rgb2ind(RGB,128);
        if i == 1
            %write to the file
            imwrite(X,cmap,file,'gif', 'Loopcount',inf,'DelayTime',delay);
        else
            imwrite(X,cmap,file,'gif','WriteMode','append','DelayTime',delay); 
        end
    end
end