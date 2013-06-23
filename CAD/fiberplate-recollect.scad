use <clamplib.scad>

plate_thickness = 3;
fiber_hole_diam = 6;
plate_width = 30;
plate_height = 30;
clamp_height = 20;

module faceplate(width, height) {
  margin = 8;
  linear_extrude(height=plate_thickness, convexity=2) {
    difference() {
//      square([width, height], center=true);
      hull() for(j=[-1,1], i=[-1,1]) translate([i/2*(width-5), j/2*(height-5)]) circle(r=5, $fn=32);
      for (j=[-1,1], i=[-1,1]) {
        translate([i/2*(width-margin), j/2*(height-margin)]) circle(r=1.5, $fn=16);
      }
    }
  }
}

module faceclamp() {
  rotate([0,0,-90])
    clamp(inner_diameter=fiber_hole_diam*0.9,
          outer_diameter=fiber_hole_diam*2.5,
          clamp_width=10,
          clamp_thickness=3,
          height=clamp_height,
          holes=1);
}

difference() {
  faceplate(plate_width, plate_height);
  cylinder(h=plate_thickness*4, r=fiber_hole_diam/2, center=true, $fn=16);
}

translate([0,0,clamp_height/2]) faceclamp();
