//Kevin Terretaz
//StartupMacros perso

// macro "test Tool - C000 T0508T  T5508e  Ta508s Tg508t"{
// }

var saved_Loc_X = 0;
var saved_Loc_Y = screenHeight() - 470;

// for quick Set LUTs
var chosen_LUTs = newArray("kb","km","ko","kg","Grays","Cyan","Magenta","Yellow");

// For split_View
var	color_Mode = "Colored";
var	montage_Style = "Linear";
var	labels = 0;
var border_Size = 0;
var channels = 1;
var font_Size = 30;
var channel_Labels = newArray("CidB","CidA","DNA","H4Ac","DIC");
var tiles = newArray(1);

// For MultiTool
var main_Tool = "Move Windows";
var tool_List = newArray("Move Windows", "slice / frame scroll", "My Magic Wand", "Curtain Tool", "Fly mode", "Scale Bar Tool");
var middle_Click = 0;
var live_AutoContrast = 0;
var enhance_Rate = 0.03;

//For wand tool
var tolerance = 0;
var wand_Box_Size = 5;
var add_To_Manager = 0;
var tolerance_Threshold = 40;
var exponent = 2;
var fit = "None";

// title of the assigned source image : space + [7] key 
var source = ""; 

// for Scale Bar Tool
var add_text = true; 

// for [f4]
var do_Scroll_Loop = false;

macro "Multitool Tool - N55C000DdeCf00Db8Db9DbaDc7Dc8DcaDcbDd7DdbDe7De8DeaDebCfffDc9Dd8Dd9DdaDe9C777D02D11D12D17D18D21D28D2bD31D36D39D3aD3bD3eD41D42D46D47D4cD4dD4eD51D52D57D5bD5dD62D63D67D6dD72D73D74D75D76D77D83D85D86D94Cf90Da6Da7Da8Da9DaaDabDacDadDaeDb4Db5Dc4Dd4De4C444D03D19D22D29D2cD32D3cD43D4bD53D58D5eD64D68D6eD78D87Cf60D95D96D97D98D99D9aD9bD9cD9dD9eDa4Da5Db3Db6DbcDbdDbeDc3Dc5Dc6DccDcdDceDd3Dd5Dd6DdcDe3De5De6DecDedDeeC333Cf40Db7DbbDddBf0C000Cf00D08D09D0aCfffC777D13D22D23D24D32D33D35D36D37D38D39D3aD3bD42D43D46D47D48D49D4cD4dD52D53D54D58D59D5aD5dD5eD62D63D6aD6bD6cD6dD72D7cD7dD7eD82D8eD92Da2Cf90D05C444Cf60D03D04D06D0cD0dD0eD14D15D16D17D18D19D1aD1bD1cD1dD1eD25D26D27D28D29D2aD2bD2cD2dD2eC333D34D3cD3dD44D4eD64D73D83D93Da3Cf40D07D0bB0fC000D12Cf00CfffC777D50D60D61D62D70D72D73D74D80D81D82D83D84D85D86D91D92D93D94D95D96D97Da3Da4Da5Da6Da7Da8Cf90C444Cf60D00D04D05D06D09D10D18D20D21D23D24D25D26D27C333D01D02D03D40D51D52D63D64D75D76D87D98Da9Cf40D07D08D11D13D14D15D16D17D22Nf0C000Da2Dd2Dd5Cf00CfffC777D42D52D60D61D65D71D73D74D83D85D86Cf90Da0Da5Da6Db7Dc8C444D40D50D53D62D63D72D75D84Cf60D90D91D93D94D95D96D97Da1Da3Da4Da7Da8Db0Db4Db5Db6Db8Db9Dc5Dc6Dc7Dc9Dd7Dd8Dd9De5De6De7De9C333Db1Db2Db3Dc0Dc4Dd0Dd4De0De4Cf40D92Dc1Dc2Dc3Dd1Dd3Dd6De1De2De3De8" {
	multi_Tool();
}
macro "Multitool Tool Options" {
	Dialog.createNonBlocking("Options");
	Dialog.addRadioButtonGroup("Main Tool : ", tool_List, tool_List.length / 2, 2, main_Tool);
	Dialog.addCheckbox("middle click macro from clipboard", middle_Click);
	Dialog.addCheckbox("live auto contrast?", live_AutoContrast);
	Dialog.addSlider("%", 0, 0.5, enhance_Rate);
	Dialog.addMessage("Magic Wand options : _______________");
	Dialog.addNumber("Maxima window size", wand_Box_Size);
	Dialog.addSlider("tolerance estimation threshold", 0, 100, tolerance_Threshold);
	Dialog.addSlider("exponent for adjustment value", 1, 2, exponent);
	Dialog.addCheckbox("auto add ROI to manager?", add_To_Manager);
	Dialog.addChoice("Fit selection? How?", newArray("None","Fit Spline","Fit Ellipse"), fit);
	Dialog.addCheckbox("text under scale bar?", add_text);
	Dialog.show();
	main_Tool =				Dialog.getRadioButton();
	middle_Click =			Dialog.getCheckbox();
	live_AutoContrast = 	Dialog.getCheckbox();
	enhance_Rate =			Dialog.getNumber();
	wand_Box_Size =				Dialog.getNumber();
	tolerance_Threshold =	Dialog.getNumber();
	exponent =				Dialog.getNumber();
	add_To_Manager =		Dialog.getCheckbox();
	fit =					Dialog.getChoice();
	add_text = 				Dialog.getCheckbox();
}
//--------------------------------------------------------------------------------------------------------------------------------------
//------SHORTCUTS
//--------------------------------------------------------------------------------------------------------------------------------------
var ShortcutsMenu = newMenu("Custom Menu Tool",
	newArray("Fetch or pull StartupMacros", "BioFormats_Bar", "Numerical Keys Bar", "Note in infos", "correct copied path",
		 "-", "Rotate 90 Degrees Right","Rotate 90 Degrees Left", "Stack Difference", "make my LUTs",
		 "-", "Median...", "Gaussian Blur...","Gaussian Blur 3D...","Gamma...","Voronoi Threshold Labler (2D/3D)",
		 "-","test all Z project", "test CLAHE options", "test all calculator modes", "test main filters",
		 "-","Batch convert ims to tif","Combine tool", "Merge tool", "Scale Bar Tool",
		 "-","Neuron (5 channels)", "Confocal Series", "Test image", "3 channels", "Brain stack", "Microtubules",
		 "-","CB_Bar","LUT_Bar", "Jeromes RGB Wheel","RGB time Is Over"));
