//Kevin Terretaz
//StartupMacros perso
//210411 SplitView2.0! en 12h...
//210515 Splitview 3.0, invertable LUTs
//210922 100 macros -> functions instead

var chosen_LUTs = newArray("kb","ko","km","kg","Grays");
var ChLabels = newArray("CidB","CidA","DNA","H4Ac","DIC");
var fontS = 30;
var tile = newArray(1);
var channels = 1;

//------SHORTCUTS
var ShortcutsMenu = newMenu("Custom Menu Tool",
	newArray("Max from virtual stack","Specify...","Note in infos","Remove Overlay","Rotate 90 Degrees Right","Rotate 90 Degrees Left","Plot Z-axis Profile","make my LUTs","-","Gaussian Blur...","Gaussian Blur 3D...","Gamma...",
		 "-","Start CLIJ2-Assistant","test all Z project", "test CLAHE options","Tempo color no Zproject","-","Batch convert ims to tif","Batch convert 32 to 16-bit",
		 "-","Neuron (5 channels)","HeLa Cells (48-bit RGB)","Fluorescent Cells", "Confocal Series","Mitosis (5D stack)","M51 Galaxy (16-bits)",
		 "-","invertedOverlay2","invertableLUTs_Bar","CB_Bar","JeromesWheel","RGBtimeIsOver"));
macro "Custom Menu Tool - C000D16D17D18D19D24D25D26D27D33D34D35D36D42D43D44D52D53D5bD5cD61D69D6aD6cD6dD6eD74D78D79D7bD7cD7dD7eD81D87D88D8aD8bD8cD8dD8eD91D9bD9cD9dD9eDaaDabDacDadDbaDbbDbcDbdDc8Dc9DcaDcbDccDd7Dd8Dd9DdaDdbDe6De7De8De9C000D28D54D71D7aD9aDb9Dc7Dd6C000D45Db2C000D15D1aD51D5eDa1De5DeaC000D29D5dDaeC000Da2C000D23D2aD32D6bDc2DcdDdcC000D2bD89C000D07D08D37D70D80Df7Df8C000D7fD8fDd3Dd5C000C111D2cC111Db8C111D62C111D92C111D14D1bD41DbeDe4DebC111D4eDb1C111Dd4C222Da9C222D64Dc3C222Dc6C222D63C222D55C222D46C222C333D3dC333D06D09D60D6fD90D9fDf6Df9C333D38C333D4dC333D82C333C444D99C444Db3C444C555D22Dd2DddC555D2dC555D72C555Db7C555C666D39C666D05D0aD50D5fDa0DafDf5DfaC666C777D3cC777D13D1cD31Dc1DceDe3DecC777D3eC777Da3C777Dc5C777C888D3aC888D3bC888D47Da8C888C999D65C999CaaaD56CaaaDc4CaaaD4cCaaaCbbbD93CbbbD04D0bD40D4fDb0DbfDf4DfbCbbbDb6CbbbCcccD73CcccCdddD5aD98CdddD48CdddD12D1dD21D2eDd1DdeDe2DedCdddD83CdddCeeeD00D01D02D03D0cD0dD0eD0fD10D11D1eD1fD20D2fD30D3fDc0DcfDd0DdfDe0De1DeeDefDf0Df1Df2Df3DfcDfdDfeDffCeeeD4bCeeeDa7CeeeD75D77Db4CeeeCfffD68CfffD59CfffDb5CfffD57CfffD4aD66D97CfffD49CfffDa4CfffDa6CfffD84D94CfffD58D67D85D86D96CfffD76D95Da5" {
	cmd = getArgument(); 
	if 		(cmd=="Note in infos") Note_in_infos();
	else if (cmd=="test CLAHE options") testCLAHE_options();
	else if (cmd=="test all Z project") test_All_Zprojections();
	else run(cmd); 
}

macro "Stacks Menu Built-in Tool" {}
macro "Developer Menu Built-in Tool" {}

//------ALL OPENED TOOLS
var ACmds = newMenu("All opened images tools Menu Tool",
	newArray("Reset all contrasts","Set all LUTs","Maximum Z project all","Save all elsewhere", "Basic save all"));
macro"All opened images tools Menu Tool - N55C000D0dD0eD1dD1eD2dD3dD3eD4dD4eD59D5aD5bD5dD5eD6bD6dD6eD73D77D78D79D7bD7dD83D84D85D88D8bD8dD8eD94D99D9dD9eDa3Da6Da8Da9DadDaeDb3Db8Db9Dc3Dc6Dc8Dc9DcdDd4Dd9DdbDdcDddDe3De4De5De8DebDecDedC4cfCe16D74D75D76D86D87D89D93D95D96D97D98Da4Da5Da7Db4Db5Db6Db7Dc4Dc5Dc7Dd3Dd5Dd6Dd7Dd8De6De7De9CfffD0cD1cD2cD3cD48D49D4aD4bD4cD58D5cD62D63D64D65D66D67D68D69D6aD6cD72D7aD7cD82D8aD8cD92D9aD9cDa2DaaDacDb2DbaDbcDbdDbeDc2DcaDceDd2DdaDdeDe1De2DeaDeeCeeeD00D01D02D03D04D05D06D07D08D09D0aD0bD10D11D12D13D14D15D16D17D18D19D1aD1bD20D21D22D23D24D25D26D27D28D29D2aD2bD30D31D32D33D34D35D36D37D38D39D3aD3bD40D41D42D43D44D45D46D47D50D51D52D53D54D55D56D57D60D61D70D71D80D81D90D91Da0Da1Db0Db1Dc0Dc1Dd0Dd1De0Cfe3D9bDabDbbDcbDccCc15C4deC8c4D2eD7eBf0C000D03D07D08D09D13D14D15D16D17D18D19D1dD1eD2eD32D34D35D36D3dD42D45D46D4dD52D55D56D5dD62D63D64D65D66D6eD72D73D74D75D76D7dD7eD8dD8eC4cfD33D43D44D53D54Ce16D04D05D06CfffD01D02D0aD0bD0cD0dD0eD11D12D1aD1cD21D22D23D24D25D26D27D28D29D2aD2cD31D37D3cD41D47D4cD51D57D5cD61D67D6cD71D77D7cD81D82D83D84D85D86D87D8cD9cD9dD9eCeeeD00D10D1bD20D2bD30D38D39D3aD3bD40D48D49D4aD4bD50D58D59D5aD5bD60D68D69D6aD6bD70D78D79D7aD7bD80D88D89D8aD8bD90D91D92D93D94D95D96D97D98D99D9aD9bDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDacDadDaeCfe3Cc15C4deD2dD3eD4eD5eD6dC8c4B0fC000D00D01D02D03D04D05D10D11D12D15D23D24D25D35D43D44D45D55D63D64D65D70D71D72D75D80D81D82D83D84D85C4cfCe16CfffD06D16D26D36D46D56D66D76D86D90D91D92D93D94D95D96CeeeD07D08D09D0aD17D18D19D1aD27D28D29D2aD37D38D39D3aD47D48D49D4aD57D58D59D5aD67D68D69D6aD77D78D79D7aD87D88D89D8aD97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaCfe3Cc15D31D51C4deD13D14D20D21D22D30D32D33D34D40D41D42D50D52D53D54D60D61D62D73D74C8c4Nf0C000D00D01D02D05D06D07D10D11D14D15D16D17D20D25D27D32D36D37D40D45D46D47D50D55D56D57D62D66D67D70D75D77D80D81D84D85D86D87D90D91D92D95D96D97Da0Da1Da2Da3Da4Da5Da6Da7C4cfCe16CfffD08D18D28D38D48D58D68D78D88D98Da8Db0Db1Db2Db3Db4Db5Db6Db7Db8De0De1De2De3De4De5De6CeeeD09D0aD19D1aD29D2aD39D3aD49D4aD59D5aD69D6aD79D7aD89D8aD99D9aDa9DaaDb9DbaDc0Dc1Dc2Dc3Dc4Dc5Dc6Dc7Dc8Dc9DcaDd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7Dd8Dd9DdaDe7De8De9DeaCfe3Cc15C4deC8c4D03D04D12D13D21D22D23D24D26D30D31D33D34D35D41D42D43D44D51D52D53D54D60D61D63D64D65D71D72D73D74D76D82D83D93D94"{
	cmd = getArgument();
	if (cmd=="Set LUTs") { Ask_LUTs(); SetAllLUTs();}
	else if (cmd=="Reset all contrasts") { Reset_All_Contrasts();}
	else if (cmd=="Save all elsewhere") { Save_all_opened_images_elsewhere();}
	else if (cmd=="Basic save all") { Basic_save_all();}
	else if (cmd=="Maximum Z project all") { Maximum_Z_project_all();}
	else run(cmd);	}

//------POPUP
var pmCmds = newMenu("Popup Menu",
	newArray("copy paste LUT set", "Rename...", "Duplicate...","Set LUTs","Set active path",
	"rajout de bout","Copy to System","-", "CLAHE","gauss correction", "test all color blindness","RGB to Luminance","rgb LUT to LUT","rotate LUT",
	"-", "Record...", "Monitor Memory...","Control Panel...", "Startup Macros..."));
macro "Popup Menu" {
	cmd = getArgument(); 
	if (cmd=="CLAHE") CLAHE();
	else if (cmd=="Set active path") SetActivePath();
	else if (cmd=="gauss correction") gaussCorrection();
	else if (cmd=="test all color blindness") test_all_color_blindness();
	else if (cmd=="Set LUTs") {Ask_LUTs(); Set_LUTs();}
	else if (cmd=="RGB to Luminance") luminance();
	else run(cmd); 
}

var luts = getLutMenu(); //merdier en bas.
var lCmds = newMenu("LUT Menu Tool", luts);
macro "LUT Menu Tool - C000T0b11LT6b09UTcb09T" { cmd = getArgument(); if (cmd!="-") run(cmd);}

macro "Preview Opener Tool - N66C000D34D35D36D37D38D39D3aD3bD3cD3dD3eD44D49D4eD54D59D5eD64D69D6eD74D79D7eD84D85D86D87D88D89D8aD8bD8cD8dD8eD94D99D9eDa4Da9DaeDb4Db9DbeDc4Dc9DceDd4Dd5Dd6Dd7Dd8Dd9DdaDdbDdcDddDdeDe4De9DeeC95fD4aD4bD4cD4dD5aD5bD5cD5dD6aD6bD6cD6dD7aD7bD7cD7dC09bC5ffCf05Cf85C8bfDeaDebDecDedCfc0D9aD9bD9cD9dDaaDabDacDadDbaDbbDbcDbdDcaDcbDccDcdCf5bCaf8Cfb8Ccf8D95D96D97D98Da5Da6Da7Da8Db5Db6Db7Db8Dc5Dc6Dc7Dc8Cf5dDe5De6De7De8C8fdCfa8D45D46D47D48D55D56D57D58D65D66D67D68D75D76D77D78Bf0C000D04D09D0eD14D19D1eD24D29D2eD34D35D36D37D38D39D3aD3bD3cD3dD3eD44D49D4eD54D59D5eD64D69D6eD74D79D7eD84D85D86D87D88D89D8aD8bD8cD8dD8eC95fC09bC5ffCf05Cf85D45D46D47D48D55D56D57D58D65D66D67D68D75D76D77D78C8bfD0aD0bD0cD0dD1aD1bD1cD1dD2aD2bD2cD2dCfc0Cf5bCaf8Cfb8Ccf8Cf5dD05D06D07D08D15D16D17D18D25D26D27D28C8fdD4aD4bD4cD4dD5aD5bD5cD5dD6aD6bD6cD6dD7aD7bD7cD7dCfa8B0fC000D03D07D13D17D23D27D30D31D32D33D34D35D36D37D43D47D53D57D63D67D73D77D80D81D82D83D84D85D86D87C95fC09bC5ffCf05Cf85C8bfCfc0D44D45D46D54D55D56D64D65D66D74D75D76Cf5bD04D05D06D14D15D16D24D25D26Caf8Cfb8D40D41D42D50D51D52D60D61D62D70D71D72Ccf8Cf5dC8fdD00D01D02D10D11D12D20D21D22Cfa8Nf0C000D30D31D32D33D34D35D36D37D43D47D53D57D63D67D73D77D80D81D82D83D84D85D86D87D93D97Da3Da7Db3Db7Dc3Dc7Dd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7De3De7C95fC09bD94D95D96Da4Da5Da6Db4Db5Db6Dc4Dc5Dc6C5ffD40D41D42D50D51D52D60D61D62D70D71D72Cf05D90D91D92Da0Da1Da2Db0Db1Db2Dc0Dc1Dc2Cf85C8bfCfc0Cf5bDe4De5De6Caf8D44D45D46D54D55D56D64D65D66D74D75D76Cfb8Ccf8Cf5dC8fdDe0De1De2Cfa8"{
	title = getTitle();
	if (startsWith(title, "Preview Opener")) openFromPreview();
	else setTool(0);
}
macro "Preview Opener Tool Options"{
	if (!isOpen("Preview Opener.tif")) makePreviewOpener();
}


