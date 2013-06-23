lens_diameter = 22;
lens_opening = 8.5;
top_diameter = 14;
fiber_hole_diam = 6;
guide_opening = 9;
height = 23;
$fs=2;
$fa=1;
difference() {
  cylinder(r1=lens_diameter/2, r2=top_diameter/2, h=height);
  translate([0,0,-1]) cylinder(r=fiber_hole_diam/2, h=height+2);
  cylinder(r1=0, r2=guide_opening/2, h=height+2);
  translate([0,0,-0.1]) cylinder(r1=lens_opening/2, r2=0, h=10);
}
