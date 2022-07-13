diameter = 100;
line_width = 0.5;
mesh_depth = 0.8;
mesh_spacing = 0.25;
frame_thickness = 4;
frame_height = 16;

module frame() {
	rotate_extrude($fn=180) translate([-diameter/2,0,0]) {
		polygon([[0,0],
			[-frame_thickness/2,0],
			[-frame_thickness/2,frame_thickness/2],
			[-frame_thickness,frame_thickness],
			[-frame_thickness,frame_height],
			[-frame_thickness/1.8,frame_height],
			[-frame_thickness/1.8,frame_height-frame_thickness/2],
			[0,frame_height-frame_thickness/2]]);
	}
}

module mesh() {
	linear_extrude(mesh_depth/2) {
		intersection() {
			union() {
				for (i = [-diameter/2:line_width+mesh_spacing:diameter/2]) {
					translate([-diameter/2,i,0]) square([diameter, line_width]);
				}
			}
			circle(d=diameter+frame_thickness/2, $fn=180);
		}
	}
}

module solid_bottom() {
	linear_extrude(mesh_depth*2) {
		circle(d=diameter+frame_thickness/2, $fn=180);
	}
}


frame();
// mesh();
// translate([0,0,mesh_depth/2]) rotate([0,0,90]) mesh();
solid_bottom();
