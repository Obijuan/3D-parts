use <obiscad/bcube.scad>

X = 0;
Y = 1;
Z = 2;


cres = 4;
cr = 1;

extra = 5;

//--- Futaba body
body_size = [19.8, 40.4, 21.6];
body_wall_th = 1;

//-- Fake elecronic board
board_size = [body_size[X] - 2*body_wall_th,
              body_size[Y] - 2*body_wall_th,
              2];

module ear()
{
  we = dxf_dim(file="futaba-ears.dxf", name="we");
  rd = dxf_dim(file="futaba-ears.dxf", name="rd");
  xd = dxf_dim(file="futaba-ears.dxf", name="xd");
  yd = dxf_dim(file="futaba-ears.dxf", name="yd");
  we2= dxf_dim(file="futaba-ears2.dxf", name="we2");

  difference() {
    union() {
      linear_extrude(height=we)
       import(file="futaba-ears.dxf", layer="exterior");

      translate([0,we2/2,we])
      rotate(a=90, v=[1,0,0])
      linear_extrude(height=we2)
        import(file="futaba-ears2.dxf", layer="exterior");
    }

    translate([-xd,yd,0])
      cylinder(r=rd, h=we+10, $fn=16,center=true);
    translate([-xd,-yd,0])
      cylinder(r=rd, h=we+10, $fn=16,center=true);
  }
}

module futaba() 
{
  z1 = dxf_dim(file="futaba-main.dxf", name="z1");
  x1 = dxf_dim(file="futaba-main.dxf", name="x1");
  y1 = dxf_dim(file="futaba-main.dxf", name="y1");
  ht  = dxf_dim(file="futaba-top.dxf", name="ht");
  xs = dxf_dim(file="futaba-main.dxf",name="xs");
  he = dxf_dim(file="futaba-main.dxf",name="he");



  union() {
    //-- Main part
    translate([0,0,z1/2])
    #cube(size=[x1,y1,z1], center=true);

    //-- Top part
    translate([0,0,z1])
    rotate (a=90, v=[1,0,0])
    linear_extrude(height=y1,center=true)
       import(file="futaba-top.dxf");

   //-- Shaft part
   translate ([xs,0,z1+ht]) 
     rotate_extrude()
       import(file="Futaba-shaft.dxf");
      
  }

  translate([-x1/2,0,he]) ear();
  translate([x1/2,0,he]) 
    rotate(a=180, v=[0,0,1]) ear();

}

module futaba_top_cover()
{
}

module futaba_body()
{

   body_cutout_size = [board_size[X], board_size[Y], board_size[Z]+extra];

   difference() {
     bcube(body_size, cr = cr, cres = cres);
   
     translate([0, 0, -body_cutout_size[Z]/2 -body_size[Z]/2 + board_size[Z] ])
       cube(body_cutout_size, center = true);
   }
   
}

rotate([0,0,90])
futaba();

*futaba_body();

futaba_top_cover();




