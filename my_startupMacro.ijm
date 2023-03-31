// Kevin Terretaz
// StartupMacros perso
// global variables are in UPPER_CASE

// macro "test Tool - C000 T0508T  T5508e  Ta508s Tg508t"{
// 	getCursorLoc(x, y, z, flags);
// 	showStatus(flags);
// }

macro "AutoRun" {
	//set inferno as default favorite lut (numerical 0 key)
	if (!File.exists(getDirectory("temp") + "/favoriteLUT.lut"))
		File.copy(getDirectory("luts") + "mpl-inferno.lut", getDirectory("temp") + "/favoriteLUT.lut");
	run("Roi Defaults...", "color=orange stroke=2 group=0");
	setForegroundColor(255, 255, 255);
	setBackgroundColor(0, 0, 0);
	setTool(15);setTool(15);
}

var SAVED_LOC_X = 0;
var SAVED_LOC_Y = screenHeight() - 470;

//for image window size backup (macro[2])
var X_POSITION_BACKUP = 300;
var Y_POSITION_BACKUP = 300;
var WIDTH_POSITION_BACKUP = 400;
var HEIGHT_POSITION_BACKUP = 400;

// for quick Set LUTs
var CHOSEN_LUTS = newArray("k_Blue","k_Magenta","k_Orange","k_Green","Grays","Cyan","Magenta","Yellow");
var NOICE_LUTs = 0;

// For split_View
var	COLOR_MODE = "Colored";
var MONTAGE_STYLE = "Linear";
var LABELS = 0;
var BORDER_SIZE = 0;
var FONT_SIZE = 30;
var CHANNEL_LABELS = newArray("CidB","CidA","DNA","H4Ac","DIC");
var TILES = newArray(1);

// For MultiTool
var MAIN_TOOL = "Move Windows";
var LIVE_AUTOCONTRAST = 0;
var SATURATION_RATE = 0.03;
var MULTITOOL_LIST = newArray("Move Windows", "Slice/Frame Scroll", "LUT Gamma Tool", "Curtain Tool", "Magic Wand", "Scale Bar Tool", "Multi-channel Plot Tool");

//For wand tool
var WAND_BOX_SIZE = 5;
var ADD_TO_MANAGER = 0;
var TOLERANCE_THRESHOLD = 40;
var EXPONENT = 2;
var FIT_MODE = "None";

// title of the assigned target image : space + [7] key 
var TARGET_IMAGE_TITLE = ""; 

// for Scale Bar Tool
var ADD_SCALEBAR_TEXT = true; 

// for counting tools
var COUNT_LINE = 0;

// for [f5]
var DO_SCROLL_LOOP = false;

// for Action Bars
var ACTION_BAR_STRING = "";

macro "Multi Tool - N55C000DdeCf00Db8Db9DbaDc7Dc8DcaDcbDd7DdbDe7De8DeaDebCfffDc9Dd8Dd9DdaDe9C777D02D11D12D17D18D21D28D2bD31D36D39D3aD3bD3eD41D42D46D47D4cD4dD4eD51D52D57D5bD5dD62D63D67D6dD72D73D74D75D76D77D83D85D86D94Cf90Da6Da7Da8Da9DaaDabDacDadDaeDb4Db5Dc4Dd4De4C444D03D19D22D29D2cD32D3cD43D4bD53D58D5eD64D68D6eD78D87Cf60D95D96D97D98D99D9aD9bD9cD9dD9eDa4Da5Db3Db6DbcDbdDbeDc3Dc5Dc6DccDcdDceDd3Dd5Dd6DdcDe3De5De6DecDedDeeC333Cf40Db7DbbDddBf0C000Cf00D08D09D0aCfffC777D13D22D23D24D32D33D35D36D37D38D39D3aD3bD42D43D46D47D48D49D4cD4dD52D53D54D58D59D5aD5dD5eD62D63D6aD6bD6cD6dD72D7cD7dD7eD82D8eD92Da2Cf90D05C444Cf60D03D04D06D0cD0dD0eD14D15D16D17D18D19D1aD1bD1cD1dD1eD25D26D27D28D29D2aD2bD2cD2dD2eC333D34D3cD3dD44D4eD64D73D83D93Da3Cf40D07D0bB0fC000D12Cf00CfffC777D50D60D61D62D70D72D73D74D80D81D82D83D84D85D86D91D92D93D94D95D96D97Da3Da4Da5Da6Da7Da8Cf90C444Cf60D00D04D05D06D09D10D18D20D21D23D24D25D26D27C333D01D02D03D40D51D52D63D64D75D76D87D98Da9Cf40D07D08D11D13D14D15D16D17D22Nf0C000Da2Dd2Dd5Cf00CfffC777D42D52D60D61D65D71D73D74D83D85D86Cf90Da0Da5Da6Db7Dc8C444D40D50D53D62D63D72D75D84Cf60D90D91D93D94D95D96D97Da1Da3Da4Da7Da8Db0Db4Db5Db6Db8Db9Dc5Dc6Dc7Dc9Dd7Dd8Dd9De5De6De7De9C333Db1Db2Db3Dc0Dc4Dd0Dd4De0De4Cf40D92Dc1Dc2Dc3Dd1Dd3Dd6De1De2De3De8" {
	multi_Tool();
}
macro "Multi Tool Options" {
	Dialog.createNonBlocking("Multitool Options");
	Dialog.setInsets(0, 0, 0);
	Dialog.addMessage("      Shift to adjust contrast");
	Dialog.setInsets(0, 0, 0);
	Dialog.addMessage("      Shift + alt to auto-adjust locally (75px box)");
	Dialog.addRadioButtonGroup("Main Tool : ", MULTITOOL_LIST, 4, 2, MAIN_TOOL);
	Dialog.addCheckbox("text under scale bar?", ADD_SCALEBAR_TEXT);
	// Dialog.addCheckbox("live auto contrast?", LIVE_AUTOCONTRAST);
	// Dialog.addSlider("%", 0, 0.5, SATURATION_RATE);
	Dialog.setInsets(0, 0, 0);
	Dialog.addMessage("Magic Wand options : ______________________________");
	Dialog.addNumber("Maxima window size", WAND_BOX_SIZE);
	Dialog.addSlider("tolerance estimation threshold", 0, 100, TOLERANCE_THRESHOLD);
	Dialog.addSlider("Exponent for adjustment value", 1, 2, EXPONENT);
	Dialog.addCheckbox("auto add ROI to manager?", ADD_TO_MANAGER);
	Dialog.addChoice("Fit selection? How?", newArray("None","Fit Spline","Fit Ellipse"), FIT_MODE);
	Dialog.addHelp("https://kwolby.notion.site/Multi-Tool-526950d8bafc41fd9402605c60e74a99");
	Dialog.show();
	MAIN_TOOL =				Dialog.getRadioButton();
	ADD_SCALEBAR_TEXT = 	Dialog.getCheckbox();
	// LIVE_AUTOCONTRAST = 	Dialog.getCheckbox();
	// SATURATION_RATE =		Dialog.getNumber();
	WAND_BOX_SIZE =			Dialog.getNumber();
	TOLERANCE_THRESHOLD =	Dialog.getNumber();
	EXPONENT =				Dialog.getNumber();
	ADD_TO_MANAGER =		Dialog.getCheckbox();
	FIT_MODE =				Dialog.getChoice();
}
//--------------------------------------------------------------------------------------------------------------------------------------
//------SHORTCUTS
//--------------------------------------------------------------------------------------------------------------------------------------
var ShortcutsMenu = newMenu("Custom Menu Tool",
	newArray( "Batch convert to tiff", "Merge Ladder and Signal WB",
		 "-","Rotate 90 Degrees Right","Rotate 90 Degrees Left", "make my LUTs",
		 "-", "Median...", "Gaussian Blur...","Gaussian Blur 3D...","Gamma...","Voronoi Threshold Labler (2D/3D)"));
macro "Custom Menu Tool - N55C000D1aD1bD1cD1dD29D2dD39D3dD49D4dD4eD59D5eD69D75D76D77D78D79D85D88D89D94D98D99Da4Da7Da8Da9Db3Db7Db8Dc3Dc6Dc7DccDcdDd3Dd6Dd8DdbDdcDe2De3De6De8De9DeaDebDecCfffD0dD3cD5cD6dD7bD8bD8cD96D9aD9bDa5DacDadDb5DcaDd4Dd9DdaDe4CdddD0aD1eD2bD6aD74D7aD95Dc4Dc5DeeC222D8eDa3DbcC111D38D5bD6bD7dDabDbaDd7C888D66De5C666D19Db4DcbC900CbbbD0cD87DaeDb2C444D28D2aD3eD48D84Db6Dc2CaaaDb9DedC777D0bD2eD4aD6cD7cD7eD9cD9dD9eDbdDc8CcccD2cDdeDe7C333D67D68DbeDd2DddC999D4cD58D5aD5dD93DceDd5Bf0C000D03D06D0cD13D16D1bD23D26D2aD33D37D39D43D44D47D48D54D65D76D77D87D88D89D8aD8bD8cD8dD8eD9bCfffD04D08D0dD0eD14D18D19D24D28D2cD35D3bD3cD3dD3eD45D46D4aD4bD4cD4eD56D57D5aD5bD5cD5dD5eD68D69D6aD6bD6cD6dD7cD7dCdddD1cD25D63D7eD97C222D64D66D9aC111D02D0bD36C888D98C666D12D38D78C900CbbbD0aD15D1eD2dD32D34C444D22D49D55D75D86D9cD9dCaaaD05D29D53C777D27D3aCcccD09D17C333D99C999D1aD2bD58D9eB0fC000D02D03D04D05D08D09D18D27D28D36D37D45D46D54D55D63D64D71D72D80D81CfffD06D07D16D25D30D34D35D40D43D44D52D57D60D61D75D83D85CdddD10D22D32D33D42D74C222D01D13D14D73C111C888D47D70C666C900D56D66D67D76D77D78D86D87D96CbbbD12D15D19D20D23D24D41D82C444D17CaaaC777D00CcccD11D26D90C333C999D62D65Nf0C000D33D34D35D36D42D43D46D50D51D55D64D65D66D67D73D74D78D88D96D97Da4Da5Db4Dc4Dd4Dd6Dd7Dd8De3De4De6De8De9CfffD15D31D44D53D54D58D62D84D85D86D92D93Da2Db2Dc2Dd2De7CdddD63Da1Da7Dc1Dd0De2C222D75D95Db3C111C888D23D32D45Dc3C666D40D52D57C900CbbbD70D80D94C444D24D60D68D87Da3Db0CaaaD26Dc0C777D41D81D91D98Dc7De5CcccD61D72D79D83D89Dc5Dd5Dd9De1C333D25D47D56D77Da0C999D37D76D90Da6Db5Dc6Dc8Dd3" {
	cmd = getArgument(); 
	if 		(cmd=="Batch convert to tiff") 			batch_ims_To_tif();
	else if (cmd=="Merge Ladder and Signal WB")		merge_Ladder_And_Signal_From_Licor();
	else if (cmd=="make my LUTs")					make_My_LUTs();
	else run(cmd);
}

macro "Stacks Menu Built-in Tool" {}

//--------------------------------------------------------------------------------------------------------------------------------------
//------POPUP
//--------------------------------------------------------------------------------------------------------------------------------------
var pmCmds = newMenu("Popup Menu",
	newArray("Remove Overlay", "Duplicate...","Set LUTs","Set active path", "Set target image",
	 "-", "CLAHE", "Gaussian Correction", "Color Blindness",
	 "-", "Record...", "Monitor Memory...","Control Panel...", "Startup Macros..."));
macro "Popup Menu" {
	cmd = getArgument(); 
	if 		(cmd == "CLAHE") 				CLAHE();
	else if (cmd == "Set active path") 		set_Active_Path();
	else if (cmd == "Rajout de bout") 		rajout_De_Bout();
	else if (cmd == "Gaussian Correction") 	gauss_Correction();
	else if (cmd == "Color Blindness") 		{rgb_Snapshot(); run("Dichromacy", "simulate=Deuteranope");}
	else if (cmd == "Set LUTs") 			{get_LUTs_Dialog(); apply_LUTs();}
	else if (cmd == "Rotate LUT") 			rotate_LUT();
	else if (cmd == "Set target image") 	set_Target_Image();
	else run(cmd); 
}

// macro "LUT Menu Built-in Tool" {}

macro "Preview Opener Action Tool - N66C000D34D35D36D37D38D39D3aD3bD3cD3dD3eD44D49D4eD54D59D5eD64D69D6eD74D79D7eD84D85D86D87D88D89D8aD8bD8cD8dD8eD94D99D9eDa4Da9DaeDb4Db9DbeDc4Dc9DceDd4Dd5Dd6Dd7Dd8Dd9DdaDdbDdcDddDdeDe4De9DeeC95fD4aD4bD4cD4dD5aD5bD5cD5dD6aD6bD6cD6dD7aD7bD7cD7dC09bC5ffCf05Cf85C8bfDeaDebDecDedCfc0D9aD9bD9cD9dDaaDabDacDadDbaDbbDbcDbdDcaDcbDccDcdCf5bCaf8Cfb8Ccf8D95D96D97D98Da5Da6Da7Da8Db5Db6Db7Db8Dc5Dc6Dc7Dc8Cf5dDe5De6De7De8C8fdCfa8D45D46D47D48D55D56D57D58D65D66D67D68D75D76D77D78Bf0C000D04D09D0eD14D19D1eD24D29D2eD34D35D36D37D38D39D3aD3bD3cD3dD3eD44D49D4eD54D59D5eD64D69D6eD74D79D7eD84D85D86D87D88D89D8aD8bD8cD8dD8eC95fC09bC5ffCf05Cf85D45D46D47D48D55D56D57D58D65D66D67D68D75D76D77D78C8bfD0aD0bD0cD0dD1aD1bD1cD1dD2aD2bD2cD2dCfc0Cf5bCaf8Cfb8Ccf8Cf5dD05D06D07D08D15D16D17D18D25D26D27D28C8fdD4aD4bD4cD4dD5aD5bD5cD5dD6aD6bD6cD6dD7aD7bD7cD7dCfa8B0fC000D03D07D13D17D23D27D30D31D32D33D34D35D36D37D43D47D53D57D63D67D73D77D80D81D82D83D84D85D86D87C95fC09bC5ffCf05Cf85C8bfCfc0D44D45D46D54D55D56D64D65D66D74D75D76Cf5bD04D05D06D14D15D16D24D25D26Caf8Cfb8D40D41D42D50D51D52D60D61D62D70D71D72Ccf8Cf5dC8fdD00D01D02D10D11D12D20D21D22Cfa8Nf0C000D30D31D32D33D34D35D36D37D43D47D53D57D63D67D73D77D80D81D82D83D84D85D86D87D93D97Da3Da7Db3Db7Dc3Dc7Dd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7De3De7C95fC09bD94D95D96Da4Da5Da6Db4Db5Db6Dc4Dc5Dc6C5ffD40D41D42D50D51D52D60D61D62D70D71D72Cf05D90D91D92Da0Da1Da2Db0Db1Db2Dc0Dc1Dc2Cf85C8bfCfc0Cf5bDe4De5De6Caf8D44D45D46D54D55D56D64D65D66D74D75D76Cfb8Ccf8Cf5dC8fdDe0De1De2Cfa8"{
	if (!isOpen("Preview Opener.tif")) make_Preview_Opener();
}

var Action_Bars_Menu = newMenu("Action Bars Menu Tool", 
	newArray("Main Macros Shortcuts", "Basics Macros", "Export Macros", "Contrast Macros", "Splitview Macros", "Numerical Keyboard Macros"));

macro "Action Bars Menu Tool - C000 T0c15A Tac15B" {
	cmd = getArgument();
	if 		(cmd == "Main Macros Shortcuts")		show_All_Macros_Action_Bar();
	else if (cmd == "Basics Macros")				show_Basic_Macros_Action_Bar();
	else if (cmd == "Export Macros")				show_Export_Action_Bar();
	else if (cmd == "Contrast Macros")				show_Contrast_Bar();
	else if (cmd == "Splitview Macros")				show_SplitView_Bar();
	else if (cmd == "Numerical Keyboard Macros")	show_Numerical_Keyboard_Bar();
}
//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------

//FUNCTIONS KEYS
macro "[f1]" {	count_Button("Type 1", "green"); }
macro "[f2]" {	count_Button("Type 2", "magenta"); }
macro "[f3]" {	count_Button("Type 3", "orange"); }
macro "[f4]" {	count_Button("Type 4", "#00b9ff"); }
macro "[f5]" {	scroll_Loop(); }

//NUMPAD KEYS
macro "[n0]"{ if (isKeyDown("space")) set_Favorite_LUT();	else if (isKeyDown("alt")) convert_To_iMQ_Style();	else paste_Favorite_LUT();}
macro "[n1]"{ if (isKeyDown("space")) toggle_Channel(1); 	else if (isKeyDown("alt")) toggle_Channel_All(1); 	else run("Grays");}
macro "[n2]"{ if (isKeyDown("space")) toggle_Channel(2); 	else if (isKeyDown("alt")) toggle_Channel_All(2); 	else run("k_Green");	}
macro "[n3]"{ if (isKeyDown("space")) toggle_Channel(3); 	else if (isKeyDown("alt")) toggle_Channel_All(3); 	else run("Red");}
macro "[n4]"{ if (isKeyDown("space")) toggle_Channel(4); 	else if (isKeyDown("alt")) toggle_Channel_All(4); 	else run("k_Blue");	}
macro "[n5]"{ if (isKeyDown("space")) toggle_Channel(5); 	else if (isKeyDown("alt")) toggle_Channel_All(5); 	else run("k_Magenta");	}
macro "[n6]"{ if (isKeyDown("space")) toggle_Channel(6); 	else if (isKeyDown("alt")) toggle_Channel_All(6); 	else run("k_Orange");	}
macro "[n7]"{ if (isKeyDown("space")) toggle_Channel(7);	else if (isKeyDown("alt")) toggle_Channel_All(7); 	else run("Cyan");	}
macro "[n8]"{ if (isKeyDown("space")) run("8-bit"); 		else if (isKeyDown("alt")) run("16-bit");		 	else run("Magenta");	}
macro "[n9]"{ if (isKeyDown("space")) run("glasbey_on_dark");													else run("Yellow");}

macro "[n*]"{ difference_Of_Gaussian_Clij();}


//TOP NUMBER KEYS
macro "[0]"	{
	if		(no_Alt_no_Space())		run("Open in ClearVolume");
	else if (isKeyDown("space"))	open_in_3D_Viewer();
	// else if (isKeyDown("alt"))		
}
macro "[1]"	{
	if		(no_Alt_no_Space())		apply_LUTs();
	else if (isKeyDown("space"))	apply_All_LUTs(); 	
	else if (isKeyDown("alt"))		get_My_LUTs();
}
macro "[2]"	{
	if		(no_Alt_no_Space())		maximize_Image();
	else if (isKeyDown("space"))	restore_Image_Position();
	else if (isKeyDown("alt"))		full_Screen_Image();
}
macro "[3]"	{
	if		(no_Alt_no_Space())		my_3D_projection();
	else if (isKeyDown("space"))	fancy_3D_montage();
	// else if (isKeyDown("alt"))		
}
macro "[4]"	{
	if		(no_Alt_no_Space())		{ run("Make Montage...", "scale=1"); setOption("Changes", 0); }
	else if (isKeyDown("space"))	run("Montage to Stack...");
	// else if (isKeyDown("alt"))		
}
macro "[5]"	{
	if		(no_Alt_no_Space())		make_Scaled_Rectangle(25);
	else if (isKeyDown("space"))	make_Scaled_Rectangle(500);
	// else if (isKeyDown("alt"))		
}
macro "[6]"	{
	if		(no_Alt_no_Space())		force_black_canvas();
	else if (isKeyDown("space"))	show_my_Zbeul_Action_Bar();
}

