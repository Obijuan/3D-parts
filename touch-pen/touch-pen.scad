
pen_diam = 10;

//------ pen cap --------
cap_th = 1.4;
cap_diam = pen_diam;
cap_base_h = 5;
pen_tip_h = 5;

pen_body_h = 30;


extra = 5;


//--- Cap base
color("green")
translate([0,0,cap_base_h/2 + pen_body_h])
difference() {
  cylinder(r = cap_diam/2, h = cap_base_h, center = true, $fn = 6);
  cylinder(r = pen_diam/2 - cap_th, h = cap_base_h + extra, center = true, $fn = 6);
}


//-- Cap tip
translate([0,0, pen_tip_h/2 + cap_base_h + pen_body_h])
difference() {
cylinder(r1 = cap_diam/2, r2 = cap_diam/2 - cap_th, h = pen_tip_h, center = true, $fn = 6);
cylinder(r1 = cap_diam/2 - cap_th, r2 = pen_diam/2 - 2*cap_th, h = pen_tip_h + 0.05, center = true, $fn = 6);
}
         

//-- Pen body
color("Blue")
translate([0,0,pen_body_h/2])
cylinder(r = pen_diam/2, h = pen_body_h, center = true, $fn = 6);
