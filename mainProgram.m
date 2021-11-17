
 
r = init()
controlLoop(r)




function r = init()
    %create recipes
    

    %set up robot
    clear all;
    arduinoObj = serialport("COM4",9600)
    configureTerminator(arduinoObj,hex2dec('5A')); % Data package ends with byte 0x5A
    r = dobotInit()

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
                    q = zeros(4)%invkin(r,);
                    rob = forwardKinematics(q,rob)
                    %open claw
                    q = [zeros(3),openAngle]
                    rob = forwardKinematics(q,rob)
                    %descend
                    %close claw
                    q = [zeros(3),closedAngle]
                    rob = forwardKinematics(q,rob)
                    %% 
                    %ascend
                %bring to location
                    %move across
                    %descend
                    %open claw
                    q = [zeros(3),openAngle]
                    rob = forwardKinematics(q,rob)
                    %ascend
                    %return
    end
end