macro "[7]" 	{
	if		(no_Alt_no_Space())		set_Target_Image();
	else if (isKeyDown("space"))	set_my_Custom_Location();
}
macro "[8]"	{
	if		(no_Alt_no_Space())		run("Rename...");
	else if (isKeyDown("space"))	rename(get_Time_Stamp("short") + "_" + getTitle());
	else if (isKeyDown("alt"))		rename(get_Time_Stamp("full") + "_" + getTitle());
}
macro "[9]"	{
	if		(no_Alt_no_Space())		{ if(File.exists(getDirectory("temp")+"temp.tif")) open(getDirectory("temp")+"temp.tif"); }
	else if (isKeyDown("space"))	saveAs("tif", getDirectory("temp")+"temp.tif");
	// else if (isKeyDown("alt"))	
}


//LETTER KEYS
macro "[a]"	{
	if		(no_Alt_no_Space())		run("Select All");
	else if (isKeyDown("space"))	run("Restore Selection");
	else if (isKeyDown("alt"))		run("Select None");
}
macro "[A]"	{
	if		(no_Alt_no_Space())		{ if (bitDepth() == 24) run("Enhance True Color Contrast", "saturated=0.03"); else run("Enhance Contrast", "saturated=0.03");}	
	else if (isKeyDown("space"))	enhance_All_Channels();
	else if (isKeyDown("alt"))		enhance_All_Images_Contrasts();
}
macro "[b]"	{
	if		(no_Alt_no_Space())		split_View(1,2,0); //vertical colored
	else if (isKeyDown("space"))	split_View(0,2,0); //vertical grayscale
	else if (isKeyDown("alt"))		quick_Figure_Splitview("vertical");
}
macro "[B]"	{	
	if		(no_Alt_no_Space())		switch_Composite_Mode();
	else if (isKeyDown("space"))	quick_Scale_Bar();
}

macro "[C]" {	run("Brightness/Contrast...");}

macro "[d]"	{
	if		(no_Alt_no_Space())		run("Split Channels");
	else if (isKeyDown("space"))	{run("Duplicate...", " "); string_To_Recorder("run(\"Duplicate...\", \" \");");}//slice
	else if (isKeyDown("alt"))		duplicate_The_Way_I_Want();
}
macro "[D]"	{
	if		(no_Alt_no_Space())		{run("Duplicate...", "duplicate"); string_To_Recorder("run(\"Duplicate...\", \"duplicate\");");}
	else if (isKeyDown("space"))	open_Memory_And_Recorder();
	// else if (isKeyDown("alt"))		
}
macro "[e]"	{
	if		(no_Alt_no_Space())		plot_LUT();
	else if (isKeyDown("space"))	see_All_LUTs();
	else if (isKeyDown("alt"))		run("Edit LUT...");
}
macro "[E]"	{	my_Tile();}

macro "[F]"	{	
	if (no_Alt_no_Space())			my_Tool_Roll();
	else if (isKeyDown("space")) 	multichannel_CliJ_Stack_Focuser();
}

macro "[f]"	{
	if		(no_Alt_no_Space())		run("Gamma...");
	else if (isKeyDown("space"))	set_Gamma_LUT_All_Channels(0.8);
	else if (isKeyDown("alt"))		run("Gaussian Blur 3D...","x=0.5 y=0.5 z=0.5");
}
macro "[G]"	{
	if		(no_Alt_no_Space())		run("Z Project...", "projection=[Max Intensity] all");
	else if (isKeyDown("space"))	z_Project_All();
	else if (isKeyDown("alt"))		run("Z Project...", "projection=[Sum Slices] all");
}
macro "[g]"	{
	if		(no_Alt_no_Space())		run("Z Project...");
	else if (isKeyDown("space"))	color_Code_Progressive_Max();
	else if (isKeyDown("alt"))		color_Code_No_Projection();	
}
macro "[H]"	{	run("Show All");}

macro "[i]"	{
	if		(no_Alt_no_Space())		run("Invert LUTs");
	else if (isKeyDown("space"))	inverted_Overlay_HSB();
	else if (isKeyDown("alt"))		run("Invert LUT");
}

macro "[J]"	{
	if		(no_Alt_no_Space())		{run("Input/Output...", "jpeg=100"); saveAs("Jpeg");}
	else if (isKeyDown("space"))	save_As_LZW_compressed_tif();
}

macro "[j]"  {
	if		(no_Alt_no_Space())		run("Macro");
	else if (isKeyDown("space")) 	run("Subtract Background...");
	else if (isKeyDown("alt"))		run_Clipboard_Macro_On_All_opened_Images();	
}

macro "[k]"  {
	if		(no_Alt_no_Space())		multi_Plot();
	else if (isKeyDown("space"))	multi_Plot(); //normalized multiplot
	else if (isKeyDown("alt"))		multi_Plot_Z_Axis(); 
}
macro "[l]"	{
	if		(no_Alt_no_Space())		run("Find Commands...");
	else if (isKeyDown("space"))	ultimate_LUT_Generator();
	else if (isKeyDown("alt"))		open_LUT_Bar();	
}
macro "[L]"  {
	if		(no_Alt_no_Space())		copy_Paste_All_Channels_LUTs();
	else if (isKeyDown("space"))	rgb_LUT_To_LUT();
	// else if (isKeyDown("alt"))		
}
macro "[M]"	{
	if		(no_Alt_no_Space())		fast_Merge();
	else if (isKeyDown("space"))	run("Merge Channels...");
	// else if (isKeyDown("alt"))		
} 
macro "[m]"	{	
	if		(no_Alt_no_Space())		linear_LUTs_Baker();
	else if (isKeyDown("space"))	{setPasteMode("Max"); run("Paste"); setPasteMode("Copy"); run("Select None");}
}

macro "[n]"	{
	if		(no_Alt_no_Space())		Hela();
	else if (isKeyDown("space"))	make_LUT_Image();
	else if (isKeyDown("alt"))		open("https://i.imgur.com/psSX0UR.png");
}
macro "[N]"	{
	if		(no_Alt_no_Space())		show_Numerical_Keyboard_Bar();
	else if (isKeyDown("space"))	run("Text Window...", "name=Untitled width=50 height=10 menu");
}

macro "[o]"	{
	if (startsWith(getTitle(), "Preview Opener")) open_From_Preview_Opener();
	else if (startsWith(getTitle(), "Lookup Tables")) set_LUT_From_Montage();
	else open("["+ String.paste() + "]");
}
macro "[p]"	{
	if		(no_Alt_no_Space())		split_View(0,0,0); //linear grayscale
	else if (isKeyDown("space"))	split_View(0,1,0); //squared grayscale
	else if (isKeyDown("alt"))		quick_Figure_Splitview("linear");
}
macro "[Q]" 	{	composite_Switch();	}

macro "[q]"	{
	if		(no_Alt_no_Space())		arrange_Channels();
	else if (isKeyDown("space"))	reorder_LUTs();
	else if (isKeyDown("alt"))		doCommand("Start Animation [\\]");
}
macro "[R]"	{
	if		(no_Alt_no_Space())		auto_Contrast_All_Channels();
	else if (isKeyDown("space"))	auto_Contrast_All_Images(); 
	else if (isKeyDown("alt"))		propagate_Contrasts_All_Images();
}
macro "[r]"	{
	if		(no_Alt_no_Space())		adjust_Contrast();
	else if (isKeyDown("space"))	{run("Install...","install=["+getDirectory("macros")+"/StartupMacros.fiji.ijm]"); setTool(15);}
	else if (isKeyDown("alt"))		reduce_Contrast();
}
macro "[S]"	{
	if		(no_Alt_no_Space())		split_View(1,1,0); //colored squared
	else if (isKeyDown("space"))	split_View(1,0,0); //colored linear
	else if (isKeyDown("alt"))		split_View_Dialog();
}
macro "[s]"	{
	if		(no_Alt_no_Space())		saveAs("Tiff");
	else if (isKeyDown("space"))	ultimate_SplitView();
	else if (isKeyDown("alt"))		save_All_Images_Dialog();
}
macro "[t]"	{
	if		(no_Alt_no_Space())		eval(String.paste);
	else if (isKeyDown("space"))	run("Action Bar", String.paste);
	else if (isKeyDown("alt"))		install_Tool_From_Clipboard();
}
macro "[u]"  {
	if		(no_Alt_no_Space())		rgb_To_Composite_switch();
	else if (isKeyDown("space"))	my_RGB_Converter("half");
	else if (isKeyDown("alt"))		Red_Green_to_Orange_Blue();
}
macro "[U]"  {
	if		(no_Alt_no_Space())		my_RGB_Converter("full");
}
macro "[v]"	{
	if		(no_Alt_no_Space())		run("Paste");
	else if (isKeyDown("space"))	run("System Clipboard");
	else if (isKeyDown("alt"))		open(getDirectory("temp")+"/copiedLut.lut");
}
macro "[w]"  {
	if		(no_Alt_no_Space())		{
		//avoid "are you sure?" and stores path in case of misclick
		path = getDirectory("image") + getTitle();
		if (File.exists(path)) call("ij.Prefs.set","last.closed", path); 
		close();
	}
	else if (isKeyDown("space"))	open(call("ij.Prefs.get","last.closed",""));	
	else if (isKeyDown("alt"))		close("\\Others");
}
macro "[x]"  {
	if		(no_Alt_no_Space())		copy_LUT();
	else if (isKeyDown("space"))	channels_Roll();	
	else if (isKeyDown("alt"))		{run("Copy to System");	showStatus("copy to system");}
}
macro "[y]"	{
	if		(no_Alt_no_Space())		run("Synchronize Windows");
	else if (isKeyDown("space"))	{getCursorLoc(x, y, z, modifiers); doWand(x, y, estimate_Tolerance(), "8-connected");}	
}

macro "[Z]" {	
	if		(no_Alt_no_Space())		run("Channels Tool...");
	else if (isKeyDown("space"))	run("LUT Channels Tool");
}

macro "[n/]" {
	show_Shortcuts_Table();
}

function show_Shortcuts_Table(){
	SHORTCUT_LINE_INDEX = -1;
	Table.create("Macro shortcuts");
	Table.setLocationAndSize(0, 100, 580, 600);
	//				line  Key   Alone									with Space										with Alt
	add_Shortcuts_Line("f1, f2, f3, f4", "Count++ and add overlay",		"Count-- and remove overlay", 			"new line on Count Table (not f4!)");
	add_Shortcuts_Line("f5", "Toggle auto slice scroll", 			"",								 		"");
	add_Shortcuts_Line("0", "Open in ClearVolume              ", 	"Open in 3D viewer                ",	"                                 ");
	add_Shortcuts_Line("1", "Apply favorite LUTs",					"Apply LUTs to all",					"Set favorite LUTs");
	add_Shortcuts_Line("2", "Center image",							"Restore position", 					"Full width of screen");
	add_Shortcuts_Line("3", "3D animation",							"Cool 3D animation",					"");
	add_Shortcuts_Line("4", "Make montage",							"Montage to stack",						"");
	add_Shortcuts_Line("5", "Make selection 25x25",					"make selection 500x500",				"");
	add_Shortcuts_Line("6", "Force black canvas",					"my Popup Bar",							"");
	add_Shortcuts_Line("7", "Set target image",						"Set source image",						"Set custom position");
	add_Shortcuts_Line("8", "Rename image",							"Add short time stamp to title",		"Add full time Stamp to title");
	add_Shortcuts_Line("9", "Open temp image",						"Save image in temp",					"");
					
	add_Shortcuts_Line("n0", "Favorite LUT", 						"Set favorite LUT", 					"Convert LUT to IMQ");
	add_Shortcuts_Line("n1", "Grays LUT", 							"toggle channel 1", 					"toggle channel 1 all images");
	add_Shortcuts_Line("n2", "Green LUT", 							"toggle channel 2", 					"toggle channel 2 all images");
	add_Shortcuts_Line("n3", "Red LUT", 							"toggle channel 3", 					"toggle channel 3 all images");
	add_Shortcuts_Line("n4", "Light blue LUT",						"toggle channel 4", 					"toggle channel 4 all images");
	add_Shortcuts_Line("n5", "My Magenta LUT",						"toggle channel 5", 					"toggle channel 5 all images");
	add_Shortcuts_Line("n6", "Orange LUT",							"toggle channel 6", 					"toggle channel 6 all images");
	add_Shortcuts_Line("n7", "Cyan LUT",							"toggle channel 7", 					"toggle channel 7 all images");
	add_Shortcuts_Line("n8", "Magenta LUT",							"Convert image to 8-bit", 				"Convert image to 16-bit");
	add_Shortcuts_Line("n9", "Yellow LUT", 							"Glasbey on dark LUT",	 				"");
				
	add_Shortcuts_Line("a", "Select All",							"Restore Selection",					"Select None");
	add_Shortcuts_Line("A", "Enhance Contrast 0.03%",				"Enhance all channels",					"Enhance all images");
	add_Shortcuts_Line("b", "Vertical colored Splitiview",			"Vertical grayscale split_View",		"Quick vertical PPT SplitView");
	add_Shortcuts_Line("B", "Switch composite modes",				"Auto scale bar",						"");
	add_Shortcuts_Line("c", "Copy",									"",										"");
	add_Shortcuts_Line("C", "Brightness & Contrast",				"",										"");
	add_Shortcuts_Line("d", "Split Channels",						"Duplicate slice",						"Duplicate full channel");
	add_Shortcuts_Line("D", "Duplicate full image",					"Open Memory and recorder",				"");
	add_Shortcuts_Line("e", "Plot Current LUT",						"",										"");
	add_Shortcuts_Line("E", "Arrange windows on Tiles",				"Multichannel LUT montage",				"Edit LUT...");
	add_Shortcuts_Line("f", "Gamma (real one)",						"Gamma 0.7 on all LUTs",				"Gaussian blur 3D 0.5");
	add_Shortcuts_Line("F", "Rectangle/MultiTool switch",			"ClIJ Stack focuser",					"");
	add_Shortcuts_Line("g", "Z Project...",							"MaxColorCoding on copied LUT",			"Color Coding no max (heavy)");
	add_Shortcuts_Line("G", "Max Z Projection",						"Max on all opened images",				"Sum Z Projection");
	add_Shortcuts_Line("H", "Show All images",						"",										"");
	add_Shortcuts_Line("i", "Invert LUTs (Built in)",				"Snapshot and invert colors",			"Reverse LUT");
	add_Shortcuts_Line("j", "Script Editor <3",						"Rolling Ball bkg substraction",		"Run clipboard macro on opened images");
	add_Shortcuts_Line("J", "Save as JPEG max quality",				"save As LZW compressed tif",			"");
	add_Shortcuts_Line("k", "Multi channel plot",					"Normalized Multichannel Plot",			"Multichannel Plot Z axis");
	add_Shortcuts_Line("K", "Random LUTs",							"",										"");
	add_Shortcuts_Line("l", "Find commands Tool <3",				"LUT generator",						"Open LUT Bar");
	add_Shortcuts_Line("L", "Transfer LUTs from source ",			"RGB image to LUT",						"");
	add_Shortcuts_Line("m", "LUT baker",							"Max Paste mode",						"");
	add_Shortcuts_Line("M", "Automatic Merge channels",				"Manual Merge channels",				"");
	add_Shortcuts_Line("n", "Open Hela Cells",						"Create small LUT image",				"Open my test image");
	add_Shortcuts_Line("N", "numerical Keyboard Bar",				"Text Window...",						"");
	add_Shortcuts_Line("o", "Open from macro montages",				"",										"");
	add_Shortcuts_Line("p", "Linear grayscale splitview",			"Squared grayscale Splitview",			"Quick linear PPT SplitView");
	add_Shortcuts_Line("P", "Properties...",						"",										"");
	add_Shortcuts_Line("q", "Arrange channels order",				"Arrange LUTs order",					"Animation start/stop");
	add_Shortcuts_Line("Q", "Composite/channel switch",				"",										"");
	add_Shortcuts_Line("r", "Reset contrast channel",				"Refresh startupMacros",				"Reduce all max");
	add_Shortcuts_Line("R", "Reset contrast all channels",			"Reset contrast all images",			"Same contrast all images");
	add_Shortcuts_Line("s", "Save as tiff",							"Hyperstack splitview",					"Save all opened images");
	add_Shortcuts_Line("S", "Colored squared Splitview",			"Colored linear Splitiview",			"Splitview options Dialog");
	add_Shortcuts_Line("t", "Run macro from clipboard",				"Install Ac_Bar from clipboard",		"Install macro tool from clipboard");
	add_Shortcuts_Line("u", "RGB/8bit switch",						"RGB to half CMY",						"RGB to Orange Blue");
	add_Shortcuts_Line("U", "RGB to half CMY",						"",										"");
	add_Shortcuts_Line("v", "Paste",								"Paste from system",					"Paste LUT");
	add_Shortcuts_Line("x", "Copy LUT",								"channel roll",							"Copy to System");
	add_Shortcuts_Line("y", "Synchronise windows",					"Do my Wand",							"");
	add_Shortcuts_Line("w", "Close image",							"Open last closed image (w)",			"Close all others");
	add_Shortcuts_Line("Z", "Channels Tool",						"",										"");
	add_Shortcuts_Line("n*", "Difference of gaussian",				"",										"");
}

var SHORTCUT_LINE_INDEX = -1;
function add_Shortcuts_Line(key, alone, space, alt){
	SHORTCUT_LINE_INDEX++;
	Table.set("Key",		SHORTCUT_LINE_INDEX, key);
	Table.set("Alone",		SHORTCUT_LINE_INDEX, alone);
	Table.set("with Space",	SHORTCUT_LINE_INDEX, space);
	Table.set("with Alt",	SHORTCUT_LINE_INDEX, alt);
}

function string_To_Recorder(string) {
	if (isOpen('Recorder')) call("ij.plugin.frame.Recorder.recordString",string + "\n");
}

function clipboard_To_String(){
	string = replace(String.paste(), "\"", "\\\"");	
	String.copy("\"" + string + "\""); 
	showStatus("corrected in clipboard");
}

function quick_Figure_Splitview(linear_or_Vertical){
	getDimensions(width, height, channels, slices, frames);
	BORDER_SIZE = minOf(height, width) * 0.02;
	if (linear_or_Vertical == "linear") split_View(0,0,1);
	else split_View(0, 2, 1);
	// quick_Scale_Bar();
	run("Copy to System");
}

function clipboard_To_Completion() {
	command = String.paste();
	command = replace(command, "\"", "\\\"");
	full_Command = command;
	end_Index = command.indexOf("(");
	if (end_Index == -1) end_Index = command.length;
	command = "\n\n		{ \"trigger\": \"" +  command.substring(0, end_Index) + "\", \"contents\": \"" + add_Fields(command) + "\""+ ", \"annotation\": \"" + full_Command + "\" },";
	return String.copy(command);
}

// fields = auto variable selection after completion 
function add_Fields(s) {
	index_1 = indexOf(s, "(");
	index_2 = indexOf(s, ")");
	if (index_1 == -1 || index_2 == -1) return s+"();"; 
	result_String = substring(s, 0, indexOf(s, "(")+1);
	fields = substring(s, index_1+1, index_2);
	fields = split(fields, ", ");
	if (fields.length == 0) return s +";";
	for (i = 0; i < fields.length; i++) {
		fields[i] = "${" + toString(i+1) +":"+ fields[i] + "}";
		if (i==fields.length-1) result_String += fields[i] + ");";
		else  result_String += fields[i] + ", ";
	}
	return result_String;
}

