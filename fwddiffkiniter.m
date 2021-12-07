function robot = fwddiffkiniter(robot)
    q = robot.q;
    T = eye(4,4);
    T(4,4)=1;
    n=length(q);
    %get R
    R = zeros(3,3);
    %get p
    p = [0;0;0];


    for i=1:length(robot.q)
        axis = robot.H(:,i);
        if robot.joint_type(i)==0
            R=expm(hat(axis)*q(i));%R is the rotation of q around h, 
            p=robot.P(1:3,i); %p is just the vector of the arm segment

        end
        T=T*[R p;zeros(1,3) 1];%T is [R p] with a bottom row of 0s then a 1



    end

    robot.T=T*[eye(3,3) robot.P(1:3,n+1);zeros(1,3) 1];
    
end

function khat = hat(k) %gets the rotation matrix about the axis given
  
  khat=[0 -k(3) k(2); k(3) 0 -k(1); -k(2) k(1) 0];
  
end