//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------

//CHANNELS
macro "myTurbo 	[n0]"{ splineRoll();}
macro "Gray 	[n1]"{ if (isKeyDown("space")) toggleChannel(1); else if (isKeyDown("alt")) toggleAllchannels(1); else run("Grays");}
macro "Green 	[n2]"{ if (isKeyDown("space")) toggleChannel(2); else if (isKeyDown("alt")) toggleAllchannels(2); else run("kg");	}
macro "Red 		[n3]"{ if (isKeyDown("space")) toggleChannel(3); else if (isKeyDown("alt")) toggleAllchannels(3); else run("Red");	}
macro "Bop 		[n4]"{ if (isKeyDown("space")) toggleChannel(4); else if (isKeyDown("alt")) toggleAllchannels(4); else run("kb");	}
macro "boP 		[n5]"{ if (isKeyDown("space")) toggleChannel(5); else if (isKeyDown("alt")) toggleAllchannels(5); else run("km");	}
macro "bOp 		[n6]"{ if (isKeyDown("space")) toggleChannel(6); else if (isKeyDown("alt")) toggleAllchannels(6); else run("ko");	}
macro "Cyan		[n7]"{ if (isKeyDown("space")) toggleChannel(7); else if (isKeyDown("alt")) toggleAllchannels(7); else run("Cyan");	}
macro "Magenta 	[n8]"{ run("Magenta");	}
macro "Yellow 	[n9]"{ run("Yellow");	}

//toggle channel number (i)
function toggleChannel(i) { //modified from J.Mutterer
	if (nImages<1) exit; 
	if (is("composite")) {
		Stack.getActiveChannels(s);
		c = s.substring(i-1,i);
		Stack.setActiveChannels(s.substring(0,i-1)+!c+s.substring(i)); //at the end it looks like Stack.setActiveChannels(1101);
		showStatus("Channel "+i+" toggled"); 
	}
}

function toggleAllchannels(i) {
	setBatchMode(1);
	for (k=0; k<nImages; k++) {
		selectImage(k+1);
		toggleChannel(i);	
	}
	showStatus("Channel "+i+" toggled");
	setBatchMode(0);
}



//--------------------------------------------------------------------------------------------------------------------------------------
//NOICE TOOLS
macro "composite switch  [Q]" 	{if (!is("composite")) exit; Stack.getDisplayMode(mode); if (mode=="color"||mode=="greyscale")Stack.setDisplayMode("composite"); else Stack.setDisplayMode("color");}
macro "my default LUTs   [1]"	{if (isKeyDown("space")) SetAllLUTs(); 		else if (isKeyDown("alt")) perso_Ask_LUTs(); else Set_LUTs();}
macro "good size  		 [2]"	{if (isKeyDown("space")) fullScreen(); else goodSize();}
macro "3D Zproject++     [3]"	{if (isKeyDown("space")) Cool_3D_montage(); else my3D_project();}
macro "full scale montage[4]"	{if (Image.title=="Montage") {id=getImageID(); run("Montage to Stack..."); selectImage(id);	close();} else run("Make Montage...", "scale=1"); setOption("Changes", 0);}
macro "25x25 selection   [5]"	{size=400; /*toUnscaled(size); size = round(size);*/ getCursorLoc(x, y, null, null); makeRectangle(x,y,size,size); showStatus(size+"x"+size);}
macro "make it look good [6]"	{for (i=0; i<nImages; i++) { setBatchMode(1); selectImage(i+1); run("Appearance...", "  "); run("Appearance...", "black no"); setBatchMode("exit and display"); }}
macro "set destination   [7]" 	{showStatus("Destination set");	run("Alert ", "object=Image color=Orange duration=5000"); call("ij.Prefs.set","Destination.title",getTitle());}
macro "rename w/ id      [8]"	{rename(getImageID());}

macro "invertableLUTs_Bar"{ run("Action Bar", File.openUrlAsString("https://raw.githubusercontent.com/kwolbachia/Imagej-macro-addiction/main/iLUTs/invertableLUTs.ijm"));}
macro "CB_Bar" { 	   		run("Action Bar", File.openUrlAsString("https://git.io/JZUZw"));}

macro "auto 	  [A]"	{ if (isKeyDown("alt"))		Enhance_all_contrasts();	  				else if (isKeyDown("space")) Enhance_on_all_channels();  else run("Enhance Contrast", "saturated=0.03");}
macro "Splitview  [b]"	{ if (isKeyDown("space")) 	SplitView(0,2,0);							else 	SplitView(1,2,0); }
macro "b&c 		  [C]"  { 	B_and_C(); }
macro "duplicat	  [D]"	{ 	run("Duplicate...", "duplicate");}
macro "Spliticate [d]"	{ if (isKeyDown("space"))	run("Duplicate...", " ");	 				else if (isKeyDown("alt")) {Stack.getPosition(ch, slice, frame); run("Duplicate...", "duplicate slices=&slice frames=&frame");}	else run("Split Channels");}
macro "Tile 	  [E]"	{ 	myTile();}
macro "edit lut   [e]"	{ if (isKeyDown("space"))	run("Show LUT");							else 	run("Edit LUT...");}
macro "toolSwitch [F]"	{ if (IJ.getToolName() =="rectangle") 										{	run("Line Width...", "line=30");	setTool(4);}				else  	setTool(0);}
macro "gammaLUT	  [f]"	{ if (bitDepth() == 24) 	run("Gamma..."); 							else if (isKeyDown("space")) setGammaLUTAllch(getNumber("gamma",0.7));	else 	interactiveGamma(); }
macro "Max 		  [G]"	{ if (isKeyDown("space"))	Maximum_Z_project_all();					else run("Z Project...", "projection=[Max Intensity] all");}
macro "Z Project  [g]"	{ if (isKeyDown("alt"))		test_All_Zprojections();					else run("Z Project...");}
macro "overlay I  [i]"	{ if (isKeyDown("space"))	invertedOverlay3(); 						else if (isKeyDown("alt")) invert_invertable_LUTs();	 				else 	invert_all_LUTs();}
macro "New Macro  [J]"	{ 	run("Macro");}
macro "JPEG		  [j]"  { 	run("Input/Output...", "jpeg=100"); saveAs("Jpeg");}
macro "multiplot  [k]"  { 	multiPlot();}
macro "Cmd finder [l]"	{ if (isKeyDown("space"))	run("Repeat a Recent Command"); 			else 	run("Find Commands...");}
macro "Merge 	  [M]"	{ if (isKeyDown("space"))	run("Merge Channels..."); 					else 	fastMerge();} 
macro "LUT baker  [m]"	{	LUTbaker();}
macro "Hela       [n]"	{	Hela();}
macro "open paste [o]"	{ if (isKeyDown("space")) 	makePreviewOpener();						else if (isKeyDown("alt")) open(String.paste);							else openFromPreview();}
macro "Splitview  [p]"	{ if (isKeyDown("space")) 	SplitView(0,1,0); 							else 	SplitView(0,0,0); }
macro "Arrange ch [q]"	{ if (isKeyDown("space"))	ReorderLUTsAsk(); 							else 	run("Arrange Channels...");}
macro "Adjust 	  [R]"	{ if (isKeyDown("space"))	Reset_All_Contrasts(); 						else 	Auto_Contrast_on_all_channels();}
macro "Adjust 	  [r]"	{ if (isKeyDown("alt"))		resetMinAndMax; 							else if (isKeyDown("space")) run("Install...","install=["+getDirectory("macros")+"/StartupMacros.fiji.ijm]");	else Adjust_Contrast();}
macro "Splitview  [S]"	{ if (isKeyDown("alt"))   	getSplitViewPrefs();						else if (isKeyDown("space")) SplitView(1,0,0); 							else SplitView(1,1,0); }
macro "as tiff 	  [s]"	{ if (isKeyDown("space"))	ultimateSplitview(); 						else if (isKeyDown("alt")) Basic_save_all(); 							else	saveAs("Tiff");}
macro "test.ijm   [t]"	{ if (isKeyDown("space"))	runMacroFromUrl();							else if (isKeyDown("alt")) installMacroFromUrl();						else eval(String.paste);}
macro "rgb color  [u]"  { if (isKeyDown("space"))	myRGBconverter(); 							else if (isKeyDown("alt"))	RedGreen2OrangeBlue(); 						else 	switcher(); }
macro "pasta	  [v]"	{ if (isKeyDown("space"))	run("System Clipboard");					else 	run("Paste");}
macro "roll & FFT [x]"  { if (isKeyDown("space"))	channelsRoll();								else	run("FFT");}
macro "sync 	  [y]"	{ 							run("Synchronize Windows");}

//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------

function runMacroFromUrl() {
	script = File.openUrlAsString(getString("run macro from URL", ""));
	String.copy(script);
	eval(script);
}

function installMacroFromUrl() {
	path = getDirectory("temp")+File.separator+"fromURL.ijm";
	File.saveString(File.openUrlAsString(getString("Install macro from URL", "")), path);
	run("Install...","install=["+path+"]");
}

var splineLUTs=newArray("2darkblue2beige","2ghost","2kevidis_splined","2moonlight","2Spline","2pinky","1a myTurbo");
var splineLUT = 3;

function splineRoll(){
	splineLUT++
	if (splineLUT<splineLUTs.length) run(splineLUTs[splineLUT]);
	else {
		splineLUT = 0;
		run(splineLUTs[splineLUT]);
	}
	showStatus(splineLUTs[splineLUT]);
}

