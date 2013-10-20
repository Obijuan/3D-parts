//---------------------------------------------------------------
//-- Another compartment box, by Obijuan  (Juan Gonzalez-Gomez)
//-- (c) April, 2013
//---------------------------------------------------------------
//-- Released under the GPL license
//---------------------------------------------------------------
//-- It is a design derived from:
//--   http://www.thingiverse.com/thing:15802  by ttsalo
//---------------------------------------------------------------

X = 0;
Y = 1;
Z = 2;

//-- Drawer parameters
drawer_size = [74, 98, 28];
drawer_bottom_th = 1.5;
drawer_wall_th = 1.6;

//-- Cabinet parameters -------------------------------

//-- Rhombus parameters
alpha = 60;    //-- Rhombus Side angle
rx = 8;        //-- Rhombus x length

cab_size = [79, 100, 65];
cab_th = 2;


//-- Handle parameters
handle_size = [drawer_size[X]/3, 12, drawer_size[Z]/2];
handle_th = 3;

//---------------------------------
//-- A rhombus
//---------------------------------
module rhombus(ang=60, rx=20, h=3)
{

  x = rx/2;
  y = x*tan(ang);

  translate([0, 0, -h/2])
  linear_extrude(height=h)
  polygon([[-x,0], [0,y], [x,0], [0, -y]]);
}

//--------------------------------------
//-- A mosaic of rhombus
//-- INPUTS:
//--   L = x length of the area
//--   H = y length of the area
//--   rx: rhombus x length
//--   alpha: rhombus side angle
//--   rth: rhombus thickness
//--------------------------------------
module mosaic(L, H, rx, alpha, rth)
{

  //-- x distance between two adjacent rhombuses
  l = rx+6;

  //-- y distance between two rows of rhombuses
  h = l/2 * tan(alpha);

  //-- Calculate the number of rhombuses along the x and y axis
  nrx = round((L-l/2)/l);
  nry = round((H-h)/h);

  //-- Calculate the dimension of the mosaic, according to the
  //-- number of rhombuses (columns and rows)
  H2 = h * (nry-1);
  L2 = (nrx-1) * l + rx;

  //-- Draw the mosaic
  color("green")
  translate([-L2/2 + rx/2, -H2/2, 0])  //-- center the mosaic
  for (j=[0:nry-1]) {  //-- Rows...

    for (i=[0:nrx-1-(j%2)]) {  //-- Columns
      translate([i*l + (j%2)*l/2 ,j*h,0])
        rhombus(alpha,rx, rth);
    }
  }
}

module cabinet()
{
  inner = [cab_size[X] - 2*cab_th, cab_size[Y], cab_size[Z] - 2*cab_th];

  union() {
  difference() {

    //-- Main cabinet
    cube(cab_size, center= true);

    //-- Inner room
    translate([0, cab_th, 0])
    cube(inner, center=true);

    //-- Top and bottom mosaics
    mosaic(L = cab_size[X], 
           H = cab_size[Y], 
           rx = rx, 
           alpha = alpha, 
           rth = cab_size[Z]+10);

     //-- Left and right mosaics
     rotate([0, 90, 0])
       mosaic(L = cab_size[Z], 
              H = cab_size[Y], 
              rx = rx, 
              alpha = alpha, 
              rth = cab_size[X] + 10);

     //-- Rear cutout
     translate([0, -cab_size[Y]/2, 0])
       cube([cab_size[X]-30, 10, cab_size[Z]-30], center=true);
  }

  //-- side rails
  translate([10/2 - cab_size[X]/2, 0, 0])
    cube([10, cab_size[Y], cab_th], center=true);

  translate([-10/2 + cab_size[X]/2, 0, 0])
    cube([10, cab_size[Y], cab_th], center=true);
  }
}



module handle()
{
  extra = 2;
  handle_co_size = [handle_size[X]-2*handle_th, handle_size[Y], handle_size[Z] + extra ];

   translate([0, handle_size[Y]/2 + drawer_size[Y]/2 , -handle_size[Z]/2]) 
    difference() {
      cube(handle_size, center=true);
      translate([0, -handle_th, 0])
        cube(handle_co_size, center=true);
    }
}

module drawer_4x4()
{
  comp_4x4_size = [drawer_size[X]/2 - drawer_wall_th - drawer_wall_th/2,
                   drawer_size[Y]/2 - drawer_wall_th - drawer_wall_th/2,
                   drawer_size[Z] ];

  xc = drawer_wall_th/2 + comp_4x4_size[X]/2;
  yc = drawer_wall_th/2 + comp_4x4_size[Y]/2;

  difference() {
    cube(drawer_size, center = true);   

    translate([xc, yc, drawer_bottom_th])
      cube(comp_4x4_size, center=true);
    
    translate([-xc, yc, drawer_bottom_th])
      cube(comp_4x4_size, center=true);
    
    translate([-xc, -yc, drawer_bottom_th])
      cube(comp_4x4_size, center=true);  
    
    translate([xc, -yc, drawer_bottom_th])
      cube(comp_4x4_size, center=true);
  }

  handle();

}

module drawer_2x1()
{
  comp_2x1_size = [drawer_size[X]/2 - drawer_wall_th - drawer_wall_th/2,
                   drawer_size[Y] - 2*drawer_wall_th,
                   drawer_size[Z] ];

  xc = drawer_wall_th/2 + comp_2x1_size[X]/2;

  difference() {
    cube(drawer_size, center = true);   

    translate([xc, 0, drawer_bottom_th])
      cube(comp_2x1_size, center=true);
    
    translate([-xc, 0, drawer_bottom_th])
      cube(comp_2x1_size, center=true);
    
  }

  handle();
}

module drawer_1x1()
{
  comp_1x1_size = [drawer_size[X] - 2*drawer_wall_th,
                   drawer_size[Y] - 2*drawer_wall_th,
                   drawer_size[Z] ];

  difference() {
    cube(drawer_size, center = true);   

    translate([0, 0, drawer_bottom_th])
      cube(comp_1x1_size, center=true);
    
  }

  handle();
}

//-- Uncomment the part you want to generate

drawer_4x4();
//drawer_2x1();
//drawer_1x1();

//--- Cabinet
//-- rotation, for making it printable
*rotate([90,0,0])
  cabinet();

