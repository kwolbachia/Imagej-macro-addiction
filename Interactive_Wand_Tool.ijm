// 12/12/2022
// K. Terretaz

//For wand tool
var tolerance = 0;
var box_size = 5;
var add_to_manager = 0;
var tolerance_threshold = 40;
var exponent = 2;
var fit = "None";


/* Reminder for getCursorLoc Flags : 
	 * shift = +1
	 * ctrl = +2
	 * cmd = +4 (Mac)
	 * alt = +8
	 * middle click is just 8
	 * leftClick = +16
	 * cursor over selection = +32
	 * So e.g. if (leftclick + alt) Flags = 24
*/

macro "Another wand (drag to adjust tolerance) Tool - N55C444Da2Db3Dc4Dc5Dd6C009C950D87C03fC36fD72D73D82D83D84D92D93D94D95D96D97Da3Da4Da5Da6Da7Da8Da9DabDacDadDaeDb4Db5Db6Db7Db8Db9DbbDbcDc6Dc7Dc9DcaDcbDd9DdbDdeDebDedDeeCfc0DbdDbeDc8DccDcdDceDd7DdaDdcDddDe8De9DecC05fD63D64D74D75D85D86D88D89D8cD8dD8eD98D99D9aD9bD9cD9dD9eDaaDbaCfa3Dd8DeaBf0C444D0aD1bD2cD2dD3eC009C950C03fC36fD0bD0cD0eD1cD1dD1eD2eCfc0D09D0dC05fCfa3B0fC444D30D41D42D43C009D06D16D26D36D46D47C950C03fD04D05D07D14D15D17D24D25D27D34D35D37D44D45D54D55D56D57D65D66C36fD00D01D03D10D11D12D13D20D21D22D31Cfc0D02D23D32D33C05fCfa3Nf0C444C009D77D78D87D97Da7Db7Dc6Dc7Dd6De6C950D64D65D72D73D75D82C03fD48D57D58D59D66D67D68D69D76D79D86D88D89D95D96D98Da5Da6Da8Db5Db6Db8Dc5Dc8Dd4Dd5Dd7De4De5De7C36fD91D92D93D94Da1Da2Da3Da4Db3Db4Dc4Dd0Dd1De0De1De2Cfc0Db0Dc0Dc1Dc2Dd2C05fD71D74D80D81D83D84D85D90Cfa3Da0Db1Db2Dc3Dd3De3"{
	getCursorLoc(x, y, z, flags);
	if (flags>=32) flags -= 32; //remove "cursor in selection" flag
	if (add_to_manager){
		run("ROI Manager...");
		roiManager("show all without labels");
	}
	if (flags == 40) { //middle click on selection
		roiManager("Add"); 
		exit;
	}
	if (flags == 16) { //left click
		adjust_Tolerance();
		if (add_to_manager)	{
			roiManager("Add");
		}
	}
	if (fit != "None"){
		run(fit);
		getSelectionCoordinates(xpoints, ypoints);
		makeSelection(4, xpoints, ypoints);
	}
	wait(30);
}

macro "Another wand (drag to adjust tolerance) Tool Options" {
	Dialog.createNonBlocking("Interactive magic wand tool");
	Dialog.addMessage("Click and drag to adjust wand tolerance\n"+
		"Middle click on a selection adds it to ROI Manager");
	Dialog.addRadioButtonGroup("Fit selection? How?", newArray("None","Fit Spline","Fit Ellipse"), 1, 3, fit);
	Dialog.addNumber("Maxima window size", box_size);
	Dialog.addSlider("tolerance estimation threshold", 0, 100, tolerance_threshold);
	Dialog.addSlider("exponent for adjustment value", 1, 2, exponent);
	Dialog.addCheckbox("auto add ROI to manager?", add_to_manager);	
	Dialog.show();
	fit =					Dialog.getRadioButton();
	box_size =				Dialog.getNumber();
	tolerance_threshold =	Dialog.getNumber();
	exponent =				Dialog.getNumber();
	add_to_manager =		Dialog.getCheckbox();
}

function adjust_Tolerance() {
	getCursorLoc(x2, y2, z, flags); //origin
	getCursorLoc(x, y, z, flags);
	if (flags>=32) flags -= 32; //remove "cursor in selection" flag
	zoom = getZoom();
	tolerance = estimateTolerance();
	while (flags >= 16) {
		getCursorLoc(x, y, z, flags);
		if (flags>=32) flags -= 32; //remove "cursor in selection" flag

		// adjust tolerance value acording to distance of mouse from origin
		distance = (x*zoom - x2*zoom);
		if (distance < 0) newTolerance = tolerance - pow(abs(distance), exponent);
		else newTolerance = tolerance + pow(abs(distance), exponent);
		if (newTolerance < 0) newTolerance = 0;
		showStatus(newTolerance);
		doWand(x2, y2, newTolerance, "Legacy");
		wait(30);
	}
}

function estimateTolerance(){
	run("Select None");
	setBatchMode(1);
	getCursorLoc(x, y, z, flags);
	makeRectangle(x-(box_size/2), y-(box_size/2), box_size, box_size);
	getStatistics(area, mean, min, max, std, histogram);;
	tolerance = (tolerance_threshold / 100) * max;
	return tolerance;
}