/*
getLut(reds, greens, blues);
run("Duplicate...","duplicate");
cul=newArray(1);
for (i = 0; i < 256; i++) cul[i]=maxOf(reds[i],maxOf(greens[i],blues[i]));
for (i = 0; i < 256; i++) if (cul[i]>reds[i]) reds[i]=cul[i]-reds[i]; else reds[i]=255-reds[i];
for (i = 0; i < 256; i++) if (cul[i]>greens[i]) greens[i]=cul[i]-greens[i]; else greens[i]=255-greens[i];
for (i = 0; i < 256; i++) if (cul[i]>blues[i]) blues[i]=cul[i]-blues[i]; else blues[i]=255-blues[i];
setLut(reds, greens, blues);
*/
macro "rotate LUT" {
	setBatchMode(1);
	getLut(reds, greens, blues);
	newImage("r1", "8-bit ramp", 256, 32, 1);
	run("Canvas Size...", "width=768 height=64 position=Top-Left zero");
	setLut(reds, greens, blues);
	newImage("r2", "8-bit ramp", 256, 32, 1);
	run("Canvas Size...", "width=768 height=64 position=Top-Center zero");
	setLut(reds, blues, greens);
	newImage("r3", "8-bit ramp", 256, 32, 1);
	run("Canvas Size...", "width=768 height=64 position=Top-Right zero");
	setLut(greens, reds, blues);
	newImage("r4", "8-bit ramp", 256, 32, 1);
	run("Canvas Size...", "width=768 height=64 position=Bottom-Left zero");
	setLut(greens, blues, reds);
	newImage("r5", "8-bit ramp", 256, 32, 1);
	run("Canvas Size...", "width=768 height=64 position=Bottom-Center zero");
	setLut(blues, greens, reds);
	newImage("r6", "8-bit ramp", 256, 32, 1);
	run("Canvas Size...", "width=768 height=64 position=Bottom-Right zero");
	setLut(blues, reds, greens);
	txt="";
	for (i=1; i<=6; i++) {
			txt += "c" + i + "=[r" + i + "] ";
	}
	run("Merge Channels...", txt + "create");
	setBatchMode(0);
	rename("wiiiii");
}

var all_LUTs = getList("LUTs");

macro "set LUT from montage Tool - N55C000D37D38D39CfffD00D01D02D03D04D05D06D07D08D09D0aD0bD0cD0dD0eD10D11D12D13D14D15D16D17D18D19D1aD1bD1cD1dD1eD20D21D22D23D24D25D26D27D28D29D2aD2bD2cD2dD2eD30D31D32D36D3aD3eD40D41D42D46D4aD4eD50D51D52D56D5aD5eD60D61D62D66D6aD6eD70D71D72D76D7aD7eD80D81D82D86D8aD8eD90D91D92D96D9aD9eDa0Da1Da2Da6DaaDaeDb0Db1Db2Db6DbaDbeDc0Dc1Dc2Dc6DcaDceDd0Dd1Dd2Dd6DdaDdeDe0De1De2De6DeaDeeC338C047Db7Db8Db9C557D73D74D75D83D84D85C500D5bD5cD5dC198Ce50Cb87C024D77D78D79C278Cd51DdbDdcDddC438Cb00D9bD9cD9dC18cCfb3Cda7C100D3bD3cD3dC158Dd7Dd8Dd9C157Dc7Dc8Dc9C877Db3Db4Db5Dc3Dc4Dc5C900C3b7Ce82Cc97C013D33D34D35C17aCaf3C448Cd30DbbDbcDbdC1dcCfb4Cfd8C012D57D58D59C358C347D53D54D55C667D93D94D95C800D7bD7cD7dC2a8Ce71DebDecDedC49fC035D97D98D99C288Ccd1Ca87De3De4De5Cb10C19dCee1Cfb7C300D4bD4cD4dC368C8d4C977Dd3Dd4Dd5C427C1eaCfa3Cd97C406C18bCce3C47fCd40DcbDccDcdC1afCfc6CfebC011D47D48D49C457D63D64D65C247D43D44D45C600D6bD6cD6dC298Cf61C4f7C034D87D88D89C169De7De8De9C9d3Cc00DabDacDadC19dCed3Cea7C022D67D68D69C268C6c5Ca00D8bD8cD8dC4b7Cf92C045Da7Da8Da9C8f5C46dC2ceCfb5C667Da3Da4Da5Bf0C000CfffD00D01D02D06D0aD0eD10D11D12D16D1aD1eD20D21D22D26D2aD2eD30D31D32D36D3aD3eD40D41D42D46D4aD4eD50D51D52D56D5aD5eD60D61D62D66D6aD6eD70D71D72D76D7aD7eD80D81D82D83D84D85D86D87D88D89D8aD8bD8cD8dD8eD90D91D92D93D94D95D96D97D98D99D9aD9bD9cD9dD9eDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDacDadDaeC338C047C557C500C198Ce50Cb87D13D14D15C024C278Cd51C438Cb00C18cD37D38D39Cfb3Cda7D43D44D45C100C158C157C877C900C3b7Ce82D0bD0cD0dCc97D23D24D25C013C17aD07D08D09D17D18D19Caf3C448Cd30C1dcCfb4D2bD2cD2dCfd8D5bD5cD5dC012C358C347C667C800C2a8Ce71C49fC035C288Ccd1Ca87D03D04D05Cb10C19dD57D58D59Cee1Cfb7D63D64D65D73D74D75C300C368C8d4C977C427C1eaCfa3Cd97D33D34D35C406C18bD27D28D29Cce3C47fCd40C1afD67D68D69D77D78D79Cfc6D4bD4cD4dCfebD6bD6cD6dD7bD7cD7dC011C457C247C600C298Cf61C4f7C034C169C9d3Cc00C19dD47D48D49Ced3Cea7D53D54D55C022C268C6c5Ca00C4b7Cf92D1bD1cD1dC045C8f5C46dC2ceCfb5D3bD3cD3dC667B0fC000CfffD03D07D08D09D0aD13D17D18D19D1aD23D27D28D29D2aD33D37D38D39D3aD43D47D48D49D4aD53D57D58D59D5aD63D67D68D69D6aD73D77D78D79D7aD80D81D82D83D84D85D86D87D88D89D8aD90D91D92D93D94D95D96D97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaC338C047C557C500C198Ce50D30D31D32Cb87C024C278Cd51C438Cb00C18cCfb3D00D01D02Cda7C100C158C157C877C900D60D61D62D70D71D72C3b7D04D05D06Ce82Cc97C013C17aCaf3C448Cd30D40D41D42C1dcCfb4Cfd8C012C358C347C667C800C2a8Ce71C49fC035C288Ccd1D54D55D56Ca87Cb10D50D51D52C19dCee1D64D65D66D74D75D76Cfb7C300C368C8d4D34D35D36C977C427C1eaCfa3D10D11D12Cd97C406C18bCce3C47fCd40C1afCfc6CfebC011C457C247C600C298Cf61D20D21D22C4f7C034C169C9d3D44D45D46Cc00C19dCed3Cea7C022C268C6c5D24D25D26Ca00C4b7D14D15D16Cf92C045C8f5C46dC2ceCfb5C667Nf0C000CfffD00D01D02D03D04D05D06D07D08D09D0aD10D11D12D13D14D15D16D17D18D19D1aD20D21D22D23D24D25D26D27D28D29D2aD33D37D38D39D3aD43D47D48D49D4aD53D57D58D59D5aD63D67D68D69D6aD73D77D78D79D7aD83D87D88D89D8aD93D97D98D99D9aDa3Da7Da8Da9DaaDb3Db7Db8Db9DbaDc3Dc7Dc8Dc9DcaDd3Dd7Dd8Dd9DdaDe3De7De8De9DeaC338D30D31D32C047C557C500C198Dd4Dd5Dd6Ce50Cb87C024C278Da4Da5Da6Cd51C438D54D55D56Cb00C18cCfb3Cda7C100C158C157C877C900C3b7Ce82Cc97C013C17aCaf3Dc0Dc1Dc2C448D64D65D66Cd30C1dcD80D81D82Cfb4Cfd8C012C358D74D75D76C347C667C800C2a8De4De5De6Ce71C49fD60D61D62C035C288Db4Db5Db6Ccd1Ca87Cb10C19dCee1Cfb7C300C368D84D85D86C8d4C977C427D44D45D46C1eaD90D91D92Cfa3Cd97C406D34D35D36C18bCce3Dd0Dd1Dd2C47fD50D51D52Cd40C1afCfc6CfebC011C457C247C600C298Dc4Dc5Dc6Cf61C4f7Da0Da1Da2C034C169C9d3Cc00C19dCed3De0De1De2Cea7C022C268D94D95D96C6c5Ca00C4b7Cf92C045C8f5Db0Db1Db2C46dD40D41D42C2ceD70D71D72Cfb5C667" 	{
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
			run(all_LUTs[index]);
		}
		else {
			newImage(all_LUTs[index], "8-bit ramp", 256, 32, 1);
			run(all_LUTs[index]);
		}
		showStatus("LUT = " + all_LUTs[index]);
	}
}

macro "set LUT from montage Tool Options" {
	run("Display LUTs");
}

function setTargetImage() {
	showStatus("Target image = "+ getTitle(), "flash image orange 200ms");
	call("ij.Prefs.set","Destination.title",getTitle());
}

function rgbPixel2LUT() {//if on a rgb image,get current pixel color and use it to create the LUT of destination image with setTargetImage()
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

function openFromPreview() {
	infos = getMetadata("Info");
	pathList = split(infos, ",,");
	rows = getInfo("xMontage");
	lines = getInfo("yMontage");
	blocSize = 400;
	index = 0;
	getCursorLoc(x, y, z, flags);
	linePosition = floor(y/blocSize);
	rowPosition = floor(x/blocSize);
	index = (linePosition*rows)+rowPosition;
	path = getDirectory("image") + pathList[index];
	if(File.exists(path)) {
		open(path);
		showStatus("opening " + pathList[index]);
	}
	else showStatus("can't open '" + pathList[index] + "' maybe incorrect name or spaces in it?");
}

//create a montage with snapshots of all opened images (virtual or not)
//in their curent state.  Will close all but the montage.
function makePreviewOpener() {
	setBatchMode(1);
	all_IDs = newArray(nImages);
	all_paths = "";
	concat_Options = "open ";
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		if (i==0) File.setDefaultDir(getDirectory("image"));
		all_IDs[i] = getImageID();
		all_paths += getTitle() +",,";
	}
	for (i=0; i<all_IDs.length; i++) {
		selectImage(all_IDs[i]); 
		rgbSnapshot();
		run("Scale...", "x=- y=- width=400 height=400 interpolation=Bilinear average create");
		rename("image"+i);
		concat_Options +=  "image"+i+1+"=[image"+i+"] ";
	}
	run("Concatenate...", concat_Options);
	run("Make Montage...", "scale=1");
	rename("Preview Opener");
	infos=getMetadata("Info");
	setMetadata("Info", all_paths+"\n"+infos);
	close("\\Others");
	setBatchMode(0);
	run("Save");
}

//Supposed to create an RGB snapshot of any kind of opened image
function rgbSnapshot(){
	Stack.getPosition(channel, slice, frame);
	getDimensions(width, height, channels, slices, frames);
	if (channels>1) Stack.getDisplayMode(mode);
	if 		(bitDepth()==24) 		run("Duplicate..."," ");
	else if (channels==1) 			run("Duplicate...", "title=toClose channels=&channels slices=&slice frames=&frame");
	else if (mode!="composite") 	run("Duplicate...", "title=toClose channels=channel slices=&slice frames=&frame");
	else 							run("Duplicate...", "duplicate title=toClose slices=&slice frames=&frame");
	run("RGB Color", "keep");
	rename("snap");
	close("toClose");
	setOption("Changes", 0);
}

function Hela(){
	setBatchMode(1);
	run("HeLa Cells (48-bit RGB)");
	makeRectangle(23, 0, 580, 478);
	run("Crop");
	run("Remove Overlay");
	run("Remove Slice Labels");
	Set_LUTs();
	makeRectangle(173, 255, 314, 178);
	Enhance_on_all_channels();
	run("Select None");
	setOption("Changes",0);
	setBatchMode(0);
}

