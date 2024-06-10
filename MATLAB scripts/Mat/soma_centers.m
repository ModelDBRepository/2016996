
center_x = zeros(440,1);
center_y = zeros(440,1);
center_z = zeros(440,1);

%no soma located in 15 µm radius annulus
%cylinder radius = 100 µm

i=1;
while(i<441)
    x = -100 + (200)*rand(1,1); 
    z = -100 + (200)*rand(1,1); 
    y = -20 + (40)*rand(1,1); %depth


    dist =  sqrt(x.^2 + z.^2);

    if(dist<100 && dist>15)
        center_x(i)=x;
        center_y(i)=y;
        center_z(i)=z; 
        i=i+1;
    end
    
end



save('cylindrical_440_neurons.mat','center_x','center_y','center_z');


    
    
    
    
    
        
    




