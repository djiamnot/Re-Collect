inner_diameter = 20;
width = 10;
clamp_width = 5;
clamp_length = 15;
height = 50;
holesize = 3;
roundingRadius = clamp_width/4;
roundingDetail = 16;

module roundedBox(dim, r)
{
  hull() {
    for (z=[-0.5,0.5], y=[-0.5,0.5], x=[-0.5,0.5]) {
      translate([x*(dim.x-2*r), y*(dim.y-2*r), z*(dim.z-2*r)]) sphere(r, $fn=roundingDetail);
    }
  }
}

module clampCylinder()
{
  rotate_extrude(convexity=2, $fn=128)
    translate([inner_diameter/2 + width/4,0]) {
        hull() {
          square([width/2, height], center=true);
          translate([width-roundingRadius,-height/2+roundingRadius]) circle(roundingRadius, $fn=roundingDetail);
          translate([width-roundingRadius,height/2-roundingRadius]) circle(roundingRadius, $fn=roundingDetail);
        }
    }
}

module clamp() {
	hole_horiz_pos = clamp_length+width+inner_diameter/2 - clamp_length/2;
	
	module hole() {
	  rotate([0,90,0]) cylinder($fn=16, r=holesize/2, h=clamp_width*2.5, center=true);
	}

	difference() {
            union() {
                clampCylinder();
	        translate([0, (clamp_length+width/2)/2 + width/2 + inner_diameter/2]) 
	          roundedBox([2*clamp_width, clamp_length+width/2, height], roundingRadius);
	        translate([0, -(clamp_length+width/2)/2 - width/2 - inner_diameter/2]) 
	          roundedBox([2*clamp_width, clamp_length+width/2, height], roundingRadius);
            }
                
	    translate([0,hole_horiz_pos,-height/4]) hole();
	    translate([0,hole_horiz_pos,height/4]) hole();
	    translate([0,-hole_horiz_pos,-height/4]) hole();
	    translate([0,-hole_horiz_pos,height/4]) hole();
	}
}

module innerProfile()
{
  difference() {
      cube([roundingRadius*2, roundingRadius*2, height*1.2], center=true);
      translate([roundingRadius, roundingRadius, 0]) cylinder(h=height*1.3, r=roundingRadius, center=true, $fn=roundingDetail);
  }
}

cubesize = 2.1*[inner_diameter+width, inner_diameter+width+clamp_length, height];
difference() {
    clamp();
    translate([-cubesize.x/2, 0, 0]) cube(cubesize, center=true);
    translate([0, inner_diameter/2, 0]) innerProfile();
    translate([0, -inner_diameter/2, 0]) rotate([0,0,-90]) innerProfile();
}