function count_Button(column_Name, color){
	if (nImages==0) exit();
	if(!isOpen("count")){
		COUNT_LINE = 0;
		Table.create("count");
		Table.setLocationAndSize(0, 50, 230, 120);
		Table.set("Type 1", COUNT_LINE, 0);
		Table.set("Type 2", COUNT_LINE, 0);
		Table.set("Type 3", COUNT_LINE, 0);
		Table.set("Type 4", COUNT_LINE, 0);
		Table.update;
	}
	if (isKeyDown("alt")) {
		COUNT_LINE++;
		Table.set("Type 1", COUNT_LINE, 0);
		Table.set("Type 2", COUNT_LINE, 0);
		Table.set("Type 3", COUNT_LINE, 0);
		Table.set("Type 4", COUNT_LINE, 0);
		Table.update;
		exit();
	}
	n = Table.get(column_Name, COUNT_LINE);
	if (isKeyDown("space")){
		Table.set(column_Name, COUNT_LINE, n-1);
		remove_Selected_Overlay();
	}
	else {
		getCursorLoc(x, y, z, modifiers);
		setColor(color);
		Overlay.drawEllipse(x-5, y-5, 10, 10);
		Overlay.show;
		setColor("orange");
		Table.set(column_Name, COUNT_LINE, n+1);
	}
	Table.update;
}

function remove_Selected_Overlay(){ 
  getCursorLoc( x, y, z, flags ); 
  if ( Overlay.size < 1 ) exit(); 
  id = Overlay.indexAt( x, y ); 
  if (id!=-1) Overlay.removeSelection(id);
}

function scroll_Loop(){
	if (DO_SCROLL_LOOP) DO_SCROLL_LOOP = false;
	else DO_SCROLL_LOOP = true;
	getDimensions(width, height, channels, slices, frames);
	if(slices==1 && frames==1) exit();
	getCursorLoc(x, y, z, flags);
	flags = flags%32; //remove "cursor in selection" flag
	while(DO_SCROLL_LOOP) {
		getCursorLoc(x, y, z, flags);
		getDisplayedArea(area_x, area_y, width, height);
		flags = flags%32; //remove "cursor in selection" flag
		if (frames > 1) Stack.setFrame(((x - area_x) / width) * frames);
		else 			Stack.setSlice(((x - area_x) / width) * slices);
		wait(10);
	}
}

//Ah jérôme... \o/
// macro "Table Action" {}


function arrange_Channels() { 
	// whithout losing metadata
	infos = getMetadata("Info");
	run("Arrange Channels...");
	setMetadata("Info", infos);
	string_To_Recorder("run(\"Arrange Channels...\");");
}

// Add scale bar to image in 1-2-5 series size
// adapted from there https://forum.image.sc/t/automatic-scale-bar-in-fiji-imagej/60774?u=k_taz
function quick_Scale_Bar(){
	color = "White";
	// approximate size of the scale bar relative to image width :
	scalebar_Size = 0.23;
	getPixelSize(unit, pixel_Width, pixel_Height);
	if (unit == "pixels") exit("Image not spatially calibrated");
	// image width in measurement units
	shortest_Image_Edge = pixel_Width * minOf(Image.width, Image.height);  
	// initial scale bar length in measurement units :
	scalebar_Length = 1;            
	// recursively calculate a 1-2-5 series until the length reaches scalebar_Size
	// 1-2-5 series is calculated by repeated multiplication with 2.3, rounded to one significant digit
	while (scalebar_Length < shortest_Image_Edge * scalebar_Size) 
		scalebar_Length = round((scalebar_Length*2.3)/(Math.pow(10,(floor(Math.log10(abs(scalebar_Length*2.3)))))))*(Math.pow(10,(floor(Math.log10(abs(scalebar_Length*2.3))))));
	if (ADD_SCALEBAR_TEXT) 
		scalebar_Settings_String = " height=" + minOf(Image.width, Image.height)/30 + " font=" + minOf(Image.width, Image.height)/15 + " color="+color+" bold overlay";
	else {
		scalebar_Settings_String = " height=" + minOf(Image.width, Image.height)/30 + " font=" + maxOf(Image.width, Image.height)/30 + " color="+color+" hide overlay";
		print("Scale Bar length = " + scalebar_Length);
	}
	run("Scale Bar...", "width=&scalebar_Length " + scalebar_Settings_String);
	string_To_Recorder("run(\"Scale Bar...\", \"width=" + scalebar_Length  + scalebar_Settings_String + "\"");
}

function run_Clipboard_Macro_On_All_opened_Images(){
	for ( i = 0; i < nImages(); i++) {
		selectImage(i+1);
		eval(String.paste());
	}
}

function merge_Ladder_And_Signal_From_Licor() {
	if (nImages == 0) exit("no image");
	image_Titles = getList("image.titles");
	Dialog.createNonBlocking("Select images");
	Dialog.addMessage("Don't forget to adjust contrast before")
	Dialog.addChoice("ladder:", image_Titles,image_Titles[0]);
	Dialog.addChoice("signal", image_Titles,image_Titles[1]);
	Dialog.show();
	image1 = Dialog.getChoice();
	image2 = Dialog.getChoice();
	setBatchMode(1);
	selectWindow(image1);
	run("Duplicate...", "duplicate title=1");
	setOption("ScaleConversions", true);
	run("16-bit");
	selectWindow(image2);
	run("Duplicate...", "duplicate title=2");
	run("16-bit");
	imageCalculator("Subtract create 32-bit", "1", "2");
	setBatchMode(0);
}

function save_As_LZW_compressed_tif(){
	path = getDir("save As LZW compressed tif");
	title = File.nameWithoutExtension;
	print( path + File.separator + title);
	run("Bio-Formats Exporter", "save=["+ path + File.separator + title + "_.tif] compression=LZW");
}

function multichannel_CliJ_Stack_Focuser(){
	if (bitDepth()==24) run("Make Composite");
	setBatchMode(1);
	title = getTitle();
	info = getMetadata("Info");
	getVoxelSize(pixel_width, pixel_height, depth, unit);
	getDimensions(width, height, channels, slices, frames);
	if (channels > 1) {
		for (i = 0; i < channels; i++) {
			selectWindow(title);
			Stack.setChannel(i+1);
			getLut(reds, greens, blues);
			clij_Stack_Focuser();
			setLut(reds, greens, blues);
			rename(title+i+1);
			resetMinAndMax();
		}
		txt = "";
		for (i=0; i<channels; i++) {
			txt = txt + "c" + i+1 + "=[" + title+i+1 + "] ";
		}
		run("Merge Channels...", txt + "create");
	}
	else {
		getLut(reds, greens, blues);
		clij_Stack_Focuser();
		setLut(reds, greens, blues);
	}
	rename(title+"_focused");
	setMetadata("Info", info);
	setVoxelSize(pixel_width, pixel_height, depth, unit);
	setBatchMode(0);
}


function clij_Stack_Focuser(){
	//Convert the strategy established by R. Wheeler in an imageJ macro running on CPU into an imageJ macro running in GPU
	//Principle:
	//In focus regions have sharper detail, therefore have a stronger edge detection result.
	//The slice with the maximum edge detection result is most in focus.
	//Build up the image from the original stack in patches according to the most in focus slice.
	//Use gaussian blending to reduce the appearance of sharp edges.
	//This is similar to the plugin by Michael Umorin:
	//http://rsbweb.nih.gov/ij/plugins/stack-focuser.html
	// input: a grayscale Z stack
	// Marjorie Guichard - 08/04/2022
	// Modified for gpu memory saving 
	
	//initialise GPU
	run("CLIJ2 Macro Extensions", "cl_device=[...]");
	Ext.CLIJ2_clear();
	//Get image information
	slice_Number = nSlices;
	width = getWidth();
	height = getHeight();
	bit = bitDepth();
	max_Radius = 0;
	blur_Sigma = 2;
	//Load stack in GPU
	original_Stack = getTitle();
	Ext.CLIJ2_push(original_Stack);
	//Sobel filter on GPU
	Ext.CLIJ2_sobelSliceBySlice(original_Stack, sobel_Stack);
	// Create max filter on pixel neighbours for each slice
	Ext.CLIJ2_maximum3DSphere(sobel_Stack, sobel_Max_Stack, max_Radius, max_Radius, 0);
	Ext.CLIJ2_release(sobel_Stack);
	// z position of maximum z projection > create a height map
	Ext.CLIJ2_zPositionOfMaximumZProjection(sobel_Max_Stack, z_Pos_of_Max);
	Ext.CLIJ2_release(sobel_Max_Stack);
	//initialise z position of maximum z projection separation
	Ext.CLIJ2_create3D(z_Pos_To_Stack, width, height, slice_Number, bit);
	Ext.CLIJ2_threshold(z_Pos_of_Max, threshTemp, slice_Number-1);
	Ext.CLIJ2_copySlice(threshTemp, z_Pos_To_Stack, slice_Number-1);
	Ext.CLIJ2_release(threshTemp);
	//separate z position of maximum z projection in different slices
	for (i = slice_Number-2; i > -1; i--) {
		threshold = i;
		Ext.CLIJ2_threshold(z_Pos_of_Max, threshTemp0, threshold+1);
		Ext.CLIJ2_threshold(z_Pos_of_Max, threshTemp, threshold);
		Ext.CLIJ2_subtractImages(threshTemp, threshTemp0, threshTempSub);
		Ext.CLIJ2_copySlice(threshTempSub, z_Pos_To_Stack, i);
	}
	Ext.CLIJ2_release(threshTempSub);
	Ext.CLIJ2_release(threshTemp0);
	Ext.CLIJ2_release(threshTemp);
	//Convert height map to float
	Ext.CLIJ2_convertFloat(z_Pos_To_Stack, z_Pos_To_Stack_Float);
	Ext.CLIJ2_release(z_Pos_To_Stack);
	//Gaussian blur on height map and Stack Map slice by slice
	for (i = 0; i < slice_Number; i++) {
		Ext.CLIJ2_copySlice(z_Pos_To_Stack_Float, temp_Max, i);
		Ext.CLIJ2_copySlice(original_Stack, temp_original, i);
		Ext.CLIJ2_gaussianBlur2D(temp_Max, temp_Blur, blur_Sigma, blur_Sigma);
		Ext.CLIJ2_multiplyImages(temp_Blur, temp_original, temp_Multiply);
		Ext.CLIJ2_copySlice(temp_Multiply, z_Pos_To_Stack_Float, i);
	}
	//Sum slice
	Ext.CLIJ2_sumZProjection(z_Pos_To_Stack_Float, result_image);
	//display image
	Ext.CLIJ2_pull(result_image);
	Ext.CLIJ2_clear();
}

function correct_Copied_Path(){
	copied_Path = replace(String.paste(), "\\", "/");	
	String.copy(copied_Path); 
	showStatus("corrected in clipboard");
}

// true if
function no_Alt_no_Space(){
	if(!isKeyDown("space") && !isKeyDown("alt")) 
		return true;
	else return false;
}

function make_LUT_Image() {
	if (nImages == 0) {
		newImage("lut"+round(random*100), "8-bit ramp", 256, 32, 1); 
		exit();
	}
	if (bitDepth()==24) {
		newImage("lut"+round(random*100), "8-bit ramp", 256, 32, 1); 
		exit();
	}
	getLut(reds, greens, blues);
	newImage("lut"+round(random*100), "8-bit ramp", 256, 32, 1); 
	setLut(reds, greens, blues);
}

function open_LUT_Bar(){
	run("Action Bar", File.openUrlAsString("https://raw.githubusercontent.com/kwolbachia/Imagej-macro-addiction/main/LUT_Bar.ijm"));
}

function duplicate_The_Way_I_Want() {
	getDimensions(width, height, channels, slices, frames);
	title = getTitle() + "_dup";
	Stack.getPosition(channel, slice, frame); 
	if (channels > 1 && frames==1) {
		run("Duplicate...", "duplicate title=title channels=&channel");
		string_To_Recorder("run(\"Duplicate...\", \"duplicate title=" + title + " channels=" + channel + "\");");
	}
	else {
		run("Duplicate...", "duplicate title=title channels=&channel frames=frame");
		string_To_Recorder("run(\"Duplicate...\", \"duplicate title=" + title + " channels=" + channel + " frames=" + frame + "\");");
	}
}

function force_black_canvas(){
	for (i=0; i<nImages; i++) {
		setBatchMode(1);
		selectImage(i+1);
		run("Appearance...", "  ");
		run("Appearance...", "black no");
		setBatchMode(0);
	}
}

function make_Scaled_Rectangle(size) {
	//makes a squared selection of specified size, centered at mouse position 
	toUnscaled(size); 
	size = round(size);
	max = maxOf(Image.width(), Image.height());
	if (size > max) size = max;
	getCursorLoc(x, y, null, null);
	call("ij.IJ.makeRectangle", x - (size/2), y-(size/2), size, size); //regular macro function is buggy
	showStatus(size+"x"+size);
}

function set_Target_Image(){
	// modify the global variable TARGET_IMAGE_TITLE with the current image title 
	showStatus("Target Image title");	
	run("Alert ", "object=Image color=Orange duration=1000"); 
	TARGET_IMAGE_TITLE = getTitle();
}

function test_main_Filters() {
	filters_List = newArray("Gaussian Blur...","Median...","Mean...","Minimum...","Maximum...","Variance...","Top Hat...","Gaussian Weighted Median");
	if (nImages == 0) exit("no image");
	source_Image = getImageID();
	setBatchMode(1);
	getDimensions(width, height, channels, slices, frames);
	if (slices*frames > 1) exit("can't test stacks, please extract one slice");
	setBatchMode(1);
	sigma = getNumber("filters sigma", 2);
	newImage("Filters", bitDepth()+"-bit", width, height, filters_List.length);
	result = getImageID();
	for (i=0; i<filters_List.length; i++) {
		selectImage(source_Image);
		run("Duplicate...", "title=test");
		if (i==0) run(filters_List[i], "sigma=" + sigma);
		else run(filters_List[i], "radius=" + sigma);
		run("Copy");
		selectImage(result);	
		setSlice(i+1);	
		run("Paste");
		Property.setSliceLabel(filters_List[i], i+1)
	}
	setSlice(1);
	run("Select None");
	setOption("Changes", 0);
	setBatchMode(0);
}

function difference_Of_Gaussian_Clij(){
	// difference of gaussian with ClIJ
	Dialog.createNonBlocking("difference_Of_Gaussian_Clij 2D");
	Dialog.addSlider("sigma 1", 0, 5, 1);
	Dialog.addSlider("sigma 2", 0, 20, 2);
	Dialog.show();
	sigma1 = Dialog.getNumber();
	sigma2 = Dialog.getNumber();
	run("CLIJ2 Macro Extensions","cl_device=");
	image1 = getTitle();
	Ext.CLIJ2_push(image1);
	image2 = "difference_of_gaussian_" + image1;
	Ext.CLIJ2_differenceOfGaussian2D(image1, image2, sigma1, sigma1, sigma2, sigma2);
	Ext.CLIJ2_pull(image2);
}

function open_Memory_And_Recorder() {
	run("Record...");
	Table.setLocationAndSize(screenWidth()-430, 0, 430, 125,"Recorder");
	run("Monitor Memory...");
	Table.setLocationAndSize(screenWidth()-676, 0, 255, 120,"Memory");
}

function switch_Composite_Mode(){
	getLut(reds,greens,blues);
	MODE = Property.get("CompositeProjection");
	if (!my_is_inverting_LUT()) {
		if   (MODE == "Max" || MODE == "Invert" || MODE == "Min") {Property.set("CompositeProjection", "Sum"); showStatus("Sum mode");}
		else {Property.set("CompositeProjection", "Max"); showStatus("Max mode");}
	}
	else {
		if   (MODE == "Invert") {Property.set("CompositeProjection", "Min"); showStatus("Min mode");}
		else {Property.set("CompositeProjection", "Invert"); showStatus("Invert mode");}
	}
	updateDisplay();
}

function my_is_inverting_LUT() {
	is_inverting_LUT = false;
	getLut(reds, greens, blues);
	if (reds[0] + greens[0] + blues[0] > 20) is_inverting_LUT = true;
	return is_inverting_LUT;
}

function composite_Switch(){
	if (!is("composite")) exit();
	Stack.getDisplayMode(mode);
	if (mode == "color" || mode == "greyscale") Stack.setDisplayMode("composite");
	else Stack.setDisplayMode("color");
}

function Bioformats_Bar(){
	ACTION_BAR_STRING = "<fromString>"+"\n"+
	"<stickToImageJ>"+"\n"+
	"<noGrid>"+"\n"+
	"<line>"+"\n"+
	"<text> BioFormats"+"\n"+
	"<button>"+"\n"+
	"label= X "+"\n"+
	"bgcolor=orange"+"\n"+
	"arg=<close>"+"\n"+
	"</line>"+"\n"+
	"<DnDAction>"+"\n"+
	"path = getArgument();"+"\n"+
	"if (endsWith(path, '.mp4')) run('Movie (FFMPEG)...', 'choose='+ path +' first_frame=0 last_frame=-1');\n"+
	"else if (endsWith(path, '.pdf')) run('PDF ...', 'choose=' + path + ' scale=400 page=0');\n"+
	"else run('Bio-Formats Importer', 'open=[' + path + ']');\n"+
	"rename(File.nameWithoutExtension);\n"+
	"</DnDAction>\n";
	run("Action Bar",ACTION_BAR_STRING);
}

function my_Tool_Roll() {
	if (toolID() != 15) setTool(15);
	else if (toolID() == 15) setTool(0);
}


/*
 * About Flags (or Modifiers) from getCursorLoc()
 * shift = +1
 * ctrl = +2
 * cmd = +4 (Mac)
 * alt = +8
 * middle also +8
 * leftClick = +16
 * cursor over selection = +32
 * So e.g. if (leftclick + alt) Flags = 24
 */
//ispired by Robert Haase Windows Position tool from clij
function multi_Tool(){
	if (nImages == 0) exit();
	setupUndo();
	call("ij.plugin.frame.ContrastAdjuster.update");
	updateDisplay();
	getCursorLoc(x, y, z, flags);
	//middle click on selection
	if (flags == 40) { 
		roiManager("Add"); 
		exit();
	}
	//click on selection
	if (flags > 32 && MAIN_TOOL != "Magic Wand") move_selection_Tool(); 
	if (flags > 32) flags -= 32;
	//middle mouse button
	if (flags == 8) { 
		if      (matches(getTitle(), ".*Preview Opener.*")) open_From_Preview_Opener();  
		else if (matches(getTitle(), ".*Lookup Tables.*")) set_LUT_From_Montage(); 
		if (Image.height == 32 || Image.width == 256) { if (isOpen("LUT Profile")) plot_LUT(); copy_LUT();}
		else {
			if (MAIN_TOOL == "Curtain Tool") set_Target_Image();
			else composite_Switch();
		}
	}
	//left Click
	if (flags == 16) { 
		if 		(MAIN_TOOL == "Move Windows")				move_Windows();
		else if (MAIN_TOOL == "Contrast Adjuster")			live_Contrast();
		else if (MAIN_TOOL == "LUT Gamma Tool")				live_Gamma();
		else if (MAIN_TOOL == "Slice/Frame Scroll")			live_Scroll();
		else if (MAIN_TOOL == "Magic Wand")					magic_Wand();
		else if (MAIN_TOOL == "Fly mode")					fly_Mode();
		else if (MAIN_TOOL == "Curtain Tool")				curtain_Tool();
		else if (MAIN_TOOL == "Scale Bar Tool")				scale_Bar_Tool();
		else if (MAIN_TOOL == "Multi-channel Plot Tool")	live_MultiPlot();
	}
	if (flags == 9) 				if (bitDepth()!=24) paste_LUT();											// shift + middle click
	if (flags == 10 || flags == 14)	if (bitDepth()!=24) paste_Favorite_LUT();									// ctrl + middle click
	if (flags == 17)				live_Contrast();															// shift + drag
	if (flags == 18 || flags == 20)	if (isOpen("MultiPlot")) live_MultiPlot(); else k_Rectangle_Tool();			// ctrl + drag
	if (flags == 24)				if (MAIN_TOOL=="Slice/Frame Scroll") move_Windows(); else live_Scroll();	// alt + drag
	if (flags == 25)				box_Auto_Contrast();														// shift + alt + drag
	if (flags == 26 || flags == 28)	curtain_Tool();
}

function set_Main_Tool(main_Tool){
	MAIN_TOOL = main_Tool;
}

