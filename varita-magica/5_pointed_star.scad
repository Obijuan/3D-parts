//-- 5-pointed star
//-- (c)  2010 Juan Gonzalez-Gomez (Obijuan) juan@iearobotics.com
//-- GPL license

use <parametric_star.scad>

stick_len = 140;
stick_diam = 6;

rotate([0, 0, 45])
union() {
  parametric_star(ri=30/2, re=40, h = 2 * (stick_diam / 2 * cos(30) + 0.1));

  color("magenta")
  translate([-stick_len / 2, 0, stick_diam / 2 * cos(30)])
  rotate([0, 90, 0])
  rotate([0, 0, 30])
  cylinder(r = stick_diam / 2, h = stick_len, center = true, $fn = 6);
}