X = 0;
Y = 1;
Z = 2;


//-- Logo with inverse mikowski applied. When mikonski is applied
//-- with r = 1, the bq logo with the right proportions is obtained, but
//-- rounded
module bq_min(h = 5)
{
  linear_extrude(height=h)
    import("bq-logo2d-minkowski.dxf", layer="final");
}


//-- Logo grande con minkowski
minkowski() {
    mirror([0,1,0])
    bq_min(h = 5);
    
  sphere(r=1, center = true, $fn=20);
}
