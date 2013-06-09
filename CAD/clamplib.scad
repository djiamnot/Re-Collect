holesize = 3;

module roundedBox(dim, r)
{
  hull() {
    for (z=[-0.5,0.5], y=[-0.5,0.5], x=[-0.5,0.5]) {
      translate([x*(dim.x-2*r), y*(dim.y-2*r), z*(dim.z-2*r)]) sphere(r);
    }
  }
}

module clampCylinder()
{
  rotate_extrude(convexity=2, $fn=128)
    translate([$inner_diameter/2 + $width/4,0]) {
        hull() {
          square([$width/2, $height], center=true);
          translate([$width-$roundingRadius,-$height/2+$roundingRadius]) circle($roundingRadius, $fn=$roundingDetail);
          translate([$width-$roundingRadius,$height/2-$roundingRadius]) circle($roundingRadius, $fn=$roundingDetail);
        }
    }
}

module doubleclamp() {
	hole_horiz_pos = $clamp_width+$width+$inner_diameter/2 - $clamp_width/2;
	
	module hole() {
	  rotate([0,90,0]) cylinder($fn=16, r=holesize/2, h=$clamp_thickness*2.5, center=true);
	}

	difference() {
            union() {
                clampCylinder($inner_diameter, $width);
	        translate([0, ($clamp_width+$width/2)/2 + $width/2 + $inner_diameter/2]) 
	          roundedBox([2*$clamp_thickness, $clamp_width+$width/2, $height], $roundingRadius, $fn=$roundingDetail);
	        translate([0, -($clamp_width+$width/2)/2 - $width/2 - $inner_diameter/2]) 
	          roundedBox([2*$clamp_thickness, $clamp_width+$width/2, $height], $roundingRadius, $fn=$roundingDetail);
            }

            for (h=hole_horiz_pos*[-1,1]) {
                for (i=[0:$holes-1], hole_vert_pos = -$height/2 + (i+0.5)*$height/$holes+1 ) {
    	            translate([0,h,hole_vert_pos]) hole();
                }
            }
	}
}

module innerProfile()
{
  difference() {
      cube([$roundingRadius*2, $roundingRadius*2, $height*1.2], center=true);
      translate([$roundingRadius, $roundingRadius, 0]) cylinder(h=$height*1.3, r=$roundingRadius, center=true, $fn=$roundingDetail);
  }
}

module clamp(inner_diameter, outer_diameter, clamp_width, clamp_thickness, height, holes) {
  $roundingRadius = clamp_thickness/4;
  $roundingDetail = 16;
  $inner_diameter = inner_diameter;
  $clamp_width = clamp_width;
  $clamp_thickness = clamp_thickness;
  $width = outer_diameter - inner_diameter;
  $height = height;
  $holes = holes;

  cubesize = 2.1*[inner_diameter+$width, inner_diameter+$width+clamp_width, height];
  difference() {
    doubleclamp(inner_diameter, $width, clamp_width, clamp_thickness);
    translate([-cubesize.x/2, 0, 0]) cube(cubesize, center=true);
    translate([0, inner_diameter/2, 0]) innerProfile();
    translate([0, -inner_diameter/2, 0]) rotate([0,0,-90]) innerProfile();
  }
}

