//-------------------------------------------------------------------
//-- Servo Lower cover
//-- (c) Juan Gonzalez-Gomez (Obijuan). May-2013
//-------------------------------------------------------------------
//-- The original cover has been design for the Futaba 3003 servos
//-- But, as it is a parameterized design, the user can easily
//-- adapt to other servos
//--
//--  In addition, it is very easy to modify the cover to add a fake
//--- shaft, or in general customize it for improving the design
//--
//--  It is particulary interesting for designing robots. If a fake
//--  shaft is included, the mechanical designs are greatly simplified! 
//-------------------------------------------------------------------
//-- Released under the GPL license. 
//-------------------------------------------------------------------

//---  Obiscad!!
include <obiscad/utils.scad>
use <obiscad/bcube.scad>
use <obiscad/attach.scad>
use <obiscad/bevel.scad>

//-----------------------------------------------------------------------------------
//-- USER AREA. The user should change this parameters depending on the Servo used  
//-- The default values have been calculated for the SERVO FUTABA 3003
//-----------------------------------------------------------------------------------

//-- Fake shaft
fake_shaft = false;   //-- Set to false for removing
fake_shaft_len = 6;  //-- Shaft length
fake_shaft_diam = 8;  //-- Shaft diameter
fake_shaft_xpos = -10.1;  //-- X coordinate of the shaf position



//-------------------------- Main Base --------------------------
bsize = [41, 20, 4];  //-- base size
b_cr=2;               //-- Base corner radius
b_cres=4;             //-- Baser corner resolution


//-- ----------------------- Screw cutouts ----------------------
//-- These are the areas removed from the main base to give
//-- room to the screw heads
screw_lh = 1.6;         //- Screw layer height, Relative to the bottom
screw_head_diam = 3.2;  //-- Screw head diameter
screw_head_clear = 0.2; //-- Space between the screw head and the base


//-------------------------- Drills ------------------------------
ddiam=2.2;  //-- Drills diameter
ddx=35;     //-- Distance in the x axis between the drills
ddy=14.7;   //-- Distance in the y axis between the distance

//-------------------------- Electronic cutouts -------------------
//-- These are removed from the bottom of the base to make room
//-- for the servo electronics
elec_cutout_lh = 2.3;

//-- dimensions (on xy plane) of the cutouts
elec_cutout_dim = [
  [16.8, 15.5],   //-- Left cutout
  [5.7,  14.7],   //-- Right cutout
];

//-- Distance from the nearer drill (on the x axis)
//-- (not from the drill center, but the nearest drill surface)
//-- (so that it can be meassured easily with a caliper)
elec_cutout_clearx = [
  2.7, 3.4
];

elec_co_cr = 1;    //-- Corner radius
elec_co_cres = 4;  //-- Corner resolution

//-------------------------- Cable hole ----------------------------
//-- Cable hole dimensions
cable_hole_dim = [1.5, 6];

ch_cr = 0.8;  //-- Cable hole corner radius
ch_cres = 4;  //-- Cable hole corner resolution

//------------------------ Beveled edges -----------------------------
bevel_cr = 0.5;


//------------------------ Servo ears -----------------------
servo_ears = true;

//-- Estandar futaba ears
//ears_size = [7.0, 18, 2.5];


//-- Ears with the same height than the cover
//-- Uncomment if needed
ears_size = [7.0, 18, bsize[Z]];

ears_drill = 3.2;

//-- Penetration of ear in the cover
ear_pen = 0.5;  

//-- Ear drill coordinates
ear_drill_pos = [4.1, 9.6/2, 0];


//---------------------------------------------------------------------------------
//---        IMPLEMENTATION!!
//---------------------------------------------------------------------------------
//--  The USER should be able to change the base modifying only the above
//--  user parameters
//--
//--  The implementation is divided into 2 stages:
//--
//--  1) DATA calculation: It creates tables and definitions for further
//--     build the base more easily
//--  2) CODE: It just build the Servo Base, based only on the data
//-----------------------------------------------------------------------------------


//---------------------------------------
//-- DATA for the drills
//---------------------------------------
//-- Calculate the drill coordinates from the center of the base
dx=ddx/2;
dy=ddy/2;