macro "Custom Menu Tool - N55C000D1aD1bD1cD1dD29D2dD39D3dD49D4dD4eD59D5eD69D75D76D77D78D79D85D88D89D94D98D99Da4Da7Da8Da9Db3Db7Db8Dc3Dc6Dc7DccDcdDd3Dd6Dd8DdbDdcDe2De3De6De8De9DeaDebDecCfffD0dD3cD5cD6dD7bD8bD8cD96D9aD9bDa5DacDadDb5DcaDd4Dd9DdaDe4CdddD0aD1eD2bD6aD74D7aD95Dc4Dc5DeeC333D67D68DbeDd2DddCeeeD00D01D02D03D04D05D06D07D08D09D0eD10D11D12D13D14D15D16D17D18D20D21D22D23D24D25D26D27D30D31D32D33D34D35D36D37D3aD3bD40D41D42D43D44D45D46D47D4bD50D51D52D53D54D55D56D57D60D61D62D63D64D65D6eD70D71D72D73D80D81D82D83D86D8aD8dD90D91D92D97Da0Da1Da2Da6DaaDb0Db1DbbDc0Dc1Dc9Dd0Dd1De0De1C111D38D5bD6bD7dDabDbaDd7C999D4cD58D5aD5dD93DceDd5C777D0bD2eD4aD6cD7cD7eD9cD9dD9eDbdDc8C222D8eDa3DbcCcccD2cDdeDe7C666D19Db4DcbCbbbD0cD87DaeDb2C888D66De5C555D28D2aD84Dc2CaaaDb9DedC444D3eD48Db6Bf0C000D03D06D0cD13D16D1bD23D26D2aD33D37D39D43D44D47D48D54D65D76D77D87D88D89D8aD8bD8cD8dD8eD9bCfffD04D08D0dD0eD14D18D19D24D28D2cD35D3bD3cD3dD3eD45D46D4aD4bD4cD4eD56D57D5aD5bD5cD5dD5eD68D69D6aD6bD6cD6dD7cD7dCdddD1cD25D63D7eD97C333D99CeeeD00D01D07D10D11D1dD20D21D2eD30D31D40D41D42D4dD50D51D52D59D60D61D62D67D6eD70D71D72D73D74D79D7aD7bD80D81D82D83D84D85D90D91D92D93D94D95D96Da0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDacDadDaeC111D02D0bD36C999D1aD2bD58D9eC777D27D3aC222D64D66D9aCcccD09D17C666D12D38D78CbbbD0aD15D1eD2dD32D34C888D98C555D49D55D86D9cD9dCaaaD05D29D53C444D22D75B0fC000D02D03D04D05D08D09D18D27D28D36D37D45D46D54D55D63D64D71D72D80D81CfffD06D07D16D25D30D34D35D40D43D44D52D57D60D61D66D75D83D85CdddD10D22D32D33D42D74C333CeeeD0aD1aD21D29D2aD31D38D39D3aD48D49D4aD50D51D53D58D59D5aD67D68D69D6aD76D77D78D79D7aD84D86D87D88D89D8aD91D92D93D94D95D96D97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaC111C999D62D65C777D00C222D01D13D14D73CcccD11D26D90C666CbbbD12D15D19D20D23D24D41D82C888D47D56D70C555D17CaaaC444Nf0C000D33D34D35D36D42D43D46D50D51D55D64D65D66D67D73D74D78D88D96D97Da4Da5Db4Dc4Dd4Dd6Dd7Dd8De3De4De6De8De9CfffD15D31D44D53D54D58D62D84D85D86D92D93Da2Db2Dc2Dd2De7CdddD63Da1Da7Dc1Dd0De2C333D25D47D56D77Da0CeeeD00D01D02D03D04D05D06D07D08D09D0aD10D11D12D13D14D16D17D18D19D1aD20D21D22D27D28D29D2aD30D38D39D3aD48D49D4aD59D5aD69D6aD71D7aD82D8aD99D9aDa8Da9DaaDb1Db6Db7Db8Db9DbaDc9DcaDd1DdaDe0DeaC111C999D37D76D90Da6Db5Dc6Dc8Dd3C777D41D81D91D98Dc7De5C222D75D95Db3CcccD61D72D79D83D89Dc5Dd5Dd9De1C666D40D52D57CbbbD70D80D94C888D23D32D45Dc3C555D60D87Da3Db0CaaaD26Dc0C444D24D68" {
	cmd = getArgument(); 
	if 		(cmd=="Note in infos") 					note_In_Infos();
	else if (cmd=="Fetch or pull StartupMacros") 	fetch_Or_Pull_StartupMacros();
	else if (cmd=="correct copied path")			correct_Copied_Path();
	else if (cmd=="test CLAHE options") 			test_CLAHE_Options();
	else if (cmd=="test all Z project") 			test_All_Zprojections();
	else if (cmd=="Batch convert ims to tif") 		batch_ims_To_tif();
	else if (cmd=="Combine tool") 					install_Tool_From_URL("https://git.io/JXvva");
	else if (cmd=="Merge tool") 					install_Tool_From_URL("https://git.io/JXoBT");
	else if (cmd=="CB_Bar") 						run("Action Bar", File.openUrlAsString("https://git.io/JZUZw"));
	else if (cmd=="LUT_Bar") 						run("Action Bar", File.openUrlAsString("https://raw.githubusercontent.com/kwolbachia/Imagej-macro-addiction/main/LUT_Bar.ijm"));
	else if (cmd=="BioFormats_Bar") 				Bioformats_Bar();
	else if (cmd=="Numerical Keys Bar")				numerical_Keyboard_Bar();
	else if (cmd=="Microtubules")				    open("https://i.imgur.com/LDO1rVL.png");
	else if (cmd=="Test image")				   		open("https://i.imgur.com/psSX0UR.png");
	else if (cmd=="3 channels")				        {setBatchMode(1); open("https://i.imgur.com/MZGVdVj.png"); run("Make Composite"); set_LUTs(); run("Remove Slice Labels"); setBatchMode(0);}
	else if (cmd=="test all calculator modes")		test_All_Calculator_Modes();
	else if (cmd=="Brain stack") 					{setBatchMode(1); open("https://i.imgur.com/DYIF55D.jpg"); run("Montage to Stack...", "columns=20 rows=18 border=0"); rename("brain"); setBatchMode(0);}
	else if (cmd=="test main filters")				test_main_Filters();
	else if (cmd=="Scale Bar Tool")					install_Tool_From_URL("https://raw.githubusercontent.com/kwolbachia/Imagej-macro-addiction/main/scale_Bar_Tool.ijm");
	else if (cmd=="RGB time Is Over")				RGB_time_Is_Over();
	else if (cmd=="Jeromes RGB Wheel")				Jeromes_Wheel();
	else if (cmd=="make my LUTs")					make_My_LUTs();
	else run(cmd);
	call("ij.gui.Toolbar.setIcon", "Custom Menu Tool", "N55C000D1aD1bD1cD29D2dD39D3dD49D4dD4eD59D5eD69D79D99Da7Da8Da9Db3Db7Db8Dc7DccDcdDd8DdbDdcDe2De3De9DeaDebCcccD2cCa00D08D09D18D27D28D37D57D66D67D76D87D96D97Da5Db5Dc5Dd5De7CfffD3cD5cD6dD7bD8bD8cD9aD9bDacDadDcaDd9DdaC111D5bD6bD7dDabDbaCeeeD00D01D02D03D04D05D06D10D11D12D13D14D15D16D20D21D22D23D24D25D30D31D32D33D34D35D3aD3bD40D41D42D43D44D45D4bD50D51D52D53D54D55D60D61D62D63D64D6eD70D71D72D73D74D80D81D82D83D84D8aD8dD90D91D92Da0Da1Da2DaaDb0Db1DbbDc0Dc1Dc9Dd0Dd1De0De1Cb11DdeDedDeeCdddD2bD6aD7aCb00D07D0aD0bD0cD0dD0eD17D19D1dD1eD26D2eD36D38D3eD46D47D48D56D58D65D68D75D77D78D85D86D88D89D94D95D98Da4Da6Db4Db6Dc3Dc4Dc6DceDd3Dd4Dd6Dd7DddDe4De5De6De8DecC777D4aD6cD7cD7eD9cD9dD9eDbdDc8CaaaDb9Cb00C444C999D4cD5aD5dD93CbbbDaeDb2C333DbeDd2C888C666DcbC222D8eDa3DbcC555D2aDc2Bf0C000D03D13D16D23D26D33D37D43D44D47D48D54D65D76D77D87D88D89D8aD8bD8cD8dD8eD9bCcccCa00D07D0bD17CfffD14D24D35D3bD3cD3dD3eD45D46D4aD4bD4cD4eD56D57D5aD5bD5cD5dD5eD68D69D6aD6bD6cD6dD7cD7dC111D02D36CeeeD00D01D10D11D20D21D2eD30D31D40D41D42D4dD50D51D52D59D60D61D62D67D6eD70D71D72D73D74D79D7aD7bD80D81D82D83D84D85D90D91D92D93D94D95D96Da0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDacDadDaeCb11D0dD19D1dD29CdddD25D63D7eD97Cb00D04D05D06D08D09D0aD0cD0eD15D18D1aD1bD1cD1eD27D28D2aD2cD39C777D3aCaaaD53Cb00C444D22D75C999D2bD58D9eCbbbD2dD32D34C333D99C888D98C666D12D38D78C222D64D66D9aC555D49D55D86D9cD9dB0fC000D02D03D04D05D08D09D18D27D28D36D37D45D46D54D55D63D64D71D72D80D81CcccD11D26D90Ca00CfffD06D07D16D25D30D34D35D40D43D44D52D57D60D61D66D75D83D85C111CeeeD0aD1aD21D29D2aD31D38D39D3aD48D49D4aD50D51D53D58D59D5aD67D68D69D6aD76D77D78D79D7aD84D86D87D88D89D8aD91D92D93D94D95D96D97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaCb11CdddD10D22D32D33D42D74Cb00C777D00CaaaCb00C444C999D62D65CbbbD12D15D19D20D23D24D41D82C333C888D47D56D70C666C222D01D13D14D73C555D17Nf0C000D33D34D35D36D46D50D55D66D67D78D88D96D97Da5Db4Dc4Dd4Dd6Dd7Dd8De3De4De6De8De9CcccD79D89Dc5Dd5Dd9Ca00D20D30D41D65D74D84Da4Db1CfffD15D58D85D86De7C111CeeeD00D02D03D04D05D06D07D08D09D0aD12D13D14D16D17D18D19D1aD27D28D29D2aD38D39D3aD48D49D4aD59D5aD69D6aD7aD8aD99D9aDa8Da9DaaDb6Db7Db8Db9DbaDc9DcaDdaDeaCb11D42D52D54D63D64D73D83D93D94Da1Da3Db3Dc1Dc2Dc3Dd0Dd1De0De1CdddDa7De2Cb00D01D10D11D21D22D31D40D43D44D51D53D61D62D71D72D82D91D92Da2Db0Db2Dc0Dd2C777D81D98Dc7De5CaaaD26Cb00D32C444D24D68C999D37D76D90Da6Db5Dc6Dc8Dd3CbbbD70D80C333D25D47D56D77Da0C888D23D45C666D57C222D75D95C555D60D87");
 	wait(3000);
 	call("ij.gui.Toolbar.setIcon", "Custom Menu Tool", "N55C000D1aD1bD1cD1dD29D2dD39D3dD49D4dD4eD59D5eD69D75D76D77D78D79D85D88D89D94D98D99Da4Da7Da8Da9Db3Db7Db8Dc3Dc6Dc7DccDcdDd3Dd6Dd8DdbDdcDe2De3De6De8De9DeaDebDecCfffD0dD3cD5cD6dD7bD8bD8cD96D9aD9bDa5DacDadDb5DcaDd4Dd9DdaDe4CdddD0aD1eD2bD6aD74D7aD95Dc4Dc5DeeC333D67D68DbeDd2DddCeeeD00D01D02D03D04D05D06D07D08D09D0eD10D11D12D13D14D15D16D17D18D20D21D22D23D24D25D26D27D30D31D32D33D34D35D36D37D3aD3bD40D41D42D43D44D45D46D47D4bD50D51D52D53D54D55D56D57D60D61D62D63D64D65D6eD70D71D72D73D80D81D82D83D86D8aD8dD90D91D92D97Da0Da1Da2Da6DaaDb0Db1DbbDc0Dc1Dc9Dd0Dd1De0De1C111D38D5bD6bD7dDabDbaDd7C999D4cD58D5aD5dD93DceDd5C777D0bD2eD4aD6cD7cD7eD9cD9dD9eDbdDc8C222D8eDa3DbcCcccD2cDdeDe7C666D19Db4DcbCbbbD0cD87DaeDb2C888D66De5C555D28D2aD84Dc2CaaaDb9DedC444D3eD48Db6Bf0C000D03D06D0cD13D16D1bD23D26D2aD33D37D39D43D44D47D48D54D65D76D77D87D88D89D8aD8bD8cD8dD8eD9bCfffD04D08D0dD0eD14D18D19D24D28D2cD35D3bD3cD3dD3eD45D46D4aD4bD4cD4eD56D57D5aD5bD5cD5dD5eD68D69D6aD6bD6cD6dD7cD7dCdddD1cD25D63D7eD97C333D99CeeeD00D01D07D10D11D1dD20D21D2eD30D31D40D41D42D4dD50D51D52D59D60D61D62D67D6eD70D71D72D73D74D79D7aD7bD80D81D82D83D84D85D90D91D92D93D94D95D96Da0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDacDadDaeC111D02D0bD36C999D1aD2bD58D9eC777D27D3aC222D64D66D9aCcccD09D17C666D12D38D78CbbbD0aD15D1eD2dD32D34C888D98C555D49D55D86D9cD9dCaaaD05D29D53C444D22D75B0fC000D02D03D04D05D08D09D18D27D28D36D37D45D46D54D55D63D64D71D72D80D81CfffD06D07D16D25D30D34D35D40D43D44D52D57D60D61D66D75D83D85CdddD10D22D32D33D42D74C333CeeeD0aD1aD21D29D2aD31D38D39D3aD48D49D4aD50D51D53D58D59D5aD67D68D69D6aD76D77D78D79D7aD84D86D87D88D89D8aD91D92D93D94D95D96D97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaC111C999D62D65C777D00C222D01D13D14D73CcccD11D26D90C666CbbbD12D15D19D20D23D24D41D82C888D47D56D70C555D17CaaaC444Nf0C000D33D34D35D36D42D43D46D50D51D55D64D65D66D67D73D74D78D88D96D97Da4Da5Db4Dc4Dd4Dd6Dd7Dd8De3De4De6De8De9CfffD15D31D44D53D54D58D62D84D85D86D92D93Da2Db2Dc2Dd2De7CdddD63Da1Da7Dc1Dd0De2C333D25D47D56D77Da0CeeeD00D01D02D03D04D05D06D07D08D09D0aD10D11D12D13D14D16D17D18D19D1aD20D21D22D27D28D29D2aD30D38D39D3aD48D49D4aD59D5aD69D6aD71D7aD82D8aD99D9aDa8Da9DaaDb1Db6Db7Db8Db9DbaDc9DcaDd1DdaDe0DeaC111C999D37D76D90Da6Db5Dc6Dc8Dd3C777D41D81D91D98Dc7De5C222D75D95Db3CcccD61D72D79D83D89Dc5Dd5Dd9De1C666D40D52D57CbbbD70D80D94C888D23D32D45Dc3C555D60D87Da3Db0CaaaD26Dc0C444D24D68");
}

macro "Stacks Menu Built-in Tool" {}
// macro "Developer Menu Built-in Tool" {}

//--------------------------------------------------------------------------------------------------------------------------------------
//------POPUP
//--------------------------------------------------------------------------------------------------------------------------------------
var pmCmds = newMenu("Popup Menu",
	newArray("Remove Overlay", "Duplicate...","Set LUTs","Set active path", "rajout de bout", "Copy to System",
	 "-", "CLAHE", "gaussian correction", "color blindness", "rotate LUT",
	 "-", "Record...", "Monitor Memory...","Control Panel...", "Startup Macros..."));
macro "Popup Menu" {
	cmd = getArgument(); 
	if 		(cmd=="CLAHE") 					CLAHE();
	else if (cmd=="Set active path") 		Set_Active_Path();
	else if (cmd=="rajout de bout") 		rajout_De_Bout();
	else if (cmd=="gaussian correction") 	gauss_Correction();
	else if (cmd=="color blindness") 		{rgb_Snapshot(); run("Dichromacy", "simulate=Deuteranope");}
	else if (cmd=="Set LUTs") 				{get_LUTs_Dialog(); set_LUTs();}
	else if (cmd=="rotate LUT") 			rotate_LUT();
	else run(cmd); 
}

macro "LUT Menu Built-in Tool" {}

macro "Preview Opener Action Tool - N66C000D34D35D36D37D38D39D3aD3bD3cD3dD3eD44D49D4eD54D59D5eD64D69D6eD74D79D7eD84D85D86D87D88D89D8aD8bD8cD8dD8eD94D99D9eDa4Da9DaeDb4Db9DbeDc4Dc9DceDd4Dd5Dd6Dd7Dd8Dd9DdaDdbDdcDddDdeDe4De9DeeC95fD4aD4bD4cD4dD5aD5bD5cD5dD6aD6bD6cD6dD7aD7bD7cD7dC09bC5ffCf05Cf85C8bfDeaDebDecDedCfc0D9aD9bD9cD9dDaaDabDacDadDbaDbbDbcDbdDcaDcbDccDcdCf5bCaf8Cfb8Ccf8D95D96D97D98Da5Da6Da7Da8Db5Db6Db7Db8Dc5Dc6Dc7Dc8Cf5dDe5De6De7De8C8fdCfa8D45D46D47D48D55D56D57D58D65D66D67D68D75D76D77D78Bf0C000D04D09D0eD14D19D1eD24D29D2eD34D35D36D37D38D39D3aD3bD3cD3dD3eD44D49D4eD54D59D5eD64D69D6eD74D79D7eD84D85D86D87D88D89D8aD8bD8cD8dD8eC95fC09bC5ffCf05Cf85D45D46D47D48D55D56D57D58D65D66D67D68D75D76D77D78C8bfD0aD0bD0cD0dD1aD1bD1cD1dD2aD2bD2cD2dCfc0Cf5bCaf8Cfb8Ccf8Cf5dD05D06D07D08D15D16D17D18D25D26D27D28C8fdD4aD4bD4cD4dD5aD5bD5cD5dD6aD6bD6cD6dD7aD7bD7cD7dCfa8B0fC000D03D07D13D17D23D27D30D31D32D33D34D35D36D37D43D47D53D57D63D67D73D77D80D81D82D83D84D85D86D87C95fC09bC5ffCf05Cf85C8bfCfc0D44D45D46D54D55D56D64D65D66D74D75D76Cf5bD04D05D06D14D15D16D24D25D26Caf8Cfb8D40D41D42D50D51D52D60D61D62D70D71D72Ccf8Cf5dC8fdD00D01D02D10D11D12D20D21D22Cfa8Nf0C000D30D31D32D33D34D35D36D37D43D47D53D57D63D67D73D77D80D81D82D83D84D85D86D87D93D97Da3Da7Db3Db7Dc3Dc7Dd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7De3De7C95fC09bD94D95D96Da4Da5Da6Db4Db5Db6Dc4Dc5Dc6C5ffD40D41D42D50D51D52D60D61D62D70D71D72Cf05D90D91D92Da0Da1Da2Db0Db1Db2Dc0Dc1Dc2Cf85C8bfCfc0Cf5bDe4De5De6Caf8D44D45D46D54D55D56D64D65D66D74D75D76Cfb8Ccf8Cf5dC8fdDe0De1De2Cfa8"{
	if (!isOpen("Preview Opener.tif")) make_Preview_Opener();
}

