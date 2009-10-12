# seba rotation
# recieves three arrays X, Y and Z 
# and three rotations xrot, yrot and zrot
# the function takes xi, yi and zi and applies the rotations to give you
# XR, YR and ZR, the rotated entry arrays
function [XR YR ZR] = seba_rotation(X, Y, Z, xrot, y rot, zrot)

	if rows(X)>1 || rows(Y)>1 || rows(Z)>1
		error('entry vectors must be column vectors');
	endif


	xRotationMatrix = [1 0 0; 0 cos(xrot) -sin(xrot); 0 sin(xrot) cos(xrot)];
	yRotationMatrix = [cos(yrot) 0 sin(yrot); 0 1 0; -sin(yrot) 0 cos(yrot)];
	zRotationMatrix = [cos(zrot) -sin(zrot) 0; sin(zrot) cos(zrot) 0; 0 0 1];
	
	XR=zeros(1,columns(X))';
	YR=zeros(1,columns(Y))';
	ZR=zeros(1,columns(Z))';
	for i=1:columns(X)
		[XR(i) YR(i) ZR(i)]=[X(i) Y(i) Z(i)]*xRotationMatrix*yRotationMatrix*zRotationMatrix;
	endfor
	
endfunction