//-- Build the drill table, for automating the process of 
//-- making drills
//-- All the drill are symetric respect the x and y axis
drill_table = [
  [dx,   dy, 0],
  [-dx,  dy, 0],
  [-dx, -dy, 0],
  [dx,  -dy, 0],
];


//-------------------------------------------------------------
//-- DATA for the First layer: screw layer
//-------------------------------------------------------------

//-- Extra value. Does not matter the value (but it should be > 0
extra = 5;


//-- Calculate the clear distance from the drill center
clear = screw_head_diam/2 + screw_head_clear;

//-- Calculate the cutout size
scx = bsize[X]/2-drill_table[0][X]+clear+extra;
scy = bsize[Y]/2-drill_table[0][Y]+clear+extra;
screw_cutout_size = [scx,scy, bsize[Z]];

//-- vector for the z position of the cutouts:
//-- They are screw_lh high from the bottom 
sc_z = [0,0, -bsize[Z]/2+screw_lh];


//-- Connector table. It contains the pairs of connectors for performing
//-- the attach operation.
//-- The first connector of the pair belongs to the base, the second to the cutout
//-- The connectors coordinates are relative to the drills
screw_connector_table = [

  //-- First quadrant
  [ [drill_table[0]+[-clear, -clear,0]+sc_z, [0,0,1], 0 ],  //-- First pair of connectors
   [[-screw_cutout_size[X]/2, -screw_cutout_size[Y]/2, -screw_cutout_size[Z]/2],[0,0,1],0]
  ],

  //-- Second quadrant
  [ [drill_table[1]+[clear, -clear,0]+sc_z, [0,0,1], 0 ],
    [[screw_cutout_size[X]/2, -screw_cutout_size[Y]/2, -screw_cutout_size[Z]/2],[0,0,1],0]
  ],

  //-- Third quadrant
  [ [drill_table[2]+[clear, clear,0]+sc_z, [0,0,1], 0 ],
    [[screw_cutout_size[X]/2, screw_cutout_size[Y]/2, -screw_cutout_size[Z]/2],[0,0,1],0]
  ],

  //-- Forth quadrant
  [ [drill_table[3]+[-clear, clear,0]+sc_z, [0,0,1], 0 ],
    [[-screw_cutout_size[X]/2, screw_cutout_size[Y]/2, -screw_cutout_size[Z]/2],[0,0,1],0]
  ],
 
];

//---------------------------------------
//-- DATA for the electronics cutouts
//---------------------------------------

//-- vector for the z position of the cutouts:
//-- They are elec_cutout_lh high from the bottom 
ec_z = [0,0, -bsize[Z]/2+elec_cutout_lh];

//-- Auxiliary table with the cutout size
elec_co_size = [
  [elec_cutout_dim[0][X], elec_cutout_dim[0][Y], bsize[Z]],
  [elec_cutout_dim[1][X], elec_cutout_dim[1][Y], bsize[Z]]
];


//-- Connector table. It contains the pairs of connectors for performing
//-- the attach operation.
//-- The first connector of the pair belongs to the base, the second to the cutout
//-- The connectors coordinates are relative to the drills
elec_connector_table = [

  //-- Connector pair for the Left cutout (relative to the upper-left drill)
  [ [VX(drill_table[1][X]+ddiam/2+elec_cutout_clearx[0])+
     VY(elec_co_size[0][Y]/2)+ ec_z,
     [0,0,1], 0],                        //-- Base connector
     
    [[-elec_co_size[0][X]/2, elec_co_size[0][Y]/2 ,elec_co_size[0][Z]/2],[0,0,1],0]
  ],
 
  //-- connector pair for the right cutout (relative to the upper-right drill)
  [ [VX(drill_table[0][X]-ddiam/2-elec_cutout_clearx[1])+
     VY(elec_co_size[1][Y]/2)+ec_z,
     [0,0,1], 0],

    [[elec_co_size[1][X]/2, elec_co_size[1][Y]/2 ,elec_co_size[1][Z]/2],[0,0,1],0]
  ],

];