function k_Rectangle_Tool() {
	getCursorLoc(x_origin, y_origin, z, flags);
	getCursorLoc(last_x, last_y, z, flags);
	remove_ROI = true;
	if (flags > 32) exit();
	while (flags >= 16) {
		rect_x = x_origin;
		rect_y = y_origin;
		getCursorLoc(x, y, z, flags);
		if (x != last_x || y != last_y) {
			if (x <= x_origin) rect_x = x;
			if (y <= y_origin) rect_y = y;
			rect_width = abs(x_origin - x);
			rect_heigth = abs(y_origin - y);
			makeRectangle(rect_x, rect_y, rect_width, rect_heigth);
			getCursorLoc(last_x, last_y, z, flags);
			if (flags >= 32) flags -= 32;
			remove_ROI = false;
		}
		wait(10);
	}
	if (remove_ROI) run("Select None");
}


function move_selection_Tool() {
	getCursorLoc(x_origin, y_origin, z, flags);
	getCursorLoc(last_x, last_y, z, flags);
	getSelectionBounds(roi_x, roi_y, width, height);
	if (flags >= 32) flags -= 32;
	while (flags == 16) {
		getCursorLoc(x, y, z, flags);
		if (x != last_x || y != last_y) {
			setSelectionLocation(roi_x - (x_origin-x), roi_y - (y_origin-y));
			getCursorLoc(last_x, last_y, z, flags);
		}
		wait(10);
		if (flags >= 32) flags -= 32;
	}
}

function scale_Bar_Tool(){
	//adapted from Aleš Kladnik there https://forum.image.sc/t/automatic-scale-bar-in-fiji-imagej/60774
	getPixelSize(unit,w,h);
	if (unit == "pixels") exit("Image not spatially calibrated");
	bar_Length = 1;	// initial scale bar length in measurement units
	bar_Relative_Size = 0;
	bar_Height = 0;
	if (ADD_SCALEBAR_TEXT == true) text_Parameter = "bold";
	else text_Parameter = "hide";
	font_Size = minOf(Image.width, Image.height) / 15; // estimation of "good" font size
	getCursorLoc(x2, y2, z2, flags2);
	getCursorLoc(last_x, last_y, z, flags);
	while (flags >= 16) { //left click			
		getCursorLoc(x, y, z, flags);
		getDisplayedArea(area_x, area_y, width, height);
		//if mouse moved
		if (x != last_x || y != last_y) {
			// approximate size of the scale bar relative to image width
			bar_Relative_Size = round(((width-(x - area_x))/width) * 10);

			// recursively calculate a 1-2-5-10-20... series
			// 1-2-5 series is calculated by repeated multiplication with 2.3, rounded to one significant digit
			for (i = 0; i < bar_Relative_Size; i++) {
				magical_Formula = Math.pow( 10, (floor( Math.log10( abs(bar_Length * 2.3)))));
				bar_Length = round( (bar_Length*2.3) / magical_Formula) * magical_Formula;
			}

			bar_Height = round(((height - (y - area_y)) / height) * Image.height/20);

			//if size or height values changed from last loop, update scale bar
			if (bar_Relative_Size != last_Size || bar_Height != last_Height) 
				run("Scale Bar...", "width=&bar_Length height=&bar_Height font=&font_Size color=White background=None location=[Lower Right] "+ text_Parameter +" overlay");
			showStatus("height = "+bar_Height+ "px   length = "+ bar_Length + unit);
			bar_Length = 1;
		}
		//save changes
		last_Size = bar_Relative_Size;
		last_Height = bar_Height;
		getCursorLoc(last_x, last_y, z, flags);
		wait(10);
	}
}

function curtain_Tool() {
	getCursorLoc(last_x, y, z, flags);
	getDimensions(width, height, channels, slices, frames);
	setBatchMode(true);
	id = getImageID();
	while (flags&16>0) {
		selectImage(id);
		getCursorLoc(x, y, z, flags);
		if (x != last_x) {
			if (x < 0) x = 0;
			if (isOpen(TARGET_IMAGE_TITLE)) selectWindow(TARGET_IMAGE_TITLE);
			else exit();
			setKeyDown("none");
			makeRectangle(x, 0, width-x, height);
			run("Duplicate...","title=part");
			selectImage(id);
			run("Add Image...", "image=part x="+ x +" y=0 opacity=100"); //zero
			while (Overlay.size>1) Overlay.removeSelection(0);
			close("part");
			last_x = x;
			wait(10);
		}
	}
	selectWindow(TARGET_IMAGE_TITLE);
	run("Select None");
	selectImage(id);
	Overlay.remove;
}

function move_Windows() {
	getCursorLoc(x, y, z, flags);
	origin_x = get_Cursor_Screen_Loc_X();
	origin_y = get_Cursor_Screen_Loc_Y();
	getLocationAndSize(origin_window_x, origin_window_y, width, height);
 	showStatus(origin_window_x);
	while (flags == 16) {
		x = get_Cursor_Screen_Loc_X();
		y = get_Cursor_Screen_Loc_Y();
		Table.setLocationAndSize(x - (origin_x - origin_window_x), y - (origin_y - origin_window_y), width, height, getTitle());
		getCursorLoc(x, y, z, flags);
		wait(10);
	}
}


function get_Cursor_Screen_Loc_X(){ 
	x = parseInt(eval("bsh", "import java.awt.MouseInfo; MouseInfo.getPointerInfo().getLocation().x;"));
	return x;
}

function get_Cursor_Screen_Loc_Y(){
	y = parseInt(eval("bsh", "import java.awt.MouseInfo; MouseInfo.getPointerInfo().getLocation().y;"));
	return y;
}

function live_Contrast() {	
	if (bitDepth() == 24) exit();
	resetMinAndMax();
	getMinAndMax(min, max);
	getCursorLoc(x, y, z, flags);
	flags = flags%32; //remove "cursor in selection" flag
	while (flags >= 16) {			
		getCursorLoc(x, y, z, flags);
		getDisplayedArea(area_x, area_y, width, height);
		flags = flags%32; //remove "cursor in selection" flag
		new_Max = ((x - area_x) / width) * max;
		new_Min = ((height - (y - area_y)) / height) * max / 2;
		if (new_Max < 0) new_Max = 0;
		if (new_Min < 0) new_Min = 0;
		if (new_Min > new_Max) new_Min = new_Max;
		setMinAndMax(new_Min, new_Max);
		call("ij.plugin.frame.ContrastAdjuster.update");
		wait(10);
	}
}

function live_Gamma(){
	setBatchMode(1);
	getLut(reds, greens, blues);
	// copy_LUT();
	setColor("white");
	setFont("SansSerif", Image.height/20, "bold antialiased");
	getCursorLoc(x, y, z, flags);
	flags = flags%32; //remove "cursor in selection" flag
	while (flags >= 16) {
		getCursorLoc(x, y, z, flags);
		getDisplayedArea(area_x, area_y, width, height);
		flags = flags%32; //remove "cursor in selection" flag
		gamma = d2s(((x - area_x) / width) * 2, 2); if (gamma < 0) gamma=0;
		gamma_LUT(gamma, reds, greens, blues);
		showStatus("Gamma on LUT : " + gamma);
		wait(10);
	}
	setBatchMode(0);
	run("Select None");
}

function live_Scroll() {
	getDimensions(width, height, channels, slices, frames);
	if(slices==1 && frames==1) exit();
	getCursorLoc(x, y, z, flags);
	flags = flags%32; //remove "cursor in selection" flag
	while(flags >= 16) {
		getCursorLoc(x, y, z, flags);
		getDisplayedArea(area_x, area_y, width, height);
		flags = flags%32; //remove "cursor in selection" flag
		if (frames > 1) Stack.setFrame(((x - area_x) / width) * frames);
		else 			Stack.setSlice(((x - area_x) / width) * slices);
		if (LIVE_AUTOCONTRAST) run("Enhance Contrast", "saturated=&SATURATION_RATE");
		call("ij.plugin.frame.ContrastAdjuster.update");
		wait(10);
	}
}

function box_Auto_Contrast() {
	if (bitDepth==24) exit("This macro won't work with rgb");
	size = 75;
	getCursorLoc(x, y, z, flags);
	makeRectangle(x - size/2, y - size/2, size, size);
	auto_Contrast_All_Channels();
	run("Select None");
}

function fly_Mode(){
	getCursorLoc(x, y, z, flag);
	zoom = getZoom()*100;
	getDimensions(width, height, channels, slices, frames);
	getCursorLoc(last_x, last_y, z, flags);
	new_x = last_x;
	new_y = last_y;
	while (flag>=16) {
		getCursorLoc(x, y, z, flag);
		getDisplayedArea(area_x, area_y, area_width, area_height);
		if (x != last_x || y != last_y) {
			new_x = ((x - area_x) / area_width)*width;
			new_y = ((y - area_y) / area_height)*height;
			run("Set... ", "zoom=&zoom x=&new_x y=&new_y");
			getCursorLoc(last_x, last_y, z, flags);
			wait(10);
		}
	}
	run("Set... ", "zoom=&zoom x=&new_x y=&new_y");
}

function magic_Wand(){
	getCursorLoc(x, y, z, flags);
	if (flags>=32) flags -= 32; //remove "cursor in selection" flag
	if (ADD_TO_MANAGER){
		run("ROI Manager...");
		roiManager("show all without labels");
	}
	if (flags == 16) { //left click
		adjust_Tolerance();
		if (ADD_TO_MANAGER)	roiManager("Add");
	}
	if (FIT_MODE != "None"){
		run(FIT_MODE);
		getSelectionCoordinates(xpoints, ypoints);
		makeSelection(4, xpoints, ypoints);
	}
	wait(30);
}

function adjust_Tolerance() {
	getCursorLoc(x2, y2, z, flags); //origin
	getCursorLoc(x, y, z, flags);
	if (flags>=32) flags -= 32; //remove "cursor in selection" flag
	zoom = getZoom();
	tolerance = estimate_Tolerance();
	while (flags >= 16) {
		getCursorLoc(x, y, z, flags);
		if (flags>=32) flags -= 32; //remove "cursor in selection" flag
		distance = (x*zoom - x2*zoom);
		if (distance < 0) new_Tolerance = tolerance - pow(abs(distance), EXPONENT);
		else new_Tolerance = tolerance + pow(abs(distance), EXPONENT);
		if (new_Tolerance < 0) new_Tolerance = 0;
		showStatus(new_Tolerance);
		doWand(x2, y2, new_Tolerance, "Legacy");
		wait(30);
	}
}

function estimate_Tolerance(){
	run("Select None");
	setBatchMode(1);
	getCursorLoc(x, y, z, flags);
	makeRectangle(x - (WAND_BOX_SIZE / 2), y - (WAND_BOX_SIZE / 2), WAND_BOX_SIZE, WAND_BOX_SIZE);
	getStatistics(bla, bla, bla, max, bla, bla);;
	tolerance = (TOLERANCE_THRESHOLD / 100) * max;
	return tolerance;
}

function set_Favorite_LUT(){
	saveAs("lut", getDirectory("temp") + "/favoriteLUT.lut");
	showStatus("new favorite LUT");
}

function paste_Favorite_LUT(){
	open(getDirectory("temp") + "/favoriteLUT.lut");
	showStatus("Paste LUT");
}

function copy_LUT() {
	getCursorLoc(x, y, z, flags);
	if (flags == 40) {roiManager("Add"); exit();}
	saveAs("lut", getDirectory("temp")+"/copiedLut.lut");
	showStatus("Copy LUT");
}

function paste_LUT(){
	open(getDirectory("temp")+"/copiedLut.lut");
	showStatus("Paste LUT");
}

function open_in_3D_Viewer(){//...
	title = getTitle();
	run("3D Viewer");
	call("ij3d.ImageJ3DViewer.setCoordinateSystem", "false");
	call("ij3d.ImageJ3DViewer.add", title, "None", title, "0", "true", "true", "true", "2", "0");
	close("Console");
}

function see_All_LUTs(){
	setBatchMode(1);
	title = getTitle();
	mode = Property.get("CompositeProjection");
	getDimensions(width, height, channels, slices, frames);
	id = getImageID();
	newImage(title + "_LUTs", "8-bit color-mode", 256, 32 * (channels+1), channels, 1, 1);
	id2 = getImageID();
	newImage("ramp", "8-bit Ramp", 256, 32, 1);
	run("Copy");
	selectImage(id2);
	y = -32;
	for (i = 0; i < channels; i++) {
		y += 32;
		selectImage(id);
		Stack.setChannel(i+1);
		getLut(reds, greens, blues);
		selectImage(id2);
		Stack.setChannel(i+1);
		setLut(reds, greens, blues);
		makeRectangle(0, y, 256, 32);
		run("Paste");
		makeRectangle(0, channels*32, 256, 32);
		run("Paste");
	}
	run("Select None");
	Stack.setDisplayMode("composite");
	Property.set("CompositeProjection", mode); 
	setOption("Changes", 0);
	setBatchMode(0);
}

function fetch_Or_Pull_StartupMacros() {
	sync_Path = getDirectory("home") + "/Nextcloud/sync/FIJI/StartupMacros.fiji.ijm";
	if (!File.exists(sync_Path)) sync_Path = getDirectory("home") + "/Nextcloud2/sync/FIJI/StartupMacros.fiji.ijm";
	fiji_Startup_Path = getDirectory("macros")+"/StartupMacros.fiji.ijm";
	 //return true for Fetch and false for pull
	choice = getBoolean("Fetch or pull?", "Pull", "Fetch");
	if (!choice){
		//backup of current StMacros
		File.saveString(File.openAsString(fiji_Startup_Path), getDirectory("macros")+"/backups/StM_" + get_Time_Stamp("full") + ".ijm");
		//import new
		File.saveString(File.openAsString(sync_Path), fiji_Startup_Path);
		run("Install...","install=["+fiji_Startup_Path+"]");
		showStatus("Fetch!");
	}
	else {
		//pull
		File.saveString(File.openAsString(fiji_Startup_Path), sync_Path);
		showStatus("Pull!");
	}
}

function get_Time_Stamp(full_or_short) {
	getDateAndTime(year, month, day_Of_Week, day_Of_Month, hour, minute, second, msec);
	if (full_or_short == "short") 
		time_Stamp = "" + toString(year-2000) + toString(IJ.pad(month+1, 2)) + toString(IJ.pad(day_Of_Month, 2)) + "_";
	else time_Stamp = "" + toString(year-2000) + toString(IJ.pad(month+1, 2)) + toString(IJ.pad(day_Of_Month, 2)) + "_" + toString(hour) + toString(minute) + toString(second);
	return time_Stamp;
}

//toggle channel number (i)
function toggle_Channel(i) { //modified from J.Mutterer
	if (nImages < 1) exit(); 
	if (is("composite")) {
		Stack.getActiveChannels(string);
		channel_Index = string.substring(i-1,i);
		Stack.setActiveChannels(string.substring(0, i-1) + !channel_Index + string.substring(i)); //at the end it looks like Stack.setActiveChannels(1101);
		showStatus("channel " + i + " toggled"); 
	}
}

function toggle_Channel_All(i) {
	setBatchMode(1);
	for (k=0; k<nImages; k++) {
		selectImage(k+1);
		toggle_Channel(i);	
	}
	showStatus("channel "+i+" toggled");
	setBatchMode(0);
}

