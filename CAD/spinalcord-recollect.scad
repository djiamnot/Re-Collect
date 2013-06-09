outer = 75;
inner = 45;
small = 12.5;
thickness = 5;
$fs=0.5;
$fa=5;

linear_extrude(thickness) {
	difference() {
		minkowski() {
		difference() {
		  circle(outer);
		  for (i=[0:4]) {
		    rotate(360/5*i) {
		      translate([outer-small-3,0,0]) circle(small);
		      translate([outer,0]) square([10,9], center=true);
		    }
		  }
		}
		circle(2);
		}
	  circle(inner);
	}
}

