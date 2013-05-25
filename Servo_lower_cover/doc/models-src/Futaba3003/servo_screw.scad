X = 0;
Y = 1;
Z = 2;


len = 29;
diam = 1.7;

head_diam = 3.3;
head_th = 1.3;

extra = 5;

cross_size = [1.8, 0.7, extra];

module cross()
{
  cube(cross_size, center = true);

  rotate([0,0,90])
    cube(cross_size, center = true);
}

module head()
{

  difference() {
    cylinder(r=head_diam/2, h = head_th, center = true, $fn=50);
    
    translate([0,0, cross_size[Z]/2])
      cross();
 }     

}


cylinder(r=diam/2, h = len, center = true, $fn=30);
translate([0,0,head_th/2 + len/2 -0.1])
head();
