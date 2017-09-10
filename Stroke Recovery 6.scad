////////////////////////////////////////////
// 
// Stroke Recovery Finger Cots
// by Les Hall
// started Thu Apr 13 2017
// 



// parameters
sizes = [85, 95, 90];  // sizes to make (in percentages)
//sizes = [100];
circ = [85, 80, 75, 55];  // circumference at knuckles
dist = [25, 30, 20];  // distance from base of circ's
nozzleDiameter = 0.8;  // diameter of nozzle
thick = nozzleDiameter * 1.5;  // thickness of shape
nf = 8;  // number of facets on relief holes
$fn = 64;  // number of facets on tapered cylinders



// draw a plate of finger cots
plate();
module plate() {
    
    for (s = [0:len(sizes)-1])  // s is the percentage of full size circ and dist
        translate([33*(s - (len(sizes)-1)/2), 0, 0])  // position each finger cot
        finger_cot(
            circ*sizes[s]/100, 
            dist*sizes[s]/100, 
            thick, nf);  // draw each finger cot
}



// draw one finger cot
module finger_cot(circumference, spacing, thickness, fn) {
    
    // calculations
    diameter = circumference / PI;
    totalLength = spacing[0] + spacing[1] + spacing[2];
    
    rotate(45)
    difference() {
        
        // the outer shape
        cylinder(h = totalLength, 
            d1 = diameter[0] + 2*thickness, 
            d2 = diameter[3] + 2*thickness);
        
        // the inner shape
        cylinder(h = totalLength, 
            d1 = diameter[0], 
            d2 = diameter[3]);
        
        // the knuckle cutouts
        kSize = 1.25;
        
        for (side = [-1:2:1], knuckle = [1:2]) {
            translate([0, side*diameter[knuckle], 
                spacing[0] + (knuckle-1)*spacing[1] + side*spacing[1]/8])
            rotate([45, 0, 0])
            difference() {
                
                // knuckle and under-finger cuts
                cube(kSize*diameter[(side+1)/2], center = true);
                
                // strain relief
                rotate([45, 0, 0])
                translate([0, 0, side] * sqrt(2)/2 * kSize*diameter[(side+1)/2])
                rotate([0, 90, 0])
                translate([side, 0, 0])
                scale([1, 2, 1])
                rotate(45)
                cylinder(h = 2*diameter[(side+1)/2], 
                    d = 5, center = true, $fn = 4);
            }
        }
    }
}


