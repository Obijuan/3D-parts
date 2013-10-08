
tedx_h = 4;
hole_size = [8, 3, 2*tedx_h + 10];
hole_pos = [-13, 20, 0];

module tedx(h)
{

  linear_extrude(height=h)
    import("x.dxf");
}

color("red")
difference() {
tedx(h = tedx_h);

translate(hole_pos)
cube(hole_size, center = true);
}