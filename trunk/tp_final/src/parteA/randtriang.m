function y=randtriang(a,b,c)

% A= 2/((b-a)*(c-a))
% B= 2/((c-b)*(c-a))
% %Limites del intervalo (a,b)
% lima=A*(0.5*a^2 -a*b)
% limb=A*(0.5*b^2-a^2)
% %Limites del intervalo (b,c)
% limc=B*(c*b - 0.5*c^2)
% limd=B*(c^2 - 0.5*b^2)

% printf("Limites para U: (1) %f <= U <= %f\n",lima,limb);
% printf("\t (2) %f <= U <= %f\n",limc,limd);

% y=zeros(1,n)
% for i=1:n

% 	if(u(i) >= lima && u(i) <= limb )
% 		det = sqrt((A^2)*(a^2)+2*A*u(i));
% 		y(i) = (A*a + det)/A;
% 		%y(i) tiene que estar en el intervalo (a,b)
% 		if(y(i) > b || y(i) < a)
% 			y(i) = (A*a - det)/A;
% 			if(y(i) > b || y(i) < a)
% 				printf("(1)Nú generado fuera del rango (%f,%f) = %f con u = %f \n",a,b,y(i),u(i));
% 				%return;
% 			end
% 		end		
% 	else%if( u(i) >= B*(c*b - 0.5*c^2) && u(i) <= B*(c^2 - 0.5*b^2))
% 		det = sqrt((B^2)*(c^2)-2*B*u(i));
% 		y(i) = (B*c + det)/B;
% 		%y(i) tiene que estar en el intervalo (b,c)
% 		if(y(i) > c || y(i) < b)
% 			y(i) = (B*c - det)/B;
% 			if(y(i) > c || y(i) < b)
% 				printf("(2)Nú generado fuera del rango (%f,%f) = %f con u = %f \n",b,c,y(i),u(i));
% 				%return;
% 			end
% 		end		
% 	%elseif
% 	%	printf("Error!!!!!!!!");
% 	end
% end

A=(c-a)*(b-a);
B=(c-a)*(c-b);
lima = (b-a)^2/A;
limb = 1 - (c-b)^2/B;

u = rand;
y=0;
if( u <= lima )
	det = sqrt(u*A);
	y = det + a;
	%y(i) tiene que estar en el intervalo (a,b)
	if(y > b || y < a)
		y = -det + a;
		if(y > b || y < a)
			printf("(1)Nú generado fuera del rango (%f,%f) = %f con u = %f \n",a,b,y(i),u(i));
			%return;
		end
	end		
else
% 		det = sqrt(A-A*u(i));
	det = sqrt(B*(1-u));
	y = c - det;
	%y(i) tiene que estar en el intervalo (b,c)
	if(y > c || y < b)
		y = c + det;
		if(y > c || y < b)
			printf("(2)Nú generado fuera del rango (%f,%f) = %f con u = %f \n",b,c,y(i),u(i));
			%return;
		end
	end		
%elseif
%	printf("Error!!!!!!!!");
end



end
