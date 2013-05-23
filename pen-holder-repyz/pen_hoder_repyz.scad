include <obiscad/utils.scad>
use <obiscad/bcube.scad>
use <obiscad/attach.scad>
use <obiscad/bevel.scad>


//-- Pen-holder
pen_diam = 8;
pen_wrap_th = 2;
pen_hi = 10;
clamp_empty = 4;
clamp_lx = 15;
clamp_drill = 3.2;

//------------------------------ Pen-arm --------------------
pen_arm_lx = 20;

//-- INTERFACE: Radial distance of drills
fp_drills_distance = 6;

//-- Drills diameter
fp_drills_diam = 3.2;

pen_base_th = 4;

reinforce_cr = 4;
reinforce_cres = 0;

//----- Skymega drills  ----------------------
sky_dd = 15; //-- Distance
sky_drill_diam = 3.2; //-- Drill diam

//--- Create the skymega drill table
sky_drill_table = [
  [sky_dd, sky_dd, 0],
  [-sky_dd, sky_dd, 0],
  [-sky_dd, -sky_dd, 0],
  [sky_dd, -sky_dd, 0],
];

//-- Connecting plate (base) for the repyz modules
plate_border_th = 3;
plate_th = 2;

plate_side = 2*sky_dd + sky_drill_diam + plate_border_th;
plate_size = [plate_side, plate_side, plate_th];

module plate() 
{

  difference() {
    //-- Plate
    cube(plate_size, center = true);
  
    //-- Skymega drills
    for (drill = sky_drill_table) {
      translate(drill)
      cylinder(r=sky_drill_diam/2, h=plate_size[Z]+extra,center=true, $fn=6);
    }
    
    //-- Cutout
    translate([5,0,0])
    bcube([plate_size[X]/3, plate_size[Y]/2, plate_size[Z]+extra], cr = 2, cres=0);
  }

}

//translate([-plate_size[Z]/2,0,0])
//rotate([0, 90, 0])
//plate();

//---- -------------------------Build the pen-holder
extra=5;

//-- Clamp
clamp_size = [clamp_lx+pen_wrap_th, clamp_empty + 2*pen_wrap_th, pen_hi];
empty_size = [clamp_size[X]+extra, clamp_empty, clamp_size[Z]+extra];

module clamp_body()
{
  difference() {
  cube(clamp_size,center=true);

    //-- Body drill
    rotate([90,0,0])
      cylinder(r=clamp_drill/2, h=clamp_size[Z]+extra, center=true, $fn=20);
  }
}

module clamp_empty_part()
{

  union() {
  //-- Pen hole and clamp empty space
  cylinder(r=pen_diam/2, h=pen_hi+extra, center=true, $fn=30);

  translate([empty_size[X]/2,0,0])
    cube(empty_size,center=true);
  }
}

a = [[(pen_diam+pen_wrap_th)/2,0,0],[1,0,0],0];
b = [[-clamp_size[X]/2+pen_wrap_th,0,0],[1,0,0],0];

//connector(a);
//connector(b);

difference() {
  union() {
    attach(a,b)
      //color("yellow",0.4)
      clamp_body();

      //-- Pen holder
      cylinder(r=(pen_diam+2*pen_wrap_th)/2, h=pen_hi, center=true, $fn=30);
    }

  clamp_empty_part();
}


//--- Pen arm
pen_arm_size = [pen_arm_lx-(pen_diam+pen_wrap_th)/2+pen_wrap_th, clamp_empty + 2*pen_wrap_th, pen_hi];

translate([-pen_arm_size[X]/2-pen_diam/2,0,0])
cube(pen_arm_size,center=true);

//-- Pen base
pen_base_size = [pen_base_th, 
		  2*fp_drills_distance + fp_drills_diam+2*pen_base_th, 
		  pen_arm_size[Z] + fp_drills_diam + 2*pen_base_th ];

module pen_base() {
  

  drills_pos =  [0,fp_drills_distance, pen_base_size[Z]/2-pen_base_th];
  drills_pos2 = [0,-fp_drills_distance, pen_base_size[Z]/2-pen_base_th ];

  difference() {
    cube(pen_base_size,center=true);

    translate(drills_pos)
      rotate([0,90,0])
	cylinder(r=fp_drills_diam/2, h=pen_base_th+extra, center=true, $fn=20);

    translate(drills_pos2)
      rotate([0,90,0])
	cylinder(r=fp_drills_diam/2, h=pen_base_th+extra, center=true, $fn=20);

  }
}

con1 = [[-pen_arm_size[X]-pen_diam/2,0, -pen_arm_size[Z]/2],[-1,0,0],0];
con2 = [[-plate_size[X]/2,0,0],[0,0,1],0];

*connector(con1);
*connector(con2);

attach(con1,con2)
  plate();

//-- Add some reinforcements
pr1 = [
  [[con1[0][X], -pen_arm_size[Y]/2,0],[0,0,1],0],
  [[con1[0][X], -pen_arm_size[Y]/2,0],[1,-1,0],0],
];

pr2 = [
  [[con1[0][X], pen_arm_size[Y]/2,0],[0,0,1],0],
  [[con1[0][X], pen_arm_size[Y]/2,0],[1,1,0],0],
];

pr3 = [
  [[con1[0][X],0,pen_arm_size[Z]/2],[0,1,0],0],
  [[con1[0][X],0,0],[1,0,1],0],
];

bconcave_corner_attach (pr1[0], pr1[1],l=pen_arm_size[Z],cr=reinforce_cr,cres=reinforce_cres);
bconcave_corner_attach (pr2[0], pr2[1],l=pen_arm_size[Z],cr=reinforce_cr,cres=reinforce_cres);
bconcave_corner_attach (pr3[0], pr3[1],l=pen_arm_size[Y],cr=reinforce_cr,cres=reinforce_cres);




    
