min_T = 5;                // minimum wall thickness of part

zip_T = 2;                // zip tie thickness
zip_W = 5;                // zip tie width

cable_D = 8;              // cable diameter

chm = 2;                  // chamfer size, hypotenuse
chm_leg = chm/sqrt(2);    // chamfer leg size, leg

inside_X = 110;           // inside space of psu, x distance
wall_T = 1.5;             // sheet metal wall thickness

Y1 = 21;                  // y distance protuding from front of psu
Y2 = 18.5;                // y distance protuding into psu, over the top of terminals

Z1 = 25;                  // z distance above terminals to top of psu
Z2 = 50;                  // thickness of psu

b_SD = 2.8;               // bolt shaft diameter, interference fit
b_SL = 12;                // bolt shaft length

b1_Y = 7;               // bolt hole 1 Y placement, from front of psu
b1_Z = 15.5;              // bolt hole 1 Z placement, from top of psu

b2_Y = 14;                // bolt hole 2 Y placement, from front of psu
b2_Z = b1_Z;              // bolt hole 2 Z placement, from top of psu

difference(){
  // body solid
  hull(){
    translate([chm_leg, chm_leg, chm_leg])
    cylinder(r = chm_leg, h = Y1 + Y2 - chm_leg, $fn = 4);
    
    translate([inside_X + 2*wall_T - chm_leg, chm_leg, chm_leg])
    cylinder(r = chm_leg, h = Y1 + Y2 - chm_leg, $fn = 4);
    
    translate([chm_leg, Z2 - chm_leg, chm_leg])
    cylinder(r = chm_leg, h = Y1 + Y2 - chm_leg, $fn = 4);
    
    translate([inside_X + 2*wall_T - chm_leg, Z2 - chm_leg, chm_leg])
    cylinder(r = chm_leg, h = Y1 + Y2 - chm_leg, $fn = 4);
    
    translate([chm_leg, chm_leg, chm_leg])
    rotate([0, 90, 0])
    cylinder(r = chm_leg, h = inside_X + 2*wall_T - 2*chm_leg, $fn = 4);
    
    translate([chm_leg, Z2 - chm_leg, chm_leg])
    rotate([0, 90, 0])
    cylinder(r = chm_leg, h = inside_X + 2*wall_T - 2*chm_leg, $fn = 4);
    
    translate([chm_leg, chm_leg, chm_leg])
    rotate([-90, 0, 0])
    cylinder(r = chm_leg, h = Z2 - 2*chm_leg, $fn = 4);
    
    translate([inside_X + 2*wall_T - chm_leg, chm_leg, chm_leg])
    rotate([-90, 0, 0])
    cylinder(r = chm_leg, h = Z2 - 2*chm_leg, $fn = 4);
  }
  
  //color("grey", 0.2)
  //cube([inside_X + 2*wall_T, Z2, Y1 + Y2]);
  
  
  // wall sections
  translate([-0.1, -0.1, Y1])
  cube([wall_T + 0.1, Z2 + 0.2, Y1 + Y2 + 0.1]);
  
  translate([inside_X + wall_T, -0.1, Y1])
  cube([wall_T + 0.1, Z2 + 0.2, Y1 + Y2 + 0.1]);
  
  // channel
  translate([-0.1, Z1, min_T])
  cube([inside_X + 2*wall_T - min_T + 0.1, Z2 - Z1 - min_T, Y1 + Y2 - min_T + 0.1]);
  
  // zip tie holes
  translate([min_T, Z2 - min_T - (Z2 - Z1 - min_T)/2 + cable_D/2, -0.1])
  cube([zip_W, zip_T, min_T + 0.2]);
  
  translate([min_T, Z2 - min_T - (Z2 - Z1 - min_T)/2 - cable_D/2 - zip_T, -0.1])
  cube([zip_W, zip_T, min_T + 0.2]);
  
  translate([zip_W + min_T, 0, 0]){
    translate([min_T, Z2 - min_T - (Z2 - Z1 - min_T)/2 + cable_D/2, -0.1])
    cube([zip_W, zip_T, min_T + 0.2]);
    
    translate([min_T, Z2 - min_T - (Z2 - Z1 - min_T)/2 - cable_D/2 - zip_T, -0.1])
    cube([zip_W, zip_T, min_T + 0.2]);
  }
  
  // other
  translate([-0.1, Z1, Y1])
  cube([inside_X + 2*wall_T + 0.2, Z2 - Z1 + 0.1, Y2 + 0.1]);
  
  // holes
  translate([wall_T - 0.1, b1_Z, Y1 + b1_Y])
  rotate([0, 90, 0])
  cylinder(d = b_SD, h = b_SL + 0.1, $fn = 32);
  
  translate([wall_T - 0.1, b2_Z, Y1 + b2_Y])
  rotate([0, 90, 0])
  cylinder(d = b_SD, h = b_SL + 0.1, $fn = 32);
  
  translate([inside_X + wall_T + 0.1, b1_Z, Y1 + b1_Y])
  rotate([0, -90, 0])
  cylinder(d = b_SD, h = b_SL + 0.1, $fn = 32);
  
  translate([inside_X + wall_T + 0.1, b2_Z, Y1 + b2_Y])
  rotate([0, -90, 0])
  cylinder(d = b_SD, h = b_SL + 0.1, $fn = 32);
  
}