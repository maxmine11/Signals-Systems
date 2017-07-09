
function filtered = demosaicPDI(img)
%Guesses the red space which is (:,:,1)
for i=1:2:length(img(:,1,1))
    for j=1:2:length(img(1,:,1))
        x=img(i+1,j+1,1);
        img(i:i+1,j:j+1,1)=[x x;x x]; 
    end
end
%guesses the green space which is (:,:,2)
for i=1:2:length(img(:,1,2))
    for j=1:2:length(img(1,:,2))
        g1=img(i,j+1,2);
        g2=img(i+1,j,2);
        img(i:i+1,j:j+1,2)=[g1 g1;g2 g2]; 
    end
end
%Guesses the blue space which is (:,:,3)
for i=1:2:length(img(:,1,3))
    for j=1:2:length(img(1,:,3))
        b=img(i,j,3);
        img(i:i+1,j:j+1,3)=[b b;b b]; 
    end
end
filtered = img;
end