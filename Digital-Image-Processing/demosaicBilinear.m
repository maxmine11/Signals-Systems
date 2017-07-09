function filtered = demosaicBilinear(img)
%for blue
% for i=1:length(img(:,1,3))
%     for j=1:length(img(1,:,3))
%         if img(i,j,3)== 0
%             if i == 1
%                 if j==length(img(1,:,3));
%                     img(i,j,3)=img(i,j-1,3);
%                 else
%                     img(i,j,3)=(img(i,j-1,3) + img(i,j+1,3))/2;
%                 end
%             elseif j==1
%                 if i == length(img(:,1,3))
%                     img(i,j,3)=img(i-1,j,3);
%                 else
%                     img(i,j,3)=(img(i-1,j,3) + img(i+1,j,3))/2;
%                 end
%             else
%                 if i == length(img(:,1,3))
%                     img(i,j,3)=(img(i-1,j-1,3) + img(i-1, j+1,3))/2;
%                 else
%                     img(i,j,3)=(img(i-1,j-1,3) + img(i-1, j+1,3) + img(i+1,j-1,3) +img(i+1,j+1,3))/4;
%                 end
%             end
%         end
%         
%     end
% end
% 
% %for red
% img(1,1,1)=img(2,2,1);
% for i=1:length(img(:,1,1))
%     for j=1:length(img(1,:,1))
%         if img(i,j,3)== 0
%             if i == 1
%                 if mod(j,2)==0
%                     img(i,j,1)=img(i+1,j,1);
%                 else
%                     img(i,j,1)=(img(i+1,j-1,1) + img(i+1,j+1,1))/2;
%                 end
%             elseif j==1
%                if mod(i,2)==0
%                     img(i,j,1)=img(i,j+1,1);
%                else
%                     img(i,j,1)=(img(i-1,j+1,1) + img(i+1,j+1,1))/2;
%                end
%             else
%                 if mod(j,2)==0
%                     img(i,j,1)=(img(i,j-1,1) + img(i,j+1,1))/2;
%                 else
%                     if mod(i,2)==0
%                         img(i,j,1)=(img(i-1,j,1) + img(i+1,j,1))/2;
%                     else
%                         img(i,j,3) = (img(i-1,j-1,3) + img(i-1, j+1,3) + img(i+1,j-1,3) +img(i+1,j+1,3))/4;
%                     end
%                 end
%             end
%         end
%     end
% end
% 
% %for green
% img(1,1,2)=(img(i+1,j,2) + img(i,j+1,2))/2;
% for i=1:length(img(:,1,2))
%     for j=1:length(img(1,:,2))
%         if img(i,j,2)== 0
%             if i == 1
%                 img(i,j,3)=(img(i,j-1,3) + img(i,j+1,3) + img(i+1,j,1))/3;
%             elseif j==1
%                 img(i,j,3) = (img(i-1,j,3) + img(i+1,j,3) + img(i,j+1,1))/3;
%             else
%                 img(i,j,3) = (img(i-1,j,3) + img(i+1, j,3) + img(i,j-1,3) +img(i,j+1,3))/4;
%             end
%         end
%         
%     end
% end
% demosaicBilinear demosaics a Bayer filtered image
%
% Input:
% img - NxMx3 matrix of uint8 with Bayer filtered image
%
% Output:
% filtered - NxMx3 matrix of uint8 with interpolated image that fills in
%           missing pixel values

% for green
h2=[0 1/4 0;1/4 1 1/4;0 1/4 0];
img(:,:,2)=conv2(img(:,:,2),h2,'same');

%for blue
h3=[1/4 1/2 1/4;1/2 1 1/2;1/4 1/2 1/4];
img(:,:,3)=conv2(img(:,:,3),h3,'same');
%for red
h1=[1/4 1/2 1/4; 1/2 1 1/2;1/4 1/2 1/4];
img(:,:,1)=conv2(img(:,:,1),h1,'same');
%to convert from color to gray

filtered = img;
end
