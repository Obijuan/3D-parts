h = 4;
di = 2.5;
de = 9;


difference() {
  cylinder(r = de/2, h = h, center = true, $fn = 30);
  cylinder(r = di/2, h = h+1, center = true, $fn = 20);
}
