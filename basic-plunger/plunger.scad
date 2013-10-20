plunger_length = 90;
plunger_diam = 14.5;
base_th = 3;
base_diam = 25;


//-- Body
cylinder(r = plunger_diam/2, h = plunger_length, center = true, $fn = 100);

//-- Base
translate([0, 0, base_th/2 - plunger_length/2])
scale([0.8,1,1])
cylinder(r = base_diam/2, h = base_th, center = true, $fn = 50);
