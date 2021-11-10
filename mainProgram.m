
openAngle = 8
closedAnge = 55%most recent 
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


function robot = forwardKinematics(q,robot)
        
    isGrab = 0; % No suction
    
    MOVE_MODE_JUMP = 0;
    MOVE_MODE_JOINTS = 1;  % joints move independent
    MOVE_MODE_LINEAR = 2;  % linear movement
    
    CARTESIAN = 3;
    JOINT = 6;
    
    % Set the float values in the data package
    line_float_cmd = zeros(1,10);
    line_float_cmd(1) = JOINT;
    line_float_cmd(3) = q(1);
    line_float_cmd(4) = q(2);
    line_float_cmd(5) = q(3);
    line_float_cmd(6) = q(4);
    line_float_cmd(7) = isGrab;
    line_float_cmd(8) = MOVE_MODE_JOINTS;
    
    % Combine datapackage
    header_chr = char(hex2dec('A5'));
    line_chr_cmd = char(typecast(single(line_float_cmd), 'uint8'));
    % tail_chr = char(hex2dec('5A')); % No need, bcs already specified with configureTerminator command
    line_chr_cmd = [header_chr,line_chr_cmd]; %,tail_chr]
    line_str_cmd = convertCharsToStrings(line_chr_cmd)
    
    % Send command to the robot
    writeline(arduinoObj,line_str_cmd)

    pause(1);

    flush(arduinoObj);
    line_str = readline(arduinoObj); % MATLAB returns readline as string
    line_str = readline(arduinoObj); % MATLAB returns readline as string
    line_chr = convertStringsToChars(line_str) % convert the string to char array
    
    % line_hex = dec2hex(line_chr) % Just to see the data as byte values in hex
    assert(line_chr(1) == char(hex2dec('A5'))) % Assertion for header byte
    assert(length(line_chr) == 41) % Assertion for data length is correct (ie 42 bytes, 1 is removed with end byte while reading the line)
    line_float = typecast(uint8(line_chr(2:end)), 'single') % obtain the 10 float(single) values in the data package
    robot.position.x = line_float(1); % X coordinate
    robot.position.y = line_float(2); % Y coordinate
    robot.position.z = line_float(3); % Z coordinate
    
    robot.angles.rHead = line_float(4); % Rotation value (Relative rotation angle of the end effector to the base)
    robot.angles.baseAngle = line_float(5); % Base Angle 
    robot.angles.longArmAngle = line_float(6); % Rear Arm Angle 
    robot.angles.shortArmAngle = line_float(7); % Fore Arm Angle
    robot.angles.pawArmAngle = line_float(8); % Servo Angle (joint 4 angle)
    
    robot.isGrab = line_float(9) > 0; % Pump State
    robot.angles.gripperAngle = line_float(10); % Gripper Angle 
end