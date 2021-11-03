/*
Kévin Terretaz @kWolbachia
double clic on the tool to get the imageJ LUTs montage : run("Display LUTs")
select the image which you want to set the LUT by clicking on it (it should blink in orange)
then just click on the LUT you want on the montage.
Also, if you click with the tool on another rgb image, it will make a linear LUT from the rgb pixel color
*/
macro "set LUT from montage Tool - N55C000D37D38D39CfffD00D01D02D03D04D05D06D07D08D09D0aD0bD0cD0dD0eD10D11D12D13D14D15D16D17D18D19D1aD1bD1cD1dD1eD20D21D22D23D24D25D26D27D28D29D2aD2bD2cD2dD2eD30D31D32D36D3aD3eD40D41D42D46D4aD4eD50D51D52D56D5aD5eD60D61D62D66D6aD6eD70D71D72D76D7aD7eD80D81D82D86D8aD8eD90D91D92D96D9aD9eDa0Da1Da2Da6DaaDaeDb0Db1Db2Db6DbaDbeDc0Dc1Dc2Dc6DcaDceDd0Dd1Dd2Dd6DdaDdeDe0De1De2De6DeaDeeC338C047Db7Db8Db9C557D73D74D75D83D84D85C500D5bD5cD5dC198Ce50Cb87C024D77D78D79C278Cd51DdbDdcDddC438Cb00D9bD9cD9dC18cCfb3Cda7C100D3bD3cD3dC158Dd7Dd8Dd9C157Dc7Dc8Dc9C877Db3Db4Db5Dc3Dc4Dc5C900C3b7Ce82Cc97C013D33D34D35C17aCaf3C448Cd30DbbDbcDbdC1dcCfb4Cfd8C012D57D58D59C358C347D53D54D55C667D93D94D95C800D7bD7cD7dC2a8Ce71DebDecDedC49fC035D97D98D99C288Ccd1Ca87De3De4De5Cb10C19dCee1Cfb7C300D4bD4cD4dC368C8d4C977Dd3Dd4Dd5C427C1eaCfa3Cd97C406C18bCce3C47fCd40DcbDccDcdC1afCfc6CfebC011D47D48D49C457D63D64D65C247D43D44D45C600D6bD6cD6dC298Cf61C4f7C034D87D88D89C169De7De8De9C9d3Cc00DabDacDadC19dCed3Cea7C022D67D68D69C268C6c5Ca00D8bD8cD8dC4b7Cf92C045Da7Da8Da9C8f5C46dC2ceCfb5C667Da3Da4Da5Bf0C000CfffD00D01D02D06D0aD0eD10D11D12D16D1aD1eD20D21D22D26D2aD2eD30D31D32D36D3aD3eD40D41D42D46D4aD4eD50D51D52D56D5aD5eD60D61D62D66D6aD6eD70D71D72D76D7aD7eD80D81D82D83D84D85D86D87D88D89D8aD8bD8cD8dD8eD90D91D92D93D94D95D96D97D98D99D9aD9bD9cD9dD9eDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDacDadDaeC338C047C557C500C198Ce50Cb87D13D14D15C024C278Cd51C438Cb00C18cD37D38D39Cfb3Cda7D43D44D45C100C158C157C877C900C3b7Ce82D0bD0cD0dCc97D23D24D25C013C17aD07D08D09D17D18D19Caf3C448Cd30C1dcCfb4D2bD2cD2dCfd8D5bD5cD5dC012C358C347C667C800C2a8Ce71C49fC035C288Ccd1Ca87D03D04D05Cb10C19dD57D58D59Cee1Cfb7D63D64D65D73D74D75C300C368C8d4C977C427C1eaCfa3Cd97D33D34D35C406C18bD27D28D29Cce3C47fCd40C1afD67D68D69D77D78D79Cfc6D4bD4cD4dCfebD6bD6cD6dD7bD7cD7dC011C457C247C600C298Cf61C4f7C034C169C9d3Cc00C19dD47D48D49Ced3Cea7D53D54D55C022C268C6c5Ca00C4b7Cf92D1bD1cD1dC045C8f5C46dC2ceCfb5D3bD3cD3dC667B0fC000CfffD03D07D08D09D0aD13D17D18D19D1aD23D27D28D29D2aD33D37D38D39D3aD43D47D48D49D4aD53D57D58D59D5aD63D67D68D69D6aD73D77D78D79D7aD80D81D82D83D84D85D86D87D88D89D8aD90D91D92D93D94D95D96D97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaC338C047C557C500C198Ce50D30D31D32Cb87C024C278Cd51C438Cb00C18cCfb3D00D01D02Cda7C100C158C157C877C900D60D61D62D70D71D72C3b7D04D05D06Ce82Cc97C013C17aCaf3C448Cd30D40D41D42C1dcCfb4Cfd8C012C358C347C667C800C2a8Ce71C49fC035C288Ccd1D54D55D56Ca87Cb10D50D51D52C19dCee1D64D65D66D74D75D76Cfb7C300C368C8d4D34D35D36C977C427C1eaCfa3D10D11D12Cd97C406C18bCce3C47fCd40C1afCfc6CfebC011C457C247C600C298Cf61D20D21D22C4f7C034C169C9d3D44D45D46Cc00C19dCed3Cea7C022C268C6c5D24D25D26Ca00C4b7D14D15D16Cf92C045C8f5C46dC2ceCfb5C667Nf0C000CfffD00D01D02D03D04D05D06D07D08D09D0aD10D11D12D13D14D15D16D17D18D19D1aD20D21D22D23D24D25D26D27D28D29D2aD33D37D38D39D3aD43D47D48D49D4aD53D57D58D59D5aD63D67D68D69D6aD73D77D78D79D7aD83D87D88D89D8aD93D97D98D99D9aDa3Da7Da8Da9DaaDb3Db7Db8Db9DbaDc3Dc7Dc8Dc9DcaDd3Dd7Dd8Dd9DdaDe3De7De8De9DeaC338D30D31D32C047C557C500C198Dd4Dd5Dd6Ce50Cb87C024C278Da4Da5Da6Cd51C438D54D55D56Cb00C18cCfb3Cda7C100C158C157C877C900C3b7Ce82Cc97C013C17aCaf3Dc0Dc1Dc2C448D64D65D66Cd30C1dcD80D81D82Cfb4Cfd8C012C358D74D75D76C347C667C800C2a8De4De5De6Ce71C49fD60D61D62C035C288Db4Db5Db6Ccd1Ca87Cb10C19dCee1Cfb7C300C368D84D85D86C8d4C977C427D44D45D46C1eaD90D91D92Cfa3Cd97C406D34D35D36C18bCce3Dd0Dd1Dd2C47fD50D51D52Cd40C1afCfc6CfebC011C457C247C600C298Dc4Dc5Dc6Cf61C4f7Da0Da1Da2C034C169C9d3Cc00C19dCed3De0De1De2Cea7C022C268D94D95D96C6c5Ca00C4b7Cf92C045C8f5Db0Db1Db2C46dD40D41D42C2ceD70D71D72Cfb5C667" 	{
	folderLUTs = getDirectory("luts");
	all_LUTs = getFileList(folderLUTs);
	title = getTitle();
	if (bitDepth()!=24 && title!="Lookup Tables")		setTargetImage();
	else if (bitDepth()==24 && title!="Lookup Tables")	rgbPixel2LUT();
	else {
		getCursorLoc(x, y, z, modifiers);
		rows = getInfo("xMontage");
		lines = getInfo("yMontage");
		YblocSize = Image.height/lines;
		XblocSize = Image.width/rows;
		index = 0;
		linePosition = floor(y/YblocSize);
		rowPosition = floor(x/XblocSize);
		index = (linePosition*rows)+rowPosition;
		targetImage=call("ij.Prefs.get","Destination.title","");
		if (isOpen(targetImage)){
			selectWindow(targetImage);
			open(folderLUTs + all_LUTs[index]);
		}
		else {
			newImage(all_LUTs[index], "8-bit ramp", 256, 32, 1);
			open(folderLUTs + all_LUTs[index]);
		}
		showStatus("LUT = " + all_LUTs[index]);
	}
}

