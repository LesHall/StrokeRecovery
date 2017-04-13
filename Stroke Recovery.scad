// by Les Hall
// started Thu Apr 13 2017



// parameters
circumference = [85, 75, 55] * 1.05;
length = [15, 10, 10];
spacing = [10, 20, 15];
nozzleDiameter = 0.8;
thickness = nozzleDiameter;
$fn = 64;



// calculations
diameter = circumference / PI;
totalLength = spacing[0] + length[0] + 
    spacing[1] + length[1] + 
    spacing[2] + length[2];



// draw the thing
difference() {
    cylinder(h = totalLength, 
        d1 = diameter[0] + 2*thickness, 
        d2 = diameter[2] + 2*thickness);
    cylinder(h = totalLength, 
        d1 = diameter[0], 
        d2 = diameter[2]);
}