/* Kevin Terretaz @kWolbachia 14/11/2021
* normal click to move easily images windows
* shift + click to adjust min and max contrast 
* ctrl or cmd + click to adjust gamma on the LUT, not on pixels
* alt + click to navigate slices or frames in stacks
* room for anything you want to add!
* No licence
*/

var mainTool = "Move Windows";
var middleClick = 0;
var live_autoContrast = 0;
var enhance_rate = 0.03;
var toolList = newArray("Move Windows",	"Contrast Adjuster", "Gamma on LUT", "slice / frame scroll" );

macro "Multitool Tool - N55C000DdeCf00Db8Db9DbaDc7Dc8DcaDcbDd7DdbDe7De8DeaDebCfffDc9Dd8Dd9DdaDe9C777D02D11D12D17D18D21D28D2bD31D36D39D3aD3bD3eD41D42D46D47D4cD4dD4eD51D52D57D5bD5dD62D63D67D6dD72D73D74D75D76D77D83D85D86D94Cf90Da6Da7Da8Da9DaaDabDacDadDaeDb4Db5Dc4Dd4De4C444D03D19D22D29D2cD32D3cD43D4bD53D58D5eD64D68D6eD78D87Cf60D95D96D97D98D99D9aD9bD9cD9dD9eDa4Da5Db3Db6DbcDbdDbeDc3Dc5Dc6DccDcdDceDd3Dd5Dd6DdcDe3De5De6DecDedDeeC333Cf40Db7DbbDddBf0C000Cf00D08D09D0aCfffC777D13D22D23D24D32D33D35D36D37D38D39D3aD3bD42D43D46D47D48D49D4cD4dD52D53D54D58D59D5aD5dD5eD62D63D6aD6bD6cD6dD72D7cD7dD7eD82D8eD92Da2Cf90D05C444Cf60D03D04D06D0cD0dD0eD14D15D16D17D18D19D1aD1bD1cD1dD1eD25D26D27D28D29D2aD2bD2cD2dD2eC333D34D3cD3dD44D4eD64D73D83D93Da3Cf40D07D0bB0fC000D12Cf00CfffC777D50D60D61D62D70D72D73D74D80D81D82D83D84D85D86D91D92D93D94D95D96D97Da3Da4Da5Da6Da7Da8Cf90C444Cf60D00D04D05D06D09D10D18D20D21D23D24D25D26D27C333D01D02D03D40D51D52D63D64D75D76D87D98Da9Cf40D07D08D11D13D14D15D16D17D22Nf0C000Da2Dd2Dd5Cf00CfffC777D42D52D60D61D65D71D73D74D83D85D86Cf90Da0Da5Da6Db7Dc8C444D40D50D53D62D63D72D75D84Cf60D90D91D93D94D95D96D97Da1Da3Da4Da7Da8Db0Db4Db5Db6Db8Db9Dc5Dc6Dc7Dc9Dd7Dd8Dd9De5De6De7De9C333Db1Db2Db3Dc0Dc4Dd0Dd4De0De4Cf40D92Dc1Dc2Dc3Dd1Dd3Dd6De1De2De3De8" {
	multiTool();
}
macro "Multitool Tool Options" {
	Dialog.createNonBlocking("Options");
	Dialog.addRadioButtonGroup("Main Tool : ", toolList, toolList.length, 1, mainTool);
	Dialog.addCheckbox("middle click macro from clipboard", middleClick);
	Dialog.show();
	mainTool = Dialog.getRadioButton();
	middleClick =  Dialog.getCheckbox();
}

//ispired by Robert Haase Windows Position tool from clij
function multiTool(){ //avec menu "que faire avec le middle click? **"
	/*
	* flags or modificator value of getCursorLoc :
	* shift = 1;
	* ctrl = 2;
	* cmd = 4;...
	* alt = 8; middle click is just 8
	* leftClick = 16;
	* so flag of leftclick + alt = 24
	*/
	getCursorLoc(x, y, z, flags);

	//setup : 
	setupUndo();
	call("ij.plugin.frame.ContrastAdjuster.update");

	if (flags>=32) flags -= 32; //remove "cursor in selection" flag
	if (flags == 8) { //middle mouse button
		if (middleClick) eval(String.paste);
		else compositeSwitch();
	}
	if (flags == 16) {
		if 			(mainTool=="Move Windows")           moveWindows();
		else if (mainTool=="Contrast Adjuster")      liveContrast();
		else if (mainTool=="Gamma on LUT")           liveGamma();
		else if (mainTool=="slice / frame scroll")   liveScroll();
	}
	if (flags == 17)				liveContrast();					// shift + long click
	if (flags == 18 || flags == 20)	liveGamma();		// ctrl(or cmd) + long click
	if (flags == 24)				liveScroll();						// alt + long click
	updateDisplay();
}

