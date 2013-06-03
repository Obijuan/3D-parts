pen_len = 130;
pen_diam = 14;
pen_idiam = 9.5;
pen_sides = 6;
pen_tip_angle = 10;
pen_tip_wall_th = 1.5;

//-- Calculations
pen_tip_h = (pen_diam/2 - (pen_idiam/2 + pen_tip_wall_th)) / tan(pen_tip_angle);

extra = 10;

difference() {

 //-- Pen with tip
  union() {
    //-- Tip
    color("red")
    translate([0,0,pen_len/2])
    cylinder(r1 = pen_diam/2, r2 = pen_idiam/2 + pen_tip_wall_th, h = pen_tip_h, center = true, $fn = pen_sides);

    //-- Body
    cylinder(r = pen_diam/2, h = pen_len - pen_tip_h, center = true, $fn = pen_sides);
  }  

  //-- Inner part
  cylinder(r = pen_idiam/2, h = pen_len + pen_tip_h + extra, center = true, $fn = 20);

}