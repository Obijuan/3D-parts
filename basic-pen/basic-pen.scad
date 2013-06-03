//-----------------------------------------------------------------------
//-- Basic pen.
//-- (c) Juan Gonzalez-Gomez (Obijuan). June-2013
//-----------------------------------------------------------------------
//-- Inspired by the customized retro font word pen, by BandromW6
//--     http://www.thingiverse.com/thing:45576
//-----------------------------------------------------------------------
use <teardrop.scad>

//-- Build a vertical pen, from all the parameters
module pen_vert(h, d, id, sides, tip_angle, tip_wall_th, closed = true) 
{
  //-- Calculations
  tip_h = (d/2 - (id/2 + tip_wall_th)) / tan(tip_angle);
  extra = 10;

  difference() {

  //-- Pen with tip
    union() {
      //-- Tip
      color("red")
      translate([0,0,h/2])
      cylinder(r1 = d/2, r2 = id/2 + tip_wall_th, h = tip_h,
	      center = true, $fn = sides);

      //-- Body
      cylinder(r = d/2, h = h - tip_h, center = true, $fn = sides);
    }  

    //-- Inner part
    if (closed == true)
      translate([0,0, tip_h/2 + 2])
      teardrop(r = id/2, h = h);
      //cylinder(r = id/2, h = h, center = true, $fn = 20);
    else
      teardrop(r = id/2, h = h + extra);
      //cylinder(r = id/2, h = h + tip_h + extra, center = true, $fn = 20);

  }
}



//-- Basic pen
module pen(h = 130,            //-- Pen length
           d = 9.5,              //-- pen outter diameter
           id = 5,             //-- pen inner diameter
           sides = 6,          //-- Pen section sides. WARNING! If printed horizontally,
                               //--   it should be not greater than 8. If so, the angles
                               //--   will be lesser than 45 degrees
                               //--   (therefore support material 
           tip_angle = 20,     //-- Angle between  the pen body end and the tip. 
                               //--    WARNING! If printed horizontally, it should be greater 
                               //--    than 45 degrees. If not, support material will be needed
           tip_wall_th = 1.5,  //-- Thickness of the tip wall (in the end)
           closed = true,      //-- If the rear is opened or closed
           horizontal = false) //-- true or false. How to print it. If horizontally, letter and
                               //-- more stuff can be added easily. If vertically, the section
                               //-- can have different shapes
{

  if (horizontal == true) 
    rotate([90,0,0])
    pen_vert(h = h, 
	    d = d,
	    id = id,
	    sides = sides,
	    tip_angle = tip_angle,
	    tip_wall_th = tip_wall_th,
	    closed = closed);
  else
    pen_vert(h = h, 
	    d = d,
	    id = id,
	    sides = sides,
	    tip_angle = tip_angle,
	    tip_wall_th = tip_wall_th,
	    closed = closed);
}


//-- EXAMPLES

//-- Standar pen (printed vertically)
*pen();


//-- The same, but printed horizontally. The tip angle is changed
pen(horizontal = true, tip_angle = 45);


