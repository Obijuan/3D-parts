th=1.5;
h = 10;
di = 9;


de = 25;


difference() {
  cylinder(r = de/2, h = h, center = true, $fn = 30);
  cylinder(r = di/2, h = h+1, center = true, $fn = 20);
}