function channelsRoll(){
	id = getImageID();
	if(bitDepth() != 24) run("Stack to RGB");
	newList = newArray(132,213,231,321,312);
	for (i = 0; i < 5; i++) {
		setBatchMode(1);
		selectImage(id);
		run("Duplicate...","duplicate");
		if(bitDepth() == 24) run("Make Composite");
		reorderLUTs(newList[i]);
		run("Stack to RGB");
		setOption("Changes", 0);
		setBatchMode(0);
	}
	run("Images to Stack");

	function reorderLUTs(order) {//for channelsRoll
		Stack.getPosition(Channel, slice, frame);
		getDimensions(width, height, channels, slices, frames);
		order = toString(order);
		title=getTitle();
		run("Duplicate...","title=dup duplicate frames=1 slices=1");
		run("Arrange Channels...", "new=&order");
		for (i = 1; i <= channels; i++) {
			selectWindow("dup");
			Stack.setChannel(i);
			getLut(r, g, b);
			selectWindow(title);
			Stack.setChannel(i);
			setLut(r, g, b);
		}
		Stack.setPosition(Channel, slice, frame);
	}//reorderLUTs end
}//channelsRoll end


function multiPlot(){
	if (bitDepth()==24){ run("Plot Profile"); exit;}
	id=getImageID();
	alreadyOpenPlot = 0;
	if (isOpen("MultiPlot")) alreadyOpenPlot = 1;
	getDimensions(width,  height, channels, slices, frames);
	if (selectionType()==-1) { run("Select All"); selectNone = true;}
	Stack.getPosition(Channel, slice, frame);
	Plot.create("MultiPlot", "Pixels", "Grey value");
	for (i=1; i<=channels; i++) {
		if (channels>1) Stack.setChannel(i);
		p = getProfile();
		Plot.setColor(lutToHex2());
		Plot.setLineWidth(2);
		Plot.add("line", p);
	}
	Stack.setPosition(Channel, slice, frame);
	if (selectNone) run("Select None");
	if (channels>1) {Stack.setDisplayMode("color");	Stack.setDisplayMode("composite");}
	Plot.setBackgroundColor("#2f2f2f");
	Plot.setAxisLabelSize(14.0, "bold");
	Plot.setFormatFlags("11001100001111");
	Plot.update();
	selectWindow("MultiPlot");
	if (!alreadyOpenPlot) setLocation(50,300);
	Plot.setLimitsToFit();
	selectImage(id);
}
function lutToHex2(){
	getLut(r,g,b);
	if (is("Inverting LUT")) { R = r[0];   G = g[0];   B = b[0];   }
	else 					 { R = r[255]; G = g[255]; B = b[255]; }
	if (R<16) xR = "0" + toHex(R); else xR = toHex(R);
	if (G<16) xG = "0" + toHex(G); else xG = toHex(G);
	if (B<16) xB = "0" + toHex(B); else xB = toHex(B);
	return "#"+xR+xG+xB;
}

function fastMerge(){
	if (nImages>4) {run("Merge Channels..."); exit();}
	for (i=0; i<nImages; i++) {
		selectImage(i+1);
		if(bitDepth()==24) run("8-bit");
	}
	list = getList("image.titles");
	txt = "";
	for (i=0; i<list.length; i++) {
		txt = txt + "c" + i+1 + "=[" + list[i] + "] ";
	}
	run("Merge Channels...", txt + "create");
}

function CLAHE(){
	if (isKeyDown("shift")) run("Enhance Local Contrast (CLAHE)", "blocksize=100 histogram=256 maximum=1.5 mask=*None* fast_(less_accurate)");
	else run("Enhance Local Contrast (CLAHE)");
}

function SetActivePath() { File.setDefaultDir(getDirectory("image")); }


function switcher(){ //RGB to Composite et vice versa 
	if (nImages==0) exit("no image");
	title=getTitle();
	if (bitDepth() == 24) {
		run("Duplicate...","duplicate");
		run("Make Composite");
		run("Remove Slice Labels");
	}
	else { 
		rgbSnapshot();
		rename(title);
	}
	setOption("Changes", 0);
}

function myRGBconverter(){
	setBatchMode(1);
	if (nImages==0) exit("no image");
	if (bitDepth() == 24) {
		run("Duplicate...","duplicate");
		run("Make Composite");
		run("Remove Slice Labels");
	}
	Stack.setChannel(1); LUTmaker(147,108,0);
	Stack.setChannel(2); LUTmaker(0,107,138);
	Stack.setChannel(3); LUTmaker(108,40,117);
	setOption("Changes", 0);
	setBatchMode(0);
}

function RedGreen2OrangeBlue() { //Red Green to Orange Blue
	if (nImages==0) exit("no image");
	if (bitDepth() == 24) {
		run("Duplicate...","duplicate");
		run("Make Composite");
		run("Remove Slice Labels");
	}
	getDimensions(width, height, channels, slices, frames);
	if (channels > 2) run("Arrange Channels...", "new=12");
	Stack.setChannel(1); LUTmaker(0,150,255);
	Stack.setChannel(2); LUTmaker(255,105,0);
	setOption("Changes", 0);
}

function B_and_C(){
	run("Brightness/Contrast...");
	selectWindow("B&C");
	setLocation(150,300);
}

function goodSize() {
	getDimensions(W, H, null, null, null);
	newH = (screenHeight/10) * 8;
	newW = W * (newH / H);
	x = (screenWidth - newW) / 2;
	y = (screenHeight - newH) / 2;
	setLocation(x, y, newW, newH);
	run("Set... ", "zoom="+(getZoom()*100)-2);
}

function fullScreen() {
	setBatchMode(1);
	run("Set... ", "zoom=2000");
	setLocation(0, screenHeight/10, screenWidth, screenHeight*0.8);
	run("Set... ", "zoom="+round((screenWidth/getWidth())*100)-1);
}

function Note_in_infos(){
	infos=getMetadata("Info");
	Dialog.create("Add comment in image infos");
	Dialog.addString("Comment :", "", 80);
	Dialog.show();
	Comment = Dialog.getString();
	setMetadata("Info", Comment+'\n\n'+infos);
	run("Show Info...");
}

function gaussCorrection(){
	setBatchMode(1);
	title=getTitle();
	run("Duplicate...", "title=gaussed duplicate");
	getDimensions(width, height, channels, slices, frames);
	sigma = height/3;
	run("Gaussian Blur...", "sigma="+sigma+" stack");
	imageCalculator("Substract create stack", title, "gaussed");
	rename(title+"_corrected");
	setOption("Changes", 0);
	setBatchMode(0);
}

function testCLAHE_options() {
	if (nImages == 0) exit("no image");
	setBatchMode(1);
	getDimensions(width, height, channels, slices, frames);
	if (slices*frames > 1) exit("can't test stacks, please extract one slice");
	setBatchMode(1);
	if (bitDepth()!= 24) run("Stack to RGB");
	blocSize = newArray(10, 100, 200, 500, 700);
	contrast = newArray(5,3,2,1.5);
	run("Duplicate...", "title=test");
	for (k=0; k<4; k++)	{
		for (i=0; i<5; i++)	{
			showProgress(i/20);
			blocSize_i = blocSize[i];	
			contrast_k = contrast[k];
			setSlice(1);
			run("Copy"); run("Add Slice"); run("Paste");	
			run("Enhance Local Contrast (CLAHE)", "blocksize=&blocSize_i histogram=256 maximum=&contrast_k fast_(less_accurate)");
			Property.setSliceLabel("bloc=" + blocSize[i]+ " contrast=" + contrast[k], 2);  
		}
	}
	setSlice(1); run("Delete Slice"); run("Select None");
	setOption("Changes", 0);
	setBatchMode(0);
}

function test_All_Zprojections(){
	showStatus("Test all Z projections");
	getDimensions(width, height, channels, slices, frames);
	title = getTitle();
	source = getImageID();
	setBatchMode(1);
	modes = newArray("[Average Intensity]","[Max Intensity]","[Min Intensity]","[Sum Slices]","[Standard Deviation]","Median");
	newImage(title + "-Zprojects", "RGB", width, height, 6);
	result = getImageID();
	for (i=0; i<=5; i++) {
		selectImage(source);
		run("Z Project...", "projection=" + modes[i]);
		run("Enhance Contrast...", "saturated=0.001");
		run("RGB Color");
		run("Copy");
		selectImage(result);	setSlice(i+1);	run("Paste");
		Property.setSliceLabel(modes[i], i+1)
	}
	run("Make Montage...", "scale=1 font=20 label");
	setBatchMode(0);
	setOption("Changes", 0);
}

function luminance(){
	setBatchMode(1);
	if (bitDepth()!= 24) rgbSnapshot();
	run("RGB to Luminance");
	setOption("Changes", 0);
	setBatchMode(0);
}

function test_all_color_blindness(){
	if (nImages == 0) exit("no image");
	setBatchMode(1);
	getDimensions(width, height, channels, slices, frames);
	if (bitDepth()!= 24) rgbSnapshot();
	showStatus("test all color blindness");
	inTitle = getTitle();
	inID = getImageID();
	run("Copy");
	modes = newArray("[Protanopia (no red)]","[Deuteranopia (no green)]","[Tritanopia (no blue)]");
	newImage(inTitle + "-CB", "RGB", width, height, 4);
	setSlice(4); run("Paste");
	outID = getImageID();
	for (i=0; i<=2; i++) {
		selectImage(inID);
		run("Duplicate...","duplicate");
		run("Simulate Color Blindness", "mode=" + modes[i]);
		run("Copy");
		selectImage(outID);	
		setSlice(i+1);	
		run("Paste");
		Property.setSliceLabel(modes[i], i+1);
	}
	Property.setSliceLabel("original", 4);
	setSlice(1);
	run("Select None");
	setOption("Changes", 0);
	setBatchMode(0);
}

