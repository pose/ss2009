function y=triangle(a,b,c)

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
                       printf('(1)Numero generado fuera del rango (%f,%f) = %f con u = %f \n',a,b,y(i),u(i));
                       %return;
               end
       end                
else
       det = sqrt(B*(1-u));
       y = c - det;
       %y(i) tiene que estar en el intervalo (b,c)
       if(y > c || y < b)
               y = c + det;
               if(y > c || y < b)
                       printf('(2)Numero generado fuera del rango (%f,%f) = %f con u = %f \n',b,c,y(i),u(i));
                       %return;
               end
       end                

end



end
 
