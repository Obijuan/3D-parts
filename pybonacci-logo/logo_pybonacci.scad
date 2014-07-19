//---------------------------------------------------------------
//-- Pybonacci logo in 3D, by Juan Gonzalez-Gomez (Obijuan)
//-- March - 2014
//---------------------------------------------------------------
//-- Released under the GPL v3 license
//---------------------------------------------------------------

//-- Pybonacci logo parameters
f = 0.65;      //-- Reduction factor
offset = 1;   //-- Distance between adjacent triangles
side = 40;    //-- Initial triangle side
ang = 60;     //-- Rotation angle
ov = [0, -1, 0];  //-- Unit vector perpendicular to the triangle's bottom side

//-- Constants for accessing the x,y and z components
X = 0;
Y = 1;
Z = 2;

//-- Rotate a vector an angle phi around the Z axis
//-- INPUTS:t
//--   v: Vector to rotate
//--   phi: Angle to rotate (in degrees)
function Rotz(v, phi) = [v[X] * cos(phi) - v[Y] * sin(phi), 
                         v[X] * sin(phi) + v[Y] * cos(phi), 
                         0];

//-- Pybonacci triangle. The logo is composed of 
//-- 7 of these equilateral triangles
module triangle(l = 10, th = 3)
{
  rotate([0, 0, -30])
  cylinder(r = l * sqrt(3) / 3,
           h = th,
	   center = true,
           $fn = 3);
}

module pybonacci_logo(pos, angle, side)
{
  translate(pos)
    rotate([0, 0, angle])
      triangle(l = side);          
}

//-- Calculate the normal distance of the next triangle
function Nv(n) = side * pow(f, n-1) * sqrt(3)*(1 + f) / 6 + offset;

//-- Calculate the tangencial distance of the next triangle
function Tv(n) = side * pow(f, n-1) * (1 - f) / 2;

//-- Calculate the relative distance between two triangles
//-- n is the triangle number
function Rel_Posv(n) = Rotz(ov, ang * (n - 1))      * Nv(n) + 
                       Rotz(ov, ang * (n-1) -90)  * Tv(n);



//---------------  Initial triangle 0 -------------
color([255/255, 211/255, 52/255])
pybonacci_logo(pos = [0, 0, 0],
               angle = 0, 
               side = side);

//--------------- Triangle 1 ----------------------
pos1 = Rel_Posv(1);     

color([255/255, 230/255, 113/255])
pybonacci_logo(pos = pos1,
               angle = ang,
               side = side * pow(f, 1));

//--------------- Triangle 2 ----------------------
pos2 = pos1 + Rel_Posv(2);       

color([112/255, 164/255, 203/255])
pybonacci_logo(pos = pos2,
               angle = ang * 2,
               side = side * pow(f, 2));

//--------------- Triangle 3 ----------------------   
pos3 = pos2 + Rel_Posv(3);       

color([80/255, 142/255, 191/255])
pybonacci_logo(pos = pos3,
               angle = ang * 3,
               side = side * pow(f, 3));

//--------------- Triangle 4 ----------------------  
pos4 = pos3 + Rel_Posv(4);       
       
color([68/255, 133/255, 187/255])
pybonacci_logo(pos = pos4,
               angle = ang * 4,
               side = side * pow(f, 4));

//--------------- Triangle 5 ----------------------
pos5 = pos4 + Rel_Posv(5);

color([63/255, 116/255, 168/255])
pybonacci_logo(pos = pos5,
               angle = ang * 5,
               side = side * pow(f, 5));

//--------------- Triangle 6 ----------------------
pos6 = pos5 + Rel_Posv(6);

color([60/255, 97/255, 126/255])
pybonacci_logo(pos = pos6,
               angle = ang * 6,
               side = side * pow(f, 6));

     
