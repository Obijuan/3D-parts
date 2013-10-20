//-----------------------------------------------------------------------
//-- Battery holder mounting brackets for REPYZ modules
//-----------------------------------------------------------------------
//-- (c) Juan Gonzalez-Gomez (Obijuan). May-2013
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
wall_th = 3;
holder_size = [20.1, 57, 14 + 2 *wall_th];


//--------------------------------------------------
//--  INTERNAL CALCULATIONS
//--------------------------------------------------

//-------------  Module Base parameters
base_side = 52;
base_th = 3;      //-- Base thickness

//--- SKYMEGA Drills
sky_dd = 15;            //-- Distance
sky_drill_diam = 3.2;   //-- Drill diam

//---------  BASE
base_size = [base_side, base_side, base_th];
            
//-- temp value used for intersections
extra = 5;

//--- Create the skymega drill table
sky_drill_table = [
  [-sky_dd, sky_dd, 0],
  [-sky_dd, -sky_dd, 0],
];


//----------------------------------------------------
//--    MAIN  
//----------------------------------------------------
co_size = [holder_size[Z] - 2*wall_th, holder_size[Y] - 2*wall_th, holder_size[X] + extra];

rotate([0, 90, 0])
translate([-holder_size[X] + base_size[X]/2 + holder_size[X]/2,0,0])
difference() {
  translate([holder_size[X]/2 - base_size[X]/2,0,0])
    rotate([0, 90, 0])
      difference() {
	bcube([holder_size[Z], holder_size[Y], holder_size[X]], cr = 3, cres = 4);
	cube(co_size, center = true);
      }

  //-- Skymega drills
      for (drill = sky_drill_table) {
	translate(drill)
	  rotate([0,0,90])
	    teardrop(r = sky_drill_diam/2, h = holder_size[Z] + extra);
      }
}



