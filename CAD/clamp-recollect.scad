use <clamplib.scad>

inner_diameter = 20;
outer_diameter = 40;
clamp_thickness = 5;
clamp_width = 15;
height = 50;
holes = 2;

clamp(inner_diameter, outer_diameter, clamp_width, clamp_thickness, height, holes);
