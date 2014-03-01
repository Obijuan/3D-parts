//---------------------------------------------------------------
//-- Recursive Pybonacci logo in 3D
//-- by Juan Gonzalez-Gomez (Obijuan)
//-- March - 2014
//--------------------------------------------------------------
//-- Note: The openscad only supports recursion from
//-- the version 2013.06.  In early version this code will not
//-- work
//---------------------------------------------------------------
//-- Released under the GPL v3 license
//---------------------------------------------------------------

//-- Pybonacci logo parameters
f = 0.65;      //-- Reduction factor
offset = 1;   //-- Distance between adjacent triangles
side = 50;    //-- Initial triangle side
ang = 60;     //-- Rotation angle
ov = [0, -1, 0];  //-- Unit vector perpendicular to the triangle's bottom side
nt = 7;  //-- Number of triangles of the logo

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

//-- Calculate the normal distance of the next triangle
function Nv(n) = side * pow(f, n-1) * sqrt(3)*(1 + f) / 6 + offset;

//-- Calculate the tangencial distance of the next triangle
function Tv(n) = side * pow(f, n-1) * (1 - f) / 2;

//-- Calculate the relative distance between two triangles
//-- n is the triangle number
function Rel_Posv(n) = Rotz(ov, ang * (n - 1))      * Nv(n) + 
                       Rotz(ov, ang * (n-1) -90)  * Tv(n);

//-- Colors of the triangles
logo_color = [
  [255/255, 211/255, 52/255],
  [255/255, 230/255, 113/255],
  [112/255, 164/255, 203/255],
  [80/255, 142/255, 191/255],
  [68/255, 133/255, 187/255],
  [63/255, 116/255, 168/255],
  [60/255, 97/255, 126/255]
  
];


//-- Recursive function for generating the logo
//-- n: Number of triangle
//-- pos: Position
//-- angle: Orientation angle
//-- side: triangle side length
module pybonacci_logo(n, pos, angle, side)
{
  //-- Stop when the current triangle number is higher than nt
  if (n < nt) {

    //-- Draw the current triangle (n)
    color(logo_color[n])
    translate(pos)
      rotate([0, 0, angle])
        triangle(l = side);
      
    //-- Draw the next triangle
    //-- Update the position
    //-- Update the rotation angle
    //-- Update the triangle side
    pybonacci_logo(n = n + 1,
                   pos = pos + Rel_Posv(n + 1),
 					angle = angle + ang,
                   side = side * f
                  );
  }
}

//-- Let's start the party!
pybonacci_logo(n = 0, 
               pos = [0, 0, 0], 
               angle = 0, 
               side = side);
