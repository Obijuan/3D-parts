module teardrop(r,h)
{
  $fa=15.0;
  $fs=0.1;

  diameter=2*r;

  translate([0,0,-h/2])
  linear_extrude(height=h, center=false, convexity=10)
  difference() {
    union() {
      circle(r=diameter/2);
      rotate(45) square(size=diameter/2,center=false);
    }
    translate([-diameter/2,diameter/2]) square(size=diameter);
  }
}