macro "set LUT from montage Tool - N55C000D37D38D39CfffD00D01D02D03D04D05D06D07D08D09D0aD0bD0cD0dD0eD10D11D12D13D14D15D16D17D18D19D1aD1bD1cD1dD1eD20D21D22D23D24D25D26D27D28D29D2aD2bD2cD2dD2eD30D31D32D36D3aD3eD40D41D42D46D4aD4eD50D51D52D56D5aD5eD60D61D62D66D6aD6eD70D71D72D76D7aD7eD80D81D82D86D8aD8eD90D91D92D96D9aD9eDa0Da1Da2Da6DaaDaeDb0Db1Db2Db6DbaDbeDc0Dc1Dc2Dc6DcaDceDd0Dd1Dd2Dd6DdaDdeDe0De1De2De6DeaDeeC338C047Db7Db8Db9C557D73D74D75D83D84D85C500D5bD5cD5dC198Ce50Cb87C024D77D78D79C278Cd51DdbDdcDddC438Cb00D9bD9cD9dC18cCfb3Cda7C100D3bD3cD3dC158Dd7Dd8Dd9C157Dc7Dc8Dc9C877Db3Db4Db5Dc3Dc4Dc5C900C3b7Ce82Cc97C013D33D34D35C17aCaf3C448Cd30DbbDbcDbdC1dcCfb4Cfd8C012D57D58D59C358C347D53D54D55C667D93D94D95C800D7bD7cD7dC2a8Ce71DebDecDedC49fC035D97D98D99C288Ccd1Ca87De3De4De5Cb10C19dCee1Cfb7C300D4bD4cD4dC368C8d4C977Dd3Dd4Dd5C427C1eaCfa3Cd97C406C18bCce3C47fCd40DcbDccDcdC1afCfc6CfebC011D47D48D49C457D63D64D65C247D43D44D45C600D6bD6cD6dC298Cf61C4f7C034D87D88D89C169De7De8De9C9d3Cc00DabDacDadC19dCed3Cea7C022D67D68D69C268C6c5Ca00D8bD8cD8dC4b7Cf92C045Da7Da8Da9C8f5C46dC2ceCfb5C667Da3Da4Da5Bf0C000CfffD00D01D02D06D0aD0eD10D11D12D16D1aD1eD20D21D22D26D2aD2eD30D31D32D36D3aD3eD40D41D42D46D4aD4eD50D51D52D56D5aD5eD60D61D62D66D6aD6eD70D71D72D76D7aD7eD80D81D82D83D84D85D86D87D88D89D8aD8bD8cD8dD8eD90D91D92D93D94D95D96D97D98D99D9aD9bD9cD9dD9eDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDacDadDaeC338C047C557C500C198Ce50Cb87D13D14D15C024C278Cd51C438Cb00C18cD37D38D39Cfb3Cda7D43D44D45C100C158C157C877C900C3b7Ce82D0bD0cD0dCc97D23D24D25C013C17aD07D08D09D17D18D19Caf3C448Cd30C1dcCfb4D2bD2cD2dCfd8D5bD5cD5dC012C358C347C667C800C2a8Ce71C49fC035C288Ccd1Ca87D03D04D05Cb10C19dD57D58D59Cee1Cfb7D63D64D65D73D74D75C300C368C8d4C977C427C1eaCfa3Cd97D33D34D35C406C18bD27D28D29Cce3C47fCd40C1afD67D68D69D77D78D79Cfc6D4bD4cD4dCfebD6bD6cD6dD7bD7cD7dC011C457C247C600C298Cf61C4f7C034C169C9d3Cc00C19dD47D48D49Ced3Cea7D53D54D55C022C268C6c5Ca00C4b7Cf92D1bD1cD1dC045C8f5C46dC2ceCfb5D3bD3cD3dC667B0fC000CfffD03D07D08D09D0aD13D17D18D19D1aD23D27D28D29D2aD33D37D38D39D3aD43D47D48D49D4aD53D57D58D59D5aD63D67D68D69D6aD73D77D78D79D7aD80D81D82D83D84D85D86D87D88D89D8aD90D91D92D93D94D95D96D97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaC338C047C557C500C198Ce50D30D31D32Cb87C024C278Cd51C438Cb00C18cCfb3D00D01D02Cda7C100C158C157C877C900D60D61D62D70D71D72C3b7D04D05D06Ce82Cc97C013C17aCaf3C448Cd30D40D41D42C1dcCfb4Cfd8C012C358C347C667C800C2a8Ce71C49fC035C288Ccd1D54D55D56Ca87Cb10D50D51D52C19dCee1D64D65D66D74D75D76Cfb7C300C368C8d4D34D35D36C977C427C1eaCfa3D10D11D12Cd97C406C18bCce3C47fCd40C1afCfc6CfebC011C457C247C600C298Cf61D20D21D22C4f7C034C169C9d3D44D45D46Cc00C19dCed3Cea7C022C268C6c5D24D25D26Ca00C4b7D14D15D16Cf92C045C8f5C46dC2ceCfb5C667Nf0C000CfffD00D01D02D03D04D05D06D07D08D09D0aD10D11D12D13D14D15D16D17D18D19D1aD20D21D22D23D24D25D26D27D28D29D2aD33D37D38D39D3aD43D47D48D49D4aD53D57D58D59D5aD63D67D68D69D6aD73D77D78D79D7aD83D87D88D89D8aD93D97D98D99D9aDa3Da7Da8Da9DaaDb3Db7Db8Db9DbaDc3Dc7Dc8Dc9DcaDd3Dd7Dd8Dd9DdaDe3De7De8De9DeaC338D30D31D32C047C557C500C198Dd4Dd5Dd6Ce50Cb87C024C278Da4Da5Da6Cd51C438D54D55D56Cb00C18cCfb3Cda7C100C158C157C877C900C3b7Ce82Cc97C013C17aCaf3Dc0Dc1Dc2C448D64D65D66Cd30C1dcD80D81D82Cfb4Cfd8C012C358D74D75D76C347C667C800C2a8De4De5De6Ce71C49fD60D61D62C035C288Db4Db5Db6Ccd1Ca87Cb10C19dCee1Cfb7C300C368D84D85D86C8d4C977C427D44D45D46C1eaD90D91D92Cfa3Cd97C406D34D35D36C18bCce3Dd0Dd1Dd2C47fD50D51D52Cd40C1afCfc6CfebC011C457C247C600C298Dc4Dc5Dc6Cf61C4f7Da0Da1Da2C034C169C9d3Cc00C19dCed3De0De1De2Cea7C022C268D94D95D96C6c5Ca00C4b7Cf92C045C8f5Db0Db1Db2C46dD40D41D42C2ceD70D71D72Cfb5C667" 	{
	set_LUT_From_Montage();
}
macro "set LUT from montage Tool Options" {	display_LUTs();}

//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------

//CHANNELS
macro "[n0]"{ if (isKeyDown("space")) set_Favorite_LUT();	else if (isKeyDown("alt")) convert_To_iMQ_Style();	else paste_Favorite_LUT();}
macro "[n1]"{ if (isKeyDown("space")) toggle_Channel(1); 	else if (isKeyDown("alt")) toggle_All_Channels(1); 	else run("Grays");}
macro "[n2]"{ if (isKeyDown("space")) toggle_Channel(2); 	else if (isKeyDown("alt")) toggle_All_Channels(2); 	else run("kg");	}
macro "[n3]"{ if (isKeyDown("space")) toggle_Channel(3); 	else if (isKeyDown("alt")) toggle_All_Channels(3); 	else run("Red");	}
macro "[n4]"{ if (isKeyDown("space")) toggle_Channel(4); 	else if (isKeyDown("alt")) toggle_All_Channels(4); 	else run("kb");	}
macro "[n5]"{ if (isKeyDown("space")) toggle_Channel(5); 	else if (isKeyDown("alt")) toggle_All_Channels(5); 	else run("km");	}
macro "[n6]"{ if (isKeyDown("space")) toggle_Channel(6); 	else if (isKeyDown("alt")) toggle_All_Channels(6); 	else run("ko");	}
macro "[n7]"{ if (isKeyDown("space")) toggle_Channel(7);	else if (isKeyDown("alt")) toggle_All_Channels(7); 	else run("Cyan");	}
macro "[n8]"{ if (isKeyDown("space")) run("8-bit"); 		else if (isKeyDown("alt")) run("16-bit");		 	else run("Magenta");	}
macro "[n9]"{ if (isKeyDown("space")) run("glasbey_on_dark");													else run("Yellow");}

macro "[n*]"{ difference_Of_Gaussian_Clij();}

//--------------------------------------------------------------------------------------------------------------------------------------
//NOICE TOOLS
macro "[0]"	{
	if		(no_Alt_no_Space())		run("Open in ClearVolume");
	else if (isKeyDown("space"))	open_in_3D_Viewer();
	// else if (isKeyDown("alt"))		
}
macro "[1]"	{
	if		(no_Alt_no_Space())		set_LUTs();
	else if (isKeyDown("space"))	set_All_LUTs(); 	
	else if (isKeyDown("alt"))		set_My_LUTs();
}
macro "[2]"	{
	if		(no_Alt_no_Space())		maximize_Image();
	else if (isKeyDown("space"))	restore_Image_Position();
	else if (isKeyDown("alt"))		full_Screen();
}
macro "[3]"	{
	if		(no_Alt_no_Space())		my_3D_projection();
	else if (isKeyDown("space"))	cool_3D_montage();
	// else if (isKeyDown("alt"))		
}
macro "[4]"	{
	if		(no_Alt_no_Space())		{ run("Make Montage...", "scale=1"); setOption("Changes", 0); }
	else if (isKeyDown("space"))	run("Montage to Stack...");
	// else if (isKeyDown("alt"))		
}
macro "[5]"	{
	if		(no_Alt_no_Space())		make_Scaled_Rectangle(25);
	else if (isKeyDown("space"))	duplicate_Box();
	// else if (isKeyDown("alt"))		
}
macro "[6]"	{	force_black_canvas();}

macro "[7]" 	{
	if		(no_Alt_no_Space())		set_my_Target_Image();
	else if (isKeyDown("space"))	set_my_Source_Image();
	else if (isKeyDown("alt"))		set_my_Custom_Location();
}
macro "[8]"	{
	if		(no_Alt_no_Space())		run("Rename...");
	else if (isKeyDown("space"))	rename(getImageID());
	// else if (isKeyDown("alt"))		
}
macro "[9]"	{
	if		(no_Alt_no_Space())		{ if(File.exists(getDirectory("temp")+"temp.tif")) open(getDirectory("temp")+"temp.tif"); }
	else if (isKeyDown("space"))	saveAs("tif", getDirectory("temp")+"temp.tif");
	// else if (isKeyDown("alt"))	
}




macro "[a]"	{
	if		(no_Alt_no_Space())		run("Select All");
	else if (isKeyDown("space"))	run("Restore Selection");
	else if (isKeyDown("alt"))		run("Select None");
}
macro "[A]"	{
	if		(no_Alt_no_Space())		run("Enhance Contrast", "saturated=0.03");	  	
	else if (isKeyDown("space"))	enhance_All_Channels();
	else if (isKeyDown("alt"))		enhance_All_Images_Contrasts();
}
macro "[b]"	{
	if		(no_Alt_no_Space())		split_View(1,2,0); //vertical colored
	else if (isKeyDown("space"))	split_View(0,2,0); //vertical grayscale
	// else if (isKeyDown("alt"))		
}
macro "[B]"	{	switch_Composite_Mode();}

macro "[C]" {	run("Brightness/Contrast...");}

macro "[d]"	{
	if		(no_Alt_no_Space())		run("Split Channels");
	else if (isKeyDown("space"))	run("Duplicate...", " "); //slice
	else if (isKeyDown("alt"))		duplicate_The_Way_I_Want();
}
macro "[D]"	{
	if		(no_Alt_no_Space())		run("Duplicate...", "duplicate");
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
}

macro "[k]"  {
	if		(no_Alt_no_Space())		multi_Plot();
	else if (isKeyDown("space"))	multi_Plot(); //normalized multiplot
	else if (isKeyDown("alt"))		multi_Plot_Z_Axis(); 
}
macro "[l]"	{
	if		(no_Alt_no_Space())		run("Find Commands...");
	else if (isKeyDown("space"))	ultimate_LUT_generator();
	else if (isKeyDown("alt"))		open_LUT_Bar();	
}
macro "[L]"  {
	if		(no_Alt_no_Space())		copy_Paste_Source_LUTs();
	else if (isKeyDown("space"))	rgb_LUT_To_LUT();
	// else if (isKeyDown("alt"))		
}
macro "[M]"	{
	if		(no_Alt_no_Space())		fast_Merge();
	else if (isKeyDown("space"))	run("Merge Channels...");
	// else if (isKeyDown("alt"))		
} 
macro "[m]"	{	linear_LUTs_Baker();}

macro "[n]"	{
	if		(no_Alt_no_Space())		Hela();
	else if (isKeyDown("space"))	make_LUT_Image();
	else if (isKeyDown("alt"))		open("https://i.imgur.com/psSX0UR.png");
}
macro "[N]"	{numerical_Keyboard_Bar();}

macro "[o]"	{
	if ( nImages!=0) {
		if (startsWith(getTitle(), "Preview Opener")) open_From_Preview_Opener();
		else if (startsWith(getTitle(), "Lookup Tables")) set_LUT_From_Montage();
	}
	else open(String.paste);
}
macro "[p]"	{
	if		(no_Alt_no_Space())		split_View(0,0,0); //linear grayscale
	else if (isKeyDown("space"))	split_View(0,1,0); //squared grayscale
	// else if (isKeyDown("alt"))		
}
macro "[Q]" 	{	composite_Switch();	}

