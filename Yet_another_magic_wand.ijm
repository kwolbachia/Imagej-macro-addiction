macro "Another better wand (drag to adjust tolerance) Tool - N55C444Da2Db3Dc4Dc5Dd6C009C950D87C03fC36fD72D73D82D83D84D92D93D94D95D96D97Da3Da4Da5Da6Da7Da8Da9DabDacDadDaeDb4Db5Db6Db7Db8Db9DbbDbcDc6Dc7Dc9DcaDcbDd9DdbDdeDebDedDeeCfc0DbdDbeDc8DccDcdDceDd7DdaDdcDddDe8De9DecC05fD63D64D74D75D85D86D88D89D8cD8dD8eD98D99D9aD9bD9cD9dD9eDaaDbaCfa3Dd8DeaBf0C444D0aD1bD2cD2dD3eC009C950C03fC36fD0bD0cD0eD1cD1dD1eD2eCfc0D09D0dC05fCfa3B0fC444D30D41D42D43C009D06D16D26D36D46D47C950C03fD04D05D07D14D15D17D24D25D27D34D35D37D44D45D54D55D56D57D65D66C36fD00D01D03D10D11D12D13D20D21D22D31Cfc0D02D23D32D33C05fCfa3Nf0C444C009D77D78D87D97Da7Db7Dc6Dc7Dd6De6C950D64D65D72D73D75D82C03fD48D57D58D59D66D67D68D69D76D79D86D88D89D95D96D98Da5Da6Da8Db5Db6Db8Dc5Dc8Dd4Dd5Dd7De4De5De7C36fD91D92D93D94Da1Da2Da3Da4Db3Db4Dc4Dd0Dd1De0De1De2Cfc0Db0Dc0Dc1Dc2Dd2C05fD71D74D80D81D83D84D85D90Cfa3Da0Db1Db2Dc3Dd3De3"{
	magicWand();
}

macro "Another better wand (drag to adjust tolerance) Tool Options" {
	if (isKeyDown("shift")) {
		roiManager("Add");
		exit;
	}
	targetSize = getNumber("roi size (in pixels number) to target upon click", nPixels);
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
