macro "Another better wand (drag to adjust tolerance) Tool - C000 T0509w  T7509a  Tc509n Th509d"{
	magicWand();
}

macro "Another better wand (drag to adjust tolerance) Tool Options" {
	if (isKeyDown("shift")) {
		roiManager("Add");
		exit;
	}
	targetSize = getNumber("roi size to target on short click in pixels", nPixels);
}

var targetSize = 500;
var tolerance = 100;
var nPixels = 500;

function magicWand() {
	getCursorLoc(x2, y2, z2, flags2);
	getCursorLoc(x, y, z, flags);
	if (flags == 40) {roiManager("Add"); exit;}
	zoom = getZoom();
	factor = 2;
	newTolerance = tolerance;
	run("Select None");
	estimateTolerance();
	getMinAndMax(min, max);
	while (flags >= 16) {
		getCursorLoc(x, y, z, flags);
		if (flags==32) flags = 0; //ignore the flag "cursor on selection"
		newTolerance = tolerance + (x*zoom-x2*zoom) * factor;
		run("Wand Tool...", "tolerance=&newTolerance mode=Legacy");
		wait(30);
	}
	tolerance = newTolerance;
	getRawStatistics(nPixels);
	showStatus("pixels number = "+nPixels);
}

function estimateTolerance(){
	getCursorLoc(x, y, z, modifiers);
	tolerance = 0;
	doWand(x,y);
	getMinAndMax(min, max);
	getRawStatistics(nPixels);
	while (nPixels<=targetSize) {
		tolerance += 70;
		run("Wand Tool...", "tolerance=&tolerance");
		getRawStatistics(nPixels);
		if (tolerance > max) exit;
	}
}