function Cool_3D_montage() {
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

function my3D_project() {
	showStatus("3D project ++");
	setBatchMode(1);
	titl1 = getTitle();
	run("3D Project...", "projection=[Brightest Point] initial=310 total=100 rotation=5 interpolate");
	titl2 = getTitle(); 
	What2Merge = "";
	getDimensions(w, h, channels, s, f);
	if (channels > 1) {
		run("Duplicate...","title=split duplicate");
		run("Split Channels");
		for (i = 1; i <= channels; i++) {
			selectWindow("C"+i+"-split");
			run("Reverse");	//only works on stacks so need split / merge
			What2Merge = What2Merge + "c" +i+ "=C" +i+ "-split ";	
		}
		run("Merge Channels...", What2Merge + " create");	
	}
	else {
		run("Duplicate...","title=split duplicate");
		run("Reverse");	}
	run("Concatenate...", "image1=&titl2 image2=split");
	rename("3D "+titl1);
	setBatchMode("exit and display");
	run("Animation Options...", "speed=11 start");
	setOption("Changes", 0);
}

macro "Batch convert 32 to 16-bit" {
	// ask user to select a folder
	dir = getDirectory("Select A folder");
	bit = getString("do you want 8 or 16 bits?", "16");
	// get the list of files (& folders) in it
	fileList = getFileList(dir);
	setBatchMode(true);
	for (i = 0; i < lengthOf(fileList); i++) {
		current_imagePath = dir + fileList[i];
		// check that the currentFile is not a directory
		if (!File.isDirectory(current_imagePath)) {
			print("opening "+ fileList[i]);
			run("Bio-Formats Importer", "open=&current_imagePath");
			getDimensions(width, height, channels, slices, frames);
			if (channels == 1) {
				resetMinAndMax;
				run(bit +"-bit");
			}
			else {
				Stack.getStatistics(voxelCount, mean, min, max, stdDev);
				for (k = 0; k < channels; k++) {
					Stack.setChannel(k+1);
					setMinAndMax(min, max);
				}
				run(bit +"-bit");
			}
			currentImage_name = getTitle();
			saveAs("tiff", dir+currentImage_name);
			run("Close All");
		}
	}
	print("done");
	setBatchMode(false);
}

macro "Batch convert ims to tif" {
	// ask user to select a folder
	dir = getDirectory("Select A folder");
	// get the list of files (& folders) in it
	fileList = getFileList(dir);
	setBatchMode(true);
	for (i = 0; i < lengthOf(fileList); i++) {
		current_imagePath = dir + fileList[i];
		// check that the currentFile is not a directory
		if (!File.isDirectory(current_imagePath)||endsWith(fileList[i], "txt")) {
			print("opening "+ fileList[i]);
			run("Bio-Formats Importer", "open=&current_imagePath");
			rename(fileList[i]);
			currentImage_name = getTitle();
			saveAs("tiff", dir+currentImage_name);
			run("Close All");
		}
	}
	print("done");
	setBatchMode(false);
}

/*--------
Set LUTs
--------*/
function perso_Ask_LUTs(){
	LUT_list = newArray("kb","ko","km","kg","Grays",splineLUTs[splineLUT],"glasbey_on_dark");
	Dialog.create("Set all LUTs");
	for(i=0; i<4; i++) Dialog.addRadioButtonGroup("LUT " + (i+1), LUT_list, 2, 4, chosen_LUTs[i]);
	Dialog.show();
	for(k=0; k<4; k++) chosen_LUTs[k] = Dialog.getRadioButton();
	Set_LUTs();
}

function Ask_LUTs(){
	LUT_list = newArray("kb","km","ko","kg","Grays",
		"Cyan","Magenta","Yellow","Red","Green","Blue","kevidis");
	Dialog.create("Set all LUTs");
	for(i=0; i<5; i++) Dialog.addChoice("LUT " + (i+1),LUT_list,chosen_LUTs[i]);
	Dialog.show();
	for(k=0; k<5; k++) chosen_LUTs[k] = Dialog.getChoice();
}

function Set_LUTs(){
	Stack.getPosition(ch,s,f);
	getDimensions(w,h,channels,s,f);
	if (channels>1){
		Stack.setDisplayMode("composite");
		for(i=1; i<=channels; i++){
			Stack.setChannel(i);
			run(chosen_LUTs[i-1]);
		}
		Stack.setChannel(ch);
	}
	else run(chosen_LUTs[0]);
}

function SetAllLUTs(){
	setBatchMode(1);
	all_IDs = newArray(nImages);
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		all_IDs[i] = getImageID(); 
	} 
	for (i=0; i<nImages; i++) {
		selectImage(all_IDs[i]);
		if (bitDepth() != 24) Set_LUTs();	
	}
	setBatchMode(0);
}

function interactiveGamma(){
	setBatchMode(1);
	Run=1; gamma=1;
	getLut(r, g, b);
	getDimensions(w, h, ch, s, f);
	setColor("white");
	setFont("SansSerif",h/20, "bold antialiased");
	Overlay.drawString("press space to apply, alt to cancel",h/20,h/20*19);
	Overlay.drawString("drag left / right to set gamma",h/20 ,h/20*18);
	Overlay.show;
	while(Run) {
		getCursorLoc(x, null, null, flags);
		if (flags==16){
			gamma = d2s((x/w)*2, 1); if (gamma<0) gamma=0;
			gammaLUT(gamma,r, g, b);
			Overlay.remove;
			Overlay.drawString("gamma = "+gamma, h/30,h/20);
			Overlay.drawString("press space to apply, alt to cancel",h/20,h/20*19);
			Overlay.drawString("drag left / right to set gamma",h/20 ,h/20*18);
			Overlay.show;
		}
		if(isKeyDown("space")) 	{ 	Run=0; showStatus("applied gamma "+gamma);		}
		if(isKeyDown("alt")) 	{	setLut(r,g,b); Run=0; showStatus("canceled");	}
		wait(60);
	}
	setBatchMode(0);
	Overlay.remove;
	run("Select None");
}

//for args give gamma number, and r,g,b obtained by getLut(r,g,b) command.
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

function setGammaLUTAllch(gamma){
	if (nImages==0) exit("No opened image"); if (bitDepth() == 24) exit("this is an RGB image");
	getDimensions(w,h,channels,s,f);
	if (channels>1) {
		for (i=1; i<=channels; i++){
		Stack.setChannel(i);
		getLut(r, g, b);
		gammaLUT(gamma,r, g, b);	
		}
	}
	else {
		getLut(r, g, b);
		gammaLUT(gamma,r, g, b);
	}
}

/*----------------------------------------------------------------
Adjust the contrast window between min and max on active channel
----------------------------------------------------------------*/
function Adjust_Contrast() { 
	setBatchMode(1);
	id = getImageID();
	getDimensions(width, height, channels, slices, frames);
	if (slices*frames*channels == 1) 
		getStatistics(area, mean, min, max, std, histogram);
	else if (slices*frames == 1 && channels>1)	{
		Stack.getPosition(channel, slice, frame);
		run("Duplicate...", "title=temp duplicate channels=&channel");//duplicate only the active channel.
		getStatistics(area, mean, min, max, std, histogram);
	}
	else {
		Stack.getPosition(channel, slice, frame);
		run("Duplicate...", "title=temp duplicate channels=&channel");
		Stack.getStatistics(voxelCount, mean, min, max, stdDev);
	}
	selectImage(id);
	setMinAndMax(min, max);
	showStatus("min = "+min+" max = "+max);
	close("temp");
	setBatchMode("exit and display");
	updateDisplay();
}// Note : I discovered that the built-in command 'run("Enhance Contrast...", "saturated=0.001 use");' give same results
//		  but it only works on single channel stacks so this macro is still necessary for hyperstacks.

function Auto_Contrast_on_all_channels() {
	getDimensions(w, h, CH, s, f);
	Stack.getPosition(ch, s, f);
	for (i = 1; i <= CH; i++) {
		Stack.setPosition(i, s, f);
		Adjust_Contrast();	
	}
	Stack.setPosition(ch, s, f);
	makeRectangle(5,5,5,5); run("Select None"); //trick for display update
}

function Enhance_on_all_channels() {
	getDimensions(w, h, CH, slices, frames);
	Stack.getPosition(ch, s, f);
	for (i = 1; i <= CH; i++) {
		Stack.setPosition(i, slices/2, frames/2);
		run("Enhance Contrast", "saturated=0.03 use");	
	}
	Stack.setPosition(ch, s, f);
	makeRectangle(5,5,5,5); run("Select None"); //trick for display update
}
/*------------------
All opened images
------------------*/
function Reset_All_Contrasts(){
	showStatus("Reset all contrasts");
	all_IDs = newArray(nImages);
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		all_IDs[i] = getImageID(); 
	} 
	for (i=0; i<all_IDs.length; i++) {
		showProgress(i/all_IDs.length);
		selectImage(all_IDs[i]);
	    Auto_Contrast_on_all_channels();	
	}
}

function Enhance_all_contrasts() {
	showStatus("Enhance all contrasts");
	all_IDs = newArray(nImages);
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		all_IDs[i] = getImageID(); 
	} 
	for (i=0; i<all_IDs.length; i++) {
		showProgress(i/all_IDs.length);
		selectImage(all_IDs[i]);
	    Enhance_on_all_channels();
	}
}

function Maximum_Z_project_all() {
	
	all_IDs = newArray(nImages);
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		all_IDs[i] = getImageID(); 
	} 
	setBatchMode(1);
	for (i=0; i<all_IDs.length; i++) {
		selectImage(all_IDs[i]);
		getDimensions(w, h, channels, slices, frames);
		if (channels*slices*frames!=1) run("Z Project...", "projection=[Max Intensity] all"); 
	}
	for (i=0; i<all_IDs.length ; i++) {	//Close not projected images
		selectImage(all_IDs[i]);
		getDimensions(w, h, channels, slices, frames);
		if (channels*slices*frames!=1) close();
	}
	setBatchMode("exit and display");
	run("Tile");
}

function Save_all_opened_images_elsewhere() {
	dir = getDirectory("Choose a Directory");
	for (i=0; i<nImages; i++) {
        selectImage(i+1);
        title = getTitle;
        saveAs("tiff", dir+title);
        print(title + " saved");
	}
	print("done");
}

function Basic_save_all() {
	for (i=0; i<nImages; i++) {
        selectImage(i+1);
        title = getTitle;
        run("Save");
        print(title + " saved");
	} 
	print("done");
}

function myTile() {
	all_IDs = newArray(nImages);
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		all_IDs[i] = getImageID(); 
	} 
	for (i=0; i<all_IDs.length; i++) {
		selectImage(all_IDs[i]);
		getDimensions(width, height, channels, slices, frames);
		Stack.setPosition(1, round(slices/2), round(frames/2));
	}
	run("Tile");
}

//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------


function ultimateSplitview() {
	noRGB_errorCheck();
	getDimensions(null, null, ch, null, null); id=getImageID();
	if (ch==1||ch>5) exit;
	if (startsWith(getTitle(), "Splitview")) { revertSplitview(); exit; }
	setBatchMode("hide");
	run("Duplicate...","title=be_right_back duplicate frames=1 slices=1");
	setBatchMode("show");
	selectImage(id);
	rename("Splitview_" + getTitle());
	Stack.getPosition(channel,slice,frame);
	getDimensions(w, h, ch, s, f); newW=w*(ch+1); allsteps=ch*s; step = 0;
	if ((f>1)&&(s==1)) {s=f; f=1; Stack.setDimensions(ch,s,f); } 
	run("Canvas Size...", "width=&newW height=&h position=Center-Right zero");
	makeRectangle(0, 0, w, h);
	for (k = 1; k <= ch; k++) {	
		Stack.setChannel(k); 
		for (i=1; i<=s; i++) {
			Stack.setSlice(i);
			Roi.move(w*ch, 0);	run("Copy");
			if(k==1){Roi.move(0, 0);  run("Paste");}
			if(k==2){Roi.move(w, 0);  run("Paste");}
			if(k==3){Roi.move(w*2,0); run("Paste");}
			if(k==4){Roi.move(w*3,0); run("Paste");}
			if(k==5){Roi.move(w*4,0); run("Paste");}
			step++;	showProgress(step/allsteps);
		}
	}
	close("be_right_back");
	run("Select None");
	setOption("Changes", 0);
	Stack.setDisplayMode("composite");
	Stack.setPosition(channel,slice,frame);
	setBatchMode(0);
	SplitviewInteractor();

	function SplitviewInteractor(){
	getDimensions(w, h, ch, s, f);
	w=w/(ch+1);	overlay = (ch*w); id=getImageID();
	while (isOpen(id)) {
		if (!startsWith(getTitle(), "Splitview")) exit;
		getCursorLoc(x, y, z, flags);
		if (flags==16&&getImageID()==id) {
			if(x<overlay){
				if (x <= w) 			 Stack.setChannel(1);
				if (x > w && x <= w*2) 	 Stack.setChannel(2);
				if (x > w*2 && x <= w*3) Stack.setChannel(3);
				if (x > w*3 && x <= w*4) Stack.setChannel(4);
				if (x > w*4 && x <= w*5) Stack.setChannel(5);
			}
		}
	Stack.setDisplayMode("color");
	Stack.setDisplayMode("composite");
	wait(60);
	}
	}
	
	function revertSplitview(){
	getDimensions(w, h, ch, s, f);
	w=w/(ch+1);	overlay = (ch*w); id=getImageID();
	makeRectangle(overlay, 0, w, h);
	run("Crop");
	title=getTitle();
	rename(title.substring(10,(title.length)));
	setOption("Changes", 0);
	}
	
	function noRGB_errorCheck(){
	if (nImages==0) exit("No opened image");
	if(bitDepth()==24) exit("won't work on RGB image");
	}
}