macro "set LUT from montage Tool Options" {
	displayLUTs();
}

function setTargetImage() {
	showStatus("Target image = "+ getTitle(), "flash image orange 200ms");
	call("ij.Prefs.set","Destination.title",getTitle());
}

function rgbPixel2LUT() {
	getCursorLoc(x, y, z, modifiers);
	c = getPixel(x, y);
	r = (c>>16)&0xff; 	g = (c>>8)&0xff; b = c & 0xff; //black magic...
	targetImage=call("ij.Prefs.get","Destination.title","");
	if (isOpen(targetImage)){
		selectWindow(targetImage);
		LUTmaker(r,g,b);
	}
	showStatus("LUT = " + r + "," + g+ "," + b);
}

function LUTmaker(r,g,b) {
	R = newArray(256); G = newArray(256); B = newArray(256);
	for(i=0; i<256; i++) { 
		R[i] = (r/256)*(i+1);
		G[i] = (g/256)*(i+1);
		B[i] = (b/256)*(i+1);
	}
	setLut(R, G, B);
}

//adapted from https://imagej.nih.gov/ij/macros/Show_All_LUTs.txt
//the "display LUTs" function caused problems with some lut names.
function displayLUTs(){
	saveSettings();
	lutdir=getDirectory("luts");
	list = getFileList(lutdir);
	setBatchMode(true);
	newImage("ramp", "8-bit Ramp", 256, 32, 1);
	newImage("luts", "RGB White", 256, 48, 1);
	count = 0;
	setForegroundColor(255, 255, 255);
	setBackgroundColor(255, 255, 255);
	for (i=0; i<list.length; i++) {
	  if (endsWith(list[i], ".lut")) {
	      selectWindow("ramp");
	      open(lutdir+list[i]);
	      run("Copy");
	      selectWindow("luts");
	      makeRectangle(0, 0, 256, 32);
	      run("Paste");
	      setJustification("center");
	      setColor(0,0,0);
	      setFont("Arial", 12, "bold");
	      //drawString(list[i],128, 48, "Black");
	      drawString(list[i], 128, 48);
	      run("Add Slice");
	      run("Select All");
	      run("Clear", "slice");
	      count++;
	  }
	}
	run("Delete Slice");
	rows = floor(count/5);
	if (rows<count/5) rows++;
	run("Canvas Size...", "width=258 height=50 position=Center");
	run("Make Montage...", "columns=5 rows="+rows+" scale=1 first=1 last="+count+" increment=1 border=0 use");
	rename("Lookup Tables");
	setBatchMode(false);
	restoreSettings();
}
