include <../OpenSCAD_Lib/MakeInclude.scad>

$fa=0.2;

module itemModule()
{
	difference()
	{
		cylinder(d=30, h=60);

		translate([-30/2-1.7,0,0]) rotate([0,90-50,0]) rotate([0,0,30]) tcy([0,0,-10], d=4, h=100, $fn=6);

		translate([0,0,20]) rotate([0,-50,0]) 
		{
			tcy([0,0,0], d=3, h=100);
			tcy([0,0,13], d=6, h=100);
			translate([0,0,3+nothing]) cylinder(d2=6, d1=0, h=10);
		}
	}
}

module clip(d=0)
{
	// tc([-200, -400-d, -10], 400);
	rotate([0,90-50,0]) tcu([-200, -200, 30], 400);
}

if(developmentRender)
{
	display() itemModule();
}
else
{
	itemModule();
}