//----------------------- ---------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------

//
function SplitView(color,style,labels) {
	setBatchMode(true);
	title = getTitle();
	Setup_Splitview(color,labels);//up until split
	if (style==1)	squareView();
	if (style==0)	linearView();
	if (style==2)	brugiaStyle();
	rename(title + " Splitview");
	setOption("Changes", 0);
	setBatchMode("exit and display");

	function Setup_Splitview(color,labels){ 
	getDimensions(w, h, ch, Z, T);
	if (ch == 1) exit("only one channel");
	if (ch > 5)  exit("5 channels max");
	run("Duplicate...", "title=image duplicate");
	if ((Z>1)&&(T==1)) {T=Z; Z=1; Stack.setDimensions(ch,Z,T); } 
	tile = newArray(ch+1);	channels = ch;
	getDimensions(w,h,ch,Z,T);
	fontS = h/9;
	run("Duplicate...", "title=split duplicate");
	run("Split Channels");
	selectWindow("image");
	Stack.setDisplayMode("composite");

	if (labels) {
		getLabels();
		setColor("white");
		setFont("SansSerif", fontS, "bold antialiased");
		Overlay.drawString("Overlay",h/20,fontS);
		Overlay.show;
		run("Flatten","stack");
		rename("overlay"); tile[0] = getTitle();
		close("image");

		for (i = 1; i <= channels; i++) {
			selectWindow("C"+i+"-split");
			id = getImageID();
			getLut(r, g, b); 
			setColor(r[255], g[255], b[255]);
			if (!color) run("Grays");
			Overlay.drawString(ChLabels[i-1],h/20,fontS);
			Overlay.show;
			if (Z*T>1) run("Flatten","stack");
			else { run("Flatten"); selectImage(id);	close();	}
			tile[i]=getTitle();
		}
	}
	else {
		run("RGB Color", "frames"); 
		rename("overlay"); tile[0] = getTitle(); 
		close("image");
		for (i = 1; i <= channels; i++) {
			selectWindow("C"+i+"-split");
			if(!color)run("Grays");
			run("RGB Color", "slices"); 
			tile[i]=getTitle();	
		}
	}
	}
	
	function getLabels(){
	Dialog.createNonBlocking("Provide channel names");
	for (a = 0; a < 5; a++) Dialog.addString("Channel "+a+1, ChLabels[a],12); 
	Dialog.addNumber("Font size", fontS);
	Dialog.show();
	for (k = 0; k < 5; k++) {ChLabels[k] = Dialog.getString();}
	fontS = Dialog.getNumber();
	}
	
	function squareView(){
									C1_C2 = 	Combine_Horizontally(tile[1],tile[2]);
	if (channels==2||channels==4)	C1_C2_Ov =	Combine_Horizontally(C1_C2,tile[0]);
	if (channels==3){				C3_Ov = 	Combine_Horizontally(tile[3],tile[0]); 		Combine_Vertically(C1_C2,C3_Ov);}
	if (channels>=4)				C3_C4 =		Combine_Horizontally(tile[3],tile[4]);
	if (channels==4)							Combine_Vertically(C1_C2_Ov,C3_C4);
	if (channels==5){				C1234 = 	Combine_Vertically(C1_C2,C3_C4); 	C5_Ov =	Combine_Vertically(tile[5],tile[0]); Combine_Horizontally(C1234,C5_Ov);}
	}
	
	function linearView(){
	C1_C2 = 					Combine_Horizontally(tile[1],tile[2]);
	if (channels==2)			Combine_Horizontally(C1_C2,tile[0]);
	if (channels==3){	C3_Ov = Combine_Horizontally(tile[3],tile[0]);			Combine_Horizontally(C1_C2,C3_Ov);}
	if (channels>=4){	C3_C4 =	Combine_Horizontally(tile[3],tile[4]);	C1234 =	Combine_Horizontally(C1_C2,C3_C4);}
	if (channels==4)			Combine_Horizontally(C1234,tile[0]);
	if (channels==5){	C5_Ov = Combine_Horizontally(tile[5],tile[0]);			Combine_Horizontally(C1234,C5_Ov);}
	}
	
	function brugiaStyle(){
						C1_C2 = Combine_Vertically(tile[1],tile[2]);
	if (channels==2)			Combine_Vertically(C1_C2,tile[0]);
	if (channels==3){	C3_Ov = Combine_Vertically(tile[3],tile[0]);		Combine_Vertically(C1_C2,C3_Ov);}
	if (channels>=4){	C3_C4 =	Combine_Vertically(tile[3],tile[4]);C1234 = Combine_Vertically(C1_C2,C3_C4);}
	if (channels==4)			Combine_Vertically(C1234,tile[0]);
	if (channels==5){	C5_Ov = Combine_Vertically(tile[5],tile[0]);		Combine_Vertically(C1234,C5_Ov);}
	}
	
	function Combine_Horizontally(stack1,stack2){ //returns result image title *.*
	run("Combine...", "stack1=&stack1 stack2=&stack2");
	rename(stack1+"_"+stack2);
	return getTitle();
	}
	
	function Combine_Vertically(stack1,stack2){
	run("Combine...", "stack1=&stack1 stack2=&stack2 combine"); //vertically
	rename(stack1+"_"+stack2);
	return getTitle();
	}
}

function getSplitViewPrefs(){
	Dialog.createNonBlocking("Labeled Prefs");
	Dialog.addMessage("choose your weapon!");
	Dialog.addRadioButtonGroup("Color style", newArray("Colored","Grayscale"), 1, 3, "Colored");
	Dialog.addRadioButtonGroup("Montage style", newArray("Linear","Square","Brugia"), 1, 3, "Linear");
	Dialog.show();
	color = Dialog.getRadioButton();
	style = Dialog.getRadioButton();
	if		(color=="Colored"   && style=="Linear") SplitView(1,0,1);
	else if (color=="Grayscale" && style=="Linear") SplitView(0,0,1);
	else if (color=="Colored"   && style=="Square") SplitView(1,1,1);
	else if (color=="Grayscale" && style=="Square") SplitView(0,1,1);
	else if (color=="Colored"   && style=="Brugia") SplitView(1,2,1);
	else if (color=="Grayscale" && style=="Brugia") SplitView(0,2,1);
}

//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------

function LUTbaker(){
	noRGB_errorCheck();
	Rz = newArray(4); Gz = newArray(4); Bz = newArray(4); preview = 1; inv = 0;
	Stack.getPosition(ch,s,f);
	getDimensions(w,h,CH,s,f);
	getLocationAndSize(x, y, w, h);
	id = getImageID();
	SavedRz = newArray(4); SavedGz = newArray(4); SavedBz = newArray(4);
	for(i=0; i<CH; i++) { //Save actual LUTs for undo
		if(CH>1)Stack.setChannel(i+1);
		getLut(r,g,b); 
		if (is("Inverting LUT")) { R = r[0];   G = g[0];   B = b[0];   }
		else 					 { R = r[255]; G = g[255]; B = b[255]; }
		SavedRz[i] = R; SavedGz[i] = G; SavedBz[i] = B;
	}
	while ( preview ) { //LUT baking
		setBatchMode(1);
		totR = 0; totG = 0; totB = 0;
		if (getInfo("os.name")!="Mac OS X") Dialog.createNonBlocking("§ The LUT baker §");
		else Dialog.createNonBlocking("◊ The LUT baker ◊");
		Dialog.setLocation(x+w,y);
		for(i=0; i<CH; i++) {
			if(CH>1)Stack.setChannel(i+1);
			getLut(r,g,b); 
			if (is("Inverting LUT")) { R = r[0];   G = g[0];   B = b[0];   }
			else 					 { R = r[255]; G = g[255]; B = b[255]; }
			Rz[i] = R; Gz[i] = G; Bz[i] = B;
			totR += R; totG += G; totB += B;
			if (getInfo("os.name")!="Mac OS X") Dialog.addMessage("_ LUT " + (i+1) + " _", 20, lutToHex(R,G,B));
			else Dialog.addMessage("◊ LUT " + (i+1) + "◊", 20, lutToHex(R,G,B));
			Dialog.addSlider("red",	 0,255, R);
			Dialog.addSlider("green",0,255, G);
			Dialog.addSlider("blue", 0,255, B);
		}
		if(CH>1)Stack.setChannel(ch); 
		Dialog.setInsets(20, 0, 0);
		Dialog.addMessage("Reds= "+totR+"   Greens= "+totG+"   Blues= "+totB);
		if (is_InvertableLUTs()) Dialog.addMessage("These LUTs are invertable ;)");
		else Dialog.addMessage("These LUTs won't be invertable :s");
		Dialog.addCheckbox("update changes", 1); 
		Dialog.addCheckbox("inverted LUTs", inv); 
		Dialog.addCheckbox("Reset all", 0);
		setBatchMode(0);
		Dialog.show();
		setBatchMode(1);
		preview = Dialog.getCheckbox();
		inv = Dialog.getCheckbox();
		undo = Dialog.getCheckbox();
		selectImage(id);
		for(k=0; k<CH; k++){
			Rz[k]=Dialog.getNumber();
			Gz[k]=Dialog.getNumber();
			Bz[k]=Dialog.getNumber();
			if (CH>1) Stack.setChannel(k+1);
			LUTmaker(Rz[k],Gz[k],Bz[k]);
			if (inv) run("Invert LUT");
		}
		if (undo==1) { //Undo all modifications
			for(k=0; k<CH; k++){
				if (CH>1) Stack.setChannel(k+1);
				LUTmaker(SavedRz[k],SavedGz[k],SavedBz[k]);
			}
			preview = 0;
		}
	}
	if (CH>1) Stack.setChannel(ch);
	setBatchMode(0);
}

function LUTmaker(r,g,b){
	R = newArray(256); G = newArray(256); B = newArray(256);
	for(i=0; i<256; i++) { 
		R[i] = (r/256)*(i+1);
		G[i] = (g/256)*(i+1);
		B[i] = (b/256)*(i+1);
	}
	setLut(R, G, B);
}

function invertedLUTmaker(){
	getLut(r,g,b);
	if(r[255]==g[255]&&r[255]==b[255]) run("Invert LUT"); //grayscale case
	else {
		R = newArray(256); G = newArray(256); B = newArray(256);
		for(i=256;i>0;i--) { 
			R[i-1] = 256-(((256-r[255])/256)*i);
			G[i-1] = 256-(((256-g[255])/256)*i);
			B[i-1] = 256-(((256-b[255])/256)*i);}
		setLut(R, G, B);
	}
}

function lutToHex(R,G,B){
	if (R<16) xR = "0" + toHex(R); else xR = toHex(R);
	if (G<16) xG = "0" + toHex(G); else xG = toHex(G);
	if (B<16) xB = "0" + toHex(B); else xB = toHex(B);
	return "#"+xR+xG+xB;
}

