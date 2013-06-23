//-----------------------------------------------------------------------
//-- REPYZ modules
//-----------------------------------------------------------------------
//-- (c) Juan Gonzalez-Gomez (Obijuan). May-2013
//-- REPYZ modules derives from:
//--
//--  REPY V1 (obijuan) http://www.thingiverse.com/thing:13442
//--  REPY v2, by David Estevez: https://github.com/David-Estevez/REPY-2.0
//-------------------------------------------------------------------------
//-- This file includes 2 of the 3 parts needed for assembling the module
//--   - the body
//--   - the head
//--
//--   The body is the part where the servo is attached
//--   The head is screwed to the servo shaft
//-------------------------------------------------------------------------
//-- Released under the GPL license
//-------------------------------------------------------------------------
use <obiscad/bcube.scad>
use <teardrop.scad>

//-- Constants for indexing vector components
X = 0;
Y = 1;
Z = 2;

//------------------------------------------------------------------
//--       USER AREA.  Change the parameters to fit your needs
//------------------------------------------------------------------

//-------------  Base parameters
base_side = 52;
base_th = 3;      //-- Base thickness
base_cr = 3;      //-- Base corner radius
base_cres = 4;    //-- Base corner resolution

//------------ Servo parameters
ear_size = [2.5, 18, 7.4];  //-- Servo ears size

//-- Distance between the top and lower servo ears
ear_dx = 23.8;

servo_shaft_diam = 8.1;    //-- Servo horn shaft diameter
servo_horn_drill_diam = 2; //-- Servo horn drills diameter

//-- Radial distance of the rounded servo horn drills
rounded_horn_drill_distance = 7.3;

//-- Fake shaft
fs_diam = 8;

//----------- Feet parameters 
foot_th = 6;
foot_ly = 23;           //-- Feet length in the y axis
foot_drill_diam = 3.2;  
foot_drill_h = 1.6;     //-- Drills height form the module base
foot_drill_dx_m = 6.6;  //-- Distance between the two drills

//--------- Captive nuts
nut_h = 3;
nut_radius = 6.6/2;   

//--- SKYMEGA Drills
sky_dd = 15;            //-- Distance
sky_drill_diam = 3.2;   //-- Drill diam

//----------------------- Arms
//-- The arms are the two sides of the module head part

//--- (optional)  Bearing on the fake shaft
//-- Set to true for the PRO version, false for the standar version
fake_shaft_bearing = true;

bearing_diam = 22+0.5;

//-- Extra length on the arm (y-axis) when the bearing is used
//-- When not used it is 0
arm_extra_y_length = (fake_shaft_bearing == true) ? 6 : 0;

//-- Arm size for the PRO version (with bearing)
//-- and the standar version
arm_size = [4, 27 + arm_extra_y_length,  38];
  
arm_dx = 40;  //-- Distance between the right and left arms

//------------------------------------------------------------------
//--    DATA AREA.  More parameters calculated from the user params
//------------------------------------------------------------------

//---------  BASE
base_size = [base_side, base_side, base_th];


//--------- Feet calculations
foot_size = [foot_th + ear_size[X], foot_ly, ear_size[Z]];

//-- Distance between the center of the two
//-- foot drills
foot_drill_dx = foot_drill_dx_m + foot_drill_diam;

//-- Distance between the two feet (along x axis)
feet_dx = ear_dx - 2 * foot_th;

//-- Feet location coordinates
foot_pos = [foot_size[X]/2 + feet_dx/2,
            0,
            foot_size[Z]/2 + base_size[Z]/2 - 0.01];
            
//-- temp value used for intersections
extra = 5;

//--- Create the skymega drill table
sky_drill_table = [
  [-sky_dd, sky_dd, 0],
  [-sky_dd, -sky_dd, 0],
];


//--- Center cutouts
co1_size = [feet_dx, foot_size[Y], base_size[Z]+extra];

//-- Feet reinforment (in x direction)
//-- Define the connectors

//-- Reinforments x-direction thickness
rx_th = (foot_size[Y]-ear_size[Y])/2;
rx_pos = [-foot_size[X]/2, ear_size[Y]/2 + rx_th/2, -foot_size[Z]/2];

rx_ec1 = [ [rx_pos[X], rx_pos[Y], rx_pos[Z]], [0,1,0], 0];
rx_en1 = [ rx_ec1[0], [-1,0,1], 0];

rx_ec2 = [ [rx_pos[X], -rx_pos[Y], rx_pos[Z]], [0,-1,0], 0];
rx_en2 = [ rx_ec2[0], [-1,0,1], 0];


//-- Reinforments in the y direction
ry_th = foot_size[X] - ear_size[X];
ry_pos = [ear_size[X]/2, foot_size[Y]/2, -foot_size[Z]/2];

