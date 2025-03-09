include <../OpenSCAD_Lib/MakeInclude.scad>

bladeX = 60.8;
bladeAngleX = 14;
bladeY = 0.65;
bladeZ = 19.1;
bladeNotchCtrs = 6.27;
bladeNotchX = 3.25;
bladeNotchZ = 3.9;

baseX = 25;

bladeExposure = 1.5;

module itemModule()
{
	difference()
	{
		cube([baseX,25,bladeX+1-bladeExposure]);
		translate([baseX-1,-5+1,-bladeExposure]) rotate([0,-90,0]) blade(t=5);
	}
}

module blade(t=bladeY)
{
  points = [
    [0, 0],
    [bladeAngleX, bladeZ],
    [bladeX-bladeAngleX, bladeZ],
    [bladeX, 0]
  ];
  echo(str("points = ", points));
  echo(str("t = ", t));
  translate([0,t,0]) difference()
  {
    rotate(90,[1,0,0]) linear_extrude(height=t) polygon(points);
    bladeNotch( bladeNotchCtrs/2, t);
    bladeNotch(-bladeNotchCtrs/2, t);
  }
}

module bladeNotch(dx, t)
{
  translate([bladeX/2+dx, -t/2+1, bladeZ+1])
  {
    translate([0, -t/2-1, -1+bladeNotchX/2-bladeNotchZ])
    {
      rotate(-90, [1,0,0]) cylinder(d=bladeNotchX, h=t+2);
      translate([-bladeNotchX/2,0,0]) cube([bladeNotchX, t, bladeNotchZ]);
    }
  }
}

module clip(d=0)
{
	//tc([-200, -400-d, -10], 400);
}

if(developmentRender)
{
	display() itemModule();
}
else
{
  rotate([-90,0,0]) itemModule();
}