function is_InvertableLUTs(){ //invertable LUTs check
	setBatchMode(1);
	getDimensions(w,h,CH,s,f);
	totR = 0; totG = 0; totB = 0;
	for(i=0; i<CH; i++) {
		if(CH>1)Stack.setChannel(i+1);
		getLut(r,g,b); 
		if (is("Inverting LUT")) { R = r[0];   G = g[0];   B = b[0];   }
		else 					 { R = r[255]; G = g[255]; B = b[255]; }
		totR += R; totG += G; totB += B;
	}
	if (CH==1) yesItis = 1;
	else if (CH==2) { if(totR+totG+totB==765) yesItis = 1; else yesItis = 0; }
	else {
		if (is("Inverting LUT")) { if (totG==totR&&totB==totR) yesItis = 1; else yesItis = 0; }
		else { if (totR+totG+totB==1530) yesItis = 1; else yesItis = 0; }
	}
	setBatchMode(0);
	return yesItis;
}

function invert_invertable_LUTs(){
	getDimensions(w, h, channels, s, f);
	if		(channels==1) iLUT();
	else if (channels==2) invert2_iLUTs();
	else if (channels==3) invert3_iLUTs();
	else 				  invert4_iLUTs();
}

function iLUT(){
	if(is("Inverting LUT")) {
		getLut(r,g,b);
		if(r[255]==g[255]&&r[255]==b[255]) run("Invert LUT"); //grayscale case
		else LUTmaker(r[255],g[255],b[255]);
	}
	else invertedLUTmaker();
}

function invert2_iLUTs(){
	Stack.getPosition(ch,s,f);
	setBatchMode(1);
	Stack.setChannel(1); getLut(r,g,b);
	Stack.setChannel(2); getLut(r2,g2,b2);		
	Stack.setChannel(1); setLut(r2,g2,b2);	run("Invert LUT");
	Stack.setChannel(2); setLut(r,g,b);		run("Invert LUT");
	Stack.setChannel(ch); 
	setBatchMode(0);
}

function invert3_iLUTs() {
	Stack.getPosition(ch,s,f);
	getDimensions(w,h,CH,s,f);
		setBatchMode(1);
		for(i=0; i<CH; i++) {
			Stack.setChannel(i+1);
			getLut(r,g,b);
			if(!is("Inverting LUT")){ 
				R=((256-r[255]/2)-128)*2;
				G=((256-g[255]/2)-128)*2;
				B=((256-b[255]/2)-128)*2;
				LUTmaker(R-1,G-1,B-1);
				run("Invert LUT");		}
			else {
				R=((256-r[0]/2)-128)*2;
				G=((256-g[0]/2)-128)*2;
				B=((256-b[0]/2)-128)*2;	
				LUTmaker(R-1,G-1,B-1);		}
			}
		if(CH>1)Stack.setChannel(ch); 
	setBatchMode(0);
}

function invert4_iLUTs() {
	Stack.getPosition(ch,s,f);
	getDimensions(w,h,CH,s,f);
		setBatchMode(1);
		R = 0; G = 0; B = 0;
		for(i=0; i<CH; i++) {
			Stack.setChannel(i+1);
			getLut(r,g,b);
			if (!is("Inverting LUT")){ 
				R=((256-r[255]/2)-128);
				G=((256-g[255]/2)-128);
				B=((256-b[255]/2)-128);
				LUTmaker(R,G,B);
				run("Invert LUT");		
			}
			else {
				if (r[0]==128) R=0; else if (r[0]==0) R=255; else R=((256-r[0])-128)*2;
				if (g[0]==128) G=0; else if (g[0]==0) G=255; else G=((256-g[0])-128)*2;
				if (b[0]==128) B=0; else if (b[0]==0) B=255; else B=((256-b[0])-128)*2;
				LUTmaker(R,G,B);		
			}
		}
		if(CH>1)Stack.setChannel(ch); 
	setBatchMode(0);
}

var source=0;

macro "copy paste LUT set"{
	title=getTitle();
	getDimensions(w,h,CH,s,f);
	list = getList("image.titles");
	Dialog.create("apply LUTs");
	Dialog.addChoice("source", list, source);
	Dialog.addChoice("destination",list,title);
	Dialog.show();
	setBatchMode(1);
	source = Dialog.getChoice();
	dest = Dialog.getChoice();
	selectWindow(source);
	for (i = 0; i < CH; i++) {
		selectWindow(source);
		Stack.setChannel(i+1);
		getLut(reds, greens, blues);
		selectWindow(dest);
		Stack.setChannel(i+1);
		setLut(reds, greens, blues);
	}
	setBatchMode(0);
}

function ReorderLUTsAsk(){
	if (nImages == 0) exit("no image");
	if (bitDepth() == 24) exit("won't works on RGB images");
	getDimensions(null, null, channels, null, null);
	if (channels == 2) {
		Stack.setChannel(1); getLut(reds, greens, blues);
		Stack.setChannel(2); getLut(reds2, greens2, blues2);
		Stack.setChannel(1); setLut(reds2, greens2, blues2);
		Stack.setChannel(2); setLut(reds, greens, blues);
		exit;	
	}
	Stack.getPosition(Channel, slice, frame);

	//prompt LUTs order and ask for the new one
	Dialog.create("Reorder LUTs");
	for (i = 1; i <= channels; i++) {
		Stack.setChannel(i);
		getLut(r,g,b);
		if (is("Inverting LUT")) { R = r[0];   G = g[0];   B = b[0];   }
		else 					 { R = r[255]; G = g[255]; B = b[255]; }
		Dialog.addMessage("    LuT "+i, 20, Color.toString(R,G,B));
	}
	makeRectangle(5,5,5,5); run("Select None"); //trick to update image display
	Dialog.addString("New LUTs order", "", channels);
	Dialog.show();

	//get new order
	new = Dialog.getString();
	if (new.length>channels) exit("Please set the right number of LUTs");

	//dup all channels in one slice, reorder channels, then transfert LUTs to original image
	title=getTitle();
	setBatchMode(1);
	run("Duplicate...","title=dup duplicate frames=1 slices=1");
	run("Arrange Channels...", "new=&new");
	for (i = 1; i <= channels; i++) {
		selectWindow("dup");
		Stack.setChannel(i);
		getLut(r, g, b);
		selectWindow(title);
		Stack.setChannel(i);
		setLut(r, g, b);
	}
	Stack.setPosition(Channel, slice, frame);
	setBatchMode(0);
}

function invert_all_LUTs() {
	getDimensions(width, height, channels, slices, frames);
	for (i = 1; i <= channels; i++) {
		Stack.setChannel(i);
		run("Invert LUT");
	}
}

macro"random invertable LUTs [K]"{
	getDimensions(w,h,CH,s,f);
	Rz = randomArrayTo255(CH); Gz = randomArrayTo255(CH); Bz = randomArrayTo255(CH);
	setBatchMode(0);
	for(k=0; k<CH; k++){
		Stack.setChannel(k+1);
		if (CH==2)	{ 
			if(!is("Inverting LUT"))	LUTmaker(Rz[k],Gz[k],Bz[k]);
			else 					{	LUTmaker(Rz[k],Gz[k],Bz[k]); run("Invert LUT");}
		}
		else 	{ 
			if(!is("Inverting LUT"))	LUTmaker(Rz[k]*2,Gz[k]*2,Bz[k]*2);
			else 					{	LUTmaker(Rz[k],Gz[k],Bz[k]); run("Invert LUT");}
		}
	}
	setBatchMode(0);
}

function randomArrayTo255(arraySize){ 
	array = newArray(arraySize); loop=1;
	while (loop) {
		arraySUM=0;
		for (i = 0; i < arraySize; i++) {
			if (arraySize==2)	array[i] = round(random*255);
			else 				array[i] = round(random*127);
			 arraySUM += array[i];
		}
		if (arraySUM==255)loop=0;
	}
	return array;
}


function invertedOverlay1(){
	R = 0; G = 0; B = 0;
	setBatchMode(1);
	run("Duplicate...","duplicate");
	if( bitDepth() == 24 ) run("Make Composite");
	run("Remove Slice Labels");
	getDimensions(w,h,channels,s,f);
	for(A=1;A<=channels;A++){
		Stack.setChannel(A);
		getLut(r,g,b);
		R=255-r[255];
		G=255-g[255];
		B=255-b[255];
		LUTmaker(R,G,B);
	}
	Stack.setDisplayMode("color");
	run("RGB Color");
	run("Z Project...", "projection=[Average Intensity]");
	run("Enhance Contrast", "saturated=0.001");
	run("Invert");
	setOption("Changes", 0);
	setBatchMode(0);
}

function invertedOverlay2(){
	setBatchMode(1);
	run("Duplicate...","duplicate"); 
	if( bitDepth() != 24 ) {Stack.setDisplayMode("composite"); run("Stack to RGB");}
	run("Make Composite");
	run("Remove Slice Labels");
	getDimensions(w,h,channels,s,f);
	Stack.setChannel(1); LUTmaker(0,127,128); run("Invert LUT"); resetMinAndMax;
	Stack.setChannel(2); LUTmaker(128,0,127); run("Invert LUT"); resetMinAndMax;
	Stack.setChannel(3); LUTmaker(127,128,0); run("Invert LUT"); resetMinAndMax;
	Stack.setDisplayMode("color"); Stack.setDisplayMode("composite");
	run("RGB Color");
	setOption("Changes", 0);
	setBatchMode(0);
}

function invertedOverlay3(){
	setBatchMode(1);
	rgbSnapshot();
	run("Invert");
	run("HSB Stack");
	run("Macro...", "code=v=(v+128)%256 slice");
	run("RGB Color");
	setOption("Changes", 0);
	setBatchMode(0);
}
macro "RGBtimeIsOver" {
    hues=30;
    setBatchMode(1);
    if (nImages==0) exit("no image");
    if (bitDepth() == 24) {
        run("Duplicate...","duplicate");
        run("Make Composite");
        run("Remove Slice Labels");
    }
	Stack.setChannel(1); LUTmaker(0,127,128);
	Stack.setChannel(2); LUTmaker(128,0,127);
	Stack.setChannel(3); LUTmaker(127,128,0);
    run("RGB Color", "keep");
    run("Enhance Contrast", "saturated=0.1");
    run("Duplicate...","title=temp");
    run("Size...", "width="+Image.width+" height="+Image.height+" depth="+hues+" constrain average interpolation=Bilinear");
    run("HSB Stack");
    Stack.getDimensions(width, height, channels, slices, frames);
    Stack.setChannel(1);
    for(i=1; i<=slices; i++) {
        showProgress(i, hues);
        Stack.setSlice(i);
        run("Macro...", "code=v=(v+"+i*256/hues+")%256 slice");
    }
    run("RGB Color", "slices keep");
    setOption("Changes", 0);
    setBatchMode(0);
    run("Animation Options...", "speed=15 start");
}

macro "JeromesWheel"{
	hues=30;
	setBatchMode(1);
	run("Duplicate...","title=temp");
	run("Size...", "width="+Image.width+" height="+Image.height+" depth="+hues+" constrain average interpolation=Bilinear");
	run("HSB Stack");
	Stack.getDimensions(width, height, channels, slices, frames);
	Stack.setChannel(1);
	for(i=1; i<=slices; i++) {
				showProgress(i, hues);
	      Stack.setSlice(i);
	      run("Macro...", "code=v=(v+"+i*256/hues+")%256 slice");
	}
	run("RGB Color", "slices keep");
	setOption("Changes", 0);
	run("Animation Options...", "speed=15 start");
	setBatchMode(0);
}

