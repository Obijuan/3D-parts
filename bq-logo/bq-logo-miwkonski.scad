X = 0;
Y = 1;
Z = 2;


//-- Size of the logo in the dxf file
size_ini = [106.8, 91.8];

//-- Original width of the b and q lines
width = 15;

module bq_logo(lx = 50, h = 3)
{
  s = lx / size_ini[X];

  linear_extrude(height=h)
    scale([s, s, 1])
    import("bq-logo2d.dxf", layer="lines");
}

//-- Parameters:
//-- lx = Logo length in the x axis
//-- h = logo height (z axis)
//-- d = Drill diameter
//-  dt = Distance from the drill to the top part
module bq_keychain(lx = 50, h = 3, d = 2, dt = 2)
{
  drill_h = h + 2;
  
  s = lx / size_ini[X];

  bq_logo(lx = lx, h = h);
  
  color("red")
  translate([-lx/2 + s*width/2, s * size_ini[Y]/2 + 1 -d/2 - dt, h/2])
    cylinder(r = d/2, h = drill_h, $fn = 10, center = true);
}


//-- Logo con minkowski inverso aplicado, de manera que
//-- al aplicar minkowski con una esfera de r = 1 se
//-- obtenga el logo original, pero redondeado
module bq_min(h = 5)
{
  linear_extrude(height=h)
    import("bq-logo2d-minkowski.dxf", layer="final");
}

bq_keychain();

//bq_logo_orig();

//-- Logo estándar (5cm de ancho)
*color("blue")
  bq_min();

//-- Logo grande con minkowski
*minkowski() {
  //mirror([0,1,0])
    bq_min(h = 5);
    
  sphere(r=1, center = true, $fn=20);
}
