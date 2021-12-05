% q2+q3 = 95 for tall cups
% 
% q2+q3 = 125 for short cups


clear all;
initcom()
updown = -30;
pour = (updown+100);
if(pour>90)
pour = pour-180;
end
location = -60;
[r,reclist] = initStuff()
%controlLoop(r,reclist)




function [r,reclist] = initStuff()
    %create recipes
    rec = ["blue"]
    reclist(1)=recipe(rec,"blue");

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
                colorToGet = reclist(ans).ingredientList(j)
    %% 
                aim = 30
                %secure it
                    %in position
                    q1 = [aim, 43,52,updown]%invkin(r,);
                    rob = fwdkinArduino(rob,q1,1,arduinoObj)
                    %forward
                    q2 = [aim, 43,52,updown]
                    rob = fwdkinArduino(rob,q2,1,arduinoObj)
                    %close claw
                    rob = fwdkinArduino(rob,q2,0,arduinoObj)
                    %% 
                    %ascend
                    q21 = [aim,5,0,updown]
                    rob = fwdkinArduino(rob,q21,0,arduinoObj)
                    
                   
                %bring to location
                    %move across
                    q3 = [location,5,0,updown];%invkin(r,);
                    rob = fwdkinArduino(rob,q3,0,arduinoObj)
                    %pour
                    q4 = [location,5,0,pour];
                    rob = fwdkinArduino(rob,q4,0,arduinoObj)

                    
                    %return
                    rob = fwdkinArduino(rob,q3,0,arduinoObj)
                    rob = fwdkinArduino(rob,q21,0,arduinoObj)
                    rob = fwdkinArduino(rob,q2,0,arduinoObj)
                    rob = fwdkinArduino(rob,q2,1,arduinoObj)
                    rob = fwdkinArduino(rob,q1,1,arduinoObj)
            end

        end
       
    end
end

