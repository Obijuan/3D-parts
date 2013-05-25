

use <obiscad/bcube.scad>
use <obiscad/bevel.scad>
use <obiscad/vector.scad>
use <obiscad/attach.scad>

X = 0;
Y = 1;
Z = 2;

//------------------- Parameters
cres = 4;
cr = 1;

//--- Servo drills (on ears)
servo_drill_ddx = 9.6; 
servo_drill_ddy = 48.5;
servo_drill_ddiam = 4.2;
servo_shaft_dy = 10.15;

extra = 5;

//--- Futaba body
body_size = [19.8, 40.4, 21.6];
body_wall_th = 1;

//-- Fake elecronic board
board_size = [body_size[X] - 2*body_wall_th,
              body_size[Y] - 2*body_wall_th,
              2];

//-- Futaba top cover
top_cover_size = [body_size[X], body_size[Y], 12];

//-- Ears plate
ear_plate_size = [18, 55.5, 2.5];


//---------------------------------------
//-- DATA for the drills
//---------------------------------------
//-- Calculate the drill coordinates from the center of the base
dx=servo_drill_ddx/2;
dy=servo_drill_ddy/2;

//-- Build the drill table, for automating the process of
//-- making drills
//-- All the drill are symetric respect the x and y axis
servo_drill_table = [
  [dx, dy, 0],
  [-dx, dy, 0],
  [-dx, -dy, 0],
  [dx, -dy, 0],
];

tc_bevel_table = [
  
  //-- Vertical corners
  //-- on quadrant 1
  [ [[top_cover_size[X]/2, top_cover_size[Y]/2, 0], [0 ,0 ,1], 0],
    [[top_cover_size[X]/2, top_cover_size[Y]/2, 0], [1,1,0], 0],
    top_cover_size[Z]+extra,
  ],
  
  //-- on quadrant 2
  [ [[-top_cover_size[X]/2, top_cover_size[Y]/2, 0], [0 ,0 ,1], 0],
    [[-top_cover_size[X]/2, top_cover_size[Y]/2, 0], [-1,1,0], 0],
    top_cover_size[Z]+extra,
  ],
  
  //-- on quadrant 3
  [ [[-top_cover_size[X]/2, -top_cover_size[Y]/2, 0], [0 ,0 ,1], 0],
    [[-top_cover_size[X]/2, -top_cover_size[Y]/2, 0], [-1,-1,0], 0],
    top_cover_size[Z]+extra,
  ],
  
  //-- on quadrant 4
  [ [[top_cover_size[X]/2, -top_cover_size[Y]/2, 0], [0 ,0 ,1], 0],
    [[top_cover_size[X]/2, -top_cover_size[Y]/2, 0], [1,-1,0], 0],
    top_cover_size[Z]+extra,
  ],
  
  //---- Beveling along the x axis
  [
    [[0, top_cover_size[Y]/2, top_cover_size[Z]/2], [1,0,0], 0],
    [[0, top_cover_size[Y]/2, top_cover_size[Z]/2], [0,1,1], 0],
    top_cover_size[X] + extra,
  ],
  
  //---- Beveling along the y axis
  [
    [[-top_cover_size[X]/2, 0, top_cover_size[Z]/2], [0,1,0], 0],
    [[0, top_cover_size[Y]/2, top_cover_size[Z]/2], [-1,0,1], 0],
    top_cover_size[Y] + extra,
  ],
  
   [
    [[top_cover_size[X]/2, 0, top_cover_size[Z]/2], [0,1,0], 0],
    [[0, top_cover_size[Y]/2, top_cover_size[Z]/2], [1,0,1], 0],
    top_cover_size[Y] + extra,
  ],
  
];    
   


module futaba_shaft()
{
  rotate_extrude($fn=100)
  polygon( [ [0, 0],             //-- 0
             [0, 6],             //-- 1
             [3, 6],             //-- 2
             [3, 2],             //-- 3
             [5, 2],             //-- 4
             [7,0],              //-- 5
            ],
            [ [0,1,2,3,4,5] ]);
}

module ear_reinforcements()
{
  ear_th = 1.5;

  rotate([0, 0, 90])
  rotate([90, 0, 0])
  translate([0, 0, -ear_th/2])
  linear_extrude(height = ear_th)
  polygon( [ [0, 0],                          //-- 0
             [0, 2],                          //-- 1
             [4, 0],                          //-- 2
            ],
            [ [0,1,2] ]);
}


module futaba_ears()
{
  translate([0,0,-top_cover_size[Z]/2 + ear_plate_size[Z]/2 + 2.6])
  difference() {
    bcube(ear_plate_size, cr = cr, cres = cres);
  
    //-- Drills
    for (pos = servo_drill_table) {
      translate(pos)
        cylinder(r=servo_drill_ddiam/2, h=ear_plate_size[Z]+extra, center=true, $fn=30);
    }
  }  
  
}

module futaba_top_cover()
{
  h1 = 9.3;
 
  difference() {
 
   //-- Main top cover
   rotate([0,0,90])
   rotate([90,0,0])
   translate([-top_cover_size[Y]/2, -top_cover_size[Z]/2, -top_cover_size[X]/2])
   linear_extrude(height = body_size[X])
   polygon( [ [0, 0],                                  //-- 0
              [0, h1],                                 //-- 1
              [3.5, h1 +0.5],                          //-- 2
              [3.5 + 2.5, top_cover_size[Z]],          //-- 3
              [top_cover_size[Y], top_cover_size[Z]],  //-- 4
              [top_cover_size[Y], 0],                  //-- 5
            ],
            [ [0,1,2,3,4,5] ]);
   
   //-- Beveling the edges
   for (tuple = tc_bevel_table)
    bevel( tuple[0], tuple[1], l=tuple[2], cr=cr); 
  }
  
  //-- Ears
  futaba_ears();
  
  //-- Ear reinforments
  translate([0,0, -top_cover_size[Z]/2 + 2.6 + ear_plate_size[Z]])
  translate([0,body_size[Y]/2,0])
    ear_reinforcements();
    
  translate([0,0, -top_cover_size[Z]/2 + 2.6 + ear_plate_size[Z]])
  translate([0,-body_size[Y]/2,0])
    mirror([0,1,0])
      ear_reinforcements();
      
  //--- Servo shaft
  translate([0, servo_shaft_dy, top_cover_size[Z]/2])
  futaba_shaft();
  
}

module futaba_body()
{

   body_cutout_size = [board_size[X], board_size[Y], board_size[Z]+extra];

   difference() {
     bcube(body_size, cr = cr, cres = cres);
   
     translate([0, 0, -body_cutout_size[Z]/2 -body_size[Z]/2 + board_size[Z] ])
       cube(body_cutout_size, center = true);
   }
   
}


//-- Servo futaba... without the lower cover
module futaba() 
{
  //--  Servo body
  futaba_body();

  //-- Servo top cover
  translate([0, 0, top_cover_size[Z]/2 + body_size[Z]/2])
   futaba_top_cover();
}

//----------------------------------------------------------
//---   MAIN
//----------------------------------------------------------

translate([0,0,body_size[Z]/2])
futaba();

//-- fake electronic
color("green")
cube(board_size, center = true);

