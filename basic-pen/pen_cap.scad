
//-- User parameters
module pen_cap(h = 30,        //-- Total cap height 
               body_h = 17,   //-- Body height
               th = 1,        //-- Wall thickness
               idiam = 10.3,  //-- Inner diameter
               sides = 6,     //-- Number of sides
               tip_idiam = 4, //-- Tip end diameter
               closed = true,
              )
{
  //-- Calculations
  cap_diam = idiam + 2*th;
  cap_tip_h = h - body_h;
  cap_tip_idiam = tip_idiam + 2*th;

  extra = 10;

  //-- Cap body
  translate([0,0, -body_h/2])
  difference() {
    cylinder(r = cap_diam/2, h = body_h, center = true, $fn = sides);
    cylinder(r = idiam/2, h = body_h + extra, center = true, $fn = sides);
  }

  tip_h = (closed == true) ? cap_tip_h - 1 : cap_tip_h + 0.01;
  pos_tip = (closed == true) ? -1/2 - 0.01 : 0;
  
  //-- Cap tip
  translate([0,0, cap_tip_h/2])
  difference() {
    cylinder(r1 = cap_diam/2, r2 = cap_tip_idiam/2 , h = cap_tip_h, center = true, $fn = sides);
    translate([0,0, pos_tip])
    cylinder(r1 = idiam/2, r2 = cap_tip_idiam/2 - th, h = tip_h, center = true, $fn = sides);
  }
}

pen_cap(closed = true);