//modified from https://github.com/ndefrancesco/macro-frenzy/blob/master/assorted/Colorize%20stack.ijm
//K.Terretaz 2022
//Max projection with color coding based on the current LUT
//to save RAM, it uses the Max copy paste mode to avoid creation of big RGB stack before projection
//even works with virtual stacks
function color_Code_Progressive_Max(){
	saveSettings();
	setPasteMode("Max");
	title = getTitle();
	getDimensions(width, height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	getDimensions(width, height, channels, slices, frames);
	if (selectionType() != -1) getSelectionBounds(x, y, width, height);
	setBatchMode(1);
	if (slices > 1 && frames >1) steps = frames;
	else steps = 1;
	newImage("Color Coded Projection", "RGB black", width, height, steps);
	selectWindow(title);
	// copy for backup :
	getLut(reds, greens, blues);
	//paste copied LUT
	open(getDirectory("temp")+"/copiedLut.lut");
	//get current LUT for color coding
	getLut(code_Reds, code_Greens, code_Blues);
	for (k = 0; k < frames; k++) {
		for (i = 0; i < slices; i++) {
			selectWindow(title);
			Stack.setPosition(channel, i+1, k+1);
			//create LUT with the scaled color :
			if (slices == 1) index =  (k/(frames-1)) * 255;
			else index = (i/(slices-1)) * 255;
			temp_Reds = newArray(0, code_Reds[index]);	
			temp_greens = newArray(0, code_Greens[index]);	
			temp_Blues = newArray(0, code_Blues[index]);
			temp_Reds = Array.resample(temp_Reds, 256);
			temp_greens = Array.resample(temp_greens, 256);
			temp_Blues = Array.resample(temp_Blues, 256);
			setLut(temp_Reds, temp_greens, temp_Blues);
			run("Copy");
			selectWindow("Color Coded Projection");
			Stack.setPosition(channel, k+1, k+1);

			//"MAX" paste :
			run("Paste");
		}
	}
	//restore LUT
	selectWindow(title);
	setLut(reds, greens, blues);
	selectWindow("Color Coded Projection");
	run("Select None");
	rename(title + "_Max_colored");
	setBatchMode("exit and display");
	restoreSettings();
}

//No projection, heavy on RAM
function color_Code_No_Projection(){
	setKeyDown("none"); //bug fixing? alt
	title = getTitle();
	getVoxelSize(voxel_width, voxel_height, voxel_depth, unit);
	getDimensions(width, height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	getDimensions(width, height, channels, slices, frames);
	if (selectionType() != -1) getSelectionBounds(x, y, width, height);
	setBatchMode(1);
	newImage("Color Coded Projection", "RGB black", width, height, 1, slices, frames);
	selectWindow(title);
	// copy for backup :
	getLut(reds, greens, blues);
	//paste copied LUT
	open(getDirectory("temp")+"/copiedLut.lut");
	//get current LUT for color coding
	getLut(code_Reds, code_Greens, code_Blues);
	for (k = 0; k < frames; k++) {
		for (i = 0; i < slices; i++) {
			selectWindow(title);
			Stack.setPosition(channel, i+1, k+1);
			//create LUT with the scaled color :
			if (slices == 1) index =  (k/(frames-1)) * 255;
			else index = (i/(slices-1)) * 255;
			temp_Reds = newArray(0, code_Reds[index]);	
			temp_greens = newArray(0, code_Greens[index]);	
			temp_Blues = newArray(0, code_Blues[index]);
			temp_Reds = Array.resample(temp_Reds, 256);
			temp_greens = Array.resample(temp_greens, 256);
			temp_Blues = Array.resample(temp_Blues, 256);
			setLut(temp_Reds, temp_greens, temp_Blues);
			run("Copy");
			selectWindow("Color Coded Projection");
			Stack.setPosition(1, i+1, k+1);
			run("Paste");
		}
	}
	//restore LUT
	selectWindow(title);
	Stack.setPosition(channel, slice, frame);
	setLut(reds, greens, blues);
	selectWindow("Color Coded Projection");
	Stack.setPosition(1, 1, 1);
	run("Select None");
	rename(title + "_colored");
	setVoxelSize(voxel_width, voxel_height, voxel_depth, unit);
	setBatchMode(0);
}

function install_Tool_From_URL(URL){
	String.copy(File.openUrlAsString(URL));
	install_Tool_From_Clipboard();
}

function install_Tool_From_Clipboard() {
	path = getDirectory("temp")+File.separator+"fromClipboard.ijm";
	string = File.openAsString(getDirectory("macros")+"/StartupMacros.fiji.ijm") + String.paste;
	File.saveString(string, path);
	run("Install...","install=["+path+"]");
	setTool(20);
}

function rotate_LUT() {
	setBatchMode(1);
	getLut(reds, greens, blues);
	newImage("r1", "8-bit color-mode", 256, 32, 6, 1, 1);
	Stack.setChannel(1);
	setLut(reds, greens, blues);
	Stack.setChannel(2);
	setLut(reds, blues, greens);
	Stack.setChannel(3);
	setLut(greens, reds, blues);
	Stack.setChannel(4);
	setLut(greens, blues, reds);
	Stack.setChannel(5);
	setLut(blues, greens, reds);
	Stack.setChannel(6);
	setLut(blues, reds, greens);
	see_All_LUTs();
	setBatchMode(0);
	rename("wiiiii");
}

//adapted from https://imagej.nih.gov/ij/macros/Show_All_LUTs.txt
//the "display LUTs" function caused problems with some lut names.
function display_LUTs(){
	if (isKeyDown("shift")) apply_ChrisLUTs_Montage();
	else {
		saveSettings();
		lut_Folder = getDirectory("luts");
		list = getFileList(lut_Folder);
		setBatchMode(true);
		newImage("ramp", "8-bit Ramp", 256, 32, 1);
		newImage("luts", "RGB White", 256, 48, 1);
		count = 0;
		setForegroundColor(255, 255, 255);
		setBackgroundColor(255, 255, 255);
		for (i=0; i<list.length; i++) {
		  if (endsWith(list[i], ".lut")) {
		      selectWindow("ramp");
		      open(lut_Folder + list[i]);
		      run("Copy");
		      selectWindow("luts");
		      makeRectangle(0, 0, 256, 32);
		      run("Paste");
		      setJustification("center");
		      setColor(0,0,0);
			  setFont("SansSerif", 11, "antialiased");
		      drawString(list[i], 128, 48);
		      run("Add Slice");
		      run("Select All");
		      run("Clear", "slice");
		      count++;
		  }
		}
		run("Delete Slice");
		rows = floor(count/3);
		if (rows < count/3) rows++;
		run("Canvas Size...", "width=258 height=50 position=Center");
		run("Make Montage...", "columns=3 rows="+rows+" scale=1 first=1 last="+count+" increment=1 border=0 use");
		rename("Lookup Tables");
		setBatchMode(false);
		restoreSettings();
	}
}

function set_LUT_From_Montage() {
	title = getTitle();
	if (!startsWith(title, "Lookup Tables")) set_Target_Image();
	else {
		setBatchMode(1);
		getCursorLoc(x, y, z, modifiers);
		Ybloc_Size = 50;
		Xbloc_Size = 258;
		line_Position = floor(y / Ybloc_Size);
		row_Position =  floor(x / Xbloc_Size);
		x_LUTposition = 1 + (row_Position  * Xbloc_Size);
		y_LUTposition = 1 + (line_Position * Ybloc_Size);
		reds = newArray(1); greens = newArray(1); blues = newArray(1);
		for (i = 0; i < 256; i++) {
			color = getPixel(i + x_LUTposition, 1 +	y_LUTposition);
			reds[i]   = (color>>16)&0xff; 	
			greens[i] = (color>>8)&0xff;		
			blues[i]  = color&0xff;
		}
		if (reds[100]+greens[100]+blues[100] == 765) exit(); // if white space in montage
		if (isOpen(TARGET_IMAGE_TITLE)){
			selectWindow(TARGET_IMAGE_TITLE);
			setLut(reds, greens, blues);
		}
		else {
			newImage("lutFromMontage", "8-bit ramp", 256, 32, 1);
			setLut(reds, greens, blues);
		}
		if (isOpen("LUT Profile")) plot_LUT();
		copy_LUT();
		close("lutFromMontage");
		selectWindow(title);
	}
}

function apply_ChrisLUTs_Montage() {
	default_Dir = File.getDefaultDir;
	imagej_Dir = getDir("imagej");
	scripts_Dir = imagej_Dir + "scripts" + File.separator + "LUTs" + File.separator + "___Grays_.ijm";
	File.setDefaultDir(scripts_Dir);
	lut_Folder = getDir("Choose folder");
	File.setDefaultDir(default_Dir);
	count = 0;
	saveSettings();
	setBatchMode(true);
	newImage("ramp", "8-bit Ramp", 256, 32, 1);
	newImage("luts", "RGB White", 256, 48, 1);
	setForegroundColor(255, 255, 255);
	setBackgroundColor(255, 255, 255);
	//recursive processing
	scripts_List = processFiles(lut_Folder, scripts_List);
	run("Delete Slice");
	rows = floor(count/4);
	if (rows < count/4) rows++;
	run("Canvas Size...", "width=258 height=50 position=Center");
	setBackgroundColor(0, 0, 0);
	run("Make Montage...", "columns=4 rows="+rows+" scale=1 increment=1 border=0 use");
	rename("Lookup Tables");
	Property.set("PropertyList",scripts_List);
	setBatchMode(false);
	restoreSettings();

	function processFiles(folder, scripts_List) {
		list = getFileList(folder);
		for (i=0; i<list.length; i++) {
			if (File.isDirectory(folder + list[i])) scripts_List = processFiles("" + folder + list[i] , scripts_List);
			else if (endsWith(list[i], "_.ijm")) {
				path = folder + list[i];
				scripts_List = processFile(path, scripts_List);
			}
		}
		return scripts_List;
	}

	function processFile(path, scripts_List) {
		selectWindow("ramp");
		script = File.openAsString(path);
		runMacro(path);
		scripts_List = scripts_List + script;
		run("Copy");
		selectWindow("luts");
		makeRectangle(0, 0, 256, 32);
		run("Paste");
		setJustification("center");
		setColor(0,0,0);
		setFont("SansSerif", 11, "antialiased");
		name = replace(File.getName(path), "_.ijm", "");
		drawString(name, 128, 48);
		run("Add Slice");
		run("Select All");
		run("Clear", "slice");
		count++;
		return scripts_List;
	}
}

function set_my_Custom_Location() {
	showStatus("Custom position set");
	getLocationAndSize(SAVED_LOC_X, SAVED_LOC_Y, width, height);
}

function open_From_Preview_Opener() {
	infos = getMetadata("Info");
	path_List = split(infos, ",,");
	rows = getInfo("xMontage");
	lines = getInfo("yMontage");
	bloc_Size = 400;
	index = 0;
	getCursorLoc(x, y, z, flags);
	line_Position = floor(y / bloc_Size);
	row_Position = floor(x / bloc_Size);
	index = (line_Position * rows) + row_Position;
	path = getDirectory("image") + path_List[index];
	if (File.exists(path)) {
		if (endsWith(path, '.tif')||endsWith(path, '.png')||endsWith(path, '.jpg')||endsWith(path, 'jpeg')) open(path);
		else run('Bio-Formats Importer', 'open=[' + path + ']');
		showStatus("opening " + path_List[index]);
	}
	else showStatus("can't open " + path_List[index] + " maybe incorrect name or spaces in it?");
}

//create a montage with snapshots of all opened images (virtual or not)
//in their curent state.  Will close all but the montage.
function make_Preview_Opener() {
	if (nImages == 0) exit();
	waitForUser("Make Preview Opener", "Creates a montage with snapshots of all opened images (virtual or not).\n" +
	"This will close all but the montage. Are you sure?");
	setBatchMode(1);
	all_IDs = newArray(nImages);
	paths_List = "";
	concat_Options = "open ";
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		if (i==0) {
			source_Folder = getDirectory("image"); 
			File.setDefaultDir(source_Folder);
		}
		all_IDs[i] = getImageID();
		paths_List += getTitle() +",,";
	}
	for (i=0; i<all_IDs.length; i++) {
		selectImage(all_IDs[i]); 
		if (!is("Virtual Stack") && bitDepth()!=24) {
			getDimensions(width, height, channels, slices, frames);
			getLut(reds,greens,blues);
			if (slices * frames != 1) run("Z Project...", "projection=[Max Intensity] all");
			setLut(reds, greens, blues);
		}
		rgb_Snapshot();
		run("Scale...", "x=- y=- width=400 height=400 interpolation=Bilinear average create");
		rename("image"+i);
		concat_Options +=  "image"+i+1+"=[image"+i+"] ";
	}
	run("Concatenate...", concat_Options);
	run("Make Montage...", "scale=1");
	rename("Preview Opener");
	infos = getMetadata("Info");
	setMetadata("Info", paths_List + "\n" + infos);
	close("\\Others");
	setBatchMode(0);
	saveAs("tiff", source_Folder + "_Preview Opener");
}

//Supposed to create an RGB snapshot of any kind of opened image
//check sourcecode for save as jpeg and stuff, how does it works?
function rgb_Snapshot(){
	title = getTitle();
	Stack.getPosition(channel, slice, frame);
	getDimensions(width, height, channels, slices, frames);
	if (channels > 1) Stack.getDisplayMode(mode);
	if 		(bitDepth()==24) 		run("Duplicate..."," ");
	else if (channels==1) 			run("Duplicate...", "title=toClose channels=&channels slices=&slice frames=&frame");
	else if (mode!="composite") 	run("Duplicate...", "title=toClose channels=channel slices=&slice frames=&frame");
	else 							run("Duplicate...", "duplicate title=toClose slices=&slice frames=&frame");
	run("RGB Color", "keep");
	rename("rgb_" + title);
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
	apply_LUTs();
	makeRectangle(173, 255, 314, 178);
	enhance_All_Channels();
	run("Select None");
	setOption("Changes",0);
	setBatchMode(0);
}

function channels_Roll(){
	if (bitDepth()==24) run("Make Composite");
	getDimensions(width,  height, channels, slices, frames);
	id = getImageID();
	txt = "open";
	if (channels == 3) newList = newArray(123,132,312,213,321,231);
	else newList = newArray(1234,1243,1342,1324,1423,1432,2134,2143,2341,2314,2431,2413,3124,3142,3241,3214,3412,3421,4123,4132,4231,4213,4312,4321);
	for (i = 0; i < newList.length; i++) {
		setBatchMode(1);
		selectImage(id);
		run("Duplicate...","duplicate");
		if(bitDepth() == 24) run("Make Composite");
		reorderLUTs(newList[i]);
		run("Stack to RGB");
		rename(i);
		setOption("Changes", 0);
		txt += " image" + i+1 + "=[" + i + "]";
		setBatchMode(0);
	}
	run("Concatenate...", txt);
	rename("rolled");

	function reorderLUTs(order) {//for channels_Roll
		Stack.getPosition(channel, slice, frame);
		getDimensions(width, height, channels, slices, frames);
		order = toString(order);
		title = getTitle();
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
		Stack.setPosition(channel, slice, frame);
	}
}

function live_MultiPlot() {
	// adapted from jérome Mutterer: https://gist.github.com/mutterer/4a8e226fbe55e8e682a1
	close("LUT Profile");
	cursor_Position = "not on a line anchor point";
	if (bitDepth() == 24){ run("Plot Profile"); exit();}
	getCursorLoc(origin_x, origin_y, z, flags);
	// if selection is a Line
	if (selectionType()==5) {
		getLine(line_x1, line_y1, line_x2, line_y2, line_Width);
		if		(get_Distance(line_x1, line_y1, origin_x, origin_y) < 10)									cursor_Position = "start point";
		else if	(get_Distance(line_x2, line_y2, origin_x, origin_y) < 10)									cursor_Position = "end point";
		else if	(get_Distance((line_x1 + line_x2) / 2, (line_y1 + line_y2)/2, origin_x, origin_y) < 10)		cursor_Position = "middle point";
	}
	id = getImageID;
	getStatistics(bla, bla, min, max);
	getPixelSize(unit, pixel_Width, pixel_Height);
	getLine(line_x1, line_y1, line_x2, line_y2, line_Width);
	if (!isOpen("MultiPlot")) {
		call("ij.gui.ImageWindow.setNextLocation", SAVED_LOC_X, SAVED_LOC_Y);
		run("Plots...", "width=400 height=200");
	}
	Plot.create("MultiPlot", "Distance ("+unit+")", "Value");
	selectImage(id);
	id = getImageID;
	while (flags & 16 != 0) {
		selectImage(id);
		getCursorLoc(new_x, new_y, z, flags);
		if (cursor_Position == "not on a line anchor point")	makeLine(origin_x, origin_y, new_x, new_y);
		else if (cursor_Position == "start point")				makeLine(new_x, new_y, line_x2, line_y2);
		else if (cursor_Position == "end point")				makeLine(line_x1, line_y1, new_x, new_y);
		else if (cursor_Position == "middle point") {
			dx = new_x - origin_x;  
			dy = new_y - origin_y;  
			makeLine(line_x1 + dx, line_y1 + dy, line_x2 + dx, line_y2 + dy);
		}
		Stack.getDimensions(w, h, channels, z, t);
		pre_Profile = getProfile();
		size = pre_Profile.length; 
		for (i=0; i<size; i++) pre_Profile[i] = i*pixel_Width;
		Plot.create("MultiPlot", "Distance ("+unit+")", "Value");
		Plot.setBackgroundColor("#2f2f2f");
		Plot.setAxisLabelSize(14.0, "bold");
		Plot.setFormatFlags("11001100101111");
		Plot.setLimits(0, pre_Profile[size-1], min, max);
		for (i=1; i<=channels; i++) {
			if (is_Active_Channel(i-1)) {
				if (channels > 1) Stack.setChannel(i);
				if (selectionType()==-1) makeRectangle(new_x, new_y, 1, 1);
				profile = getProfile();
				Plot.setColor(lut_To_Hex2());
				Plot.setLineWidth(2);
				Plot.add("line", pre_Profile, profile);
			}
		}
		Plot.update();
		wait(10);
	}
	selectWindow("MultiPlot"); 
	Plot.setLimitsToFit();
	selectImage(id);
}

function get_Distance(x1, y1, x2, y2) {
	return sqrt((x1-x2) * (x1-x2) + (y1-y2) * (y1-y2));
}

function multi_Plot(){
	close("LUT Profile");
	select_None = 0; normalize = 0;
	if (isKeyDown("space")) normalize = 1;
	getDimensions(width,  height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	if (selectionType() == -1) run("Select All");
	if (bitDepth() == 24){ run("Plot Profile"); exit();}
	id = getImageID();
	if (!isOpen("MultiPlot")) call("ij.gui.ImageWindow.setNextLocation", SAVED_LOC_X, SAVED_LOC_Y);
	run("Plots...", "width=400 height=200");
	Plot.create("MultiPlot", "Pixels", "Grey value");
	for (i=1; i<=channels; i++) {
		if (channels > 1) Stack.setChannel(i);
		if (is_Active_Channel(i-1)) {
			profile = getProfile();
			Array.getStatistics(profile, min, max, mean, stdDev);
			if (normalize) for (k=0; k<profile.length; k++) profile[k] = Math.map(profile[k], min, max, 0, 1);
			Plot.setColor(lut_To_Hex2());
			Plot.setLineWidth(2);
			Plot.add("line", profile);
		}
	}
	Stack.setPosition(channel, slice, frame);
	updateDisplay();
	Plot.setBackgroundColor("#2f2f2f");
	Plot.setAxisLabelSize(14.0, "bold");
	Plot.setFormatFlags("11001100101111");
	if (normalize) Plot.setXYLabels("Pixels", "Normalized Intensity");
	Plot.update();
	selectWindow("MultiPlot");
	if (normalize) Plot.setLimits(0, profile.length, 0, 1.01 );
	else  Plot.setLimitsToFit();
	Plot.freeze(1);
	selectImage(id);
	getSelectionBounds(x, y, selection_Width, height);
	if (selection_Width == Image.width) run("Select None");
}
function lut_To_Hex2(){
	getLut(reds, greens, blues);
	if (is("Inverting LUT")) { red = reds[0];   green = greens[0];   blue = blues[0];   }
	else 					 { red = reds[255]; green = greens[255]; blue = blues[255]; }
    hex_red = IJ.pad(toHex(red), 2);
    hex_green = IJ.pad(toHex(green), 2);
    hex_blue = IJ.pad(toHex(blue), 2);
	return "#" + hex_red + hex_green + hex_blue;
}

function multi_Plot_Z_Axis(){
	close("LUT Profile");
	select_None = 0; active_Channels = "1"; normalize = 1;
	// if (isKeyDown("space")) normalize = 1;
	getDimensions(width,  height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	if (selectionType() == -1) {run("Select All");}
	if (bitDepth() == 24){ run("Plot Profile"); exit();}
	if (channels > 1) Stack.getActiveChannels(active_Channels);
	id = getImageID();
	if (!isOpen("Multiplot")) call("ij.gui.ImageWindow.setNextLocation", SAVED_LOC_X, SAVED_LOC_Y);
	run("Plots...", "width=400 height=200");
	Plot.create("MultiPlot", "Frame", "Grey value");
	for (i=1; i<=channels; i++) {
		if (channels > 1) Stack.setChannel(i);
		if (is_Active_Channel(i - 1)) {
			LUTcolor = lut_To_Hex2();
			setBatchMode(1);
			run("Plot Z-axis Profile");
			Plot.getValues(xpoints, profile);
			Array.getStatistics(profile, min, max, mean, stdDev);
			if (normalize) for (k=0; k<profile.length; k++) profile[k] = Math.map(profile[k], min, max, 0, 1);
			Plot.setColor(LUTcolor);
			Plot.setLineWidth(2);
			Plot.add("line", profile);
			close();
			setBatchMode(0);
		}
	}
	Stack.setPosition(channel, slice, frame);
	updateDisplay();
	Plot.setBackgroundColor("#2f2f2f");
	Plot.setAxisLabelSize(14.0, "bold");
	Plot.setFormatFlags("11001100101111");
	if (normalize) Plot.setXYLabels("Frame", "Normalized Intensity");
	Plot.update();
	selectWindow("MultiPlot");
	if (normalize) Plot.setLimits(0, profile.length, 0, 1.01 );
	else  Plot.setLimitsToFit();
	Plot.freeze(1);
	selectImage(id);
	if (channels>1) Stack.setActiveChannels(active_Channels);
	getSelectionBounds(x, y, selection_Width, height);
	if (selection_Width == Image.width) run("Select None");
}

function plot_LUT(){
	close("MultiPlot");
	if (nImages == 0) exit();
	if (bitDepth() == 24) exit();
	id = getImageID();
	lutinance = newArray(0); //luminance of LUT...
	getLut(reds, greens, blues);
	setBatchMode(1);
		//LUT snapshot
		newImage("temp", "8-bit ramp", 385, 32, 1);
		setLut(reds, greens, blues);
		run("RGB Color");
		rename("temp");
		temp_1 = getImageID();
		run("Copy");
		newImage("temp", "RGB", 385, 32, 2);
		setSlice(1); 
		run("Paste");
		temp_2 = getImageID();
		selectImage(temp_1);
		run("Duplicate...","title=temp duplicate");
		simulate_Full_Deuteranopia();	
		rename("temp");
		run("Copy");
		selectImage(temp_2);	
		setSlice(2);	
		run("Paste");
		run("Make Montage...", "columns=1 rows=2 scale=1 border=0");
		rename("temp");
		setColor(45,45,45);
		setLineWidth(4);
		drawLine(0, 34, 385, 34);
		run("Copy");
		close("temp");
	setBatchMode(0);
	if (!isOpen("LUT Profile")) call("ij.gui.ImageWindow.setNextLocation", SAVED_LOC_X, SAVED_LOC_Y);
	run("Plots...", "width=400 height=265");
	Plot.create("LUT Profile", "Grey Value", "value");
	lutinance = get_LUTinance(reds, greens, blues);
	Plot.setColor("white"); 
	Plot.setLineWidth(2);
	Plot.add("line", lutinance);
	Plot.setColor("#ff4a4a");
	Plot.setLineWidth(2);
	Plot.add("line", reds);
	Plot.setColor("#8ce400");
	Plot.setLineWidth(2);
	Plot.add("line", greens);
	Plot.setColor("#60c3ff");
	Plot.setLineWidth(2);
	Plot.add("line", blues);
	Plot.setBackgroundColor("#2f2f2f");
	Plot.setAxisLabelSize(14.0, "bold");
	Plot.setFormatFlags("0");
	Plot.addLegend("1__luminance " + lutinance[0] + "-" + lutinance[255] + "\n1__reds\n2__greens\n3__blues", "Top-Left Transparent");
	Plot.update();
	selectWindow("LUT Profile");
	Plot.setLimits(-5, 260, -100, 260);
	Plot.freeze(1);
	makeRectangle(81, 214, 385, 64);
	run("Paste"); run("Select None"); 
	setOption("Changes", 0);
	selectImage(id);
}

function get_LUTinance(reds,greens,blues){
	lutinance = newArray(0);
	for (i = 0; i < 256; i++) {
		rgb = newArray(reds[i],greens[i],blues[i]);
		lutinance[i] = get_Luminance(rgb);
	}
	return lutinance;
}

function simulate_Full_Deuteranopia(){
	if (nImages==0) exit("No Image");
	getDimensions(width, height, channels, slices, frames);
	rgb_Snapshot();

	rgb2lms = newArray(0); lms2rgb = newArray(0); gammaRGB = newArray(0);
	a1=0.0; b1=0.0; c1=0.0; a2=0.0; b2=0.0; c2=0.0; inflection=0.0;

	rgb2lms[0] = 0.05059983; rgb2lms[1] = 0.08585369; rgb2lms[2] = 0.00952420;
	rgb2lms[3] = 0.01893033; rgb2lms[4] = 0.08925308; rgb2lms[5] = 0.01370054;
	rgb2lms[6] = 0.00292202; rgb2lms[7] = 0.00975732; rgb2lms[8] = 0.07145979;

	lms2rgb[0] = 30.830854; lms2rgb[1] = -29.832659; lms2rgb[2] = 1.610474;
	lms2rgb[3] = -6.481468; lms2rgb[4] = 17.715578; lms2rgb[5] = -2.532642; 
	lms2rgb[6] = -0.375690; lms2rgb[7] = -1.199062; lms2rgb[8] = 14.273846;

	gammaRGB[0] = 2.0; 
	gammaRGB[1] = 2.0; 
	gammaRGB[2] = 2.0; 

	anchor_e= newArray(0);
	anchor= newArray(0);

	/*
	Load the LMS anchor-point values for lambda = 475 & 485 nm (for
	protans & deutans) and the LMS values for lambda = 575 & 660 nm
	(for tritans)
	*/
	anchor[0] = 0.08008;  anchor[1]  = 0.1579;    anchor[2]  = 0.5897;
	anchor[3] = 0.1284;   anchor[4]  = 0.2237;    anchor[5]  = 0.3636;
	anchor[6] = 0.9856;   anchor[7]  = 0.7325;    anchor[8]  = 0.001079;
	anchor[9] = 0.0914;   anchor[10] = 0.007009;  anchor[11] = 0.0;

	/* We also need LMS for RGB=(1,1,1)- the equal-energy point (one of
	* our anchors) (we can just peel this out of the rgb2lms transform
	* matrix)
	*/
	anchor_e[0] = rgb2lms[0] + rgb2lms[1] + rgb2lms[2];
	anchor_e[1] = rgb2lms[3] + rgb2lms[4] + rgb2lms[5];
	anchor_e[2] = rgb2lms[6] + rgb2lms[7] + rgb2lms[8];

	/*  Deuteranope */
	a1 = anchor_e[1] * anchor[8] - anchor_e[2] * anchor[7]; 
	b1 = anchor_e[2] * anchor[6] - anchor_e[0] * anchor[8];
	c1 = anchor_e[0] * anchor[7] - anchor_e[1] * anchor[6];
	a2 = anchor_e[1] * anchor[2] - anchor_e[2] * anchor[1];
	b2 = anchor_e[2] * anchor[0] - anchor_e[0] * anchor[2];
	c2 = anchor_e[0] * anchor[1] - anchor_e[1] * anchor[0];
	inflection = (anchor_e[2] / anchor_e[0]);
			
	// process the image
	for (x = 0; x < width; x++) {
		showProgress(x/width);
		for (y = 0; y < height; y++) {
			i = getPixel(x, y);
			red = ((i & 0xff0000)>>16);
			green = ((i & 0xff00)>>8) ;
			blue = (i & 0xff);

			/* GL: Apply (not remove!) phosphor gamma to RGB intensities */
			// GL:  This is a Gimp/Scribus code bug, this way it returns values similar to those of Vischeck:
			red = Math.pow(red/255.0,  gammaRGB[0]);
			green = Math.pow(green/255.0, gammaRGB[1]);
			blue = Math.pow(blue/255.0,  gammaRGB[2]);

			redOld = red;
			greenOld = green;

			red = redOld * rgb2lms[0] + greenOld * rgb2lms[1] + blue * rgb2lms[2];
			green = redOld * rgb2lms[3] + greenOld * rgb2lms[4] + blue * rgb2lms[5];
			blue  = redOld * rgb2lms[6] + greenOld * rgb2lms[7] + blue * rgb2lms[8];

			tmp = blue / red;
			/* See which side of the inflection line we fall... */
			if (tmp < inflection)	green = -(a1 * red + c1 * blue) / b1;
			else 					green = -(a2 * red + c2 * blue) / b2;
					

			/* Convert back to RGB (cross product with transform matrix) */
			redOld = red;
			greenOld = green;

			red = redOld * lms2rgb[0] + greenOld * lms2rgb[1] + blue * lms2rgb[2];
			green = redOld * lms2rgb[3] + greenOld * lms2rgb[4] + blue * lms2rgb[5];
			blue = redOld * lms2rgb[6] + greenOld * lms2rgb[7] + blue * lms2rgb[8];

			/* GL Remove (not apply!) phosphor gamma to go back to original intensities */
			// GL:  This is a Gimp/Scribus code bug, this way it returns values similar to those of Vischeck:
			ired =		Math.round(Math.pow(red,	1.0/gammaRGB[0])*255.0);
			igreen =	Math.round(Math.pow(green,	1.0/gammaRGB[1])*255.0);
			iblue =		Math.round(Math.pow(blue,	1.0/gammaRGB[2])*255.0);

			/* Ensure that we stay within the RGB gamut */
			/* *** FIX THIS: it would be better to desaturate than blindly clip. */
			ired = Math.constrain(ired, 0, 255);
			igreen = Math.constrain(igreen, 0, 255);
			iblue = Math.constrain(iblue, 0, 255);

			i = ((ired & 0xff)<<16)+((igreen & 0xff)<<8 )+(iblue & 0xff);
			setPixel(x, y, i);
		}
	}
}

function fast_Merge(){
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
	if (isKeyDown("shift")) run("Enhance Local Contrast (CLAHE)", "blocksize=20 histogram=256 maximum=1.5 mask=*None* fast_(less_accurate)");
	else run("Enhance Local Contrast (CLAHE)");
}

function set_Active_Path() { File.setDefaultDir(getDirectory("image")); }


function rgb_To_Composite_switch(){ //RGB to Composite et vice versa 
	if (nImages==0) exit("no image");
	title=getTitle();
	if (bitDepth() == 24) {
		run("Duplicate...","duplicate");
		run("Make Composite");
		run("Remove Slice Labels");
	}
	else { 
		rgb_Snapshot();
	}
	setOption("Changes", 0);
}

function my_RGB_Converter(half_or_full_colors){
	setBatchMode(1);
	if (nImages==0) exit("no image");
	if (bitDepth() == 24) {
		run("Duplicate...","duplicate");
		run("Make Composite");
		run("Remove Slice Labels");
	}
	if (half_or_full_colors == "full") {
		Stack.setChannel(1); make_LUT(255,194,0);
		Stack.setChannel(2); make_LUT(0,255,194);
		Stack.setChannel(3); make_LUT(194,0,255);
	}
	else {
		Stack.setChannel(1); make_LUT(128,97,0);
		Stack.setChannel(2); make_LUT(0,128,97);
		Stack.setChannel(3); make_LUT(97,0,128);
	}
	setOption("Changes", 0);
	setBatchMode(0);
}

function Red_Green_to_Orange_Blue() { //Red Green to Orange Blue
	if (nImages==0) exit("no image");
	if (bitDepth() == 24) {
		run("Duplicate...","duplicate");
		run("Make Composite");
		run("Remove Slice Labels");
	}
	getDimensions(width, height, channels, slices, frames);
	if (channels > 2) run("Arrange Channels...", "new=12");
	Stack.setChannel(1); make_LUT(0,155,255);
	Stack.setChannel(2); make_LUT(255,100,0);
	setOption("Changes", 0);
}

function maximize_Image() {
	getLocationAndSize(X_POSITION_BACKUP, Y_POSITION_BACKUP, WIDTH_POSITION_BACKUP, HEIGHT_POSITION_BACKUP);
	getDimensions(width, height, null, null, null);
	if (width/height <= 2.5) {
		newHeight = (screenHeight()/11) * 10;
		newWidth = width * (newHeight / height);
		x = (screenWidth() - newWidth) / 2;
		y = (screenHeight() - newHeight)/1.2;
		setLocation(x, y, newWidth, newHeight);
		run("Set... ", "zoom="+(getZoom()*100)-2);
	}
	else {
		run("Maximize");
		setLocation(0, 200);
	}
}

function full_Screen_Image() {
	getLocationAndSize(X_POSITION_BACKUP, Y_POSITION_BACKUP, WIDTH_POSITION_BACKUP, HEIGHT_POSITION_BACKUP);
	setBatchMode(1);
	run("Set... ", "zoom="+round((screenWidth()/getWidth())*100)-1);
	setLocation(0, screenHeight()/11, screenWidth(), screenHeight()*0.88);
}

function restore_Image_Position(){
	setLocation(X_POSITION_BACKUP, Y_POSITION_BACKUP, WIDTH_POSITION_BACKUP, HEIGHT_POSITION_BACKUP);
}

function note_In_Infos(){
	if(nImages == 0) exit();
	infos = getMetadata("Info");
	note = String.paste();
	setMetadata("Info", note + '\n\n' + infos);
	run("Show Info...");
}

function gauss_Correction(){
	if (isKeyDown("shift")) EXIT_MODE = "exit and display";
	else EXIT_MODE = 0;
	setBatchMode(1);
	TITLE = getTitle();
	run("Duplicate...", "title=gaussed duplicate");
	getDimensions(width, height, channels, slices, frames);
	SIGMA = maxOf(height,width) / 4;
	run("Gaussian Blur...", "sigma=" + SIGMA + " stack");
	imageCalculator("Substract create stack", TITLE, "gaussed");
	rename(TITLE + "_corrected");
	setOption("Changes", 0);
	setBatchMode(EXIT_MODE);
}

function test_CLAHE_Options() {
	if (nImages == 0) exit("no image");
	setBatchMode(1);
	getDimensions(width, height, channels, slices, frames);
	if (slices*frames > 1) exit("can't test stacks, please extract one slice");
	setBatchMode(1);
	bloc_Size = newArray(10, 20, 50, 100, 200, 500);
	contrast = newArray(3,2,1.5);
	run("Duplicate...", "title=test");
	for (k=0; k<3; k++)	{
		for (i=0; i<6; i++)	{
			showProgress(i/20);
			bloc_Size_i = bloc_Size[i];	
			contrast_k = contrast[k];
			setSlice(1);
			run("Copy"); run("Add Slice"); run("Paste");	
			run("Enhance Local Contrast (CLAHE)", "blocksize=&bloc_Size_i histogram=256 maximum=&contrast_k fast_(less_accurate)");
			Property.setSliceLabel("bloc=" + bloc_Size[i]+ " contrast=" + contrast[k], 2);  
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
	source_Image = getImageID();
	Dialog.createNonBlocking("Test all Z projections");
	Dialog.addNumber("start", 1);
	Dialog.addNumber("stop", maxOf(slices, frames));
	Dialog.show();
	start = Dialog.getNumber();
	stop = Dialog.getNumber();
	setBatchMode(1);
	modes = newArray("[Max Intensity]", "[Sum Slices]", "[Standard Deviation]");
	newImage(title + "-Zprojects", "RGB", width, height, 3);
	result = getImageID();
	for (i=0; i<=2; i++) {
		selectImage(source_Image);
		run("Z Project...", "start=&start stop=&stop projection=" + modes[i]);
		resetMinAndMax;
		run("RGB Color");
		run("Copy");
		selectImage(result);	setSlice(i+1);	run("Paste");
		Property.setSliceLabel(modes[i], i+1)
	}
	run("Make Montage...", "scale=1 font=20 label");
	setBatchMode(0);
	setOption("Changes", 0);
}

function test_All_Calculator_Modes() {
	if (nImages == 0) exit("no image");
	image_titles = getList("image.titles");
	Dialog.createNonBlocking("Test calculator modes");
	Dialog.addChoice("image 1:", image_titles,image_titles[0]);
	Dialog.addChoice("'calculated' by image 2:", image_titles,image_titles[1]);
	Dialog.addCheckbox("32 bits?", 0);
	Dialog.show();
	image1 = Dialog.getChoice();
	image2 = Dialog.getChoice();
	bit32 = Dialog.getCheckbox();
	bitdepth = bitDepth();
	setBatchMode(1);
	getDimensions(width, height, channels, slices, frames);
	modes = newArray("add","subtract","multiply","divide", "min", "max", "average","difference","Transparent-zero");
	if (bit32) newImage("calculator", "32-bit", width, height, modes.length);
	else newImage("calculator", bitdepth+"-bit", width, height, modes.length);
	outID = getImageID();
	for (i=0; i<modes.length; i++) {
		if (bit32) imageCalculator(modes[i]+" create 32-bit", image1,image2);
		else imageCalculator(modes[i]+" create", image1,image2);
		run("Copy");
		selectImage(outID);	
		setSlice(i+1);	
		run("Paste");
		Property.setSliceLabel(modes[i], i+1);
	}
	setSlice(1);
	run("Select None");
	setOption("Changes", 0);
	setBatchMode(0);
}

function fancy_3D_montage() {
	setBatchMode(1);
	setBackgroundColor(0,0,0);
	getDimensions(width, height, channels, slices, frames);
	size = maxOf(width, height);
	id=getImageID();
	run("3D Project...", 	"projection=[Mean Value] axis=Y-Axis initial=0 total=360 rotation=10 interpolate");
		run("Canvas Size...", "width=&size height=&size position=Center zero");
		rename("3D1");
	selectImage(id);
	run("3D Project...", 	"projection=[Mean Value] axis=X-Axis initial=0 total=360 rotation=10 interpolate");
		run("Canvas Size...", "width=&size height=&size position=Center zero");
		rename("3D2");
	selectImage(id);
	run("Duplicate...","duplicate");
	run("Reslice [/]...", "output=0.354 start=Left");
	id=getImageID();
	run("3D Project...", 	"projection=[Mean Value] axis=Y-Axis initial=0 total=360 rotation=10 interpolate");
		run("Canvas Size...", "width=&size height=&size position=Center zero");
		rename("3D3");
	selectImage(id);
	run("3D Project...", 	"projection=[Mean Value] axis=X-Axis initial=0 total=360 rotation=10 interpolate");
		run("Canvas Size...", "width=&size height=&size position=Center zero");
		rename("3D4");
		top = Combine_Horizontally("3D2","3D1");
		bottom =  Combine_Horizontally("3D4","3D3");
		Combine_Vertically(top,bottom);
	setBatchMode(0);
	run("Animation Options...", "speed=8 loop start");
}

function my_3D_projection() {
	showStatus("3D project");
	run("3D Project...", "projection=[Mean Value] initial=312 total=96 rotation=12 interpolate");
	run("Animation Options...", "speed=8 loop start");
	setOption("Changes", 0);
}

function batch_ims_To_tif(){
	// ask user to select a folder
	directory = getDirectory("Select A folder");
	// get the list of files (& folders) in it
	fileList = getFileList(directory);
	setBatchMode(true);
	for (i = 0; i < lengthOf(fileList); i++) {
		current_imagePath = directory + fileList[i];
		print("opening "+ fileList[i]);
		run("Bio-Formats Importer", "open=&current_imagePath");
		rename(fileList[i]);
		saveAs("tiff", directory + fileList[i]);
		run("Z Project...", "projection=[Max Intensity] all");
		saveAs("tiff", directory + getTitle());
		run("Close All");
	}
	print("done");
	setBatchMode(false);
}

/*--------
Set LUTs
--------*/
function get_My_LUTs(){
	LUT_list = newArray("k_Blue","k_Orange","k_Magenta","k_Green","Grays" ,"copied" ,"fav");
	getDimensions(width, height, channels, slices, frames);
	Dialog.create("Set all LUTs");
	for(i=0; i<channels; i++) { Dialog.setInsets(0, 0, 0); Dialog.addRadioButtonGroup("LUT " + (i+1), LUT_list, 2, 4, CHOSEN_LUTS[i]);}
	Dialog.addCheckbox("noice?", NOICE_LUTs);
	Dialog.show();
	for(i=0; i<channels; i++) CHOSEN_LUTS[i] = Dialog.getRadioButton();
	NOICE_LUTs = Dialog.getCheckbox();
	apply_LUTs();
}

function get_LUTs_Dialog(){
	LUT_list = newArray("k_Blue","k_Magenta","k_Orange","k_Green","Grays","Cyan","Magenta","Yellow","Red","Green","Blue");
	getDimensions(width, height, channels, slices, frames);
	Dialog.create("Set all LUTs");
	for(i=0; i<channels; i++) Dialog.addChoice("LUT " + (i+1),LUT_list, CHOSEN_LUTS[i]);
	Dialog.show();
	for(i=0; i<channels; i++) CHOSEN_LUTS[i] = Dialog.getChoice();
}

function apply_LUTs(){
	Stack.getPosition(channel,s,f);
	getDimensions(w,h,channels,s,f);
	lut_list = Array.copy(CHOSEN_LUTS);
	if (NOICE_LUTs) for(i=0; i<channels; i++) if (CHOSEN_LUTS[i] != "Grays") lut_list[i] = lut_list[i] + "_noice";
	if (channels>1){
		Stack.setDisplayMode("composite");
		for(i=1; i<=channels; i++){
			Stack.setChannel(i);
			if (lut_list[i-1]=="fav") paste_Favorite_LUT();
			else if (lut_list[i-1]=="copied") paste_LUT();
			else run(lut_list[i-1]);
		}
		Stack.setChannel(channel);
		Stack.setDisplayMode("color");Stack.setDisplayMode("composite");
	}
	else {
		if (lut_list[0]=="fav") paste_Favorite_LUT();
		else if (lut_list[0]=="copied") paste_LUT();
		else  run(lut_list[0]);
	}
}

function apply_All_LUTs(){
	setBatchMode(1);
	all_IDs = newArray(nImages);
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		all_IDs[i] = getImageID(); 
	} 
	for (i=0; i<nImages; i++) {
		selectImage(all_IDs[i]);
		if (bitDepth() != 24) apply_LUTs();	
	}
	setBatchMode(0);
}

//for args give gamma value, and r,g,b obtained by getLut(r,g,b) command.
function gamma_LUT(gamma, reds, greens, blues) {
	gammaReds = newArray(256); 
	gammaGreens = newArray(256); 
	gammaBlues = newArray(256); 
	gamma_factor = newArray(256);
	for (i=0; i<256; i++) gamma_factor[i] = pow(i, gamma);
	scale = 255 / gamma_factor[255];
	for (i=0; i<256; i++) gamma_factor[i] = round(gamma_factor[i] * scale);
	for (i=0; i<256; i++) {
		j = gamma_factor[i];
		gammaReds[i] = reds[j];
		gammaGreens[i] = greens[j];
		gammaBlues[i] = blues[j];
	}
	setLut(gammaReds, gammaGreens, gammaBlues);
}

function set_Gamma_LUT_All_Channels(gamma){
	if (nImages == 0) exit("No opened image"); if (bitDepth() == 24) exit("this is an RGB image");
	getDimensions(w,h,channels,s,f);
	if (channels > 1) {
		for (i=1; i<=channels; i++){
			Stack.setChannel(i);
			getLut(reds, greens, blues);
			gamma_LUT(gamma,reds, greens, blues);	
		}
	}
	else {
		getLut(reds, greens, blues);
		gamma_LUT(gamma,reds, greens, blues);
	}
}

/*----------------------------------------------------------------
Adjust the contrast window between min and max on active channel
----------------------------------------------------------------*/
function adjust_Contrast() { 
	if (is("Virtual Stack")) {run("Enhance Contrast", "saturated=0"); run("Select None"); exit();}
	setBatchMode(1);
	id = getImageID();
	getDimensions(width, height, channels, slices, frames);
	if (slices * frames * channels == 1) 
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
	call("ij.plugin.frame.ContrastAdjuster.update");
}// Note : I discovered that the built-in command 'run("Enhance Contrast...", "saturated=0.001 use");' give same results
//		  but it only works on single channel stacks so this macro is still necessary for hyperstacks.

function reduce_Contrast(){
	getDimensions(width, height, channels, slices, frames);
	message = "";
	for (i = 0; i < channels; i++) {
		Stack.setChannel(i+1);
		getMinAndMax(min, max);
		setMinAndMax(min, max+(0.1*max));
		message += "  channel "+i+1+" = "+(max+(0.1*max));
	}
	showStatus(message, "flash orange 1500ms");
}

function auto_Contrast_All_Channels() {
	getDimensions(width, height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	for (i = 0; i < channels; i++) {
		if (is_Active_Channel(i)) {
			Stack.setPosition(i+1, slice, frame);
			adjust_Contrast();
		}
	}
	Stack.setPosition(channel, slice, frame);
	updateDisplay();
}

function is_Active_Channel(channel_Index){
	getDimensions(width, height, channels, slices, frames);
	if (channels==1) return true;
	Stack.getDisplayMode(mode)
	if (mode == "color") {
		Stack.getPosition(channel, slice, frame);
		if (channel_Index+1 == channel) return true;
		else return false;
	} 
	Stack.getActiveChannels(string);
	if (string.substring(channel_Index, channel_Index+1) == "1") return true;
	else return false;
}

function enhance_All_Channels() {
	getDimensions(width, height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	for (i = 1; i <= channels; i++) {
		Stack.setPosition(i, slice, frame);
		run("Enhance Contrast", "saturated=0.03");	
	}
	Stack.setPosition(channel, slice, frame);
	updateDisplay();
	call("ij.plugin.frame.ContrastAdjuster.update");
}

/*------------------
All opened images
------------------*/
function auto_Contrast_All_Images(){
	showStatus("Reset all contrasts");
	all_IDs = newArray(nImages);
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		all_IDs[i] = getImageID(); 
	} 
	for (i=0; i<all_IDs.length; i++) {
		showProgress(i/all_IDs.length);
		selectImage(all_IDs[i]);
	    auto_Contrast_All_Channels();	
	}
}

function enhance_All_Images_Contrasts() {
	showStatus("Enhance all contrasts");
	all_IDs = newArray(nImages);
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		all_IDs[i] = getImageID(); 
	} 
	for (i=0; i<all_IDs.length; i++) {
		showProgress(i/all_IDs.length);
		selectImage(all_IDs[i]);
	    enhance_All_Channels();
	}
}

function propagate_Contrasts_All_Images(){
	Stack.getPosition(ch,s,f);
	getDimensions(width, height, channels, slices, frames);
	min = newArray(10);
	max = newArray(10);
	if (channels>1){
		for(i=0; i<channels; i++){
			Stack.setChannel(i+1);
			getMinAndMax(min[i], max[i]);
		}
		Stack.setChannel(ch);
		updateDisplay();
	}
	else getMinAndMax(min[0], max[0]);
	
	for (i = 0; i < nImages; i++) {
		if (bitDepth() != 24) {
			selectImage(i+1);
			getDimensions(width, height, channels, slices, frames);
			if (channels>1){
				for(k=0; k<channels; k++){
					Stack.setChannel(k+1);
					setMinAndMax(min[k], max[k]);
				}
				updateDisplay();
			}
			else setMinAndMax(min[0], max[0]);
		}
	}
}

function z_Project_All() {
	modes = newArray("[Average Intensity]","[Max Intensity]","[Sum Slices]","[Standard Deviation]","Median");
	all_IDs = newArray(nImages);
	Dialog.createNonBlocking("Z-Projection on all opened images");
	Dialog.addChoice("Method", modes, "[Max Intensity]");
	Dialog.show();
	Method_choice = Dialog.getChoice();
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		all_IDs[i] = getImageID(); 
	} 
	setBatchMode(1);
	for (i=0; i<all_IDs.length; i++) {
		selectImage(all_IDs[i]);
		getDimensions(w, h, channels, slices, frames);
		getLut(reds,greens,blues);
		if (channels*slices*frames!=1) run("Z Project...", "projection=" + Method_choice + " all");
		setLut(reds,greens,blues);
	}
	for (i=0; i<all_IDs.length ; i++) {	//Close not projected images
		selectImage(all_IDs[i]);
		getDimensions(w, h, channels, slices, frames);
		if (channels*slices*frames!=1) close();
	}
	setBatchMode("exit and display");
	run("Tile");
}

function save_All_Images_Dialog() {
	Dialog.createNonBlocking("Save all images as");
	Dialog.addChoice("format", newArray("tiff", "jpeg", "gif", "raw", "avi", "bmp", "png", "pgm", "lut", "selection", "results", "text"), "tiff");
	Dialog.show();
	format = Dialog.getChoice();
	folder = getDirectory("Choose a Directory");
	for (i=0; i<nImages; i++) {
        selectImage(i+1);
        title = getTitle;
        saveAs("tiff", folder + title);
        print(title + " saved");
	}
	print("done");
}

function my_Tile() {
	if (nImages() == 0) exit();
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


function ultimate_SplitView() {
	if (nImages==0) exit("No opened image");
	if(bitDepth()==24) exit("won't work on RGB image");
	getDimensions(width, height, channels, slices, frames);
	id=getImageID();
	title = getTitle();
	if (channels == 1 || channels > 5) exit();
	if (startsWith(title, "Splitview")) { revert_SplitView(); exit(); }
	setBatchMode("hide");
	run("Duplicate...","title=be_right_back duplicate frames=1 slices=1");
	setBatchMode("show");
	selectImage(id);
	rename("Splitview_" + title);
	Stack.getPosition(channel, slice, frame);
	new_width = width * (channels+1);
	all_steps = channels * slices; 
	step = 0;
	if ((frames>1)&&(slices==1)) {
		slices=frames; 
		frames=1; 
		Stack.setDimensions(channels,slices,frames); 
	} 
	run("Canvas Size...", "width=&new_width height=&height position=Center-Right zero");
	makeRectangle(0, 0, width, height);
	for (k = 1; k <= channels; k++) {	
		Stack.setChannel(k); 
		for (i=1; i<=slices; i++) {
			Stack.setSlice(i);
			Roi.move(width*channels, 0);		run("Copy");
			if (k==1) { Roi.move(0, 0);			run("Paste");}
			if (k==2) { Roi.move(width, 0);		run("Paste");}
			if (k==3) { Roi.move(width*2, 0);	run("Paste");}
			if (k==4) { Roi.move(width*3, 0);	run("Paste");}
			if (k==5) { Roi.move(width*4, 0);	run("Paste");}
			step++;	showProgress(step / all_steps);
		}
	}
	close("be_right_back");
	run("Select None");
	setOption("Changes", 0);
	Stack.setDisplayMode("composite");
	Stack.setPosition(channel, slice, frame);
	setBatchMode(0);
	
	function revert_SplitView(){
		getDimensions(width, height, channels, slices, frames);
		width = width / (channels+1);	
		overlay = (channels * width); 
		id = getImageID();
		makeRectangle(overlay, 0, width, height);
		run("Crop");
		title=getTitle();
		rename(title.substring(10, (title.length)));
		setOption("Changes", 0);
	}
	
}


function split_View_Dialog(){
	if (nImages == 0) exit();
	getDimensions(width, height, channels, slices, frames);
	Dialog.createNonBlocking("split_View");
	Dialog.addRadioButtonGroup("color Mode", newArray("Colored","Grayscale"), 1, 3, COLOR_MODE);
	Dialog.addRadioButtonGroup("Montage Style", newArray("Linear","Square","Vertical"), 1, 3, MONTAGE_STYLE);
	Dialog.addSlider("border size", 0, 50, minOf(height, width) * 0.02);
	Dialog.addCheckbox("label channels?", LABELS);
	Dialog.show();
	COLOR_MODE = Dialog.getRadioButton();
	MONTAGE_STYLE = Dialog.getRadioButton();
	BORDER_SIZE = Dialog.getNumber();
	LABELS = Dialog.getCheckbox();
	if	    (COLOR_MODE == "Colored"   && MONTAGE_STYLE == "Linear")  { if (LABELS) split_View(1,0,1); else split_View(1,0,0); }
	else if (COLOR_MODE == "Grayscale" && MONTAGE_STYLE == "Linear")  { if (LABELS) split_View(0,0,1); else split_View(0,0,0); }
	else if (COLOR_MODE == "Colored"   && MONTAGE_STYLE == "Square")  { if (LABELS) split_View(1,1,1); else split_View(1,1,0); }
	else if (COLOR_MODE == "Grayscale" && MONTAGE_STYLE == "Square")  { if (LABELS) split_View(0,1,1); else split_View(0,1,0); }
	else if (COLOR_MODE == "Colored"   && MONTAGE_STYLE == "Vertical"){ if (LABELS) split_View(1,2,1); else split_View(1,2,0); }
	else if (COLOR_MODE == "Grayscale" && MONTAGE_STYLE == "Vertical"){ if (LABELS) split_View(0,2,1); else split_View(0,2,0); }
}

function split_View(COLOR_MODE, MONTAGE_STYLE, LABELS) {
	// COLOR_MODE : 0 = grayscale , 1 = color 
	// MONTAGE_STYLE : 0 = linear montage , 1 = squared montage , 2 = vertical montageage
	// LABELS : 0 = no , 1 = yes.
	setBatchMode(1);
	title = getTitle();
	saveSettings();
	getDimensions(width, height, channels, slices, frames);
	Setup_SplitView(COLOR_MODE, LABELS);
	restoreSettings();
	if (MONTAGE_STYLE == 0)	linear_SplitView();
	if (MONTAGE_STYLE == 1)	square_SplitView();
	if (MONTAGE_STYLE == 2)	vertical_SplitView();
	rename(title + "_SplitView");
	setOption("Changes", 0);
	setBatchMode("exit and display");

	function Setup_SplitView(COLOR_MODE, LABELS){
		//prepare TILES before montage : 
		// duplicate twice for overlay and splitted channels
		// convert to RGB with right colors, LABELS and borders
		if (channels == 1) exit("only one channel");
		if (channels > 5)  exit("5 channels max");
		setBackgroundColor(255, 255, 255); //for white borders
		run("Duplicate...", "title=image duplicate");
		if ((slices > 1) && (frames == 1)) {
			frames = slices;
			slices = 1;
			Stack.setDimensions(channels, slices, frames); 
		} 
		TILES = newArray(channels + 1);
		getDimensions(width, height, channels, slices, frames); 
		FONT_SIZE = height / 9;
		run("Duplicate...", "title=split duplicate");
		run("Split Channels");
		selectWindow("image");
		Stack.setDisplayMode("composite")
		if (LABELS) {
			get_Labels_Dialog();
			setColor("white");
			setFont("SansSerif", FONT_SIZE, "bold antialiased");
			Overlay.drawString("Merge", height/20, FONT_SIZE);
			Overlay.show;
			run("Flatten","stack");
			rename("overlay");
			TILES[0] = getTitle();
			if (BORDER_SIZE > 0) add_Borders();
			close("image");
			for (i = 1; i <= channels; i++) {
				selectWindow("C" + i + "-split");
				id = getImageID();
				getLut(reds, greens, blues); 
				setColor(reds[255], greens[255], blues[255]);
				if (!COLOR_MODE) {
					getMinAndMax(min, max); 
					run("Grays"); 
					setMinAndMax(min, max);
				}
				Overlay.drawString(CHANNEL_LABELS[i-1], height/20, FONT_SIZE);
				Overlay.show;
				if (slices * frames > 1) run("Flatten","stack");
				else {
					run("Flatten");
					selectImage(id);
					close();
				}
				if (BORDER_SIZE > 0) add_Borders();
				TILES[i]=getTitle();
			}
		}
		else { // without LABELS
			run("RGB Color", "frames"); 
			rename("overlay"); 
			TILES[0] = getTitle(); 
			if (BORDER_SIZE > 0) add_Borders();
			close("image");
			for (i = 1; i <= channels; i++) {
				selectWindow("C"+i+"-split");
				if (!COLOR_MODE) {
					getMinAndMax(min, max); 
					run("Grays"); 
					setMinAndMax(min, max);
				}
				run("RGB Color", "slices"); 
				if (BORDER_SIZE > 0) add_Borders();
				TILES[i] = getTitle();	
			}
		}
	}

	function add_Borders(){
		run("Canvas Size...", "width=" + Image.width + BORDER_SIZE + " height=" + Image.height + BORDER_SIZE + " position=Center");
	}
	
	function get_Labels_Dialog(){
		Dialog.createNonBlocking("Provide channel names");
		for (i = 0; i < 5; i++) Dialog.addString("channel " + i+1, CHANNEL_LABELS[i], 12); 
		Dialog.addNumber("Font size", FONT_SIZE);
		Dialog.show();
		for (i = 0; i < 5; i++) CHANNEL_LABELS[i] = Dialog.getString();
		FONT_SIZE = Dialog.getNumber();
	}
	
	function square_SplitView(){
		channel_1_2 = combine_Horizontally(TILES[1], TILES[2]);
		if (channels == 2||channels == 4) channel_1_2_Overlay = combine_Horizontally(channel_1_2, TILES[0]);
		if (channels == 3){
			channel_3_Overlay = combine_Horizontally(TILES[3], TILES[0]);
			combine_Vertically(channel_1_2, channel_3_Overlay);
		}
		if (channels >= 4)	channel_3_4 = combine_Horizontally(TILES[3], TILES[4]);
		if (channels == 4)	combine_Vertically(channel_1_2_Overlay, channel_3_4);
		if (channels == 5){
			channel_1_2_3_4 = combine_Vertically(channel_1_2, channel_3_4); 	
			channel_5_Overlay =	combine_Vertically(TILES[5], TILES[0]); 
			combine_Horizontally(channel_1_2_3_4, channel_5_Overlay);
		}
	}
	
	function linear_SplitView(){
		channel_1_2 = combine_Horizontally(TILES[1], TILES[2]);
		if (channels==2) combine_Horizontally(channel_1_2, TILES[0]);
		if (channels==3){
			channel_3_Overlay = combine_Horizontally(TILES[3], TILES[0]);
			combine_Horizontally(channel_1_2, channel_3_Overlay);
		}
		if (channels>=4){
			channel_3_4 = combine_Horizontally(TILES[3], TILES[4]);
			channel_1_2_3_4 = combine_Horizontally(channel_1_2, channel_3_4);
		}
		if (channels==4) combine_Horizontally(channel_1_2_3_4, TILES[0]); 
		if (channels==5){
			channel_5_Overlay = combine_Horizontally(TILES[5], TILES[0]);
			combine_Horizontally(channel_1_2_3_4, channel_5_Overlay);
		}
	}
	
	function vertical_SplitView(){
		channel_1_2 = combine_Vertically(TILES[1], TILES[2]);
		if (channels==2) combine_Vertically(channel_1_2, TILES[0]);
		if (channels==3){
			channel_3_Overlay = combine_Vertically(TILES[3], TILES[0]);
			combine_Vertically(channel_1_2, channel_3_Overlay);
		}
		if (channels>=4){
			channel_3_4 = combine_Vertically(TILES[3], TILES[4]);
			channel_1_2_3_4	= combine_Vertically(channel_1_2, channel_3_4);
		}
		if (channels==4) combine_Vertically(channel_1_2_3_4, TILES[0]);
		if (channels==5){
			channel_5_Overlay = combine_Vertically(TILES[5], TILES[0]);
			combine_Vertically(channel_1_2_3_4, channel_5_Overlay);
		}
	}
	
	function combine_Horizontally(stack1, stack2){
		run("Combine...", "stack1=&stack1 stack2=&stack2");
		rename(stack1+"_"+stack2);
		return getTitle();
	}
	
	function combine_Vertically(stack1, stack2){
		run("Combine...", "stack1=&stack1 stack2=&stack2 combine"); //vertically
		rename(stack1+"_"+stack2);
		return getTitle();
	}
}

//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
function linear_LUTs_Baker() {
	if (nImages==0) exit("No opened image");
	if (bitDepth() == 24) exit(); setFont("SansSerif", 11, "antialiased bold");
	//setup
	reds_255 = newArray(4); greens_255 = newArray(4); blues_255 = newArray(4); 
	preview = 1;
	Stack.getPosition(channel, slice, frame);
	getDimensions(width, height, channels, slices, frames);
	getLocationAndSize(x, y, width, height) ;
	id = getImageID();
	//Save actual LUTs for undo
	saved_Reds = newArray(4); saved_Greens = newArray(4); saved_Blues = newArray(4);
	for (i=0; i<channels; i++) { 
		if (channels > 1) Stack.setChannel(i+1);
		getLut(reds, greens, blues);
		saved_Reds[i] = reds[255]; saved_Greens[i] = greens[255]; saved_Blues[i] = blues[255];
	}
	//LUT baking
	while ( preview ) {
		Dialog.createNonBlocking("The LUT baker");
		Dialog.setLocation(x + width, y);
		for (i=0; i<channels; i++) {
			if (channels > 1) Stack.setChannel(i+1);
			getLut(reds, greens, blues); 
			red = reds[255]; 	green = greens[255]; 	blue = blues[255];
			reds_255[i] = red;	greens_255[i] = green;	blues_255[i] = blue;
			Dialog.addMessage("LUT " + (i+1), 20, Color.toString(red, green, blue));
			Dialog.addSlider("Red",	 0, 255, red);
			Dialog.addSlider("Green",0, 255, green);
			Dialog.addSlider("Blue", 0, 255, blue);
			color = newArray(red, green, blue);
			Dialog.addMessage("luminance = " + get_Luminance(color));
		}
		if (channels > 1) Stack.setChannel(channel); 
		Dialog.setInsets(20, 0, 0);
		Dialog.addMessage("Reds= "+sum_Of_Array(reds_255)+"   Greens= "+sum_Of_Array(greens_255)+"   Blues= "+sum_Of_Array(blues_255));
		Dialog.addCheckbox("update changes", preview);
		Dialog.show();
		preview = Dialog.getCheckbox(); 
		selectImage(id);
		for(i=0; i<channels; i++){
			reds_255[i] = Dialog.getNumber(); greens_255[i] = Dialog.getNumber(); blues_255[i] = Dialog.getNumber();
			if (channels > 1) Stack.setChannel(i+1);
			make_LUT(reds_255[i], greens_255[i], blues_255[i]);
		}
	}
	if (channels > 1) Stack.setChannel(channel);
}

function sum_Of_Array(array) {
	sum = 0;
	for (i=0; i<array.length; i++) sum += array[i];
	return sum;
}

function make_LUT(red, green, blue){
	reds = newArray(256); greens = newArray(256); blues = newArray(256);
	for(i=0; i<256; i++) { 
		reds[i] = (red / 256) * (i+1);
		greens[i] = (green / 256) * (i+1);
		blues[i] = (blue / 256) * (i+1);
	}
	setLut(reds, greens, blues);
}

function copy_Paste_All_Channels_LUTs(){
	title = getTitle();
	list = getList("image.titles");
	Dialog.create("apply LUTs");
	Dialog.addChoice("source", list, TARGET_IMAGE_TITLE);
	Dialog.addChoice("destination", list, title);
	if (!isKeyDown("shift")) Dialog.show();
	setBatchMode(1);
	TARGET_IMAGE_TITLE = Dialog.getChoice();
	destination_title = Dialog.getChoice();
	selectWindow(TARGET_IMAGE_TITLE);
	getDimensions(w, h, channels, s, f);
	composite_Mode = Property.get("CompositeProjection");
	for (i = 0; i < channels; i++) {
		selectWindow(TARGET_IMAGE_TITLE);
		Stack.setChannel(i+1);
		getLut(reds, greens, blues);
		selectWindow(destination_title);
		Stack.setChannel(i+1);
		setLut(reds, greens, blues);
	}
	Property.set("CompositeProjection", composite_Mode);
	setBatchMode(0);
}

function reorder_LUTs(){
	if (nImages == 0) exit("no image");
	if (bitDepth() == 24) exit("won't works on RGB images");
	getDimensions(null, null, channels, null, null);
	if (channels == 2) {
		Stack.setChannel(1); getLut(reds, greens, blues);
		Stack.setChannel(2); getLut(reds2, greens2, blues2);
		Stack.setChannel(1); setLut(reds2, greens2, blues2);
		Stack.setChannel(2); setLut(reds, greens, blues);
		exit();	
	}
	Stack.getPosition(channel, slice, frame);
	//-----------------------------------------------------------------------------------------
	//prompt LUTs order and ask for the new one
	Dialog.create("Reorder LUTs");
	for (i = 1; i <= channels; i++) {
		Stack.setChannel(i);
		getLut(r,g,b);
		if (is("Inverting LUT")) { R = r[0];   G = g[0];   B = b[0];   }
		else 					 { R = r[255]; G = g[255]; B = b[255]; }
		Dialog.addMessage("    LuT "+i, 20, Color.toString(R,G,B));
	}
	updateDisplay();
	Dialog.addString("New LUTs order", "", channels);
	Dialog.show();
	//-----------------------------------------------------------------------------------------
	//get new order
	new_order = Dialog.getString();
	if (new_order.length != channels) exit("Please set the right number of LUTs");
	//-----------------------------------------------------------------------------------------
	//dup all channels in one slice, reorder channels, then transfert LUTs to original image
	title=getTitle();
	setBatchMode(1);
	run("Duplicate...","title=dup duplicate frames=1 slices=1");
	run("Arrange Channels...", "new=&new_order");
	for (i = 1; i <= channels; i++) {
		selectWindow("dup");
		Stack.setChannel(i);
		getLut(r, g, b);
		selectWindow(title);
		Stack.setChannel(i);
		setLut(r, g, b);
	}
	Stack.setPosition(channel, slice, frame);
	setBatchMode(0);
}

function inverted_Overlay_HSB(){
	setBatchMode(1);
	title = getTitle();
	rgb_Snapshot();
	run("Invert");
	run("HSB Stack");
	run("Macro...", "code=v=(v+128)%256 slice");
	run("RGB Color");
	rename(title+"_inv");
	setOption("Changes", 0);
	setBatchMode(0);
}

function RGB_time_Is_Over() {
    hues=30;
    setBatchMode(1);
    if (nImages==0) exit("no image");
    if (bitDepth() == 24) {
        run("Duplicate...","duplicate");
        run("Make Composite");
        run("Remove Slice Labels");
    }
	Stack.setChannel(1); make_LUT(0,127,128);
	Stack.setChannel(2); make_LUT(128,0,127);
	Stack.setChannel(3); make_LUT(127,128,0);
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

function Jeromes_Wheel(){
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

function rajout_De_Bout() { //for better ClearVolume
	setBatchMode(1);
	source_Image = getTitle();
	getVoxelSize(xwidth, xheight, depth, unit);
	run("Duplicate...","duplicate");
	dup = getTitle();
	if (bitDepth()!=24) type = toString(bitDepth())+"-bit";
	else type = "RGB";
	getDimensions(width, height, channels, slices, frames);
	newImage("1", type +" color-mode", width, height, channels, 2, 1);
	newImage("2", type +" color-mode", width, height, channels, 2, 1);
	run("Concatenate...", "  image1=1 image2=&dup image3=2");
	rename(dup+" bou");
	destination_title = getTitle();
	selectWindow(source_Image);
	for (i = 0; i < channels; i++) {
		selectWindow(source_Image);
		Stack.setChannel(i+1);
		getLut(reds, greens, blues);
		selectWindow(destination_title);
		Stack.setChannel(i+1);
		setLut(reds, greens, blues);
	}
	Stack.setPosition(1, slices/2, frames/2);
	auto_Contrast_All_Channels();
	setVoxelSize(xwidth, xheight, depth, unit);
	setOption("Changes", 0);
	setBatchMode(0);
}

function make_My_LUTs() {
	lutsFolder = getDirectory("luts");
	newImage("bo", "8-bit composite-mode", 400, 400, 4, 1, 1);
	setBackgroundColor(255,255,255);
	Stack.setChannel(1);
	makeRectangle(0, 0, 213, 213);
	run("Clear", "slice");
												make_LUT(0,155,255);//BLUE
	saveAs("LUT", lutsFolder + "/k_Blue.lut");
	Stack.setChannel(2);
	makeRectangle(187, 0, 213, 213);
	run("Clear", "slice");
												make_LUT(255,100,0);//ORANGE
	saveAs("LUT", lutsFolder + "/k_Orange.lut");
	Stack.setChannel(3);
	makeRectangle(187, 187, 213, 213);
	run("Clear", "slice");
												make_LUT(195,39,223);//PURP
	saveAs("LUT", lutsFolder + "/k_Magenta.lut");
	Stack.setChannel(4);
	makeRectangle(0, 187, 213, 213);
	run("Clear", "slice");
												make_LUT(50,206,22);//GREEN
	saveAs("LUT", lutsFolder + "/k_Green.lut");
	run("Select None");
	setOption("Changes", 0);
}

function rgb_LUT_To_LUT(){
	if (selectionType==10) { //jerome again https://gist.github.com/mutterer/51021eb24d117bb9d4f43e5f020b6bb8
	    Roi.getCoordinates(x, y);
	    if (x.length<2) exit("Multipoint ROI with at least 2 points needed");
	    r=newArray();
	    g=newArray();
	    b=newArray();
	    for (i=0;i<x.length;i++) {
	    	v=getPixel(x[i],y[i]);
	    	r[i]=(0xffffff&v)>>16;
	    	g[i]=(0xffff&v)>>8;
	    	b[i]=(0xff&v);
	    }
	    newImage("Untitled", "8-bit ramp", 256, 32, 1);
	    Color.setLut(Array.resample(r,256), Array.resample(g,256), Array.resample(b,256));
	}
	else {
	setBatchMode(1);
		if (bitDepth()!= 24) exit();
		if (selectionType()!=-1) run("Duplicate...","duplicate");
		if(Image.width != 256) run("Scale...", "width=256 height=32 interpolation=Bilinear average create");
		R = newArray(1); G = newArray(1); B = newArray(1);
		for (i = 0; i < 256; i++) {
			c = getPixel(i, 2);
			R[i] = (c>>16)&0xff; 	G[i] = (c>>8)&0xff;		B[i] = c&0xff;
		}
		newImage("LUT from RGB", "8-bit ramp", 256, 32, 1);
		setLut(R, G, B);
		setBatchMode(0);
	}
}

function convert_To_iMQ_Style() {
	if(nImages == 0) exit();
	getLut(r,g,b); 
	newImage("lut", "8-bit ramp", 192, 32, 1); 
	setLut(r,g,b);
	setBatchMode(1);
	run("RGB Color"); rename(1);
	newImage("iGrays", "8-bit ramp", 64, 32, 1);
	run("Invert LUT");
	grey  = Array.resample(newArray(120,0),256);
	setLut(grey, grey, grey);
	run("RGB Color");
	rename(2);
	run("Combine...", "stack1=2 stack2=1");
	selectWindow("Combined Stacks");
	R = newArray(1); G = newArray(1); B = newArray(1);
	for (i = 0; i < 256; i++) {
		color = getPixel(i, 2);
		R[i] = (color>>16)&0xff; 	G[i] = (color>>8)&0xff;		B[i] = color&0xff;
	}
	newImage("iMQ Style LUT!", "8-bit ramp", 256, 32, 1);
	setLut(R, G, B);
	setBatchMode(0);
}

function get_Luminance(rgb){
	rgb_weight = newArray(0.299,0.587,0.114);
	luminance = 0;
	for (i = 0; i < 3; i++) luminance += round(rgb[i]*rgb_weight[i]);
	return luminance;
}

//--------------------------------------------------------------------------------------------------------------------------------------

function show_All_Macros_Action_Bar(){
	setup_Action_Bar_Header("Main Keyboard Macros");
	add_new_Line();
	add_macro_button_with_hotKey("E", "Arrange windows on Tiles", "none");
	add_Contrast_Action_Bar();
	add_Basic_Action_Bar();
	add_SplitView_Action_Bar();
	add_Exports_Action_Bar();
	add_Bioformats_DnD();
	run("Action Bar", ACTION_BAR_STRING);
}

function show_Basic_Macros_Action_Bar(){
	setup_Action_Bar_Header("Utilities Macros");
	add_Basic_Action_Bar();
	add_Bioformats_DnD();
	run("Action Bar", ACTION_BAR_STRING);
}

function show_Export_Action_Bar(){
	setup_Action_Bar_Header("Exports");
	add_Exports_Action_Bar();
	add_Bioformats_DnD();
	run("Action Bar", ACTION_BAR_STRING);
}

function show_Contrast_Bar(){
	setup_Action_Bar_Header("Contrast Macros");
	add_Contrast_Action_Bar();
	add_Bioformats_DnD();
	run("Action Bar", ACTION_BAR_STRING);
}

function show_SplitView_Bar(){
	setup_Action_Bar_Header("Splitview Macros");
	add_SplitView_Action_Bar();
	add_Bioformats_DnD();
	run("Action Bar", ACTION_BAR_STRING);
}

function show_Numerical_Keyboard_Bar(){
	setup_Action_Bar_Header("Numerical Keyboard Macros");
	add_Numerical_Keyboard();
	add_Bioformats_DnD();
	run("Action Bar", ACTION_BAR_STRING);
}

function add_Basic_Action_Bar(){
	add_Text_Line("                  Channels & LUTs");
	add_new_Line();
	add_macro_button_with_hotKey("1", "Apply default LUTs", "none");
	add_new_Line();
	add_macro_button_with_hotKey("1", "Set default LUTs", "alt");
	add_macro_button_with_hotKey("1", "Default LUTs to all", "space");
	add_new_Line();
	add_macro_button_with_hotKey("Q", "Composite/channel switch", "none");
	add_macro_button_with_hotKey("Z", "Channels Tool", "none");
	add_Text_Line("                  Selections / Duplicates");
	add_new_Line();
	add_macro_button_with_hotKey("a", "Restore Selection", "space");
	add_macro_button_with_hotKey("D", "Duplicate full image", "none");
	add_new_Line();
	add_macro_button_with_hotKey("a", "Select None", "alt");
	add_macro_button_with_hotKey("d", "Duplicate Slice", "space");
	add_new_Line();
	add_macro_button_with_hotKey("a", "Select All", "none");
	add_macro_button_with_hotKey("d", "Duplicate full channel", "alt");
	add_Text_Line("                  Stack Projections");
	add_new_Line();
	add_macro_button_with_hotKey("G", "MAX full stack", "none");
	add_macro_button_with_hotKey("g", "Z Project Dialog", "none");
	add_new_Line();
	add_macro_button_with_hotKey("G", "SUM full stack", "alt");
	add_macro_button_with_hotKey("G", "MAX ALL IMAGES", "space");
}

function add_Contrast_Action_Bar(){
	add_Text_Line("                  Contrast Macros");
	add_new_Line();
	add_macro_button_with_hotKey("C", "Brightness & Contrast", "none");
	add_new_Line();
	add_macro_button_with_hotKey("A", "Enhance active channel", "none");
	add_macro_button_with_hotKey("r", "Reset active channel", "none");
	add_new_Line();
	add_macro_button_with_hotKey("A", "Enhance all channels", "space");
	add_macro_button_with_hotKey("R", "Reset all channels", "none");
	add_new_Line();
	add_macro_button_with_hotKey("A", "Enhance all images", "alt");
	add_macro_button_with_hotKey("R", "Reset all images", "space");
	add_new_Line();
	add_macro_button_with_hotKey("R", "Same contrast to all images", "alt");
}

function add_SplitView_Action_Bar(){
	add_Text_Line("                  SplitView / Figures Macros");
	add_new_Line();
	add_macro_button_with_hotKey("p", "Preset linear figure", "alt");
	add_macro_button_with_hotKey("b", "Preset vertical figure", "alt");
	add_new_Line();
	add_macro_button_with_hotKey("S", "All options dialog", "alt");
	add_new_Line();
	add_macro_button_with_hotKey("S", "Colored square", "none");
	add_macro_button_with_hotKey("p", "Grayscale square", "space");
	add_new_Line();
	add_macro_button_with_hotKey("S", "Colored linear", "space");
	add_macro_button_with_hotKey("p", "Grayscale linear", "none");
	add_new_Line();
	add_macro_button_with_hotKey("b", "Colored vertical", "none");
	add_macro_button_with_hotKey("b", "Grayscale vertical", "space");
	add_new_Line();
	add_macro_button_with_hotKey("B", "Auto scale bar", "space");
}

function add_Exports_Action_Bar(){
	add_Text_Line("                  Export Images");
	add_new_Line();
	add_macro_button_with_hotKey("x", "Copy to System", "alt");
	add_new_Line();
	add_macro_button_with_hotKey("s", "Save as tiff", "none");
	add_macro_button_with_hotKey("s", "Save all opened images", "alt");
	add_new_Line();
	add_macro_button_with_hotKey("J", "Save as JPEG...", "none");
	add_macro_button_with_hotKey("J", "save As LZW tiff", "space");
}

function add_Numerical_Keyboard() {
	add_Text_Line("                  Numerical Keyboard Macros");
	add_Text_Line("      space : toggle channel, alt : toggle channel for all images");
	add_new_Line();
	add_macro_button_without_hotKey("n7", "7 (cyan)", "none");
	add_macro_button_without_hotKey("n8", "8 (magenta)", "none");
	add_macro_button_without_hotKey("n9", "9 (yellow)", "none");
	add_new_Line();
	add_macro_button_without_hotKey("n4", "4 (k blue)", "none");
	add_macro_button_without_hotKey("n5", "5 (k magenta)", "none");
	add_macro_button_without_hotKey("n6", "6 (k orange)", "none");
	add_new_Line();
	add_macro_button_without_hotKey("n1", "1 (grey)", "none");
	add_macro_button_without_hotKey("n2", "2 (k green)", "none");
	add_macro_button_without_hotKey("n3", "3 (red)", "none");
	add_new_Line();
	add_macro_button_without_hotKey("n0", "0 (favorite)", "none");
	add_macro_button_without_hotKey("n/", "/ (shortcuts list)", "none");
	add_macro_button_without_hotKey("n*", "* (diff of Gaussian)", "none");
}

function show_my_Zbeul_Action_Bar(){
	setup_Action_Bar_Header("my Zbeul");
	add_new_Line();
	add_gray_button("Fetch / Pull", "fetch_Or_Pull_StartupMacros();");
	add_Text_Line("                  Clipboard modifs");
	add_new_Line();
	add_gray_button("To string", "clipboard_To_String();");
	add_gray_button("To completion", "clipboard_To_Completion();");
	add_new_Line();
	add_gray_button("Correct path", "correct_Copied_Path();");
	add_gray_button("Add to image info", "note_In_Infos();");
	add_Text_Line("                  imgur images");
	add_new_Line();
	add_gray_button("3 channels", "setBatchMode(1); open(\"https://i.imgur.com/MZGVdVj.png\"); run(\"Make Composite\"); apply_LUTs(); run(\"Remove Slice Labels\"); setBatchMode(0);");
	add_gray_button("Microtubules", "open(\"https://i.imgur.com/LDO1rVL.png\");");
	add_gray_button("Brain stack", "setBatchMode(1); open(\"https://i.imgur.com/DYIF55D.jpg\"); run(\"Montage to Stack...\", \"columns=20 rows=18 border=0\"); rename(\"brain\"); setBatchMode(0);");
	add_Text_Line("                  Wheels and tests");
	add_new_Line();
	add_gray_button("Jeromes RGB Wheel", "Jeromes_Wheel();");
	add_gray_button("RGB time Is Over", "RGB_time_Is_Over();");
	add_new_Line();
	add_gray_button("Test calculator modes", "test_All_Calculator_Modes();");
	add_gray_button("Test all Z project", "test_All_Zprojections();");
	add_new_Line();
	add_gray_button("Test CLAHE options", "test_CLAHE_Options();");
	add_gray_button("Test main filters", "test_main_Filters();");
	add_new_Line();
	add_gray_button("LUT Montage", "display_LUTs();");
	add_Code_Library();
	add_Bioformats_DnD();
	run("Action Bar", ACTION_BAR_STRING);
}

function setup_Action_Bar_Header(main_Title){
	ACTION_BAR_STRING = "";
	if (isOpen(main_Title)) run("Close AB", main_Title);
	add_fromString();
	add_main_title(main_Title);
	add_Code_Library();
}
function setup_Popup_Action_Bar_Header(main_Title){
	ACTION_BAR_STRING = "";
	if (isOpen(main_Title)) run("Close AB", main_Title);
	add_Popup_fromString();
	add_main_title(main_Title);
	add_Code_Library();
}

function add_Code_Library() {
	macros_As_String = File.openUrlAsString("https://raw.githubusercontent.com/kwolbachia/Imagej-macro-addiction/main/my_startupMacro.ijm");
	ACTION_BAR_STRING += "<codeLibrary>\n" + macros_As_String + "</codeLibrary>\n";
}

function add_fromString(){	ACTION_BAR_STRING += "<fromString>\n<disableAltClose>\n";}

function add_Popup_fromString(){	ACTION_BAR_STRING += "<fromString>\n<popup>\n";}

function add_main_title(title){	ACTION_BAR_STRING += "<title>" + title + "\n";}

function add_new_Line(){	ACTION_BAR_STRING += "</line>\n<line>\n";}

function add_noGrid(){	ACTION_BAR_STRING += "<noGrid>\n";}

function add_Text_Line(text){	
	add_new_Line();
	ACTION_BAR_STRING += "<text>" + text + "\n";
}

function add_Text(text){	
	ACTION_BAR_STRING += "<text>" + text + "\n";
}

function add_gray_button(label, command){
	ACTION_BAR_STRING += "<button>\n"+
	"label=<html><font color='black'><b> " + label + "\n"+
	"bgcolor=lightgray\n"+
	"arg=" + command + "\n";
}

function add_macro_button_with_hotKey(key, label, alt_space){
	// auto adds hot keys <3
	if (alt_space == "none") {
		label += " (" + key + ")"; 
		add_gray_button( label, "run('[" + key + "]');" );
	}
	else label += " (" + alt_space + "+" + key + ")"; 
	if (alt_space == "space") add_gray_button( label,	"setKeyDown('space');	run('[" + key + "]'); setKeyDown('none');" );
	if (alt_space == "alt")   add_gray_button( label,	"setKeyDown('alt');		run('[" + key + "]'); setKeyDown('none');" );
}

function add_macro_button_without_hotKey(key, label, alt_space){
	add_gray_button( label, "run('[" + key + "]');" );
	if (alt_space == "space") add_gray_button( label,	"setKeyDown('space');	run('[" + key + "]'); setKeyDown('none');" );
	if (alt_space == "alt")   add_gray_button( label,	"setKeyDown('alt');		run('[" + key + "]'); setKeyDown('none');" );
}

function add_Bioformats_DnD(){
	// drag and drop beahavior
	ACTION_BAR_STRING +=	"<DnDAction>"+"\n"+
	"path = getArgument();"+"\n"+
	"if (endsWith(path, '.mp4')) run('Movie (FFMPEG)...', 'choose='+ path +' first_frame=0 last_frame=-1');\n"+
	"else if (endsWith(path, '.pdf')) run('PDF ...', 'choose=' + path + ' scale=600 page=0');\n"+
	"else run('Bio-Formats Importer', 'open=[' + path + ']');\n"+
	"rename(File.nameWithoutExtension);\n"+
	"</DnDAction>\n";
}
