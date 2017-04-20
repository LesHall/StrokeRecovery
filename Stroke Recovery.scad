////////////////////////////////////////////
// 
// Stroke Recovery Finger Cots
// by Les Hall
// started Thu Apr 13 2017
// 



// parameters
holes = false;
guides = true;
circ = [85, 80, 75, 55];  // circumference at knuckles
dist = [25, 30, 20];  // distance from base of circ's
nozzleDiameter = 0.8;  // diameter of nozzle
thick = nozzleDiameter * 1.05;  // thickness of shape
nf = 8;  // number of facets on relief holes
$fn = 64;  // number of facets on tapered cylinders



// draw a plate of finger cots
plate();
module plate() {
    
    for (s = [70])  // s is the percentage of full size circ and dist
        finger_cot(circ*s/100, dist*s/100, thick, nf);  // draw each finger cot
}



// draw one finger cot
module finger_cot(circumference, spacing, thickness, fn) {

    // calculations
    diameter = circumference / PI;
    totalLength = spacing[0] + spacing[1] + spacing[2];    
    
    rotate(-45)
    difference() {
        
        // the cylinder again
        taper(diameter, thickness, totalLength);
        
        // the knuckle cutouts
        for (side = [-1:2:1], knuckle = [1:2])
            translate([0, side*diameter[knuckle]/2, 
                spacing[0] + (knuckle-1)*spacing[1] + side*spacing[1]/8])
            rotate([90, 0, 0])
            rotate(180 / fn)
            if (holes)
                cylinder(h = diameter[(side+1)/2], 
                    d = diameter[knuckle]*3/4, 
                    center = true, $fn = fn);
    }
    
    // make the scissors guides
    k = (diameter[2] + thickness) / diameter[2];
    if (guides)
        scale([k, k, 1])
        intersection() {
            
            // the cylinder again
            taper(diameter, thickness, totalLength);
            
            // the scissors guide details
            union() {
                
                // the horizontal pieces
                for (delta = [-1:2:1], side = [-1:2:1], knuckle = [1:2])
                    translate([0, side*diameter[knuckle]/4, 
                        spacing[0] + (knuckle-1)*spacing[1] + 
                        side*spacing[1]/8 + delta*totalLength/40])
                        cube([diameter[knuckle], 
                            diameter[knuckle]/2, 
                            totalLength/40], 
                            center = true);
                
                // the vertical pieces
                translate([0, 0, totalLength/2])
                cube([diameter[0], totalLength/40, totalLength], 
                    center = true);
            }
        }
}



// the main tapered cylinder
module taper(diameter, thickness, totalLength) {
    
    difference() {
        
        // the outer shape
        cylinder(h = totalLength, 
            d1 = diameter[0] + 2*thickness, 
            d2 = diameter[3] + 2*thickness);
        
        // the inner shape
        cylinder(h = totalLength, 
            d1 = diameter[0], 
            d2 = diameter[3]);
    }
}


