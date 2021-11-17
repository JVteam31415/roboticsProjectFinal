 
clear all;
[r,reclist] = initStuff()
controlLoop(r,reclist)




function [r,reclist] = initStuff()
    %create recipes
    rec = ["orange","blue"]
    reclist(1)=recipe(rec,"sample");
    reclist(2)=recipe(rec,"sample2");

    %set up robot
    %arduinoObj = serialport("COM4",9600)
    %configureTerminator(arduinoObj,hex2dec('5A')); % Data package ends with byte 0x5A
    r = dobotInitNew()

end

function controlLoop(rob, reclist)
    response = ""
    %while user available
    while (response~="none")
        %get user recipe desire
        response = input("What recipe do you want the ingredients for? (none to exit) ", 's')
        disp(response);
        %stop condition
        if(response=="none")
            break
        end
        %find desire in recipelist
        ans = -1;
        for i=1:length(reclist)
            if(reclist(i).name==response)
                ans = i;
                break
            end
        end
        %not in, try again
        if(ans<0)
            disp("not valid recipe")
        else
        %else if in, 
            %for each ingredient in recipe
            for j=1:length(reclist(ans).ingredientList)
                %identify ingredient location
                thisOne = reclist(ans).ingredientList(j)
    %% 
    
                %secure it
                    %move to cup
                    q1 = zeros(4)%invkin(r,);
                    %rob = fwdkinArduino(rob,q1,0,arduinoObj)
                    %descend
                    q2 = zeros(4)
                    %rob = fwdkinArduino(rob,q2,0,arduinoObj)
                    %close claw
                    %rob = fwdkinArduino(rob,q2,1,arduinoObj)
                    %% 
                    %ascend
                    %rob = fwdkinArduino(rob,q1,1,arduinoObj)
                    
                   
                %bring to location
                    %move across
                    q3 = zeros(4)%invkin(r,);
                    %rob = fwdkinArduino(rob,q3,1,arduinoObj)
                    %descend
                    q4 = zeros(4)
                    %rob = fwdkinArduino(rob,q4,1,arduinoObj)
                    %open claw
                    %rob = fwdkinArduino(rob,q4,0,arduinoObj)
                    %% 
                    %ascend
                    %rob = fwdkinArduino(rob,q3,0,arduinoObj)
                    %return
            end

        end
       
    end
end

