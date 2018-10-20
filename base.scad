include <threads.scad>;
include <indenter_jig_parameters.scad>;

// form the main body from a cylinder, cut the threads with extra clearance at the root and add the viewing ports as cylindrical cutouts
difference(){

cylinder( d=handle_diameter, h=pin_depth+travel);

scale([1+oversize , 1+oversize, 1])
    union(){
metric_thread (diameter=thread_diameter-thread_pitch, pitch=thread_pitch, length=pin_depth+travel, leadin = 3, internal = true);
    
    cylinder(d=(thread_diameter-thread_pitch)-(thread_pitch-1), h = pin_depth+travel);
    }
    
// cut out four diametrically opposed circular viewing ports 
for (i = [0:3]){
    rotate([90,0,i*90])
    hull(){
        sphere(0.1);
        translate([0,0,1.3*handle_diameter])
        sphere(d=handle_diameter);
    }
    //cylinder(d=pin_depth+travel, h=50);
}

}