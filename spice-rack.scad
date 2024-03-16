$fn=64;
floor_board_width = 45;
floor_width = 60;
floor_board_height = 5;
side_wall_width = 8;

front_height = 55;
front_width = 8;
front_bar_type = "round"; // round or rectangular
front_bar_width = 6;
front_bar_height = 50;

back_height = 65;
back_depth = 8;

wall_thickness = 4;

screw_hole_upper_diameter = 4;
screw_hole_lower_diameter = 6;
screw_hole_length = 12;



screw_hole_height = 50;


total_depth = 55 + front_width;
floor_height = 10;

screw_hole_insert_depth = 2;

logo_depth_difference = 10;
logo_bottom_offset = 27;

centerlogo_color_offset = 0;


// rotate([0, -90, 0])
union() {
    // Floor
    difference() {
        cube([total_depth, side_wall_width, floor_height]);
        translate([(total_depth - floor_board_width)/2, 0, (floor_height - floor_board_height) / 2]) cube([floor_board_width, 20, floor_board_height]);
    }

    // Front
    difference() {
        cube([front_width, side_wall_width, front_height]);
        if(front_bar_type == "rectangular") {
            translate([0, wall_thickness, front_height - wall_thickness - front_bar_width]) cube([front_width, front_bar_height, front_bar_width]);
        } else {
            translate([front_width / 2, side_wall_width, front_bar_height]) rotate([90, 0, 0]) cylinder(d=front_bar_width, h=side_wall_width);
        }
    }

    // back
    difference() {
        translate([total_depth - back_depth, 0, 0]) cube([back_depth, side_wall_width, back_height]);

        translate([total_depth, side_wall_width / 2, screw_hole_height]) rotate([0, -90, 0]) union() {
            hull() {
                cylinder(d=screw_hole_upper_diameter, h=back_depth);
                translate([screw_hole_length - screw_hole_upper_diameter, 0, 0]) cylinder(d=screw_hole_upper_diameter, h=back_depth);
            }
            translate([0, 0, back_depth - screw_hole_insert_depth]) hull() {
                cylinder(d=screw_hole_lower_diameter, h=screw_hole_insert_depth);
                translate([screw_hole_length - screw_hole_upper_diameter, 0]) cylinder(d=screw_hole_lower_diameter, h=screw_hole_insert_depth);
            }
            cylinder(d=screw_hole_lower_diameter, h=back_depth);
        }
    }

    // Front section
    *difference(){
        color("red") cube([side_wall_width, front_bar_height + (wall_thickness * 2), front_height]);
        if(front_bar_type == "rectangular") {
            translate([0, wall_thickness, front_height - wall_thickness - front_bar_width]) color("blue") cube([side_wall_width, front_bar_height, front_bar_width]);
        } else {
            translate([0, wall_thickness, front_height - wall_thickness - front_bar_width]) color("blue") rotate([0, 90, 0]) cylinder(d=front_bar_width, h=front_bar_height);
        }
    }   

    // Wall mount section
    *translate([0, front_bar_height + (wall_thickness * 2) + floor_width + (wall_thickness * 2), 0]) difference() {
        color("green") cube([side_wall_width, wall_mount_depth, floor_board_height + (wall_thickness * 2) + wall_mount_height]);
        translate([0, 0, _screw_hole_height]) union() {
            translate([side_wall_width / 2, wall_mount_depth, screw_hole_length]) rotate([90, 0, 0]) color("orange") cylinder(d=screw_hole_upper_diameter, h=wall_mount_depth);
            translate([(side_wall_width / 2) - (screw_hole_upper_diameter / 2), 0, 0]) cube([screw_hole_upper_diameter, wall_mount_depth, screw_hole_length]);
            translate([side_wall_width / 2, wall_mount_depth, 0]) rotate([90, 0, 0]) cylinder(d=screw_hole_lower_diameter, h=wall_mount_depth);
        }
    }
    
    translate([total_depth / 2, side_wall_width, logo_bottom_offset]) {
        resize([total_depth - logo_depth_difference, 0, 35])
        rotate([90, 0, 0]) {
            union() {
                translate([0, 0, 0]) linear_extrude(height=side_wall_width - centerlogo_color_offset) import("heart-icon.svg", center=true);
                translate([0, 0, 0]) linear_extrude(height=side_wall_width - (2 * centerlogo_color_offset)) import("infinity.svg", center=true);
            }
        }
    }
}
