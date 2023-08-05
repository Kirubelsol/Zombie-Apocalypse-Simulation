%Function for contour animation 
function contourAnimation(FieldAll,step,file)

    %delay between each time step for animation
    delay = 0.01;
    for i = 1:500:step
        contour(FieldAll(:,:,i));
        title(sprintf('Cell population Contour \n Time step: %d', i),'Interpreter','Latex')
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