ry_ec1 = [ [ry_pos[X], ry_pos[Y], ry_pos[Z]], [-1,0,0], 0];
ry_en1 = [ ry_ec1[0], [0,1,1], 0];

ry_ec2 = [ [ry_pos[X], -ry_pos[Y], ry_pos[Z]], [1,0,0], 0];
ry_en2 = [ ry_ec2[0], [0,-1,1], 0];


//-- For debuging
*connector(rx_ec1);
*connector(rx_en1);
*connector(ry_ec4);
*connector(ry_en4);


//------------  Module head

right_arm_pos = [-arm_size[X]/2 + base_size[X]/2,
                 0,
                 arm_size[Z]/2 + base_size[Z]/2 -0.01];
                 
left_arm_pos = [right_arm_pos[X] - arm_size[X] +-arm_dx,
                 right_arm_pos[Y],
                 right_arm_pos[Z]];         

//-- Reinforment for the arm in y  
ray_th = arm_size[X];
ray_pos = [0, -arm_size[Y]/2, -arm_size[Z]/2];
ray_cr = base_size[Y]/2 - arm_size[Y]/2;
ray_cres = 0;

ray_ec1 = [[ray_pos[X], ray_pos[Y], ray_pos[Z]], [1,0,0], 0];
ray_en1 = [ ray_ec1[0], [0,-1,1], 0];

ray_ec2 = [[ray_pos[X], -ray_pos[Y], ray_pos[Z]], [1,0,0], 0];
ray_en2 = [ ray_ec2[0], [0,1,1], 0];

//-- Arm beveling
ab_pos = [arm_size[X]/2, -base_size[Y]/2, -arm_size[Z]/2] ;

ab_ec1 =[ ab_pos, [0,0,1], 0]; 
ab_en1 = [ ab_ec1[0], [1,-1,0], 0];

ab_ec2 =[ [ab_pos[X], -ab_pos[Y], ab_pos[Z]], [0,0,1], 0]; 
ab_en2 = [ ab_ec1[0], [1,1,0], 0];

//-- Reinforment for the arm in x
rax_l = 25;
rax_pos = [-arm_size[X]/2, 0, -arm_size[Z]/2];
rax_cr = 4;
rax_cres = 0;

rax_ec1 = [[rax_pos[X], rax_pos[Y], rax_pos[Z]], [0,1,0], 0];
rax_en1 = [ rax_ec1[0], [-1,0,1], 0];

//-- Reinforment of the left arm in x (outter side)
rax2_cr = base_size[X] - 2*arm_size[X] - arm_dx;
rax2_l = rax_l;
rax2_pos = [rax_pos[X] + arm_size[X], rax_pos[Y], rax_pos[Z]];
rax2_ec1 = [[rax2_pos[X], rax2_pos[Y], rax2_pos[Z]], [0,1,0], 0];
rax2_en1 = [ rax2_ec1[0], [1,0,1], 0];

*connector(rax2_ec1);
*connector(rax2_en1);

*connector(ray_ec2);
*connector(ray_en2);
*connector(ab_ec1);
*connector(ab_en1);

//-- Right arm cutout
ra_co1_size = [arm_size[X]+extra, servo_shaft_diam, arm_size[Y]];


//----------------------------------------------------------------------- 
//-                    PART building
//-----------------------------------------------------------------------

module repyz_body()
{

  difference() {
    //-- The base
    bcube(base_size, cr = base_cr, cres = base_cres);
    
    //-- Skymega drills
    for (drill = sky_drill_table) {
      translate(drill)
	cylinder(r=sky_drill_diam/2, h=base_size[Z]+extra,center=true, $fn=6);
    }
    
    //-- Central cutout
    bcube(co1_size, cr = base_cr, cres = base_cres);

  }  
    

}





//----------------------------------------------------
//--    MAIN  
//----------------------------------------------------
wall_th = 3;
holder_size = [base_size[X]/2 - co1_size[X]/2, base_size[Y], 14 + 2*wall_th];


co_size = [holder_size[Z] - 2*wall_th, holder_size[Y] - 2*wall_th, holder_size[X] + extra];


translate([holder_size[X]/2 - base_size[X]/2,0,0])
  rotate([0, 90, 0])
    difference() {
      bcube([holder_size[Z], holder_size[Y], holder_size[X]], cr = 3, cres = 4);
      cube(co_size, center = true);
    }

//-- Skymega drills
    for (drill = sky_drill_table) {
      translate(drill)
	cylinder(r=sky_drill_diam/2, h=holder_size[Z]+extra,center=true, $fn=6);
    }

repyz_body();


