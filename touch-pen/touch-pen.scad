//------------------------------------------------
//-- Touch pen.
//-- (c) Juan Gonzalez-Gomez (Obijuan). Nov-2013
//------------------------------------------------
// Released under the GPL v3 license
//------------------------------------------------

//-------------- Pen parameters
pen_diam = 10;        //-- outer diameter
pen_tip_th = 1.4;     //-- Pen tip thickness
pen_tip_base_h = 5;   //-- Tip base height
pen_tip_h = 5;        //-- Pen tip height
pen_body_h = 30;      //-- Pen body height



//--------------------------------------------------
extra = 5;


//--- Pen tip base
//color("green")
translate([0,0,pen_tip_base_h/2 + pen_body_h])
difference() {
  cylinder(r = pen_diam/2, h = pen_tip_base_h, center = true, $fn = 6);
  cylinder(r = pen_diam/2 - pen_tip_th, h = pen_tip_base_h + extra, center = true, $fn = 6);
}


//-- pen tip
translate([0,0, pen_tip_h/2 + pen_tip_base_h + pen_body_h])
difference() {
  cylinder(r1 = pen_diam/2, r2 = pen_diam/2 - pen_tip_th, h = pen_tip_h, center = true, $fn = 6);
  cylinder(r1 = pen_diam/2 - pen_tip_th, r2 = pen_diam/2 - 2*pen_tip_th, h = pen_tip_h + 0.05, center = true, $fn = 6);
}
         

//-- Pen body
//color("Blue")
translate([0,0,pen_body_h/2])
  cylinder(r = pen_diam/2, h = pen_body_h, center = true, $fn = 6);
