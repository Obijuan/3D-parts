use <obiscad/bcube.scad>

X=0;
Y=1;
Z=2;

size = [52, 25, 5];
drill_d = 30;  //-- Distance between drills
drill_diam = 3.2;


difference() {
  bcube(size, cres = 4, cr = 2);

  translate([drill_d/2, 0, 0])
    cylinder(r = drill_diam/2, h = size[Z]+1, center = true);

  translate([-drill_d/2, 0, 0])
    cylinder(r = drill_diam/2, h = size[Z]+1, center = true);
}


