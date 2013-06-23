outer_diameter = 150;
inner_diameter = 32;
fiber_diameter = 3;
inset = 10;
num_fibers = 30;
i = 10;

difference() {
  circle(outer_diameter/2, $fn=64);
  circle(inner_diameter/2, $fn=64);
  for (i=[0:num_fibers-1]) 
    rotate([0,0,i*360/num_fibers]) 
      translate([outer_diameter/2 - inset, 0]) 
        circle(fiber_diameter/2, $fn=16);
}