macro "[q]"	{
	if		(no_Alt_no_Space())		run("Arrange Channels...");
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
	else if (isKeyDown("space"))	my_RGB_Converter();
	else if (isKeyDown("alt"))		Red_Green_to_Orange_Blue();
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
		if (File.exists(path)) call("ij.Prefs.set","last.closed",path); 
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

macro "[Z]" {	run("Channels Tool...");}

macro "[n/]" {
	show_Shortcuts_Table();
}

function show_Shortcuts_Table(){
	Table.create("Macro shortcuts");
	Table.setLocationAndSize(0, 100, 520, 1000);
	//				line  Key   Alone								with Space						with Alt		
	set_Shortcuts_Line(0, "  0", "Open in ClearVolume", 			"Open in 3D viewer",			"");
	set_Shortcuts_Line(1, "  1", "Apply favorite LUTs",				"Apply LUTs to all",			"Set favorite LUTs");
	set_Shortcuts_Line(2, "  2", "Center image",					"Restore position", 			"Full width of screen");
	set_Shortcuts_Line(3, "  3", "3D animation",					"Cool 3D animation",			"");
	set_Shortcuts_Line(4, "  4", "Make montage",					"Montage to stack",				"");
	set_Shortcuts_Line(5, "  5", "Make selection 25x25 µm",			"Duplicate box",				"");
	set_Shortcuts_Line(6, "  6", "Force black canvas",				"",								"");
	set_Shortcuts_Line(7, "  7", "Set target image",				"Set source image",				"Set custom position");
	set_Shortcuts_Line(8, "  8", "Rename image",					"Random rename",				"");
	set_Shortcuts_Line(9, "  9", "Open temp image",					"Save image in temp",			"");

	// set_Shortcuts_Line( , "", "",						"",					"");

	set_Shortcuts_Line(10 , "  a", "Select All",					"Restore Selection",			"Select None");
	set_Shortcuts_Line(11 , "  A", "Enhance Contrast 0.03%",		"Enhance all channels",			"Enhance all images");
	set_Shortcuts_Line(12 , "  b", "Vertical colored Splitiview",	"Vertical grayscale split_View",	"");
	set_Shortcuts_Line(13 , "  B", "Switch composite modes",		"",								"");
	set_Shortcuts_Line(14 , "  c", "Copy",							"",								"");
	set_Shortcuts_Line(15 , "  C", "Brightness & Contrast",			"",								"");
	set_Shortcuts_Line(16 , "  d", "Split Channels",				"Duplicate slice",				"Duplicate full channel");
	set_Shortcuts_Line(17 , "  D", "Duplicate full image",			"Open Memory and recorder",		"");
	set_Shortcuts_Line(18 , "  e", "Plot Current LUT",				"",								"");
	set_Shortcuts_Line(19 , "  E", "Arrange windows on Tiles",		"Multichannel LUT montage",		"Edit LUT...");
	set_Shortcuts_Line(20 , "  f", "Gamma (real one)",				"Gamma 0.7 on all LUTs",		"Gaussian blur 3D 0.5");
	set_Shortcuts_Line(21 , "  F", "Rectangle/MultiTool switch",	"ClIJ Stack focuser",			"");
	set_Shortcuts_Line(22 , "  g", "Z Project...",					"MaxColorCoding on copied LUT",	"Color Coding no max (heavy)");
	set_Shortcuts_Line(23 , "  G", "Max Z Projection",				"Max on all opened images",		"Sum Z Projection");
	set_Shortcuts_Line(24 , "  H", "Show All images",				"",								"");
	set_Shortcuts_Line(25 , "  i", "Invert LUTs (Built in)",		"Snapshot and invert colors",	"Reverse LUT");
	set_Shortcuts_Line(26 , "  j", "Script Editor <3",				"Rolling Ball bkg substraction","");
	set_Shortcuts_Line(27 , "  J", "Save as JPEG max quality",		"save As LZW compressed tif",	"");
	set_Shortcuts_Line(28 , "  k", "Multi channel plot",			"Normalized Multichannel Plot",	"Multichannel Plot Z axis");
	set_Shortcuts_Line(29 , "  K", "Random LUTs",					"",								"");
	set_Shortcuts_Line(30 , "  l", "Find commands Tool <3",			"LUT generator",				"Open LUT Bar");
	set_Shortcuts_Line(31 , "  L", "Transfer LUTs from source ",	"RGB image to LUT",				"");
	set_Shortcuts_Line(32 , "  m", "LUT baker",						"",								"");
	set_Shortcuts_Line(33 , "  M", "Automatic Merge channels",		"Manual Merge channels",		"");
	set_Shortcuts_Line(34 , "  n", "Open Hela Cells",				"Create small LUT image",		"Open my test image");
	set_Shortcuts_Line(35 , "  N", "numerical Keyboard Bar",		"",								"");
	set_Shortcuts_Line(36 , "  o", "Open for macro montages",		"",								"");
	set_Shortcuts_Line(37 , "  p", "Linear grayscale splitview",	"Squared grayscale Splitview",	"");
	set_Shortcuts_Line(38 , "  P", "Properties...",					"",								"");
	set_Shortcuts_Line(39 , "  q", "Arrange channels order",		"Arrange LUTs order",			"Animation start/stop");
	set_Shortcuts_Line(40 , "  Q", "Composite/channel switch",		"",								"");
	set_Shortcuts_Line(41 , "  r", "Reset contrast channel",		"Refresh startupMacros",		"Reduce all max");
	set_Shortcuts_Line(42 , "  R", "Reset contrast all channels",	"Reset contrast all images",	"Same contrast all images");
	set_Shortcuts_Line(43 , "  s", "Save as tiff",					"Hyperstack splitview",			"Save all opened images");
	set_Shortcuts_Line(44 , "  S", "Colored squared Splitview",		"Colored linear Splitiview",	"Splitview options Dialog");
	set_Shortcuts_Line(45 , "  t", "Run macro from clipboard",		"Install Ac_Bar from clipboard","Install macro tool from clipboard");
	set_Shortcuts_Line(46 , "  u", "RGB/8bit switch",				"RGB to half CMY",				"");
	set_Shortcuts_Line(47 , "  v", "Paste",							"Paste from system",			"Paste LUT");
	set_Shortcuts_Line(48 , "  x", "Copy LUT",						"channel roll",					"Copy to System");
	set_Shortcuts_Line(49 , "  y", "Synchronise windows",			"Do my Wand",					"");
	set_Shortcuts_Line(50 , "  w", "Close image",					"Open last closed image (w)",	"Close all others");
	set_Shortcuts_Line(51 , "  Z", "Channels Tool",					"",								"");
	set_Shortcuts_Line(52 , "  n*", "Difference of gaussian",		"",								"");
}
function set_Shortcuts_Line(line, key, alone, space, alt){
	Table.set("Key",		line, key);
	Table.set("Alone",		line, alone);
	Table.set("with Space",	line, space);
	Table.set("with Alt",	line, alt);
}

function cul(){
	print("cul");
}

macro "[f1]" {
	count_Button("Mitosis");

	getCursorLoc(x, y, z, modifiers);
	setColor("green");
	Overlay.drawEllipse(x-3, y-3, 6, 6);
	Overlay.show;
	setColor("orange");
}
macro "[f2]" {
	count_Button("Apoptosis");

	getCursorLoc(x, y, z, modifiers);
	setColor("magenta");
	Overlay.drawEllipse(x-3, y-3, 6, 6);
	Overlay.show;
	setColor("orange");
}
macro "[f3]" {
	count_Button("Nothing");

	getCursorLoc(x, y, z, modifiers);
	setColor("orange");
	Overlay.drawEllipse(x-3, y-3, 6, 6);
	Overlay.show;
	setColor("orange");
}
macro "[f4]"{
	if (do_Scroll_Loop) do_Scroll_Loop = false;
	else do_Scroll_Loop = true;
	scroll_Loop();
}

function scroll_Loop(){
	getDimensions(width, height, channels, slices, frames);
	if(slices==1 && frames==1) exit;
	getCursorLoc(x, y, z, flags);
	flags = flags%32; //remove "cursor in selection" flag
	while(do_Scroll_Loop) {
		getCursorLoc(x, y, z, flags);
		getDisplayedArea(area_x, area_y, width, height);
		flags = flags%32; //remove "cursor in selection" flag
		if (frames > 1) Stack.setFrame(((x - area_x) / width) * frames);
		else 			Stack.setSlice(((x - area_x) / width) * slices);
		wait(10);
	}
}
function count_Button(column_Name){
	if (nImages==0) exit;
	if(!isOpen("count")){
		Table.create("count");
		Table.set("Mitosis", 0, 0);
		Table.set("Apoptosis", 0, 0);
		Table.set("Nothing", 0, 0);
		Table.update;
	}
	n = Table.get(column_Name, 0);
	if (isKeyDown("space"))Table.set(column_Name, 0, n-1);
	else Table.set(column_Name, 0, n+1);
	Table.update;
}

//Ah jérôme... \o/
// macro "Table Action" {
// 	// if (nImages==0) exit;
// 	index = Table.getSelectionStart;
// 	// if (isKeyDown("space")) index = getNumber("label number?", 1);
// 	if (index == -1) exit;
// 	// setThreshold(index,index);
// 	// run("Create Selection");
// 	// resetThreshold();
// 	key = Table.getString("Key", index);
// 	run("[" + substring(key, 2) + "]");
// } Cool idée mais ça bug

function save_As_LZW_compressed_tif(){
	File.setDefaultDir(getDirectory("image"));
	path = getDir("save As LZW compressed tif");
	title = File.nameWithoutExtension;
	print( path + File.separator + title);
	run("Bio-Formats Exporter", "save=["+ path + File.separator + title + ".tif] compression=LZW");
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
	has_Lut = 0; 
	if (nImages > 0) {
		if (bitDepth()!=24) {
			getLut(reds, greens, blues);
			has_Lut=1;
		}
	} 
	newImage("lut"+round(random*100), "8-bit ramp", 256, 32, 1); 
	if (has_Lut) setLut(reds, greens, blues);
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
	}
	else {
		run("Duplicate...", "duplicate title=title channels=&channel frames=frame");
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
	getCursorLoc(x, y, null, null);
	call("ij.IJ.makeRectangle",x-(size/2),y-(size/2),size,size); //regular macro function is buggy
	showStatus(size+"x"+size);
}

function set_my_Source_Image(){
	// modify the global variable source with the current image title 
	showStatus("Source set");	
	run("Alert ", "object=Image color=Orange duration=1000"); 
	source = getTitle();
}

function duplicate_Box(){
	// make a selection before and it will duplicate as many slices than width size
	Roi.getBounds(x, y, width, height);
	Stack.getPosition(channel, slice, frame);
	run("Duplicate...", "duplicate channels=&ch range=" +slice-(width/2)+"-"+ slice+(width/2));
}

function test_main_Filters() {
	filtersList = newArray("Gaussian Blur...","Median...","Mean...","Minimum...","Maximum...","Variance...","Top Hat...","Gaussian Weighted Median");
	if (nImages == 0) exit("no image");
	source = getImageID();
	setBatchMode(1);
	getDimensions(width, height, channels, slices, frames);
	if (slices*frames > 1) exit("can't test stacks, please extract one slice");
	setBatchMode(1);
	sigma = getNumber("filters sigma", 2);
	newImage("Filters", bitDepth()+"-bit", width, height, filtersList.length);
	result = getImageID();
	for (i=0; i<filtersList.length; i++) {
		selectImage(source);
		run("Duplicate...", "title=test");
		if (i==0) run(filtersList[i], "sigma=" + sigma);
		else run(filtersList[i], "radius=" + sigma);
		run("Copy");
		selectImage(result);	
		setSlice(i+1);	
		run("Paste");
		Property.setSliceLabel(filtersList[i], i+1)
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

function numerical_Keyboard_Bar(){
	text = "<fromString>\n"+
	"<title> numerical Keyboard Macros\n"+
	"<disableAltClose> \n"+
	"<line>\n"+
	"<button>\n"+
	"label=<html><font color='black'> 7\n"+
	"bgcolor=gray\n"+
	"arg=run('[n7]')\n"+
	"<button>\n"+
	"label=<html><font color='black'> 8\n"+
	"bgcolor=#gray\n"+
	"arg=run('[n8]');\n"+
	"<button>\n"+
	"label=<html><font color='black'> 9\n"+
	"bgcolor=gray\n"+
	"arg=run('[n9]');\n"+
	"</line>\n"+
	"<line>\n"+
	"<button>\n"+
	"label=<html><font color='black'> 4\n"+
	"bgcolor=gray\n"+
	"arg=run('[n4]')\n"+
	"<button>\n"+
	"label=<html><font color='black'> 5\n"+
	"bgcolor=gray\n"+
	"arg=run('[n5]');\n"+
	"<button>\n"+
	"label=<html><font color='black'> 6\n"+
	"bgcolor=gray\n"+
	"arg=run('[n6]');\n"+
	"</line>\n"+
	"<line>\n"+
	"<button>\n"+
	"label=<html><font color='black'> 1\n"+
	"bgcolor=gray\n"+
	"arg=run('[n1]')\n"+
	"<button>\n"+
	"label=<html><font color='black'> 2\n"+
	"bgcolor=gray\n"+
	"arg=run('[n2]');\n"+
	"<button>\n"+
	"label=<html><font color='black'> 3\n"+
	"bgcolor=gray\n"+
	"arg=run('[n3]');\n"+
	"</line>\n"+
	"<line>\n"+
	"<button>\n"+
	"label=<html><font color='black'> 0\n"+
	"bgcolor=gray\n"+
	"arg=run('[n0]')\n"+
	"</line>\n";
	run("Action Bar",text);
}

function open_Memory_And_Recorder() {
	run("Record...");
	Table.setLocationAndSize(screenWidth()-350, 0, 350, 200,"Recorder");
	run("Monitor Memory...");
	Table.setLocationAndSize(screenWidth()-595, 0, 250, 120,"Memory");
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
	if (!is("composite")) exit;
	Stack.getDisplayMode(mode);
	if (mode=="color"||mode=="greyscale") {Stack.setDisplayMode("composite");}
	else {Stack.setDisplayMode("color");}
}

function Bioformats_Bar(){
	BioFormats_Bar = "<fromString>"+"\n"+
	"<stickToImageJ>"+"\n"+
	"<noGrid>"+"\n"+
	"<title> LUTs\n"+
	"<line>"+"\n"+
	"<separator>"+"\n"+
	"<text> BioFormats"+"\n"+
	"<separator>"+"\n"+
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
	run("Action Bar",BioFormats_Bar);
}

function my_Tool_Roll() {
	if 		(toolID() == 0) setTool(15);
	else setTool(0);
}

//ispired by Robert Haase Windows Position tool from clij
function multi_Tool(){ //avec menu "que faire avec le middle click? **"
	/*
	 * shift = +1
	 * ctrl = +2
	 * cmd = +4 (Mac)
	 * alt = +8
	 * middle click is just 8
	 * leftClick = +16
	 * cursor over selection = +32
	 * So e.g. if (leftclick + alt) Flags = 24
	 */
	if (nImages == 0) exit;
	setupUndo();
	call("ij.plugin.frame.ContrastAdjuster.update");
	updateDisplay();
	getCursorLoc(x, y, z, flags);
	if (flags == 40 && !middle_Click) { //middle click on selection
		roiManager("Add"); 
		exit();
	}
	if (flags>=32) flags -= 32;
	if (flags == 8) { //middle mouse button
		if      (startsWith(getTitle(), "Preview Opener")) open_From_Preview_Opener();  
		else if (startsWith(getTitle(), "Lookup Tables")) set_LUT_From_Montage(); 
		if (Image.height==32||Image.width==256) { if(isOpen("LUT Profile")) plot_LUT(); copy_LUT();}
		else {
			if (middle_Click) eval(String.paste);
			else if (main_Tool=="Curtain Tool") set_my_Source_Image();
			else composite_Switch();
		}
	}
	if (flags == 16) {
		if 		(main_Tool=="Move Windows")           move_Windows();
		else if (main_Tool=="Contrast Adjuster")      live_Contrast();
		else if (main_Tool=="Gamma on LUT")           live_Gamma();
		else if (main_Tool=="slice / frame scroll")   live_Scroll();
		else if (main_Tool=="My Magic Wand")          magic_Wand();
		else if (main_Tool=="Fly mode")			 	  fly_Mode();
		else if (main_Tool=="Curtain Tool")			  curtain_Tool();
		else if (main_Tool=="Scale Bar Tool")		  scale_Bar_Tool();
	}
	if (flags == 9) 				if (bitDepth()!=24) paste_LUT();							//shift + middle click
	if (flags == 10||flags == 14) 	if (bitDepth()!=24) paste_Favorite_LUT();				//shift + middle click
	if (flags == 17)				live_Contrast();															// shift + long click
	if (flags == 18||flags == 20)	live_Gamma();																// ctrl + long click
	if (flags == 24)				if (main_Tool=="slice / frame scroll") move_Windows(); else live_Scroll();	// alt + drag
	if (flags == 25)				box_Auto_Contrast();														// shift + alt + long click
	if (flags == 26||flags == 28)	curtain_Tool();
}

function scale_Bar_Tool(){
	//adapted from Aleš Kladnik there https://forum.image.sc/t/automatic-scale-bar-in-fiji-imagej/60774
	getPixelSize(unit,w,h);
	if (unit == "pixels") exit("Image not spatially calibrated");
	bar_Length = 1;	// initial scale bar length in measurement units
	bar_Relative_Size = 0;
	bar_Height = 0;
	if (add_text == true) text_Parameter = "bold";
	else text_Parameter = "hide";
	font_Size = minOf(Image.width, Image.height) / 30; // estimation of "good" font size
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
	getCursorLoc(x, y, z, flags);
	setBatchMode(true);
	id=getImageID;
	px = x;
	while (flags&16>0) {
		selectImage(id);
		getCursorLoc(x, y, z, flags);
		if (x != px) {
			if (x < 0) x = 0;
			if (isOpen(source)) selectWindow(source);
			else exit;
			makeRectangle(x ,0 ,getWidth-x , getHeight);
			run("Duplicate...","title=part");
			id3 = getImageID;
			selectImage(id);
			run("Add Image...", "image=[part] x="+ x +" y=0 opacity=100"); //zero
			while (Overlay.size>1) Overlay.removeSelection(0);
			selectWindow(source);
			run("Select None");
			selectImage(id3);
			close();
			px=x;
			wait(30);
		}
    }
   run("Select None");
   Overlay.remove;
}

function move_Windows() {
	getCursorLoc(x2, y2, z2, flags2);
	zoom = getZoom();
	getCursorLoc(last_x, last_y, z, flags);
	flags = flags%32; //remove "cursor in selection" flag
	while (flags == 16) {
		getLocationAndSize(window_x, window_y, null, null);
		getCursorLoc(x, y, z, flags);
		flags = flags%32; //remove "cursor in selection" flag
		if (x != last_x || y != last_y) {
			window_x = window_x - (x2 * zoom - x * zoom);
			window_y = window_y - (y2 * zoom - y * zoom);
			setLocation(window_x, window_y);
			getCursorLoc(last_x, last_y, z, flags2);
		}
	wait(10);
	}
}

function live_Contrast() {	
	if (bitDepth() == 24) exit;
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
	if(slices==1 && frames==1) exit;
	getCursorLoc(x, y, z, flags);
	flags = flags%32; //remove "cursor in selection" flag
	while(flags >= 16) {
		getCursorLoc(x, y, z, flags);
		getDisplayedArea(area_x, area_y, width, height);
		flags = flags%32; //remove "cursor in selection" flag
		if (frames > 1) Stack.setFrame(((x - area_x) / width) * frames);
		else 			Stack.setSlice(((x - area_x) / width) * slices);
		if (live_AutoContrast) run("Enhance Contrast", "saturated=&enhance_Rate");
		call("ij.plugin.frame.ContrastAdjuster.update");
		wait(10);
	}
}

function box_Auto_Contrast() {
	if (bitDepth==24) exit("This macro won't work with rgb");
	size=75;
	getCursorLoc(x, y, z, flags);
	makeRectangle(x-size/2,y-size/2,size,size);
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
			wait(5);
		}
	}
	run("Set... ", "zoom=&zoom x=&new_x y=&new_y");
}

function magic_Wand(){
	getCursorLoc(x, y, z, flags);
	if (flags>=32) flags -= 32; //remove "cursor in selection" flag
	if (add_To_Manager){
		run("ROI Manager...");
		roiManager("show all without labels");
	}
	if (flags == 16) { //left click
		adjust_Tolerance();
		if (add_To_Manager)	{
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
		if (distance < 0) new_Tolerance = tolerance - pow(abs(distance), exponent);
		else new_Tolerance = tolerance + pow(abs(distance), exponent);
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
	makeRectangle(x-(wand_Box_Size/2),y-(wand_Box_Size/2),wand_Box_Size,wand_Box_Size);
	getStatistics(area, mean, min, max, std, histogram);;
	tolerance = (tolerance_Threshold / 100) * max;
	return tolerance;
}

function set_Favorite_LUT(){
	saveAs("lut", getDirectory("temp")+"/favoriteLUT.lut");
	showStatus("new favorite LUT");
}

function paste_Favorite_LUT(){
	open(getDirectory("temp")+"/favoriteLUT.lut");
	showStatus("Paste LUT");
}

function copy_LUT() {
	getCursorLoc(x, y, z, flags);
	if (flags == 40) {roiManager("Add"); exit;}
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
	newImage(title + "_LUTs", "8-bit color-mode", 256, 32*(channels+1), channels, 1, 1);
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
	fiji_startup_path = getDirectory("macros")+"/StartupMacros.fiji.ijm";
	 //return true for Fetch and false for pull
	choice = getBoolean("Fetch or pull?", "Pull", "Fetch");
	if (!choice){
		//backup of current StMacros
		File.saveString(File.openAsString(fiji_startup_path), getDirectory("macros")+"/backups/StM_"+round(random*10000)+".ijm");
		//import new
		File.saveString(File.openAsString(sync_Path), fiji_startup_path);
		run("Install...","install=["+fiji_startup_path+"]");
		showStatus("Fetch!");
	}
	else {
		//pull
		File.saveString(File.openAsString(fiji_startup_path), sync_Path);
		showStatus("Pull!");
	}
}

//toggle channel number (i)
function toggle_Channel(i) { //modified from J.Mutterer
	if (nImages<1) exit; 
	if (is("composite")) {
		Stack.getActiveChannels(s);
		c = s.substring(i-1,i);
		Stack.setActiveChannels(s.substring(0,i-1)+!c+s.substring(i)); //at the end it looks like Stack.setActiveChannels(1101);
		showStatus("channel "+i+" toggled"); 
	}
}

function toggle_All_Channels(i) {
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
	title=getTitle();
	getDimensions(width, height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	//invert frames and slices to prevent future bugs
	// this is reverted afterwards 
	if ((frames > 1) && (slices == 1)) {
		switch_slices_and_frames = true;
		Stack.setDimensions(channels, frames, slices);
	}
	else switch_slices_and_frames = false;
	getDimensions(width, height, channels, slices, frames);
	if(selectionType() != -1) getSelectionBounds(x, y, width, height);
	setBatchMode(1);
	newImage("Color Coded Projection", "RGB black", width, height, frames);
	selectWindow(title);
	// copy for backup :
	getLut(reds, greens, blues);
	//paste copied LUT
	open(getDirectory("temp")+"/copiedLut.lut");
	//get current LUT for color coding
	getLut(R, G, B);
	R = Array.resample(R,slices);
	G = Array.resample(G,slices);
	B = Array.resample(B,slices);
	for (k = 0; k < frames; k++) {
		for (i = 0; i < slices; i++) {
			selectWindow(title);
			Stack.setPosition(channel, i+1, k+1);
			//create LUT with the scaled color :
			r = newArray(0,R[i]);	
			g = newArray(0,G[i]);	
			b = newArray(0,B[i]);
			r = Array.resample(r,256);
			g = Array.resample(g,256);
			b = Array.resample(b,256);
			setLut(r, g, b);
			run("Copy");
			selectWindow("Color Coded Projection");
			setSlice(k+1);
			//"MAX" paste :
			run("Paste");
		}
	}
	//restore right dimensions if switched
	if (switch_slices_and_frames) {
		selectWindow(title);
		Stack.setDimensions(channels, frames, slices);
	}
	//restore LUT
	selectWindow(title);
	setLut(reds, greens, blues);
	selectWindow("Color Coded Projection");
	run("Select None");
	setBatchMode("exit and display");
	restoreSettings();
}

//No projection, heavy on RAM
function color_Code_No_Projection(){
	//https://github.com/ndefrancesco/macro-frenzy/blob/master/assorted/Colorize%20stack.ijm
	title=getTitle();
	getDimensions(width, height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	if ((frames > 1) && (slices == 1)) {
		switch_slices_and_frames = true;
		Stack.setDimensions(channels, frames, slices);
	}
	else switch_slices_and_frames = false;
	getDimensions(width, height, channels, slices, frames);
	setBatchMode(1);
	run("Duplicate...", "title=duplicate duplicate channels=&channel");
	open(getDirectory("temp")+"/copiedLut.lut");
	getLut(R, G, B);
	run("RGB Color");
	R=Array.resample(R,slices);
	G=Array.resample(G,slices);
	B=Array.resample(B,slices);
	for (k = 0; k < frames; k++) {
		for (i = 0; i < slices; i++) {
			selectWindow(title);
			Stack.setPosition(channel, i+1, k+1);
			run("Duplicate...", "title=slice");
			r=newArray(0,R[i]);	g=newArray(0,G[i]);	b=newArray(0,B[i]);
			r=Array.resample(r,256); g=Array.resample(g,256); b=Array.resample(b,256);
			setLut(r, g, b);
			run("Copy");
			close();
			selectWindow("duplicate");
			Stack.setPosition(1, i+1, k+1);
			run("Paste");
		}
	}
	if (switch_slices_and_frames) {
		selectWindow(title);
		Stack.setDimensions(channels, frames, slices);
		selectWindow("duplicate");
		Stack.setDimensions(1, frames, slices);
	}
	// if (projection) run("Z Project...", "projection=[Max Intensity] all");
	run("Select None");
	rename(title + "_colored");
	setBatchMode(false);
}

function fastColorCode(Glut) {
	if (Glut == "current") getLut(r,g,b);
	zoom = getZoom();
	setBatchMode(true);
	title = getTitle();
	Stack.getDimensions(ww, hh, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	if (channels > 1) run("Duplicate...", "duplicate channels=&channel");
	//swap slices and frames in case:
	if ((slices > 1) && (frames == 1)) {
		frames = slices;
		slices = 1;
		Stack.setDimensions(1, slices, frames);
	}
	totalframes = frames;
	calcslices = slices * totalframes;
	imgID = getImageID();
	newImage("colored", "RGB White", ww, hh, calcslices);
	run("Stack to Hyperstack...", "order=xyczt(default) channels=1 slices="	+ slices + " frames=" + totalframes + " display=Color");
	newimgID = getImageID();
	selectImage(imgID);
	run("Duplicate...", "duplicate");
	run("8-bit");
	imgID = getImageID();
	newImage("stamp", "8-bit White", 10, 10, 1);
	if (Glut == "current") paste_LUT();
	// if (Glut == "current") setLut(r,g,b);
	else open(Glut);
	getLut(rA, gA, bA);
	if (hh > 100) {
		run("Calibration Bar...", "location=[Upper Left] fill=Black label=None zoom=0.7 overlay");
		Overlay.copy;
	}
	close();
	nrA = newArray(256);	ngA = newArray(256);	nbA = newArray(256);
	newImage("temp", "8-bit White", ww, hh, 1);
	tempID = getImageID();
	for (i = 0; i < totalframes; i++) {
		colorscale = floor((256 / totalframes) * i);
		for (j = 0; j < 256; j++) {
			intensityfactor = j / 255;
			nrA[j] = round(rA[colorscale] * intensityfactor);	ngA[j] = round(gA[colorscale] * intensityfactor);	nbA[j] = round(bA[colorscale] * intensityfactor);
		}
		for (j = 0; j < slices; j++) {
			selectImage(imgID);
			Stack.setPosition(1, j + 1, i + 1);
			run("Select All");
			run("Copy");
			selectImage(tempID);
			run("Paste");
			setLut(nrA, ngA, nbA);
			run("RGB Color");
			run("Select All");
			run("Copy");
			run("8-bit");
			selectImage(newimgID);
			Stack.setPosition(1, j + 1, i + 1);
			run("Select All");
			run("Paste");
		}
	}
	slices = frames;
    frames = 1;
	Stack.setDimensions(1, slices, frames);
	run("Z Project...", "projection=[Max Intensity] all");
	rename("Tempo_color_code_"+Glut+"_"+title);
	run("Set... ", "zoom="+zoom*100);
	if (hh > 100) Overlay.paste;
	setOption("Changes", 0);
	run("Enhance Contrast", "saturated=0 use");
	run("Flatten");
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
	setTool(21);
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
	if (!startsWith(title, "Lookup Tables")) set_my_Target_Image();
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
		target_Image = call("ij.Prefs.get","Destination.title","");
		if (isOpen(target_Image)){
			selectWindow(target_Image);
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

function set_my_Target_Image() {
	showStatus("Target image = "+ getTitle(), "flash image orange 200ms");
	call("ij.Prefs.set","Destination.title", getTitle());
}

function set_my_Custom_Location() {
	showStatus("Custom position set");
	getLocationAndSize(saved_Loc_X, saved_Loc_Y, width, height);
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
		open(path);
		showStatus("opening " + path_List[index]);
	}
	else showStatus("can't open " + path_List[index] + " maybe incorrect name or spaces in it?");
}

//create a montage with snapshots of all opened images (virtual or not)
//in their curent state.  Will close all but the montage.
function make_Preview_Opener() {
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
	infos=getMetadata("Info");
	setMetadata("Info", paths_List + "\n" + infos);
	close("\\Others");
	setBatchMode(0);
	saveAs("tiff", source_Folder + "Preview Opener");
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
	rename(title);
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
	set_LUTs();
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
	if (channels == 3) newList = newArray(123,132,213,231,321,312);
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

function multi_Plot(){
	close("LUT Profile");
	select_None = 0; active_Channels="1"; normalize = 0;
	if (isKeyDown("space")) normalize = 1;
	getDimensions(width,  height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	if (selectionType() == -1) run("Select All");
	if (bitDepth() == 24){ run("Plot Profile"); exit;}
	if (channels > 1) Stack.getActiveChannels(active_Channels);
	id = getImageID();
	if (!isOpen("MultiPlot")) call("ij.gui.ImageWindow.setNextLocation", saved_Loc_X, saved_Loc_Y);
	run("Plots...", "width=400 height=200");
	Plot.create("MultiPlot", "Pixels", "Grey value");
	for (i=1; i<=channels; i++) {
		if (channels > 1) Stack.setChannel(i);
		if (is_Active_Channel(i)) {
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
	if (channels > 1) Stack.setActiveChannels(active_Channels);
	getSelectionBounds(x, y, selection_Width, height);
	if (selection_Width == Image.width) run("Select None");
}
function lut_To_Hex2(){
	getLut(reds, greens, blues);
	if (is("Inverting LUT")) { red = reds[0];   green = greens[0];   blue = blues[0];   }
	else 					 { red = reds[255]; green = greens[255]; blue = blues[255]; }
	if (red<16)   hex_red =   "0" + toHex(red); 	else hex_red = toHex(red);
	if (green<16) hex_green = "0" + toHex(green);	else hex_green = toHex(green);
	if (blue<16)  hex_blue =  "0" + toHex(blue);	else hex_blue = toHex(blue);
	return "#" + hex_red + hex_green + hex_blue;
}

function multi_Plot_Z_Axis(){
	close("LUT Profile");
	select_None = 0; active_Channels = "1"; normalize = 1;
	// if (isKeyDown("space")) normalize = 1;
	getDimensions(width,  height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	if (selectionType()==-1) {run("Select All");}
	if (bitDepth()==24){ run("Plot Profile"); exit;}
	if (channels > 1) Stack.getActiveChannels(active_Channels);
	id = getImageID();
	if (!isOpen("Multiplot")) call("ij.gui.ImageWindow.setNextLocation", saved_Loc_X, saved_Loc_Y);
	run("Plots...", "width=400 height=200");
	Plot.create("MultiPlot", "Frame", "Grey value");
	for (i=1; i<=channels; i++) {
		if (channels>1) Stack.setChannel(i);
		if (is_Active_Channel(i)) {
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
	if (nImages == 0) exit;
	if (bitDepth() == 24) exit;
	id = getImageID();
	lutinance = newArray(0); //luminance of LUT...
	getLut(reds, greens, blues);
	setBatchMode(1);
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
	if (!isOpen("LUT Profile")) call("ij.gui.ImageWindow.setNextLocation", saved_Loc_X, saved_Loc_Y);
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
		lutinance[i] = getLum(rgb);
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

function Set_Active_Path() { File.setDefaultDir(getDirectory("image")); }


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
		rename(title+"_u");
	}
	setOption("Changes", 0);
}

function my_RGB_Converter(){
	setBatchMode(1);
	if (nImages==0) exit("no image");
	if (bitDepth() == 24) {
		run("Duplicate...","duplicate");
		run("Make Composite");
		run("Remove Slice Labels");
	}
	Stack.setChannel(1); make_LUT(128,97,0);
	Stack.setChannel(2); make_LUT(0,97,128);
	Stack.setChannel(3); make_LUT(97,0,128);
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

var x_Position_Backup = 300;
var y_Position_Backup = 300;
var width_Position_Backup = 400;
var height_Position_Backup = 400;

function maximize_Image() {
	getLocationAndSize(x_Position_Backup, y_Position_Backup, width_Position_Backup, height_Position_Backup);
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

function full_Screen() {
	getLocationAndSize(x_Position_Backup, y_Position_Backup, width_Position_Backup, height_Position_Backup);
	setBatchMode(1);
	run("Set... ", "zoom="+round((screenWidth()/getWidth())*100)-1);
	setLocation(0, screenHeight()/11, screenWidth(), screenHeight()*0.88);
}

function restore_Image_Position(){
	setLocation(x_Position_Backup, y_Position_Backup, width_Position_Backup, height_Position_Backup);
}

function note_In_Infos(){
	infos=getMetadata("Info");
	Dialog.create("Add comment in image infos");
	Dialog.addString("Comment :", "", 80);
	Dialog.show();
	Comment = Dialog.getString();
	setMetadata("Info", Comment+'\n\n'+infos);
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
	source = getImageID();
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
		selectImage(source);
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
	Dialog.createNonBlocking("test all calculator modes");
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
	modes = newArray("add","subtract","multiply","divide", "and", "or", "xor", "min", "max", "average","difference","copy","Transparent-zero");
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

function cool_3D_montage() {
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
		currentImage_name = getTitle();
		saveAs("tiff", directory + currentImage_name);
		run("Z Project...", "projection=[Max Intensity] all");
		currentImage_name = getTitle();
		saveAs("tiff", directory + currentImage_name);
		run("Close All");
	}
	print("done");
	setBatchMode(false);
}

/*--------
Set LUTs
--------*/
function set_My_LUTs(){
	LUT_list = newArray("kb","ko","km","kg","Grays" ,"copied" ,"fav");
	Dialog.create("Set all LUTs");
	for(i=0; i<4; i++) Dialog.addRadioButtonGroup("LUT " + (i+1), LUT_list, 0, 7, chosen_LUTs[i]);
	Dialog.addCheckbox("noice?", 0);
	Dialog.show();
	for(i=0; i<4; i++) chosen_LUTs[i] = Dialog.getRadioButton();
	if (Dialog.getCheckbox()) for(i=0; i<4; i++) if (chosen_LUTs[i] != "Grays") chosen_LUTs[i] = chosen_LUTs[i] + "_noice"; 
	set_LUTs();
}

function get_LUTs_Dialog(){
	LUT_list = newArray("kb","km","ko","kg","Grays","Cyan","Magenta","Yellow","Red","Green","Blue");
	Dialog.create("Set all LUTs");
	for(i=0; i<5; i++) Dialog.addChoice("LUT " + (i+1),LUT_list,chosen_LUTs[i]);
	Dialog.show();
	for(i=0; i<5; i++) chosen_LUTs[i] = Dialog.getChoice();
}

function set_LUTs(){
	Stack.getPosition(ch,s,f);
	getDimensions(w,h,channels,s,f);
	if (channels>1){
		Stack.setDisplayMode("composite");
		for(i=1; i<=channels; i++){
			Stack.setChannel(i);
			if (chosen_LUTs[i-1]=="fav") paste_Favorite_LUT();
			else if (chosen_LUTs[i-1]=="copied") paste_LUT();
			else run(chosen_LUTs[i-1]);
		}
		Stack.setChannel(ch);
		Stack.setDisplayMode("color");Stack.setDisplayMode("composite");
	}
	else {
		if (chosen_LUTs[0]=="fav") paste_Favorite_LUT();
		else if (chosen_LUTs[0]=="copied") paste_LUT();
		else  run(chosen_LUTs[0]);
	}
}
function set_All_LUTs(){
	setBatchMode(1);
	all_IDs = newArray(nImages);
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		all_IDs[i] = getImageID(); 
	} 
	for (i=0; i<nImages; i++) {
		selectImage(all_IDs[i]);
		if (bitDepth() != 24) set_LUTs();	
	}
	setBatchMode(0);
}

//for args give gamma value, and r,g,b obtained by getLut(r,g,b) command.
function gamma_LUT(gamma, reds, greens, blues) {
	gammaReds = newArray(256); 
	gammaGreens = newArray(256); 
	gammaBlues = newArray(256); 
	gam = newArray(256);
	for (i=0; i<256; i++) gam[i] = pow(i, gamma);
	scale = 255 / gam[255];
	for (i=0; i<256; i++) gam[i] = round(gam[i] * scale);
	for (i=0; i<256; i++) {
		j = gam[i];
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
	if (is("Virtual Stack")) {showStatus("marche pas en virtual stack!"); wait(600); exit;}
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
	dir = getDirectory("Choose a Directory");
	for (i=0; i<nImages; i++) {
        selectImage(i+1);
        title = getTitle;
        saveAs("tiff", dir+title);
        print(title + " saved");
	}
	print("done");
}

function my_Tile() {
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
	if (channels == 1 || channels > 5) exit;
	if (startsWith(title, "Splitview")) { revert_SplitView(); exit; }
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

function split_View(color_Mode, montage_Style, labels) {
	// color_Mode : 0 = grayscale , 1 = color 
	// montage_Style : 0 = linear montage , 1 = squared montage , 2 = vertical montageage
	// labels : 0 = no , 1 = yes.
	setBatchMode(1);
	title = getTitle();
	saveSettings();
	Setup_SplitView(color_Mode, labels);
	restoreSettings();
	if (montage_Style == 0)	linear_SplitView();
	if (montage_Style == 1)	square_SplitView();
	if (montage_Style == 2)	vertical_SplitView();
	rename(title + "_SplitView");
	setOption("Changes", 0);
	setBatchMode("exit and display");

	function Setup_SplitView(color_Mode, labels){
		//prepare tiles before montage : 
		// duplicate twice for overlay and splitted channels
		// convert to RGB with right colors, labels and borders
		getDimensions(width, height, channels, slices, frames);
		if (channels == 1) exit("only one channel");
		if (channels > 5)  exit("5 channels max");
		setBackgroundColor(255, 255, 255); //for white borders
		run("Duplicate...", "title=image duplicate");
		if ((slices > 1) && (frames == 1)) {
			frames = slices;
			slices = 1;
			Stack.setDimensions(channels, slices, frames); 
		} 
		tiles = newArray(channels + 1);
		getDimensions(width, height, channels, slices, frames); 
		font_Size = height / 9;
		run("Duplicate...", "title=split duplicate");
		run("Split Channels");
		selectWindow("image");
		Stack.setDisplayMode("composite")
		if (labels) {
			get_Labels_Dialog();
			setColor("white");
			setFont("SansSerif", font_Size, "bold antialiased");
			Overlay.drawString("Merge", height/20, font_Size);
			Overlay.show;
			run("Flatten","stack");
			rename("overlay");
			tiles[0] = getTitle();
			if (border_Size > 0) add_Borders();
			close("image");
			for (i = 1; i <= channels; i++) {
				selectWindow("C" + i + "-split");
				id = getImageID();
				getLut(reds, greens, blues); 
				setColor(reds[255], greens[255], blues[255]);
				if (!color_Mode) {
					getMinAndMax(min, max); 
					run("Grays"); 
					setMinAndMax(min, max);
				}
				Overlay.drawString(channel_Labels[i-1], height/20, font_Size);
				Overlay.show;
				if (slices * frames > 1) run("Flatten","stack");
				else {
					run("Flatten");
					selectImage(id);
					close();
				}
				if (border_Size > 0) add_Borders();
				tiles[i]=getTitle();
			}
		}
		else { // without labels
			run("RGB Color", "frames"); 
			rename("overlay"); 
			tiles[0] = getTitle(); 
			if (border_Size > 0) add_Borders();
			close("image");
			for (i = 1; i <= channels; i++) {
				selectWindow("C"+i+"-split");
				if (!color_Mode) {
					getMinAndMax(min, max); 
					run("Grays"); 
					setMinAndMax(min, max);
				}
				run("RGB Color", "slices"); 
				if (border_Size > 0) add_Borders();
				tiles[i] = getTitle();	
			}
		}
	}

	function add_Borders(){
		run("Canvas Size...", "width=" + Image.width + border_Size + " height=" + Image.height + border_Size + " position=Center");
	}
	
	function get_Labels_Dialog(){
		Dialog.createNonBlocking("Provide channel names");
		for (i = 0; i < 5; i++) Dialog.addString("channel " + i+1, channel_Labels[i], 12); 
		Dialog.addNumber("Font size", font_Size);
		Dialog.show();
		for (i = 0; i < 5; i++) channel_Labels[i] = Dialog.getString();
		font_Size = Dialog.getNumber();
	}
	
	function square_SplitView(){
		channel_1_2 = combine_Horizontally(tiles[1], tiles[2]);
		if (channels == 2||channels == 4) channel_1_2_Overlay = combine_Horizontally(channel_1_2, tiles[0]);
		if (channels == 3){
			channel_3_Overlay = combine_Horizontally(tiles[3], tiles[0]);
			combine_Vertically(channel_1_2, channel_3_Overlay);
		}
		if (channels >= 4)	channel_3_4 = combine_Horizontally(tiles[3], tiles[4]);
		if (channels == 4)	combine_Vertically(channel_1_2_Overlay, channel_3_4);
		if (channels == 5){
			channel_1_2_3_4 = combine_Vertically(channel_1_2, channel_3_4); 	
			channel_5_Overlay =	combine_Vertically(tiles[5], tiles[0]); 
			combine_Horizontally(channel_1_2_3_4, channel_5_Overlay);
		}
	}
	
	function linear_SplitView(){
		channel_1_2 = combine_Horizontally(tiles[1], tiles[2]);
		if (channels==2) combine_Horizontally(channel_1_2, tiles[0]);
		if (channels==3){
			channel_3_Overlay = combine_Horizontally(tiles[3], tiles[0]);
			combine_Horizontally(channel_1_2, channel_3_Overlay);
		}
		if (channels>=4){
			channel_3_4 = combine_Horizontally(tiles[3], tiles[4]);
			channel_1_2_3_4 = combine_Horizontally(channel_1_2, channel_3_4);
		}
		if (channels==4) combine_Horizontally(channel_1_2_3_4, tiles[0]); 
		if (channels==5){
			channel_5_Overlay = combine_Horizontally(tiles[5], tiles[0]);
			combine_Horizontally(channel_1_2_3_4, channel_5_Overlay);
		}
	}
	
	function vertical_SplitView(){
		channel_1_2 = combine_Vertically(tiles[1], tiles[2]);
		if (channels==2) combine_Vertically(channel_1_2, tiles[0]);
		if (channels==3){
			channel_3_Overlay = combine_Vertically(tiles[3], tiles[0]);
			combine_Vertically(channel_1_2, channel_3_Overlay);
		}
		if (channels>=4){
			channel_3_4 = combine_Vertically(tiles[3], tiles[4]);
			channel_1_2_3_4	= combine_Vertically(channel_1_2, channel_3_4);
		}
		if (channels==4) combine_Vertically(channel_1_2_3_4, tiles[0]);
		if (channels==5){
			channel_5_Overlay = combine_Vertically(tiles[5], tiles[0]);
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

function split_View_Dialog(){
	if (nImages == 0) exit();
	getDimensions(width, height, channels, slices, frames);
	Dialog.createNonBlocking("split_View");
	Dialog.addRadioButtonGroup("color Mode", newArray("Colored","Grayscale"), 1, 3, color_Mode);
	Dialog.addRadioButtonGroup("Montage Style", newArray("Linear","Square","Vertical"), 1, 3, montage_Style);
	Dialog.addSlider("border size", 0, 50, minOf(height, width) * 0.02);
	Dialog.addCheckbox("label channels?", labels);
	Dialog.show();
	color_Mode = Dialog.getRadioButton();
	montage_Style = Dialog.getRadioButton();
	border_Size = Dialog.getNumber();
	labels = Dialog.getCheckbox();
	if	    (color_Mode == "Colored"   && montage_Style == "Linear")  { if (labels) split_View(1,0,1); else split_View(1,0,0); }
	else if (color_Mode == "Grayscale" && montage_Style == "Linear")  { if (labels) split_View(0,0,1); else split_View(0,0,0); }
	else if (color_Mode == "Colored"   && montage_Style == "Square")  { if (labels) split_View(1,1,1); else split_View(1,1,0); }
	else if (color_Mode == "Grayscale" && montage_Style == "Square")  { if (labels) split_View(0,1,1); else split_View(0,1,0); }
	else if (color_Mode == "Colored"   && montage_Style == "Vertical"){ if (labels) split_View(1,2,1); else split_View(1,2,0); }
	else if (color_Mode == "Grayscale" && montage_Style == "Vertical"){ if (labels) split_View(0,2,1); else split_View(0,2,0); }
}

//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
function linear_LUTs_Baker(){
	if (nImages==0) exit("No opened image");
	if(bitDepth()==24) exit;
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
		if (getInfo("os.name")!="Mac OS X") Dialog.createNonBlocking("The LUT baker");
		else Dialog.createNonBlocking("◊ The LUT baker ◊");
		Dialog.setLocation(x+w,y);
		for(i=0; i<CH; i++) {
			if(CH>1)Stack.setChannel(i+1);
			getLut(r,g,b); 
			R = r[255]; G = g[255]; B = b[255];
			Rz[i] = R; Gz[i] = G; Bz[i] = B;
			totR += R; totG += G; totB += B;
			if (getInfo("os.name")!="Mac OS X") Dialog.addMessage("_ LUT " + (i+1) + " _", 20, lut_To_Hex(R,G,B));
			else Dialog.addMessage("◊ LUT " + (i+1) + "◊", 20, lut_To_Hex(R,G,B));
			Dialog.addSlider("red",	 0,255, R);
			Dialog.addSlider("green",0,255, G);
			Dialog.addSlider("blue", 0,255, B);
			rgb = newArray(R,G,B);
			Dialog.addMessage("sum =" + R+G+B + "    luminance =" + getLum(rgb));
		}
		if(CH>1)Stack.setChannel(ch); 
		Dialog.setInsets(20, 0, 0);
		Dialog.addMessage("Reds= "+totR+"   Greens= "+totG+"   Blues= "+totB);
		Dialog.addCheckbox("update changes", preview); 
		setBatchMode(0);
		Dialog.show();
		setBatchMode(1);
		preview = Dialog.getCheckbox(); 
		selectImage(id);
		for(k=0; k<CH; k++){
			Rz[k]=Dialog.getNumber();
			Gz[k]=Dialog.getNumber();
			Bz[k]=Dialog.getNumber();
			if (CH>1) Stack.setChannel(k+1);
			make_LUT(Rz[k],Gz[k],Bz[k]);
		}
	}
	if (CH>1) Stack.setChannel(ch);
	setBatchMode(0);
}

function make_LUT(red, green, blue){
	REDS = newArray(256); GREENS = newArray(256); BLUES = newArray(256);
	for(i=0; i<256; i++) { 
		REDS[i] = (red/256)*(i+1);
		GREENS[i] = (green/256)*(i+1);
		BLUES[i] = (blue/256)*(i+1);
	}
	setLut(REDS, GREENS, BLUES);
}

function lut_To_Hex(R,G,B){
	if (R<16) xR = "0" + toHex(R); else xR = toHex(R);
	if (G<16) xG = "0" + toHex(G); else xG = toHex(G);
	if (B<16) xB = "0" + toHex(B); else xB = toHex(B);
	return "#"+xR+xG+xB;
}

function copy_Paste_Source_LUTs(){
	title=getTitle();
	list = getList("image.titles");
	Dialog.create("apply LUTs");
	Dialog.addChoice("source", list, source);
	Dialog.addChoice("destination",list,title);
	if (!isKeyDown("shift")) Dialog.show();
	setBatchMode(1);
	source = Dialog.getChoice();
	dest = Dialog.getChoice();
	selectWindow(source);
	getDimensions(w,h,CH,s,f);
	compositeMode = Property.get("CompositeProjection");
	for (i = 0; i < CH; i++) {
		selectWindow(source);
		Stack.setChannel(i+1);
		getLut(reds, greens, blues);
		selectWindow(dest);
		Stack.setChannel(i+1);
		setLut(reds, greens, blues);
	}
	Property.set("CompositeProjection", compositeMode);
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
		exit;	
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
	new = Dialog.getString();
	if (new.length>channels) exit("Please set the right number of LUTs");
	//-----------------------------------------------------------------------------------------
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
	Stack.setPosition(channel, slice, frame);
	setBatchMode(0);
}

macro"random light LUTs [K]"{
	if (isKeyDown("space")) {twoComp150LUTs(); exit;}
	Types = newArray("any","any","any","any","any","any","any");
	if (isKeyDown("space")) LUMINANCE = getNumber("luminance", 150);
	else LUMINANCE = 150;
	getDimensions(w,h,channels,s,f);
	if (channels>1){
		Stack.setDisplayMode("composite");
		for(i=1; i<=channels; i++){
			Stack.setChannel(i);
			rgb = randomColorByTypeAndLum(LUMINANCE, Types[i-1]);
			make_LUT(rgb[0],rgb[1],rgb[2]);
		}
	}
}

var	startLum = 0;
var	stopLum = 255;
function ultimate_LUT_generator(){
	colors = newArray("red","green","blue","cyan","magenta","yellow","orange","gray");
	//colors = newArray("red(10-167)","green(10-225)","blue(10-175)","cyan(10-190)","magenta(10-190)","yellow(10-225)","orange(10-190)","gray(0-255)");
	chosenColors = newArray("gray","gray","gray","gray","gray","gray","gray","gray");
	steps = 4;
	Dialog.createNonBlocking("steps");
	Dialog.addSlider("how many steps?", 1, 8, steps);
	Dialog.show();
	steps =  Dialog.getNumber();
	Dialog.createNonBlocking("colors");
	Dialog.addSlider("start luminance?", 0, 255, startLum);
	Dialog.addSlider("stop luminance?", 0, 255, stopLum);
	for (i = 0; i < steps; i++) Dialog.addRadioButtonGroup("color "+i+1, colors,1,8,chosenColors[i]);
	Dialog.show();
	for (i = 0; i < steps; i++) chosenColors[i] = Dialog.getRadioButton();
	startLum = Dialog.getNumber();
	stopLum = Dialog.getNumber();
	while (true) {
		basicErrorCheck();
		setBatchMode(1);
		R = newArray(256); G = newArray(256); B = newArray(256);
		range = stopLum-startLum;
		for(i=0; i<steps; i++) { 
			targetLum = i*(range/(steps-1))+startLum;
			color = randomColorByTypeAndLum(targetLum, chosenColors[i]);
			//print(i , targetLum, chosenColors[i]);
			R[i*(255/(steps-1))] = color[0];
			G[i*(255/(steps-1))] = color[1];
			B[i*(255/(steps-1))] = color[2]; 
			showProgress(i/steps);
		}
		R = splineColor(R,(steps-1));
		G = splineColor(G,(steps-1));
		B = splineColor(B,(steps-1));
		setLut(R, G, B);
		run("Select None");
		run("Remove Overlay");
		setBatchMode(0);
		plot_LUT();
		copy_LUT();
		Dialog.createNonBlocking("new roll?");
		Dialog.addMessage("OK to reroll cancel to stop");
		Dialog.show();
	}
}

function twoComp150LUTs(){
	steps = getNumber("how many steps?", 2);
	setBatchMode(1);
	Stack.setChannel(1);
	R = newArray(256); G = newArray(256); B = newArray(256);
	for(i=0; i<=steps; i++) { 
		color = randomColorByLuminance(i*(150/steps)); 
		R[i*(255/steps)] = color[0]; R[0] = 0;
		G[i*(255/steps)] = color[1]; G[0] = 0;
		B[i*(255/steps)] = color[2]; B[0] = 0;
		showProgress(i/steps);
	}
	R = splineColor(R,steps);
	G = splineColor(G,steps);
	B = splineColor(B,steps);
	setLut(R, G, B);
	setBatchMode(1);
	getLut(reds, greens, blues);
	Stack.setChannel(2);
	comp = newArray(0);
	for (i = 0; i < 256; i++) {
		comp = complementary(reds[i],greens[i],blues[i]);
		reds[i] = comp[0];
		greens[i] = comp[1];
		blues[i] = comp[2];
		showProgress(i/255);
	}
	setLut(reds, greens, blues);
	run("Select None");
	Overlay.remove;
}

function getOppositeLinearLUT(){
	setBatchMode(1);
	getLut(reds, greens, blues);
	r = reds[255];
	g = greens[255];
	b = blues[255];
	comp = newArray(0);
	comp = complementary(r,g,b);
	r = comp[0];
	g = comp[1];
	b = comp[2];
	rgb = newArray(r,g,b);
	setBatchMode(0);
	return rgb;
}

function randomColorByTypeAndLum(lum, targetColorType) {
	rgb = newArray(3); loop=1; rgb_weight = newArray(0.299,0.587,0.114);
	luminance = 0;
	colorType = "";
	count = 0;
	while (loop) {
		if (count>20000) exit("can't generate color "+targetColorType+" with a luminance of "+lum);
		if (targetColorType == "gray") rgb = newArray(lum,lum,lum);
		else rgb=randomColorByLuminance(lum);
		Array.getStatistics(rgb, min, max, mean, stdDev);
		red = rgb[0]; green = rgb[1]; blue = rgb[2];
		if (red==max && blue<135 && (green/red)<0.5)  				colorType = "red";
		if (green==max && (red/green)<0.75 && (blue/green)<0.75) 	colorType = "green";
		if (blue==max && red==min && red<70 && (green/blue)<0.8)	colorType = "blue";
		if (blue==max && red==min && red<60 && (green/blue)>0.8)	colorType = "cyan";
		if (green==min && (green/red)<0.75 && (green/blue)<0.6) 	colorType = "magenta";
		if (red==max && blue==min && blue<50 && (green/red)<0.75)  	colorType = "orange";
		if (red==max && blue==min && blue<50 && (green/red)>0.8)	colorType = "yellow";
		if (red==green && blue==green) 								colorType = "gray";
		if (colorType == targetColorType) loop = 0;
		if (targetColorType == "any") loop = 0;
		count++;
	}
	/*
	print(colorType);
	s=""; for (i = 0; i < red; i+=2) s+="|"; print(s,red);
	s=""; for (i = 0; i < green; i+=2) s+="|"; print(s,green);
	s=""; for (i = 0; i < blue; i+=2) s+="|"; print(s,blue);
	"     ";
	*/
	return rgb;
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
	source = getTitle();
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
												make_LUT(10,183,255);//BLUE
	saveAs("LUT", lutsFolder + "/kb.lut");
	Stack.setChannel(2);
	makeRectangle(187, 0, 213, 213);
	run("Clear", "slice");
												make_LUT(255,142,10);//ORANGE
	saveAs("LUT", lutsFolder + "/ko.lut");
	Stack.setChannel(3);
	makeRectangle(187, 187, 213, 213);
	run("Clear", "slice");
												make_LUT(195,39,223);//PURP
	saveAs("LUT", lutsFolder + "/km.lut");
	Stack.setChannel(4);
	makeRectangle(0, 187, 213, 213);
	run("Clear", "slice");
												make_LUT(50,206,22);//GREEN
	saveAs("LUT", lutsFolder + "/kg.lut");
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
		if (bitDepth()!= 24) exit;
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

function lutSplineFit(steps){
	basicErrorCheck();
	if (isKeyDown("shift")) steps = getNumber("how many steps?", 3);
	getLut(r,g,b);
	newImage("Smoothed LUT", "8-bit ramp", 256, 64, 1);
	R = newArray(256); G = newArray(256); B = newArray(256);
	R = splineColor(r,steps);
	G = splineColor(g,steps);
	B = splineColor(b,steps);
	setLut(R, G, B);
	run("Select None");
	run("Remove Overlay");
	plot_LUT();
}

function randomAwesomeLUT(steps) {
	basicErrorCheck();
	if (isKeyDown("shift")) steps = getNumber("how many steps?", steps);
	setBatchMode(1);
	R = newArray(256); G = newArray(256); B = newArray(256);
	for(i=0; i<=steps; i++) { 
		color = randomColorByLuminance(i*(255/steps));
		R[i*(255/steps)] = color[0];
		G[i*(255/steps)] = color[1];
		B[i*(255/steps)] = color[2]; 
		showProgress(i/steps);
	}
	R = splineColor(R,steps);
	G = splineColor(G,steps);
	B = splineColor(B,steps);
	setLut(R, G, B);
	run("Select None");
	run("Remove Overlay");
	setBatchMode(0);
	if (isOpen("LUT Profile")) plot_LUT();
	copy_LUT();
}

function coolifyLUT(steps) {
	basicErrorCheck();
	if (isKeyDown("shift")) steps = getNumber("how many steps?", 3);
	setBatchMode(1);
	R = newArray(256); G = newArray(256); B = newArray(256);
	getLut(r, g, b);
	lum = 0.299*r[255] + g[255]*0.587 + b[255]* 0.114;
	for(i=0; i<=steps; i++) { 
		color = randomColorByLuminance(i*(lum/steps)); 
		R[i*(255/steps)] = color[0]; R[0] = 0; R[255] = r[255];
		G[i*(255/steps)] = color[1]; G[0] = 0; G[255] = g[255];
		B[i*(255/steps)] = color[2]; B[0] = 0; B[255] = b[255];
		showProgress(i/steps);
	}
	R = splineColor(R,steps);
	G = splineColor(G,steps);
	B = splineColor(B,steps);
	setLut(R, G, B);
	run("Select None");
	run("Remove Overlay");
	plot_LUT();
	setBatchMode(0);
	copy_LUT();
}

function random150lumLUT(steps) {
	basicErrorCheck();
	setBatchMode(1);
	R = newArray(256); G = newArray(256); B = newArray(256);
	for(i=0; i<=steps; i++) { 
		color = randomColorByLuminance(i*(150/steps)); 
		R[i*(255/steps)] = color[0]; R[0] = 0;
		G[i*(255/steps)] = color[1]; G[0] = 0;
		B[i*(255/steps)] = color[2]; B[0] = 0;
		showProgress(i/steps);
	}
	R = splineColor(R,steps);
	G = splineColor(G,steps);
	B = splineColor(B,steps);
	setLut(R, G, B);
	run("Select None");
	run("Remove Overlay");
	plot_LUT();
	setBatchMode(0);
	copy_LUT();
}

function randomViridis(steps) {
	basicErrorCheck();
	if (isKeyDown("shift")) steps = getNumber("how many steps?", 3);
	R = newArray(256); G = newArray(256); B = newArray(256);
	baseColor = randomColorByLuminance(50);
	for(i=0; i<=steps; i++) { 
		color = randomColorByLuminance(i*(170/steps)+50);
		R[i*(255/steps)] = color[0]; R[0] = baseColor[0];
		G[i*(255/steps)] = color[1]; G[0] = baseColor[1];
		B[i*(255/steps)] = color[2]; B[0] = baseColor[2];
		showProgress(i/steps);
	}
	R = splineColor(R,steps);
	G = splineColor(G,steps);
	B = splineColor(B,steps);
	setLut(R, G, B);
	run("Select None");
	run("Remove Overlay");
	plot_LUT();
	setBatchMode(0);
	copy_LUT();
}

function createOppositeLUT(){
	basicErrorCheck();
	setBatchMode(1);
	getLut(reds, greens, blues);
	newImage("Complementary LUT", "8-bit ramp", 256, 64, 1);
	comp = newArray(0);
	for (i = 0; i < 256; i++) {
		comp = complementary(reds[i],greens[i],blues[i]);
		reds[i] = comp[0];
		greens[i] = comp[1];
		blues[i] = comp[2];
		showProgress(i/255);
	}
	setLut(reds, greens, blues);
	lutSplineFit(20);
	rename("Complementary LUT");
	setBatchMode(0);
	copy_LUT();
}

function enluminateLUT(){
	basicErrorCheck();
	lum = getNumber("target luminance?", 255);
	setBatchMode(1);
	getLut(reds, greens, blues);
	comp = newArray(0);
	for (i = 0; i < 256; i++) {
		rgb = newArray(reds[i],greens[i],blues[i]);
		comp = adjustColorToLuminance(rgb,(lum/256)*i);
		reds[i] = comp[0];
		greens[i] = comp[1];
		blues[i] = comp[2];
		showProgress(i/255);
	}
	setLut(reds, greens, blues);
	rename("Complementary LUT");
	setBatchMode(0);
	copy_LUT();
}

function convert_To_iMQ_Style() {
	if(nImages == 0) exit;
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

//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------

function basicErrorCheck(){
	if (nImages == 0) newImage("LUT", "8-bit ramp", 256, 32, 1);
	if (nImages > 0) {
		if (getTitle() == "LUT Profile") close("LUT Profile");
		if (nImages == 0) newImage("LUT", "8-bit ramp", 256, 32, 1);
		if (bitDepth()==24) newImage("LUT", "8-bit ramp", 256, 32, 1);
	}
}

function randomColorByLuminance(lum){ 
	rgb = newArray(3); loop=1; rgb_weight = newArray(0.299,0.587,0.114);
	luminance = 0;
	while (loop) {
		for (i = 0; i < 3; i++) {
			rgb[i] = round(random*255);
			luminance += round(rgb[i]*rgb_weight[i]);
		}
		if (luminance>=lum-1 && luminance<=lum+1)loop=0;
		luminance = 0;
	}
	return rgb;
}

function adjustColorToLuminance(rgb,lum){
	lum2 = getLum(rgb); rgb_weight = newArray(0.299,0.587,0.114);
	loop=1; luminance = 0; i=-1;
	while (loop) {
		if (i==2) i = -1;
		if (lum2<lum) {
			i++;
			rgb[i]++;
			if (rgb[i]>255) rgb[i] = 255;
		}
		else if (lum2>lum){
			i++;
			rgb[i]--;
			if (rgb[i]<0) rgb[i] = 0;
		}
		for (k = 0; k < 3; k++) luminance += round(rgb[k]*rgb_weight[k]);
		if (luminance>=lum-1 && luminance<=lum+1)loop=0;
		luminance = 0;
	}
	return rgb;
}

//color = one of reds, greens or blues from getLut
function splineColor(color,steps){
	Overlay.remove;
	X = newArray(0); Y = newArray(0);
	for (i = 0; i <= steps; i++) X[i] = (255/steps)*i;
	for (i = 0; i <= steps; i++) Y[i] = color[X[i]];
	makeSelection("polyline", X,Y);
	run("Fit Spline");
	Overlay.addSelection("white");
	getSelectionCoordinates(splinedX, splinedY);
	splinedY = Array.resample(splinedY,256);
	Array.getStatistics(splinedY, min, max, mean, stdDev);
	for (k=0;k<256;k++) splinedY[k] = 255-(maxOf(0,minOf(255,255-splinedY[k])));
	X = Array.resample(X,256);
	return splinedY;
}

function get_LUTinance(reds,greens,blues){
	lutinance = newArray(0);
	for (i = 0; i < 256; i++) {
		rgb = newArray(reds[i],greens[i],blues[i]);
		lutinance[i] = getLum(rgb);
	}
	return lutinance;
}

function complementary(r,g,b){
	rgb = newArray(r,g,b);
	lum = getLum(rgb);
	Array.getStatistics(rgb, min, max, mean, stdDev);
	third_number = (rgb[0]+rgb[1]+rgb[2])-(min+max);
	for (i = 0; i < 3; i++) {
		if      (rgb[i] == min) rgb[i] = max;
		else if (rgb[i] == third_number) rgb[i] = (max+min)-third_number;
		else if (rgb[i] == max) rgb[i] = min;
	}
	rgb2 = adjustColorToLuminance(rgb,lum);
	return rgb2;
}

function getLum(rgb){
	rgb_weight = newArray(0.299,0.587,0.114);
	luminance = 0;
	for (i = 0; i < 3; i++) luminance += round(rgb[i]*rgb_weight[i]);
	return luminance;
}

//--------------------------------------------------------------------------------------------------------------------------------------
macro "AutoRun" {
	run("Roi Defaults...", "color=orange stroke=2 group=0");
	setTool(15);
}
function UseHEFT() {state = call("ij.io.Opener.getOpenUsingPlugins");if (state=="false") {setOption("OpenUsingPlugins", true);showStatus("TRUE (images opened by HandleExtraFileTypes)");} else {setOption("OpenUsingPlugins", false);showStatus("FALSE (images opened by ImageJ)");}}

var pencilWidth=1,eraserWidth=10,leftClick=16,alt=8,brushWidth=10,floodType="8-connected";
macro 'Pencil Tool Options...' {pencilWidth = getNumber("Pencil Width (pixels):", pencilWidth);}
macro 'Paintbrush Tool Options...' {brushWidth = getNumber("Brush Width (pixels):", brushWidth);call("ij.Prefs.set", "startup.brush", brushWidth);}
macro 'Flood Fill Tool Options...' {Dialog.create("Flood Fill Tool");Dialog.addChoice("Flood Type:", newArray("4-connected", "8-connected"), floodType);Dialog.show();floodType = Dialog.getChoice();call("ij.Prefs.set", "startup.flood",floodType);}
macro "Set Drawing Color..."{run("Color Picker...");}