//--------------------------------
//-- DATA for the cable hole
//--------------------------------
//-- Calculate the cable hole size
//-- In the x-axis is doble sized
ch_size = [2*cable_hole_dim[X], cable_hole_dim[Y], bsize[Z]+extra];

//-- Connectors pair for attaching a bcube and make the difference
ch_conn_pair = [
  [[-bsize[X]/2,0,0], [0,0,1], 0],
  [[0,0,0], [0,0,1], 0],
];

//---------------------------------------
//-- DATA for beveling some edges
//---------------------------------------

//-- Table of Pair of connectors for beveling
//-- corner connector, normal connect and bevel length
bevel_table = [
  
  //-- cable hole external corners
  //-- Upper
  [ [[-bsize[X]/2, ch_size[Y]/2 ,0], [0 ,0 ,1], 0],
    [[-bsize[X]/2, ch_size[Y]/2 ,0], [-1,-1,0], 0],
    bsize[Z]+extra 
  ],

  //-- Lower
  [ [[-bsize[X]/2, -ch_size[Y]/2 ,0], [0 ,0 ,1], 0],
    [[-bsize[X]/2, -ch_size[Y]/2 ,0], [-1,1,0], 0],
    bsize[Z]+extra 
  ],

  //-- Beveling the Upper-left screw cutout (1) 
  [ [[-bsize[X]/2, drill_table[1][Y]-clear ,bsize[Z]/2], [0 ,0 ,1], 0],
    [[-bsize[X]/2, drill_table[1][Y]-clear ,bsize[Z]/2], [-1,1,0], 0],
    2*(bsize[Z]-screw_lh) 
  ],

  //-- Beveling the Upper-left screw cutout (2) 
  [ [[drill_table[1][X]+clear, bsize[Y]/2 ,bsize[Z]/2], [0 ,0 ,1], 0],
    [[drill_table[1][X]+clear, bsize[Y]/2 ,bsize[Z]/2], [-1,1,0], 0],
    2*(bsize[Z]-screw_lh) 
  ],

   //-- Beveling the lower-left screw cutout (1) 
  [ [[-bsize[X]/2, drill_table[2][Y]+clear ,bsize[Z]/2], [0 ,0 ,1], 0],
    [[-bsize[X]/2, drill_table[2][Y]+clear ,bsize[Z]/2], [-1,-1,0], 0],
    2*(bsize[Z]-screw_lh) 
  ],

  //-- Beveling the lower-left screw cutout (2) 
  [ [[drill_table[2][X]+clear, -bsize[Y]/2 ,bsize[Z]/2], [0 ,0 ,1], 0],
    [[drill_table[2][X]+clear, -bsize[Y]/2 ,bsize[Z]/2], [-1,-1,0], 0],
    2*(bsize[Z]-screw_lh) 
  ], 

  //-- Beveling the Upper-right screw cutout (1) 
  [ [[bsize[X]/2, drill_table[0][Y]-clear ,bsize[Z]/2], [0 ,0 ,1], 0],
    [[bsize[X]/2, drill_table[0][Y]-clear ,bsize[Z]/2], [1,1,0], 0],
    2*(bsize[Z]-screw_lh) 
  ],

  //-- Beveling the Upper-right screw cutout (2) 
  [ [[drill_table[0][X]-clear, bsize[Y]/2 ,bsize[Z]/2], [0 ,0 ,1], 0],
    [[drill_table[0][X]-clear, bsize[Y]/2 ,bsize[Z]/2], [1,1,0], 0],
    2*(bsize[Z]-screw_lh) 
  ],

   //-- Beveling the lower-right screw cutout (1) 
  [ [[bsize[X]/2, drill_table[3][Y]+clear ,bsize[Z]/2], [0 ,0 ,1], 0],
    [[bsize[X]/2, drill_table[3][Y]+clear ,bsize[Z]/2], [1,-1,0], 0],
    2*(bsize[Z]-screw_lh) 
  ],

  //-- Beveling the lower-right screw cutout (2) 
  [ [[drill_table[3][X]-clear, -bsize[Y]/2 ,bsize[Z]/2], [0 ,0 ,1], 0],
    [[drill_table[3][X]-clear, -bsize[Y]/2 ,bsize[Z]/2], [1,-1,0], 0],
    2*(bsize[Z]-screw_lh) 
  ], 

];

