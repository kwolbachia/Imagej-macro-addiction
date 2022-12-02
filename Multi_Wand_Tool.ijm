// 30/11/2022 1.0
// K. Terretaz
//gaussian fit code from jerome Mutterer
var tolerance = 0;
var fit = "None";
var box_size = 8;
var enlarge_point = 2;

macro "Another wand (drag to adjust tolerance) Tool - N55C444Da2Db3Dc4Dc5Dd6C009C950D87C03fC36fD72D73D82D83D84D92D93D94D95D96D97Da3Da4Da5Da6Da7Da8Da9DabDacDadDaeDb4Db5Db6Db7Db8Db9DbbDbcDc6Dc7Dc9DcaDcbDd9DdbDdeDebDedDeeCfc0DbdDbeDc8DccDcdDceDd7DdaDdcDddDe8De9DecC05fD63D64D74D75D85D86D88D89D8cD8dD8eD98D99D9aD9bD9cD9dD9eDaaDbaCfa3Dd8DeaBf0C444D0aD1bD2cD2dD3eC009C950C03fC36fD0bD0cD0eD1cD1dD1eD2eCfc0D09D0dC05fCfa3B0fC444D30D41D42D43C009D06D16D26D36D46D47C950C03fD04D05D07D14D15D17D24D25D27D34D35D37D44D45D54D55D56D57D65D66C36fD00D01D03D10D11D12D13D20D21D22D31Cfc0D02D23D32D33C05fCfa3Nf0C444C009D77D78D87D97Da7Db7Dc6Dc7Dd6De6C950D64D65D72D73D75D82C03fD48D57D58D59D66D67D68D69D76D79D86D88D89D95D96D98Da5Da6Da8Db5Db6Db8Dc5Dc8Dd4Dd5Dd7De4De5De7C36fD91D92D93D94Da1Da2Da3Da4Db3Db4Dc4Dd0Dd1De0De1De2Cfc0Db0Dc0Dc1Dc2Dd2C05fD71D74D80D81D83D84D85D90Cfa3Da0Db1Db2Dc3Dd3De3"{
	if (isKeyDown("shift")) gaussian_Fit_2D_Tool();
	else magicWand();
}

macro "Another wand (drag to adjust tolerance) Tool Options" {
	Dialog.createNonBlocking("Interactive magic wand tool");
	Dialog.addMessage("Click and drag to adjust wand tolerance\n"+
		"Middle click will do wand with last used tolerance\n"+
		"Middle click on a selection adds it to ROI Manager \n"+
		"Hold shift for gaussian fit dot segmentation");
	Dialog.addRadioButtonGroup("Fit selection? How?", newArray("None","Fit Spline","Fit Ellipse"), 1, 3, fit);Dialog.addNumber("gaussian fit window size", box_size);
	Dialog.addNumber("selection radius after gaussian fit", enlarge_point);		
	Dialog.show();
	fit = Dialog.getRadioButton();
	box_size = Dialog.getNumber();
	enlarge_point = Dialog.getNumber();
}

function magicWand() {
	getCursorLoc(x, y, z, flags);
	if (flags == 40) { //middle click on selection
		roiManager("Add"); 
		Overlay.addSelection("green");
		exit;
	} 
	run("Select None");
	doWand(x,y,tolerance, "8-connected"); //middle click to just do wand with last set tolerance
	while (flags >= 16) {
		getCursorLoc(x1, y1, z, flags);
		tolerance = 0.4 * sqrt((x1-x)*(x1-x) + (y1-y)*(y1-y));
		tolerance = pow(tolerance, 2);
		doWand(x, y, tolerance, "8-connected");
		showStatus(tolerance);
		if (flags==32) flags = 0; //ignore the flag "cursor on selection"
		wait(30);
	}
	if (fit != "None"){
		run(fit);
		getSelectionCoordinates(xpoints, ypoints);
		makeSelection(4, xpoints, ypoints);
	}
}

function gaussian_Fit_2D_Tool() {
	setBatchMode(1);
	getCursorLoc(x, y, z, flags);
	while (flags >= 16) {
		Overlay.remove;
		getCursorLoc(x, y, z, flags);
		makeRectangle(x-(box_size/2),y-(box_size/2),box_size,box_size);
		Overlay.addSelection("magenta");
		makePoint(x-(box_size/2) + gaussianFit(true), y-(box_size/2) + gaussianFit(false), "large orange circle");
		wait(10);
	}
	Overlay.remove;
	run("Enlarge...", "enlarge=&enlarge_point pixel");
}

function gaussianFit(horizontal) {
	if (!horizontal) setKeyDown("alt");
	k = getProfile();
	setKeyDown("none");
	Fit.doFit("Gaussian", Array.getSequence(k.length), k);
	return Fit.p(2);
}


