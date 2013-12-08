//---------------------------------------------------------------
//--  bq logo.  (c) Juan Gonzalez-Gomez. Dic-8th-2013
//---------------------------------------------------------------
//-- Released under the GPL license
//---------------------------------------------------------------

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

  difference() {
    bq_logo(lx = lx, h = h);
  
    translate([-lx/2 + s*width/2, s * size_ini[Y]/2 + 1 -d/2 - dt, h/2])
      cylinder(r = d/2, h = drill_h, $fn = 10, center = true);
  }
  
}


//-- Normal logo
bq_logo();

//-- keychain
//bq_keychain(d = 3);
