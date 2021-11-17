
 
r = init()
controlLoop(r)




function r = init()
    %create recipes
    

    %set up robot
    clear all;
    arduinoObj = serialport("COM4",9600)
    configureTerminator(arduinoObj,hex2dec('5A')); % Data package ends with byte 0x5A
    r = dobotInitNew()

end

function controlLoop(rob)
    response = ""
    %while user available
    while (response~="none")
        %get user recipe desire
        response = input("What recipe do you want the ingredients for? (none to exit) ", 's')
        disp(response)
        %stop condition
        %find desire in recipelist
        %not in, try again
        %else if in, 
            %for each ingredient in recipe

                %identify ingredient location
    %% 
    
                %secure it
                    %move to cup
                    q1 = zeros(4)%invkin(r,);
                    rob = fwdkinArduino(rob,q1,0,arduinoObj)
                    %descend
                    q2 = zeros(4)
                    rob = fwdkinArduino(rob,q2,0,arduinoObj)
                    %close claw
                    rob = fwdkinArduino(rob,q2,1,arduinoObj)
                    %% 
                    %ascend
                    rob = fwdkinArduino(rob,q1,1,arduinoObj)
                    
                   
                %bring to location
                    %move across
                    q3 = zeros(4)%invkin(r,);
                    rob = fwdkinArduino(rob,q3,1,arduinoObj)
                    %descend
                    q4 = zeros(4)
                    rob = fwdkinArduino(rob,q4,1,arduinoObj)
                    %open claw
                    rob = fwdkinArduino(rob,q4,0,arduinoObj)
                    %% 
                    %ascend
                    rob = fwdkinArduino(rob,q3,0,arduinoObj)
                    %return
    end
end