function moveWindows() {
	getCursorLoc(x2, y2, z2, flags2);
	zoom = getZoom();
	getCursorLoc(last_x, last_y, z, flags);
	while (flags == 16) {
		getLocationAndSize(window_x, window_y, null, null);
		getCursorLoc(x, y, z, flags);
		if (x != last_x || y != last_y) {
			window_x = window_x - (x2 * zoom - x * zoom);
			window_y = window_y - (y2 * zoom - y * zoom);
			setLocation(window_x, window_y);
			getCursorLoc(last_x, last_y, z, flags);
		}
	wait(1);
	}
}

function liveContrast() {	
	if (bitDepth() == 24) exit;
	resetMinAndMax();
	getMinAndMax(min, max);
	getCursorLoc(x, y, z, flags);
	if (flags >= 32) flags -= 32; //remove "cursor in selection" flag
	while (flags >= 16) {			
		getCursorLoc(x, y, z, flags);
		getDisplayedArea(area_x, area_y, width, height);
		if (flags >= 32) flags -= 32; //remove "cursor in selection" flag
		newMax = ((x - area_x) / width) * max;
		newMin = ((height - (y - area_y)) / height) * max / 2;
		if (newMax < 0) newMax = 0;
		if (newMin < 0) newMin = 0;
		if (newMin > newMax) newMin = newMax;
		setMinAndMax(newMin, newMax);
		call("ij.plugin.frame.ContrastAdjuster.update");
		wait(10);
	}
}

function liveGamma(){
	setBatchMode(1);
	getLut(reds, greens, blues);
	setColor("white");
	setFont("SansSerif", Image.height/20, "bold antialiased");
	getCursorLoc(x, y, z, flags);
	if (flags >= 32) flags -= 32; //remove "cursor in selection" flag
	while (flags >= 16) {
		getCursorLoc(x, y, z, flags);
		getDisplayedArea(area_x, area_y, width, height);
		if (flags >= 32) flags -= 32; //remove "cursor in selection" flag
		gamma = d2s(((x - area_x) / width) * 2, 2); if (gamma < 0) gamma=0;
		gammaLUT(gamma, reds, greens, blues);
		Overlay.remove;
		Overlay.drawString("gamma = " + gamma, Image.height / 30, Image.height / 20);
		Overlay.show;
		wait(10);
	}
	setBatchMode(0);
	Overlay.remove;
	run("Select None");
}

function liveScroll() {
	getDimensions(width, height, channels, slices, frames);
	if(slices==1 && frames==1) exit;
	getCursorLoc(x, y, z, flags);
	if (flags >= 32) flags -= 32; //remove "cursor in selection" flag
	while(flags >= 16) {
		getCursorLoc(x, y, z, flags);
		getDisplayedArea(area_x, area_y, width, height);
		if (flags >= 32) flags -= 32; //remove "cursor in selection" flag
		if (frames > 1) Stack.setFrame(((x - area_x) / width) * frames);
		else 			Stack.setSlice(((x - area_x) / width) * slices);
		if (live_autoContrast) run("Enhance Contrast", "saturated=&enhance_rate");
		call("ij.plugin.frame.ContrastAdjuster.update");
		wait(10);
	}
}

//for args give gamma value, and r,g,b obtained by getLut(r,g,b) command.
function gammaLUT(gamma, r, g, b) {
	R = newArray(256); G = newArray(256); B = newArray(256); Gam = newArray(256);
	for (i=0; i<256; i++) Gam[i] = pow(i, gamma);
	scale = 255/Gam[255];
	for (i=0; i<256; i++) Gam[i] = round(Gam[i] * scale);
	for (i=0; i<256; i++) {
		j = Gam[i];
		R[i] = r[j];
		G[i] = g[j];
		B[i] = b[j];
	}
	setLut(R, G, B);
}

function compositeSwitch(){
	if (!is("composite")) exit;
	Stack.getDisplayMode(mode);
	if (mode=="color"||mode=="greyscale") {Stack.setDisplayMode("composite");}
	else {Stack.setDisplayMode("color");}
}