//----------------------------------
//--  Fake shaft
//----------------------------------
//-- Define the connector pair
fs_con_pair = [
  [ [fake_shaft_xpos, 0, bsize[Z]/2],[0,0,1], 0],
  [[0,0,-fake_shaft_len/2],[0,0,1],0]
];

//-------------------------------
//--  DATA for the servo ears
//--------------------------------
//-- Calculate the ears position
ears_pos = [-ears_size[X]/2 - bsize[X]/2,0, ears_size[Z]/2 - bsize[Z]/2];

//-- Connector pais for beveling the servo ears
ear_conn_pair1 = [
    [[-ears_size[X]/2, ears_size[Y]/2, 0], [0,0,1],0],
    [[-ears_size[X]/2, ears_size[Y]/2, 0], [-1,1,0], 0],
];

ear_conn_pair2 = [
    [[-ears_size[X]/2, -ears_size[Y]/2, 0], [0,0,1],0],
    [[-ears_size[X]/2, -ears_size[Y]/2, 0], [-1,-1,0], 0],
];

module servo_ear()
{

  difference() {
    translate([ear_pen/2,0,0])  //-- ear_pen
      cube([ears_size[X]+ear_pen, ears_size[Y], ears_size[Z]], center = true );

    //-- Upper drill
    translate([ears_size[X]/2 - ear_drill_pos[X], ear_drill_pos[Y],0])
      cylinder(r=ears_drill/2, h = ears_size[Z]+extra, center = true);

    //-- Lower drill
    translate([ears_size[X]/2 - ear_drill_pos[X], -ear_drill_pos[Y],0])
      cylinder(r=ears_drill/2, h = ears_size[Z]+extra, center = true);
      
    //-- Bevel the left corners
    bevel(ear_conn_pair1[0], ear_conn_pair1[1], ears_size[Z]+extra, cr = bevel_cr);
    bevel(ear_conn_pair2[0], ear_conn_pair2[1], ears_size[Z]+extra, cr = bevel_cr);
  }
  
}

//----------------------------------------------------------------
//---         CODE!!
//----------------------------------------------------------------
//-- No numbers. Just the actions for creating the base
//-- It is very easy to remove parts: comment them out!
//-----------------------------------------------------------------


difference() {

  //-- Main Base
  bcube(bsize,cr=b_cr, cres=b_cres);
  
  //-- Screw cutouts
  for (con_pair = screw_connector_table) {
    attach(con_pair[0], con_pair[1])
      bcube(screw_cutout_size, cr=ddiam/2, cres=5);
  }
  

  //-- Drills
  for (pos  = drill_table) {
    translate(pos)
      cylinder(r=ddiam/2, h=bsize[Z]+extra, center=true, $fn=10);
  }

  //-- Electronics cutouts
  for (i=[0:1]) {
    attach(elec_connector_table[i][0], elec_connector_table[i][1])
      bcube(elec_co_size[i] , cr=elec_co_cr, cres = elec_co_cres);
  }

  //-- Cable hole
  attach(ch_conn_pair[0],ch_conn_pair[1])
    bcube(ch_size, cr=ch_cr, cres=ch_cres);

  //-- Beveling the edges
  for (tuple = bevel_table)
    bevel( tuple[0], tuple[1], l=tuple[2], cr=bevel_cr);

}


//-- Fake shaft

if (fake_shaft) {
  attach(fs_con_pair[0], fs_con_pair[1])
    cylinder(r=fake_shaft_diam/2, h=fake_shaft_len,center=true, $fn=50);
}



//--- Servo ears
if (servo_ears) {

  //-- Left ear. It has a cutout for making room for the wire
  translate(ears_pos) {
    difference() {
      servo_ear();
      translate([ears_size[X]/2,0,0])
        bcube(ch_size, cr=ch_cr, cres=ch_cres);
    }  
  }

  //-- Right ear
  translate([-ears_pos[X],0,ears_pos[Z]])
  mirror([1,0,0])
  servo_ear();
}



