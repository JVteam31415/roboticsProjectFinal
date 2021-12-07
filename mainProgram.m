% q2+q3 = 95 for tall cups
% 
% q2+q3 = 125 for short cups


clear all;
initcom()

loc = -60;
[r,reclist]= initStuff();
 cam = webcam(2);
updown = -13;
pour = (updown+100);
if(pour>90)
    pour = pour-180;
end
%and we're off.
controlLoop(r,reclist,cam,updown,pour, arduinoObj, loc)




function [r,reclist] = initStuff()
    %create recipes
    rec = ["blue"];
    reclist(1)=recipe(rec,"blue");
    rec2 = ["yellow"];
    reclist(2)=recipe(rec2,"yellow");
    rec3 = ["blue","yellow"]
    reclist(3)=recipe(rec3,"both");


    r = dobotInitNew();

end

function controlLoop(rob, reclist,cam,updown,pour, arduinoObj, loc)
    
   
    response = "";
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
        answer = -1;
        for i=1:length(reclist)
            if(reclist(i).name==response)
                answer = i;
                break
            end
        end
        %not in, try again
        if(answer<0)
            disp("not valid recipe")
        else
        %else if in, 
            %for each ingredient in recipe
            for j=1:length(reclist(answer).ingredientList)
                %identify ingredient location
                colorToGet = reclist(answer).ingredientList(j);
    %%          
                aim = -1;
                newq = [35,20,72,updown];
                %keep going until find
                for i=1:14
                    rob = fwdkinArduino(rob,newq,1,arduinoObj);
                    %take picture
                    image = snapshot(cam);
                    %find centroid of image
                    [yp,bp,foundBlue, foundYellow, centroid] = imageRecognition(image);
                    found =0; %colorToGet 
                    if strcmp(colorToGet,"blue")
                        if foundBlue
                            if (centroid(2)>220)&(centroid(2)<440) 
                                cluster = image .* uint8(bp);
                                imshow(cluster);
                                found = 1;
                            end
                        end
                    elseif strcmp(colorToGet,"yellow")
                        if foundYellow
                            if (centroid(2)>220)&(centroid(2)<440) 
                                cluster = image .* uint8(yp);
                                imshow(cluster);
                                found = 1;
                            end
                        end
                    end

                    if found
                        aim = newq(1);
                        break;
                    else
                        newq = [newq(1)-5,20,72,updown];
                    end
                end
                if(aim==-1)
                    break
                end


                %secure it
                    %in position
                    q1 = [aim, 20,72,updown];%invkin(r,);
                    rob = fwdkinArduino(rob,q1,1,arduinoObj);
                    %forward
                    q2 = [aim, 43,52,updown];
                    rob = fwdkinArduino(rob,q2,1,arduinoObj);
                    %close claw
                    rob = fwdkinArduino(rob,q2,0,arduinoObj);
                    %% 
                    %ascend
                    q21 = [aim,5,0,updown];
                    rob = fwdkinArduino(rob,q21,0,arduinoObj);
                    
                   
                %bring to location
                    %move across
                    q3 = [loc,5,0,updown];%invkin(r,);
                    rob = fwdkinArduino(rob,q3,0,arduinoObj);
                    %pour
                    q4 = [loc,5,0,pour];
                    rob = fwdkinArduino(rob,q4,0,arduinoObj);
                    pause(5);   
                    
                    %return
                    rob = fwdkinArduino(rob,q3,0,arduinoObj);
                    rob = fwdkinArduino(rob,q21,0,arduinoObj);
                    rob = fwdkinArduino(rob,q2,0,arduinoObj);
                    rob = fwdkinArduino(rob,q2,1,arduinoObj);
                    rob = fwdkinArduino(rob,q1,1,arduinoObj);
            end

        end
       
    end
end

