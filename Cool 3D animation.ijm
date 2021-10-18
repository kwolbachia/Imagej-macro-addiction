
//makes the same 3D animation than Andy Moore there : https://twitter.com/aaandmoore/status/1450089224452063236?s=20

//two next lines only for demo:
run("Confocal Series");
run("Properties...", "voxel_depth=0.3544550");

macro "Cool 3D montage" {
	setBatchMode(1);
	setBackgroundColor(0,0,0);
	getDimensions(width, height, channels, slices, frames);
	size = maxOf(width, height);
	id=getImageID();
	run("3D Project...", 	"projection=[Brightest Point] axis=Y-Axis initial=0 total=360 rotation=10 interpolate");
		run("Canvas Size...", "width=&size height=&size position=Center zero");
		rename("3D1");
	selectImage(id);
	run("3D Project...", 	"projection=[Brightest Point] axis=X-Axis initial=0 total=360 rotation=10 interpolate");
		run("Canvas Size...", "width=&size height=&size position=Center zero");
		rename("3D2");
	selectImage(id);
	run("Duplicate...","duplicate");
	run("Reslice [/]...", "output=0.354 start=Left");
	id=getImageID();
	run("3D Project...", 	"projection=[Brightest Point] axis=Y-Axis initial=0 total=360 rotation=10 interpolate");
		run("Canvas Size...", "width=&size height=&size position=Center zero");
		rename("3D3");
	selectImage(id);
	run("3D Project...", 	"projection=[Brightest Point] axis=X-Axis initial=0 total=360 rotation=10 interpolate");
		run("Canvas Size...", "width=&size height=&size position=Center zero");
		rename("3D4");
		top = Combine_Horizontally("3D2","3D1");
		bottom =  Combine_Horizontally("3D4","3D3");
		Combine_Vertically(top,bottom);
	setBatchMode(0);
}

function Combine_Horizontally(stack1,stack2){ //returns result image title
run("Combine...", "stack1=&stack1 stack2=&stack2");
rename(stack1+"_"+stack2);
return getTitle();
}

function Combine_Vertically(stack1,stack2){
run("Combine...", "stack1=&stack1 stack2=&stack2 combine"); //vertically
rename(stack1+"_"+stack2);
return getTitle();
}
