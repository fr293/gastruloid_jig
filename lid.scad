include <threads.scad>
use <knurledFinishLib_v2.scad>
include <indenter_jig_parameters.scad>;

difference(){

// create the main body by joining a thread and a knurled cylinder
// note that the thread teeth are clipped to improve the reliability of the fit
union(){
translate([0,0,handle_depth])
metric_thread (diameter=thread_diameter, pitch=thread_pitch, length=pin_depth, leadin = 1);
    
knurl(k_cyl_hg=handle_depth, k_cyl_od=handle_diameter);
    
    // put on instructional text and logo
// mirroring is necessary as it is viewed from the 'base'
translate([0,0,-text_height])
union(){
linear_extrude(height=text_height)
mirror([1,0,0])revolve_text(outer_text_radius, outer_text);
cylinder(h=text_height, r1=0.1, r2=0);


linear_extrude(height=text_height)
mirror([1,0,0])revolve_text(inner_text_radius, inner_text);

// the scaling and translation fits the logo, different logos will need different values
scale([0.8,0.8,1])
mirror([1,0,0])
linear_extrude(height=text_height)
translate([-20,-55,0])
import("ferg_logo.dxf");
}
}

// cut the ends off the thread teeth
translate([0,0,handle_depth])
difference(){
cylinder( d=handle_diameter, h=pin_depth);
cylinder( d=thread_diameter-1, h=pin_depth);  
}


// drill out nine holes in a square grid for the indenters
// there is a small adjustment for the hole size to account for the FDM hole shrinking effect
for (i = [-1:1]){
    for (j = [-1:1]){
       translate([i*well_spacing,j*well_spacing,handle_depth])
       union(){ 
        cylinder(d = pin_width + hole_adjustment, h= pin_depth+1);
           translate([0,0,pin_depth])
        sphere(r = pin_width + hole_adjustment);
       }
    }
}



}

// the module that fits the text on a circular path

module revolve_text(radius, chars) {
    PI = 3.14159;
    circumference = 2 * PI * radius;
    chars_len = len(chars);
    font_size = circumference / chars_len;
    step_angle = 360 / chars_len;
    for(i = [0 : chars_len - 1]) {
        rotate(-i * step_angle) 
            translate([0, radius + font_size / 2, 0]) 
                text(
                    chars[i], 
                    font = "Helvetica", 
                    size = font_size, 
                    valign = "center", halign = "center"
                );
    }
}
