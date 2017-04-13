// by Les Hall
// started Thu Apr 13 2017



// parameters
circumference = [85, 75, 55] * 1.05;
length = [15, 10, 10];
spacing = [25, 30, 20];
nozzleDiameter = 0.8;
thickness = nozzleDiameter;
$fn = 64;



// calculations
diameter = circumference / PI;
totalLength = spacing[0] + spacing[1] + spacing[2];



// draw the thing
difference() {
    
    // the outer shape
    cylinder(h = totalLength, 
        d1 = diameter[0] + 2*thickness, 
        d2 = diameter[2] + 2*thickness);
    
    // the inner shape
    cylinder(h = totalLength, 
        d1 = diameter[0], 
        d2 = diameter[2]);
    
    deltaDiameter = diameter[0] - diameter[2];
    
    
    // the knuckle cutouts
    for (side = [-1:2:1], knuckle = [-1:2:1])
        translate([0, side*diameter[(knuckle+1)/2]/2, 
            spacing[0] + spacing[1]/2 + 
            knuckle*spacing[1]/2 + side*spacing[1]/8])
        rotate([90, 0, 0])
        cylinder(h = diameter[(side+1)/2], 
            d = diameter[(knuckle+1)/2]*3/4, center = true);
}