macro "rajout de bout" { //for better ClearVolume
	setBatchMode(1);
	source = getTitle();
	getVoxelSize(xwidth, xheight, depth, unit);
	run("Duplicate...","duplicate")
	dup = getTitle();
	if (bitDepth()!=24) type = toString(bitDepth())+"-bit";
	else type = "RGB";
	getDimensions(width, height, channels, slices, frames);
	newImage("1", type +" color-mode", width, height, channels, 2, 1);
	newImage("2", type +" color-mode", width, height, channels, 2, 1);
	run("Concatenate...", "  image1=1 image2=&dup image3=2");
	rename(dup+" bou");
	dest = getTitle();
	selectWindow(source);
	for (i = 0; i < channels; i++) {
		selectWindow(source);
		Stack.setChannel(i+1);
		getLut(reds, greens, blues);
		selectWindow(dest);
		Stack.setChannel(i+1);
		setLut(reds, greens, blues);
	}
	Stack.setPosition(1, slices/2, frames/2);
	Auto_Contrast_on_all_channels();
	setVoxelSize(xwidth, xheight, depth, unit);
	setOption("Changes", 0);
	setBatchMode(0);
}

macro "make my LUTs" {
	lutsFolder = getDirectory("luts");
	newImage("bo", "8-bit composite-mode", 400, 400, 4, 1, 1);
	setBackgroundColor(255,255,255);
	Stack.setChannel(1);
	makeRectangle(0, 0, 213, 213);
	run("Clear", "slice");
	LUTmaker(0,155,255);
	saveAs("LUT", lutsFolder + "/kb.lut");
	Stack.setChannel(2);
	makeRectangle(187, 0, 213, 213);
	run("Clear", "slice");
	LUTmaker(255,100,0);
	saveAs("LUT", lutsFolder + "/ko.lut");
	Stack.setChannel(3);
	makeRectangle(187, 187, 213, 213);
	run("Clear", "slice");
	LUTmaker(205,50,255);
	saveAs("LUT", lutsFolder + "/km.lut");
	Stack.setChannel(4);
	makeRectangle(0, 187, 213, 213);
	run("Clear", "slice");
	LUTmaker(50,205,0);
	saveAs("LUT", lutsFolder + "/kg.lut");
	run("Select None");
	setOption("Changes", 0);
}

//need scaled image to 256 pix width
macro "rgb LUT to LUT" {
	R = newArray(1); G = newArray(1); B = newArray(1);
	for (i = 0; i < 256; i++) {
		c = getPixel(i, 2);
		R[i] = (c>>16)&0xff; 	G[i] = (c>>8)&0xff;		B[i] = c&0xff;
	}
	newImage("LUT from RGB", "8-bit ramp", 256, 32, 1);
	setLut(R, G, B);
}

/*macro "print title and minMax" {
	getDimensions(width, height, channels, slices, frames);
	print("------\n"+getTitle());
	for (i = 0; i < channels; i++) {
		Stack.setChannel(i+1);
		getMinAndMax(min, max);
		print("------\n Channel "+i+1+"\n min="+min+"\n max="+max);
	}
}

macro "copy paste minMax"{
	title=getTitle();
	getDimensions(w,h,CH,s,f);
	list = getList("image.titles");
	Dialog.create("share contrasts");
	Dialog.addChoice("source", list );
	Dialog.addChoice("destination",list,title);
	Dialog.show();
	setBatchMode(1);
	source = Dialog.getChoice();
	dest = Dialog.getChoice();
	selectWindow(source);
	for (i = 0; i < CH; i++) {
		selectWindow(source);
		Stack.setChannel(i+1);
		getMinAndMax(min, max);
		selectWindow(dest);
		Stack.setChannel(i+1);
		setMinAndMax(min, max);
	}
	setBatchMode(0);
}*/

/*------SPLITVIEWz
var zCmds = newMenu("SplitView tools Menu Tool",
	newArray("Colored squared Splitview","Grayscaled squared Splitview","Colored linear Splitview","Grayscaled linear Splitview","Labeled Splitview"));
macro"SplitView tools Menu Tool - N55C000D00D01D02D03D04D05D06D07D08D09D0aD0bD0dD0eD10D11D12D13D14D15D16D19D1dD1eD20D21D22D23D24D25D26D27D2dD2eD30D31D33D35D3dD3eD40D43D4dD4eD50D52D53D5dD5eD60D61D6dD6eD9bD9eDa0Da1Da2Da3Da5Da6DadDaeDb0Db1Db2Db3Db6Db7Db8Db9DbaDbbDbdDbeDc0Dc1Dc2Dc3Dc4Dc5Dc6Dc7Dc8Dc9DcaDcbDcdDceDe0De1De2De3De4De5De6De7De8De9DeaDebDedDeeC000D17D1bD32D34D41D51D90D91D9dDa9DaaDabDb4Db5C82aD28D29D36D37D3aD45D54D63D72D81D82D83D8aD8eD94D99C010D5bC0eeC101D18D1aD2bD3bD42D44D62D70D7dD92Da4Da8Cf0fC523D8bCfffD0cD1cD2cD3cD46D47D4cD55D56D57D58D5cD65D66D67D68D6cD75D76D77D7cD8cD9cDacDbcDccDd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7Dd8Dd9DdaDdbDdcDddDdeDecC000Ce0eD38D4aD5aD6aD73D7aD95D96D97D98C023D6bD7bCfcfD64D74C404D2aD4bD71D7eD80D8dD93D9aDa7Cf4fD39D48D49D59D69D78D79D84D85D86D87D88D89Cee0Bf0C000D00D01D02D03D04D05D06D07D08D09D0aD0bD0dD0eD10D11D12D13D14D15D16D1bD1dD1eD20D21D22D23D24D2bD2dD2eD30D31D32D33D3bD3dD3eD40D41D42D43D4bD4dD4eD50D51D5bD5dD5eD60D68D6dD6eD70D71D72D73D77D78D79D7aD7dD7eD80D81D82D83D84D86D87D88D89D8aD8bD8dD8eD90D91D92D93D94D95D96D97D98D99D9aD9bD9dD9eDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDadDaeC000C82aC010D18D19D2aD3aD4aD5aD76C0eeD35D36D37D38D44D45D46D47D48D54D55D56D57D64D65D66C101Cf0fC523CfffD0cD1cD2cD3cD4cD5cD6cD7cD8cD9cDacC000D17D1aD52D61D62D69D6aD6bD7bD85Ce0eC023D25D26D27D28D29D34D39D49D53D58D59D63D67D74D75CfcfC404Cf4fCee0B0fC000D00D01D02D03D04D05D06D07D08D09D0aD10D11D14D18D19D1aD20D21D22D28D29D2aD30D31D39D3aD40D41D48D49D4aD50D57D58D59D5aD60D66D67D68D69D70D71D74D75D76D77D78D79D80D81D82D83D84D85D86D87D88D89D8aD90D91D92D93D94D95D96D97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaC000D12D13D15D38D6aD72D7aC82aC010D16D17D27D51D61D73C0eeC101Cf0fC523D23D26D32D37D47D56D62D65CfffC000Ce0eC023CfcfC404Cf4fCee0D24D25D33D34D35D36D42D43D44D45D46D52D53D54D55D63D64Nf0C000D00D01D02D03D05D06D07D08D09D0aD10D11D12D13D14D15D17D1aD20D21D22D23D24D25D31D32D33D3aD41D4aD50D51D5aD6aD7aD89D8aD99Da0Da1Da2Da3Da9DaaDb0Db1Db3Db4Db5Db6Db7Db8Db9DbaDc0Dc1Dc2Dc3Dc4Dc5Dc6Dc7Dc8Dc9DcaDe0De1De2De3De4De5De6De7De8De9DeaC000D16D19D29D2aD30D40D42D60D9aDa7Da8Db2C82aD27D35D38D43D48D52D68D70D80D81D88D92D96D97C010C0eeC101D04D18D39D59D69D90Da4Da5Da6Cf0fD37D44D45D46D47D53D54D55D56D57D62D63D64D65D66D67D72D73D74D75D76D77D82D83D84D85C523CfffDd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7Dd8Dd9DdaC000Ce0eD36D58D71D78D86D87D93D94D95C023CfcfC404D26D28D34D49D61D79D91D98Cf4fCee0"{
	cmd = getArgument();
	if (cmd=="Colored linear Splitview")	 SplitView(1,0,0);
	if (cmd=="Grayscaled linear Splitview")	 SplitView(0,0,0);
	if (cmd=="Colored squared Splitview")	 SplitView(1,1,0);
	if (cmd=="Grayscaled squared Splitview") SplitView(0,1,0);
	if (cmd=="Labeled Splitview")			 getSpVpref();
}*/

//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
macro "AutoRun" {
	// run all the .ijm scripts provided in macros/AutoRun/
	//autoRunDirectory = getDirectory("imagej") + "/macros/AutoRun/";
	//if (File.isDirectory(autoRunDirectory)) { list = getFileList(autoRunDirectory); Array.sort(list); for (i = 0; i < list.length; i++) {if (endsWith(list[i], ".ijm")) {runMacro(autoRunDirectory + list[i]);}}}
	eval("js", "javax.swing.UIManager.setLookAndFeel('javax.swing.plaf.metal.MetalLookAndFeel');");//------------------------------------------------
}
function UseHEFT {requires("1.38f");state = call("ij.io.Opener.getOpenUsingPlugins");if (state=="false") {setOption("OpenUsingPlugins", true);showStatus("TRUE (images opened by HandleExtraFileTypes)");} else {setOption("OpenUsingPlugins", false);showStatus("FALSE (images opened by ImageJ)");}}
UseHEFT();

var pencilWidth=1,eraserWidth=10,leftClick=16,alt=8,brushWidth=10,floodType="8-connected";
var xx = requires138b(); // check version at install
function requires138b() {requires("1.38b"); return 0; }
function getLutMenu() {list = getLutList();menu = newArray(16+list.length);menu[0] = "Invert LUT"; menu[1] = "Edit LUT..."; menu[2] = "-";menu[3] = "Fire"; menu[4] = "Grays"; menu[5] = "Ice";menu[6] = "1_Ultime"; menu[7] = "1a myTurbo"; menu[8] = "Red";menu[9] = "Green"; menu[10] = "Blue"; menu[11] = "Cyan";menu[12] = "Magenta"; menu[13] = "Yellow"; menu[14] = "Red/Green";menu[15] = "-";for (i=0; i<list.length; i++)menu[i+16] = list[i];return menu;}
function getLutList() {lutdir = getDirectory("luts");list = newArray("No LUTs in /ImageJ/luts");if (!File.exists(lutdir))return list;rawlist = getFileList(lutdir);if (rawlist.length==0)return list;count = 0;for (i=0; i< rawlist.length; i++)if (endsWith(rawlist[i], ".lut")) count++;if (count==0)return list;list = newArray(count);index = 0;for (i=0; i< rawlist.length; i++) {if (endsWith(rawlist[i], ".lut"))list[index++] = substring(rawlist[i], 0, lengthOf(rawlist[i])-4);}return list;}
macro 'Pencil Tool Options...' {pencilWidth = getNumber("Pencil Width (pixels):", pencilWidth);}
macro 'Paintbrush Tool Options...' {brushWidth = getNumber("Brush Width (pixels):", brushWidth);call("ij.Prefs.set", "startup.brush", brushWidth);}
macro 'Flood Fill Tool Options...' {Dialog.create("Flood Fill Tool");Dialog.addChoice("Flood Type:", newArray("4-connected", "8-connected"), floodType);Dialog.show();floodType = Dialog.getChoice();call("ij.Prefs.set", "startup.flood",floodType);}
macro "Set Drawing Color..."{run("Color Picker...");}
macro "-" {} //menu divider
macro "Save Inverted FITS" {run("Flip Vertically");	run("FITS...", "");run("Flip Vertically");}
