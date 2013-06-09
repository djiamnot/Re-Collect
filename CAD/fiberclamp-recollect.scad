use <clamplib.scad>

plate_thickness = 3;
fiber_hole_diam = 5;

difference() {
  translate([0,0,10]) clamp(inner_diameter=fiber_hole_diam,
        outer_diameter=fiber_hole_diam*2,
        clamp_width=10,
        clamp_thickness=3,
        height=20,
        holes=1);
   cube([100,100,6], center=true);
}
