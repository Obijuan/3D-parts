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

module triangle(l = 10, th = 3)
{
  rotate([0, 0, -30])
  cylinder(r = l * sqrt(3) / 3,
           h = th,
	   center = true,
           $fn = 3);
}

module pybonacci_logo( pos = [0, 0, 0],
                       ov = [0, -1, 0],  //-- Orientation vector
                       angle = 0,
                       side = 50, 
                     )

{
  

  translate(pos)
    rotate([0, 0, angle])
      triangle(l = side);          
}

//-- User parameters
f = 0.65;      //-- Reduction factor
offset = 1;   //-- Distance between adjacent triangles
side = 40;    //-- Initial triangle side
ang = 60;     //-- Rotation angle
ov = [0, -1, 0];  //-- Orientation

//-- Initial triangle (0)
color([255/255, 211/255, 52/255])
pybonacci_logo(angle = 0, side = side);


//-- Calculate the pos of the next triangle (1)
vn = sqrt(3)*(1 + f) * side / 6 + offset;
vt = side * (1 - f) / 2;
v = ov * vn + Rotz(ov, -90) * vt;
pos = v;


color([255/255, 230/255, 113/255])
pybonacci_logo(pos = pos,
               angle = ang,
               side = side * f);

//-- Calculate the next triangle (2)
side2 = side * f;
ov2 = Rotz(ov,60);
vn2 = sqrt(3)*(1 + f) * side2 / 6 + offset;
vt2 = side2 * (1 - f) / 2;
v2 = ov2 * vn2 + Rotz(ov2, -90) * vt2;

pos2 = pos + v2;

color([112/255, 164/255, 203/255])
pybonacci_logo(pos = pos2,
               angle = ang * 2,
               side = side2 * f);

//-- Calculate the next triangle (3)
side3 = side2 * f;
ov3 = Rotz(ov2,60);
vn3 = sqrt(3)*(1 + f) * side3 / 6 + offset;
vt3 = side3 * (1 - f) / 2;
v3 = ov3 * vn3 + Rotz(ov3, -90) * vt3;

pos3 = pos2 + v3;

color([80/255, 142/255, 191/255])
pybonacci_logo(pos = pos3,
               angle = ang * 3,
               side = side3 * f);

//-- Calculate the next triangle (4)
side4 = side3 * f;
ov4 = Rotz(ov3,60);
vn4 = sqrt(3)*(1 + f) * side4 / 6 + offset;
vt4 = side4 * (1 - f) / 2;
v4 = ov4 * vn4 + Rotz(ov4, -90) * vt4;

pos4 = pos3 + v4;

color([68/255, 133/255, 187/255])
pybonacci_logo(pos = pos4,
               angle = ang * 4,
               side = side4 * f);

//-- Calculate the next triangle (5)
side5 = side4 * f;
ov5 = Rotz(ov4,60);
vn5 = sqrt(3)*(1 + f) * side5 / 6 + offset;
vt5 = side5 * (1 - f) / 2;
v5 = ov5 * vn5 + Rotz(ov5, -90) * vt5;

pos5 = pos4 + v5;

color([63/255, 116/255, 168/255])
pybonacci_logo(pos = pos5,
               angle = ang * 5,
               side = side5 * f);

//-- Calculate the next triangle (6)
side6 = side5 * f;
ov6 = Rotz(ov5,60);
vn6 = sqrt(3)*(1 + f) * side6 / 6 + offset;
vt6 = side6 * (1 - f) / 2;
v6 = ov6 * vn6 + Rotz(ov6, -90) * vt6;

pos6 = pos5 + v6;

color([60/255, 97/255, 126/255])
pybonacci_logo(pos = pos6,
               angle = ang * 6,
               side = side6 * f);



