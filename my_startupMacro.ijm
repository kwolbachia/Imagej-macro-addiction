//Kevin Terretaz
//StartupMacros perso
//210411 SplitView2.0! en 12h...
//210515 Splitview 3.0, invertable LUTs
//210922 100 macros -> functions instead
var savedLocX = 0;
var savedLocY = screenHeight - 470;

var chosen_LUTs = newArray("kb","km","ko","kg","Grays");

var	color_Mode = "Colored";
var	montage_Style = "Linear";
var	labels = 0;
var borderSize = 0;
var channels = 1;
var font_Size = 30;
var channel_Labels = newArray("CidB","CidA","DNA","H4Ac","DIC");
var tile = newArray(1);

var mainTool = "Move Windows";
var toolList = newArray("Move Windows",	"Contrast Adjuster", "Gamma on LUT", "slice / frame scroll", "explorer", "My Magic Wand" );
var middleClick = 0;
var live_autoContrast = 0;
var enhance_rate = 0.03;

var source="";

macro "Multitool Tool - N55C000DdeCf00Db8Db9DbaDc7Dc8DcaDcbDd7DdbDe7De8DeaDebCfffDc9Dd8Dd9DdaDe9C777D02D11D12D17D18D21D28D2bD31D36D39D3aD3bD3eD41D42D46D47D4cD4dD4eD51D52D57D5bD5dD62D63D67D6dD72D73D74D75D76D77D83D85D86D94Cf90Da6Da7Da8Da9DaaDabDacDadDaeDb4Db5Dc4Dd4De4C444D03D19D22D29D2cD32D3cD43D4bD53D58D5eD64D68D6eD78D87Cf60D95D96D97D98D99D9aD9bD9cD9dD9eDa4Da5Db3Db6DbcDbdDbeDc3Dc5Dc6DccDcdDceDd3Dd5Dd6DdcDe3De5De6DecDedDeeC333Cf40Db7DbbDddBf0C000Cf00D08D09D0aCfffC777D13D22D23D24D32D33D35D36D37D38D39D3aD3bD42D43D46D47D48D49D4cD4dD52D53D54D58D59D5aD5dD5eD62D63D6aD6bD6cD6dD72D7cD7dD7eD82D8eD92Da2Cf90D05C444Cf60D03D04D06D0cD0dD0eD14D15D16D17D18D19D1aD1bD1cD1dD1eD25D26D27D28D29D2aD2bD2cD2dD2eC333D34D3cD3dD44D4eD64D73D83D93Da3Cf40D07D0bB0fC000D12Cf00CfffC777D50D60D61D62D70D72D73D74D80D81D82D83D84D85D86D91D92D93D94D95D96D97Da3Da4Da5Da6Da7Da8Cf90C444Cf60D00D04D05D06D09D10D18D20D21D23D24D25D26D27C333D01D02D03D40D51D52D63D64D75D76D87D98Da9Cf40D07D08D11D13D14D15D16D17D22Nf0C000Da2Dd2Dd5Cf00CfffC777D42D52D60D61D65D71D73D74D83D85D86Cf90Da0Da5Da6Db7Dc8C444D40D50D53D62D63D72D75D84Cf60D90D91D93D94D95D96D97Da1Da3Da4Da7Da8Db0Db4Db5Db6Db8Db9Dc5Dc6Dc7Dc9Dd7Dd8Dd9De5De6De7De9C333Db1Db2Db3Dc0Dc4Dd0Dd4De0De4Cf40D92Dc1Dc2Dc3Dd1Dd3Dd6De1De2De3De8" {
	multiTool();
}
macro "Multitool Tool Options" {
	Dialog.createNonBlocking("Options");
	Dialog.addRadioButtonGroup("Main Tool : ", toolList, toolList.length,1, mainTool);
	Dialog.addCheckbox("middle click macro from clipboard", middleClick);
	Dialog.addCheckbox("live auto contrast?", live_autoContrast);
	Dialog.addSlider("%", 0, 0.5, enhance_rate);
	Dialog.addMessage("Magic Wand options :");
	Dialog.addNumber("roi size to target in pixels", nPixels);
	Dialog.addChoice("Fit selection? How?", newArray("None","Fit Spline","Fit Ellipse"), fit);
	Dialog.show();
	mainTool = Dialog.getRadioButton();
	middleClick =  Dialog.getCheckbox();
	live_autoContrast = Dialog.getCheckbox();
	enhance_rate = Dialog.getNumber();
	targetSize = Dialog.getNumber();
	fit = Dialog.getChoice();
}
//--------------------------------------------------------------------------------------------------------------------------------------
//------SHORTCUTS
//--------------------------------------------------------------------------------------------------------------------------------------
var ShortcutsMenu = newMenu("Custom Menu Tool",
	newArray("Fetch or pull StartupMacros", "BioFormats_Bar", "Numerical Keys Bar", "quick scale bar", "Note in infos", "correct copied path",
		 "-", "Rotate 90 Degrees Right","Rotate 90 Degrees Left", "Stack Difference", "make my LUTs",
		 "-","Gaussian Blur...","Gaussian Blur 3D...","Gamma...","Voronoi Threshold Labler (2D/3D)",
		 "-","test all Z project", "test CLAHE options", "test all calculator modes", "test main filters",
		 "-","Batch convert ims to tif","Batch Merge","Combine tool", "Merge tool","my Wand tool",
		 "-","Neuron (5 channels)", "Confocal Series", "Test image", "3 channels", "Brain stack",
		 "-","invertableLUTs_Bar","CB_Bar","LUT_Bar", "JeromesWheel","RGBtimeIsOver"));
macro "Custom Menu Tool - N55C000D1aD1bD1cD1dD29D2dD39D3dD49D4dD4eD59D5eD69D75D76D77D78D79D85D88D89D94D98D99Da4Da7Da8Da9Db3Db7Db8Dc3Dc6Dc7DccDcdDd3Dd6Dd8DdbDdcDe2De3De6De8De9DeaDebDecCfffD0dD3cD5cD6dD7bD8bD8cD96D9aD9bDa5DacDadDb5DcaDd4Dd9DdaDe4CdddD0aD1eD2bD6aD74D7aD95Dc4Dc5DeeC333D67D68DbeDd2DddCeeeD00D01D02D03D04D05D06D07D08D09D0eD10D11D12D13D14D15D16D17D18D20D21D22D23D24D25D26D27D30D31D32D33D34D35D36D37D3aD3bD40D41D42D43D44D45D46D47D4bD50D51D52D53D54D55D56D57D60D61D62D63D64D65D6eD70D71D72D73D80D81D82D83D86D8aD8dD90D91D92D97Da0Da1Da2Da6DaaDb0Db1DbbDc0Dc1Dc9Dd0Dd1De0De1C111D38D5bD6bD7dDabDbaDd7C999D4cD58D5aD5dD93DceDd5C777D0bD2eD4aD6cD7cD7eD9cD9dD9eDbdDc8C222D8eDa3DbcCcccD2cDdeDe7C666D19Db4DcbCbbbD0cD87DaeDb2C888D66De5C555D28D2aD84Dc2CaaaDb9DedC444D3eD48Db6Bf0C000D03D06D0cD13D16D1bD23D26D2aD33D37D39D43D44D47D48D54D65D76D77D87D88D89D8aD8bD8cD8dD8eD9bCfffD04D08D0dD0eD14D18D19D24D28D2cD35D3bD3cD3dD3eD45D46D4aD4bD4cD4eD56D57D5aD5bD5cD5dD5eD68D69D6aD6bD6cD6dD7cD7dCdddD1cD25D63D7eD97C333D99CeeeD00D01D07D10D11D1dD20D21D2eD30D31D40D41D42D4dD50D51D52D59D60D61D62D67D6eD70D71D72D73D74D79D7aD7bD80D81D82D83D84D85D90D91D92D93D94D95D96Da0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDacDadDaeC111D02D0bD36C999D1aD2bD58D9eC777D27D3aC222D64D66D9aCcccD09D17C666D12D38D78CbbbD0aD15D1eD2dD32D34C888D98C555D49D55D86D9cD9dCaaaD05D29D53C444D22D75B0fC000D02D03D04D05D08D09D18D27D28D36D37D45D46D54D55D63D64D71D72D80D81CfffD06D07D16D25D30D34D35D40D43D44D52D57D60D61D66D75D83D85CdddD10D22D32D33D42D74C333CeeeD0aD1aD21D29D2aD31D38D39D3aD48D49D4aD50D51D53D58D59D5aD67D68D69D6aD76D77D78D79D7aD84D86D87D88D89D8aD91D92D93D94D95D96D97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaC111C999D62D65C777D00C222D01D13D14D73CcccD11D26D90C666CbbbD12D15D19D20D23D24D41D82C888D47D56D70C555D17CaaaC444Nf0C000D33D34D35D36D42D43D46D50D51D55D64D65D66D67D73D74D78D88D96D97Da4Da5Db4Dc4Dd4Dd6Dd7Dd8De3De4De6De8De9CfffD15D31D44D53D54D58D62D84D85D86D92D93Da2Db2Dc2Dd2De7CdddD63Da1Da7Dc1Dd0De2C333D25D47D56D77Da0CeeeD00D01D02D03D04D05D06D07D08D09D0aD10D11D12D13D14D16D17D18D19D1aD20D21D22D27D28D29D2aD30D38D39D3aD48D49D4aD59D5aD69D6aD71D7aD82D8aD99D9aDa8Da9DaaDb1Db6Db7Db8Db9DbaDc9DcaDd1DdaDe0DeaC111C999D37D76D90Da6Db5Dc6Dc8Dd3C777D41D81D91D98Dc7De5C222D75D95Db3CcccD61D72D79D83D89Dc5Dd5Dd9De1C666D40D52D57CbbbD70D80D94C888D23D32D45Dc3C555D60D87Da3Db0CaaaD26Dc0C444D24D68" {
	cmd = getArgument(); 
	if 		(cmd=="Note in infos") 					Note_in_infos();
	else if (cmd=="Fetch or pull StartupMacros") 	fetchOrPullStartupMacros();
	else if (cmd=="correct copied path")			{copiedPath = replace(getString("paste your path", ""), "\\", "/");	print(copiedPath);}
	else if (cmd=="test CLAHE options") 			testCLAHE_options();
	else if (cmd=="test all Z project") 			test_All_Zprojections();
	else if (cmd=="Combine tool") 					{String.copy(File.openUrlAsString("https://git.io/JXvva")); installMacroFromClipboard();}
	else if (cmd=="Merge tool") 					{String.copy(File.openUrlAsString("https://git.io/JXoBT")); installMacroFromClipboard();}
	else if (cmd=="my Wand tool") 					{String.copy(File.openUrlAsString("https://raw.githubusercontent.com/kwolbachia/Imagej-macro-addiction/main/Yet_another_magic_wand.ijm")); installMacroFromClipboard();}
	else if (cmd=="invertableLUTs_Bar")				{run("Action Bar", File.openUrlAsString("https://git.io/JXoB2"));}
	else if (cmd=="CB_Bar") 						{run("Action Bar", File.openUrlAsString("https://git.io/JZUZw"));}
	else if (cmd=="LUT_Bar") 						{run("Action Bar", File.openUrlAsString("https://raw.githubusercontent.com/kwolbachia/Imagej-macro-addiction/main/LUT_Bar.ijm"));}
	else if (cmd=="BioFormats_Bar") 				{BioformatsBar();}
	else if (cmd=="Videos Bar") 					{videoBar();}
	else if (cmd=="Batch Merge") 					{batchMerge();}
	else if (cmd=="quick scale bar") 				{quickScaleBar();}
	else if (cmd=="cool 3D anim")					{Cool_3D_montage();}
	else if (cmd=="Numerical Keys Bar")				{numericalKeyboardBar();}
	// else if (cmd=="Brain slice")				    {open("https://i.imgur.com/IKUefAf.png");}
	// else if (cmd=="Microtubules")				    {open("https://i.imgur.com/YwlSveS.png");}
	else if (cmd=="Test image")				   		{open("https://i.imgur.com/psSX0UR.png");}	
	else if (cmd=="3 channels")				        {setBatchMode(1); open("https://i.imgur.com/MZGVdVj.png"); run("Make Composite"); Set_LUTs(); run("Remove Slice Labels"); setBatchMode(0);}
	else if (cmd=="test all calculator modes")		{testAllCaluclatorModes();}
	else if (cmd=="montage de LUTs Bar")			{montageLUTsBar();}
	else if (cmd=="Brain stack") 					{setBatchMode(1); open("https://i.imgur.com/DYIF55D.jpg"); run("Montage to Stack...", "columns=20 rows=18 border=0"); rename("brain"); setBatchMode(0);}
	else if (cmd=="test main filters")				{testFilters();}
	
	else run(cmd);
	call("ij.gui.Toolbar.setIcon", "Custom Menu Tool", "N55C000D1aD1bD1cD29D2dD39D3dD49D4dD4eD59D5eD69D79D99Da7Da8Da9Db3Db7Db8Dc7DccDcdDd8DdbDdcDe2De3De9DeaDebCcccD2cCa00D08D09D18D27D28D37D57D66D67D76D87D96D97Da5Db5Dc5Dd5De7CfffD3cD5cD6dD7bD8bD8cD9aD9bDacDadDcaDd9DdaC111D5bD6bD7dDabDbaCeeeD00D01D02D03D04D05D06D10D11D12D13D14D15D16D20D21D22D23D24D25D30D31D32D33D34D35D3aD3bD40D41D42D43D44D45D4bD50D51D52D53D54D55D60D61D62D63D64D6eD70D71D72D73D74D80D81D82D83D84D8aD8dD90D91D92Da0Da1Da2DaaDb0Db1DbbDc0Dc1Dc9Dd0Dd1De0De1Cb11DdeDedDeeCdddD2bD6aD7aCb00D07D0aD0bD0cD0dD0eD17D19D1dD1eD26D2eD36D38D3eD46D47D48D56D58D65D68D75D77D78D85D86D88D89D94D95D98Da4Da6Db4Db6Dc3Dc4Dc6DceDd3Dd4Dd6Dd7DddDe4De5De6De8DecC777D4aD6cD7cD7eD9cD9dD9eDbdDc8CaaaDb9Cb00C444C999D4cD5aD5dD93CbbbDaeDb2C333DbeDd2C888C666DcbC222D8eDa3DbcC555D2aDc2Bf0C000D03D13D16D23D26D33D37D43D44D47D48D54D65D76D77D87D88D89D8aD8bD8cD8dD8eD9bCcccCa00D07D0bD17CfffD14D24D35D3bD3cD3dD3eD45D46D4aD4bD4cD4eD56D57D5aD5bD5cD5dD5eD68D69D6aD6bD6cD6dD7cD7dC111D02D36CeeeD00D01D10D11D20D21D2eD30D31D40D41D42D4dD50D51D52D59D60D61D62D67D6eD70D71D72D73D74D79D7aD7bD80D81D82D83D84D85D90D91D92D93D94D95D96Da0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDacDadDaeCb11D0dD19D1dD29CdddD25D63D7eD97Cb00D04D05D06D08D09D0aD0cD0eD15D18D1aD1bD1cD1eD27D28D2aD2cD39C777D3aCaaaD53Cb00C444D22D75C999D2bD58D9eCbbbD2dD32D34C333D99C888D98C666D12D38D78C222D64D66D9aC555D49D55D86D9cD9dB0fC000D02D03D04D05D08D09D18D27D28D36D37D45D46D54D55D63D64D71D72D80D81CcccD11D26D90Ca00CfffD06D07D16D25D30D34D35D40D43D44D52D57D60D61D66D75D83D85C111CeeeD0aD1aD21D29D2aD31D38D39D3aD48D49D4aD50D51D53D58D59D5aD67D68D69D6aD76D77D78D79D7aD84D86D87D88D89D8aD91D92D93D94D95D96D97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaCb11CdddD10D22D32D33D42D74Cb00C777D00CaaaCb00C444C999D62D65CbbbD12D15D19D20D23D24D41D82C333C888D47D56D70C666C222D01D13D14D73C555D17Nf0C000D33D34D35D36D46D50D55D66D67D78D88D96D97Da5Db4Dc4Dd4Dd6Dd7Dd8De3De4De6De8De9CcccD79D89Dc5Dd5Dd9Ca00D20D30D41D65D74D84Da4Db1CfffD15D58D85D86De7C111CeeeD00D02D03D04D05D06D07D08D09D0aD12D13D14D16D17D18D19D1aD27D28D29D2aD38D39D3aD48D49D4aD59D5aD69D6aD7aD8aD99D9aDa8Da9DaaDb6Db7Db8Db9DbaDc9DcaDdaDeaCb11D42D52D54D63D64D73D83D93D94Da1Da3Db3Dc1Dc2Dc3Dd0Dd1De0De1CdddDa7De2Cb00D01D10D11D21D22D31D40D43D44D51D53D61D62D71D72D82D91D92Da2Db0Db2Dc0Dd2C777D81D98Dc7De5CaaaD26Cb00D32C444D24D68C999D37D76D90Da6Db5Dc6Dc8Dd3CbbbD70D80C333D25D47D56D77Da0C888D23D45C666D57C222D75D95C555D60D87");
 	wait(3000);
 	call("ij.gui.Toolbar.setIcon", "Custom Menu Tool", "N55C000D1aD1bD1cD1dD29D2dD39D3dD49D4dD4eD59D5eD69D75D76D77D78D79D85D88D89D94D98D99Da4Da7Da8Da9Db3Db7Db8Dc3Dc6Dc7DccDcdDd3Dd6Dd8DdbDdcDe2De3De6De8De9DeaDebDecCfffD0dD3cD5cD6dD7bD8bD8cD96D9aD9bDa5DacDadDb5DcaDd4Dd9DdaDe4CdddD0aD1eD2bD6aD74D7aD95Dc4Dc5DeeC333D67D68DbeDd2DddCeeeD00D01D02D03D04D05D06D07D08D09D0eD10D11D12D13D14D15D16D17D18D20D21D22D23D24D25D26D27D30D31D32D33D34D35D36D37D3aD3bD40D41D42D43D44D45D46D47D4bD50D51D52D53D54D55D56D57D60D61D62D63D64D65D6eD70D71D72D73D80D81D82D83D86D8aD8dD90D91D92D97Da0Da1Da2Da6DaaDb0Db1DbbDc0Dc1Dc9Dd0Dd1De0De1C111D38D5bD6bD7dDabDbaDd7C999D4cD58D5aD5dD93DceDd5C777D0bD2eD4aD6cD7cD7eD9cD9dD9eDbdDc8C222D8eDa3DbcCcccD2cDdeDe7C666D19Db4DcbCbbbD0cD87DaeDb2C888D66De5C555D28D2aD84Dc2CaaaDb9DedC444D3eD48Db6Bf0C000D03D06D0cD13D16D1bD23D26D2aD33D37D39D43D44D47D48D54D65D76D77D87D88D89D8aD8bD8cD8dD8eD9bCfffD04D08D0dD0eD14D18D19D24D28D2cD35D3bD3cD3dD3eD45D46D4aD4bD4cD4eD56D57D5aD5bD5cD5dD5eD68D69D6aD6bD6cD6dD7cD7dCdddD1cD25D63D7eD97C333D99CeeeD00D01D07D10D11D1dD20D21D2eD30D31D40D41D42D4dD50D51D52D59D60D61D62D67D6eD70D71D72D73D74D79D7aD7bD80D81D82D83D84D85D90D91D92D93D94D95D96Da0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDacDadDaeC111D02D0bD36C999D1aD2bD58D9eC777D27D3aC222D64D66D9aCcccD09D17C666D12D38D78CbbbD0aD15D1eD2dD32D34C888D98C555D49D55D86D9cD9dCaaaD05D29D53C444D22D75B0fC000D02D03D04D05D08D09D18D27D28D36D37D45D46D54D55D63D64D71D72D80D81CfffD06D07D16D25D30D34D35D40D43D44D52D57D60D61D66D75D83D85CdddD10D22D32D33D42D74C333CeeeD0aD1aD21D29D2aD31D38D39D3aD48D49D4aD50D51D53D58D59D5aD67D68D69D6aD76D77D78D79D7aD84D86D87D88D89D8aD91D92D93D94D95D96D97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaC111C999D62D65C777D00C222D01D13D14D73CcccD11D26D90C666CbbbD12D15D19D20D23D24D41D82C888D47D56D70C555D17CaaaC444Nf0C000D33D34D35D36D42D43D46D50D51D55D64D65D66D67D73D74D78D88D96D97Da4Da5Db4Dc4Dd4Dd6Dd7Dd8De3De4De6De8De9CfffD15D31D44D53D54D58D62D84D85D86D92D93Da2Db2Dc2Dd2De7CdddD63Da1Da7Dc1Dd0De2C333D25D47D56D77Da0CeeeD00D01D02D03D04D05D06D07D08D09D0aD10D11D12D13D14D16D17D18D19D1aD20D21D22D27D28D29D2aD30D38D39D3aD48D49D4aD59D5aD69D6aD71D7aD82D8aD99D9aDa8Da9DaaDb1Db6Db7Db8Db9DbaDc9DcaDd1DdaDe0DeaC111C999D37D76D90Da6Db5Dc6Dc8Dd3C777D41D81D91D98Dc7De5C222D75D95Db3CcccD61D72D79D83D89Dc5Dd5Dd9De1C666D40D52D57CbbbD70D80D94C888D23D32D45Dc3C555D60D87Da3Db0CaaaD26Dc0C444D24D68");
}

macro "Stacks Menu Built-in Tool" {}
// macro "Developer Menu Built-in Tool" {}

//--------------------------------------------------------------------------------------------------------------------------------------
//------ALL OPENED TOOLS
//--------------------------------------------------------------------------------------------------------------------------------------
var ACmds = newMenu("All opened images Menu Tool",
	newArray("Reset all contrasts","Set all LUTs","Convert decon32 to 8-bit", "Z projection all","Save all elsewhere", "Basic save all"));
macro "All opened images Menu Tool - N55C000D0dD0eD1dD1eD2dD3dD3eD4dD4eD59D5aD5bD5dD5eD6bD6dD6eD73D77D78D79D7bD7dD83D84D85D88D8bD8dD8eD94D99D9dD9eDa3Da6Da8Da9DadDaeDb3Db8Db9Dc3Dc6Dc8Dc9DcdDd4Dd9DdbDdcDddDe3De4De5De8DebDecDedC4cfCe16D74D75D76D86D87D89D93D95D96D97D98Da4Da5Da7Db4Db5Db6Db7Dc4Dc5Dc7Dd3Dd5Dd6Dd7Dd8De6De7De9CfffD0cD1cD2cD3cD48D49D4aD4bD4cD58D5cD62D63D64D65D66D67D68D69D6aD6cD72D7aD7cD82D8aD8cD92D9aD9cDa2DaaDacDb2DbaDbcDbdDbeDc2DcaDceDd2DdaDdeDe1De2DeaDeeCeeeD00D01D02D03D04D05D06D07D08D09D0aD0bD10D11D12D13D14D15D16D17D18D19D1aD1bD20D21D22D23D24D25D26D27D28D29D2aD2bD30D31D32D33D34D35D36D37D38D39D3aD3bD40D41D42D43D44D45D46D47D50D51D52D53D54D55D56D57D60D61D70D71D80D81D90D91Da0Da1Db0Db1Dc0Dc1Dd0Dd1De0Cfe3D9bDabDbbDcbDccCc15C4deC8c4D2eD7eBf0C000D03D07D08D09D13D14D15D16D17D18D19D1dD1eD2eD32D34D35D36D3dD42D45D46D4dD52D55D56D5dD62D63D64D65D66D6eD72D73D74D75D76D7dD7eD8dD8eC4cfD33D43D44D53D54Ce16D04D05D06CfffD01D02D0aD0bD0cD0dD0eD11D12D1aD1cD21D22D23D24D25D26D27D28D29D2aD2cD31D37D3cD41D47D4cD51D57D5cD61D67D6cD71D77D7cD81D82D83D84D85D86D87D8cD9cD9dD9eCeeeD00D10D1bD20D2bD30D38D39D3aD3bD40D48D49D4aD4bD50D58D59D5aD5bD60D68D69D6aD6bD70D78D79D7aD7bD80D88D89D8aD8bD90D91D92D93D94D95D96D97D98D99D9aD9bDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDacDadDaeCfe3Cc15C4deD2dD3eD4eD5eD6dC8c4B0fC000D00D01D02D03D04D05D10D11D12D15D23D24D25D35D43D44D45D55D63D64D65D70D71D72D75D80D81D82D83D84D85C4cfCe16CfffD06D16D26D36D46D56D66D76D86D90D91D92D93D94D95D96CeeeD07D08D09D0aD17D18D19D1aD27D28D29D2aD37D38D39D3aD47D48D49D4aD57D58D59D5aD67D68D69D6aD77D78D79D7aD87D88D89D8aD97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaCfe3Cc15D31D51C4deD13D14D20D21D22D30D32D33D34D40D41D42D50D52D53D54D60D61D62D73D74C8c4Nf0C000D00D01D02D05D06D07D10D11D14D15D16D17D20D25D27D32D36D37D40D45D46D47D50D55D56D57D62D66D67D70D75D77D80D81D84D85D86D87D90D91D92D95D96D97Da0Da1Da2Da3Da4Da5Da6Da7C4cfCe16CfffD08D18D28D38D48D58D68D78D88D98Da8Db0Db1Db2Db3Db4Db5Db6Db7Db8De0De1De2De3De4De5De6CeeeD09D0aD19D1aD29D2aD39D3aD49D4aD59D5aD69D6aD79D7aD89D8aD99D9aDa9DaaDb9DbaDc0Dc1Dc2Dc3Dc4Dc5Dc6Dc7Dc8Dc9DcaDd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7Dd8Dd9DdaDe7De8De9DeaCfe3Cc15C4deC8c4D03D04D12D13D21D22D23D24D26D30D31D33D34D35D41D42D43D44D51D52D53D54D60D61D63D64D65D71D72D73D74D76D82D83D93D94"{
	cmd = getArgument();
	if 		(cmd=="Set LUTs") 				{ Ask_LUTs(); SetAllLUTs();}
	else if (cmd=="Reset all contrasts") 	{ Reset_All_Contrasts();}
	else if (cmd=="Save all elsewhere") 	{ Save_all_opened_images_elsewhere();}
	else if (cmd=="Basic save all") 		{ Basic_save_all();}
	else if (cmd=="Z projection all") 		{ Z_project_all();}
	else if (cmd=="Set all LUTs") 			{ Ask_LUTs(); SetAllLUTs();}
	else if (cmd=="Convert decon32 to 8-bit") { decon32_to_8bit();}
	else run(cmd);	}

//--------------------------------------------------------------------------------------------------------------------------------------
//------POPUP
//--------------------------------------------------------------------------------------------------------------------------------------
var pmCmds = newMenu("Popup Menu",
	newArray("Remove Overlay", "Rename...", "Duplicate...","Set LUTs","Set active path", "rajout de bout","Copy to System",
	 "-", "CLAHE", "gauss correction", "color blindness","rgb LUT to LUT", "rotate LUT",
	 "-", "Record...", "Monitor Memory...","Control Panel...", "Startup Macros..."));
macro "Popup Menu" {
	cmd = getArgument(); 
	if 		(cmd=="CLAHE") CLAHE();
	else if (cmd=="Set active path") SetActivePath();
	else if (cmd=="gauss correction") gaussCorrection();
	else if (cmd=="color blindness") {rgbSnapshot(); run("Dichromacy", "simulate=Deuteranope");}
	else if (cmd=="Set LUTs") {Ask_LUTs(); Set_LUTs();}
	else if (cmd=="Luminance") rgb2Luminance();
	else if (cmd=="copy paste LUT set") copyPasteLUTset();
	else if (cmd=="rotate LUT") rotateLUT();
	else if (cmd=="rgb LUT to LUT") rgbLUT_ToLUT();
	else run(cmd); 
}

macro "LUT Menu Built-in Tool" {}

// macro "Preview Opener Tool - N66C000D34D35D36D37D38D39D3aD3bD3cD3dD3eD44D49D4eD54D59D5eD64D69D6eD74D79D7eD84D85D86D87D88D89D8aD8bD8cD8dD8eD94D99D9eDa4Da9DaeDb4Db9DbeDc4Dc9DceDd4Dd5Dd6Dd7Dd8Dd9DdaDdbDdcDddDdeDe4De9DeeC95fD4aD4bD4cD4dD5aD5bD5cD5dD6aD6bD6cD6dD7aD7bD7cD7dC09bC5ffCf05Cf85C8bfDeaDebDecDedCfc0D9aD9bD9cD9dDaaDabDacDadDbaDbbDbcDbdDcaDcbDccDcdCf5bCaf8Cfb8Ccf8D95D96D97D98Da5Da6Da7Da8Db5Db6Db7Db8Dc5Dc6Dc7Dc8Cf5dDe5De6De7De8C8fdCfa8D45D46D47D48D55D56D57D58D65D66D67D68D75D76D77D78Bf0C000D04D09D0eD14D19D1eD24D29D2eD34D35D36D37D38D39D3aD3bD3cD3dD3eD44D49D4eD54D59D5eD64D69D6eD74D79D7eD84D85D86D87D88D89D8aD8bD8cD8dD8eC95fC09bC5ffCf05Cf85D45D46D47D48D55D56D57D58D65D66D67D68D75D76D77D78C8bfD0aD0bD0cD0dD1aD1bD1cD1dD2aD2bD2cD2dCfc0Cf5bCaf8Cfb8Ccf8Cf5dD05D06D07D08D15D16D17D18D25D26D27D28C8fdD4aD4bD4cD4dD5aD5bD5cD5dD6aD6bD6cD6dD7aD7bD7cD7dCfa8B0fC000D03D07D13D17D23D27D30D31D32D33D34D35D36D37D43D47D53D57D63D67D73D77D80D81D82D83D84D85D86D87C95fC09bC5ffCf05Cf85C8bfCfc0D44D45D46D54D55D56D64D65D66D74D75D76Cf5bD04D05D06D14D15D16D24D25D26Caf8Cfb8D40D41D42D50D51D52D60D61D62D70D71D72Ccf8Cf5dC8fdD00D01D02D10D11D12D20D21D22Cfa8Nf0C000D30D31D32D33D34D35D36D37D43D47D53D57D63D67D73D77D80D81D82D83D84D85D86D87D93D97Da3Da7Db3Db7Dc3Dc7Dd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7De3De7C95fC09bD94D95D96Da4Da5Da6Db4Db5Db6Dc4Dc5Dc6C5ffD40D41D42D50D51D52D60D61D62D70D71D72Cf05D90D91D92Da0Da1Da2Db0Db1Db2Dc0Dc1Dc2Cf85C8bfCfc0Cf5bDe4De5De6Caf8D44D45D46D54D55D56D64D65D66D74D75D76Cfb8Ccf8Cf5dC8fdDe0De1De2Cfa8"{
// 	title = getTitle();
// 	if (startsWith(title, "Preview Opener")) openFromPreview();
// 	else setTool(0);
// }
// macro "Preview Opener Tool Options"{ if (!isOpen("Preview Opener.tif")) makePreviewOpener();}
macro "Preview Opener Action Tool - N66C000D34D35D36D37D38D39D3aD3bD3cD3dD3eD44D49D4eD54D59D5eD64D69D6eD74D79D7eD84D85D86D87D88D89D8aD8bD8cD8dD8eD94D99D9eDa4Da9DaeDb4Db9DbeDc4Dc9DceDd4Dd5Dd6Dd7Dd8Dd9DdaDdbDdcDddDdeDe4De9DeeC95fD4aD4bD4cD4dD5aD5bD5cD5dD6aD6bD6cD6dD7aD7bD7cD7dC09bC5ffCf05Cf85C8bfDeaDebDecDedCfc0D9aD9bD9cD9dDaaDabDacDadDbaDbbDbcDbdDcaDcbDccDcdCf5bCaf8Cfb8Ccf8D95D96D97D98Da5Da6Da7Da8Db5Db6Db7Db8Dc5Dc6Dc7Dc8Cf5dDe5De6De7De8C8fdCfa8D45D46D47D48D55D56D57D58D65D66D67D68D75D76D77D78Bf0C000D04D09D0eD14D19D1eD24D29D2eD34D35D36D37D38D39D3aD3bD3cD3dD3eD44D49D4eD54D59D5eD64D69D6eD74D79D7eD84D85D86D87D88D89D8aD8bD8cD8dD8eC95fC09bC5ffCf05Cf85D45D46D47D48D55D56D57D58D65D66D67D68D75D76D77D78C8bfD0aD0bD0cD0dD1aD1bD1cD1dD2aD2bD2cD2dCfc0Cf5bCaf8Cfb8Ccf8Cf5dD05D06D07D08D15D16D17D18D25D26D27D28C8fdD4aD4bD4cD4dD5aD5bD5cD5dD6aD6bD6cD6dD7aD7bD7cD7dCfa8B0fC000D03D07D13D17D23D27D30D31D32D33D34D35D36D37D43D47D53D57D63D67D73D77D80D81D82D83D84D85D86D87C95fC09bC5ffCf05Cf85C8bfCfc0D44D45D46D54D55D56D64D65D66D74D75D76Cf5bD04D05D06D14D15D16D24D25D26Caf8Cfb8D40D41D42D50D51D52D60D61D62D70D71D72Ccf8Cf5dC8fdD00D01D02D10D11D12D20D21D22Cfa8Nf0C000D30D31D32D33D34D35D36D37D43D47D53D57D63D67D73D77D80D81D82D83D84D85D86D87D93D97Da3Da7Db3Db7Dc3Dc7Dd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7De3De7C95fC09bD94D95D96Da4Da5Da6Db4Db5Db6Dc4Dc5Dc6C5ffD40D41D42D50D51D52D60D61D62D70D71D72Cf05D90D91D92Da0Da1Da2Db0Db1Db2Dc0Dc1Dc2Cf85C8bfCfc0Cf5bDe4De5De6Caf8D44D45D46D54D55D56D64D65D66D74D75D76Cfb8Ccf8Cf5dC8fdDe0De1De2Cfa8"{
	if (!isOpen("Preview Opener.tif")) makePreviewOpener();
}

macro "set LUT from montage Tool - N55C000D37D38D39CfffD00D01D02D03D04D05D06D07D08D09D0aD0bD0cD0dD0eD10D11D12D13D14D15D16D17D18D19D1aD1bD1cD1dD1eD20D21D22D23D24D25D26D27D28D29D2aD2bD2cD2dD2eD30D31D32D36D3aD3eD40D41D42D46D4aD4eD50D51D52D56D5aD5eD60D61D62D66D6aD6eD70D71D72D76D7aD7eD80D81D82D86D8aD8eD90D91D92D96D9aD9eDa0Da1Da2Da6DaaDaeDb0Db1Db2Db6DbaDbeDc0Dc1Dc2Dc6DcaDceDd0Dd1Dd2Dd6DdaDdeDe0De1De2De6DeaDeeC338C047Db7Db8Db9C557D73D74D75D83D84D85C500D5bD5cD5dC198Ce50Cb87C024D77D78D79C278Cd51DdbDdcDddC438Cb00D9bD9cD9dC18cCfb3Cda7C100D3bD3cD3dC158Dd7Dd8Dd9C157Dc7Dc8Dc9C877Db3Db4Db5Dc3Dc4Dc5C900C3b7Ce82Cc97C013D33D34D35C17aCaf3C448Cd30DbbDbcDbdC1dcCfb4Cfd8C012D57D58D59C358C347D53D54D55C667D93D94D95C800D7bD7cD7dC2a8Ce71DebDecDedC49fC035D97D98D99C288Ccd1Ca87De3De4De5Cb10C19dCee1Cfb7C300D4bD4cD4dC368C8d4C977Dd3Dd4Dd5C427C1eaCfa3Cd97C406C18bCce3C47fCd40DcbDccDcdC1afCfc6CfebC011D47D48D49C457D63D64D65C247D43D44D45C600D6bD6cD6dC298Cf61C4f7C034D87D88D89C169De7De8De9C9d3Cc00DabDacDadC19dCed3Cea7C022D67D68D69C268C6c5Ca00D8bD8cD8dC4b7Cf92C045Da7Da8Da9C8f5C46dC2ceCfb5C667Da3Da4Da5Bf0C000CfffD00D01D02D06D0aD0eD10D11D12D16D1aD1eD20D21D22D26D2aD2eD30D31D32D36D3aD3eD40D41D42D46D4aD4eD50D51D52D56D5aD5eD60D61D62D66D6aD6eD70D71D72D76D7aD7eD80D81D82D83D84D85D86D87D88D89D8aD8bD8cD8dD8eD90D91D92D93D94D95D96D97D98D99D9aD9bD9cD9dD9eDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDacDadDaeC338C047C557C500C198Ce50Cb87D13D14D15C024C278Cd51C438Cb00C18cD37D38D39Cfb3Cda7D43D44D45C100C158C157C877C900C3b7Ce82D0bD0cD0dCc97D23D24D25C013C17aD07D08D09D17D18D19Caf3C448Cd30C1dcCfb4D2bD2cD2dCfd8D5bD5cD5dC012C358C347C667C800C2a8Ce71C49fC035C288Ccd1Ca87D03D04D05Cb10C19dD57D58D59Cee1Cfb7D63D64D65D73D74D75C300C368C8d4C977C427C1eaCfa3Cd97D33D34D35C406C18bD27D28D29Cce3C47fCd40C1afD67D68D69D77D78D79Cfc6D4bD4cD4dCfebD6bD6cD6dD7bD7cD7dC011C457C247C600C298Cf61C4f7C034C169C9d3Cc00C19dD47D48D49Ced3Cea7D53D54D55C022C268C6c5Ca00C4b7Cf92D1bD1cD1dC045C8f5C46dC2ceCfb5D3bD3cD3dC667B0fC000CfffD03D07D08D09D0aD13D17D18D19D1aD23D27D28D29D2aD33D37D38D39D3aD43D47D48D49D4aD53D57D58D59D5aD63D67D68D69D6aD73D77D78D79D7aD80D81D82D83D84D85D86D87D88D89D8aD90D91D92D93D94D95D96D97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaC338C047C557C500C198Ce50D30D31D32Cb87C024C278Cd51C438Cb00C18cCfb3D00D01D02Cda7C100C158C157C877C900D60D61D62D70D71D72C3b7D04D05D06Ce82Cc97C013C17aCaf3C448Cd30D40D41D42C1dcCfb4Cfd8C012C358C347C667C800C2a8Ce71C49fC035C288Ccd1D54D55D56Ca87Cb10D50D51D52C19dCee1D64D65D66D74D75D76Cfb7C300C368C8d4D34D35D36C977C427C1eaCfa3D10D11D12Cd97C406C18bCce3C47fCd40C1afCfc6CfebC011C457C247C600C298Cf61D20D21D22C4f7C034C169C9d3D44D45D46Cc00C19dCed3Cea7C022C268C6c5D24D25D26Ca00C4b7D14D15D16Cf92C045C8f5C46dC2ceCfb5C667Nf0C000CfffD00D01D02D03D04D05D06D07D08D09D0aD10D11D12D13D14D15D16D17D18D19D1aD20D21D22D23D24D25D26D27D28D29D2aD33D37D38D39D3aD43D47D48D49D4aD53D57D58D59D5aD63D67D68D69D6aD73D77D78D79D7aD83D87D88D89D8aD93D97D98D99D9aDa3Da7Da8Da9DaaDb3Db7Db8Db9DbaDc3Dc7Dc8Dc9DcaDd3Dd7Dd8Dd9DdaDe3De7De8De9DeaC338D30D31D32C047C557C500C198Dd4Dd5Dd6Ce50Cb87C024C278Da4Da5Da6Cd51C438D54D55D56Cb00C18cCfb3Cda7C100C158C157C877C900C3b7Ce82Cc97C013C17aCaf3Dc0Dc1Dc2C448D64D65D66Cd30C1dcD80D81D82Cfb4Cfd8C012C358D74D75D76C347C667C800C2a8De4De5De6Ce71C49fD60D61D62C035C288Db4Db5Db6Ccd1Ca87Cb10C19dCee1Cfb7C300C368D84D85D86C8d4C977C427D44D45D46C1eaD90D91D92Cfa3Cd97C406D34D35D36C18bCce3Dd0Dd1Dd2C47fD50D51D52Cd40C1afCfc6CfebC011C457C247C600C298Dc4Dc5Dc6Cf61C4f7Da0Da1Da2C034C169C9d3Cc00C19dCed3De0De1De2Cea7C022C268D94D95D96C6c5Ca00C4b7Cf92C045C8f5Db0Db1Db2C46dD40D41D42C2ceD70D71D72Cfb5C667" 	{
	// setLutFromMontageTool();
	setLUTfromMontage();
}
macro "set LUT from montage Tool Options" {	displayLUTs();}

//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------

//CHANNELS

 macro "results to label [F2]"{ result2label();}

macro "myTurbo 	[n0]"{ if (isKeyDown("space")) setFavoriteLUT();	else if (isKeyDown("alt")) convertTo_iMQ_Style(); else pasteFavoriteLUT();}
macro "Gray 	[n1]"{ if (isKeyDown("space")) toggleChannel(1); 	else if (isKeyDown("alt")) toggleAllchannels(1); else run("Grays");}
macro "Green 	[n2]"{ if (isKeyDown("space")) toggleChannel(2); 	else if (isKeyDown("alt")) toggleAllchannels(2); else run("kg");	}
macro "Red 		[n3]"{ if (isKeyDown("space")) toggleChannel(3); 	else if (isKeyDown("alt")) toggleAllchannels(3); else run("Red");	}
macro "Bop 		[n4]"{ if (isKeyDown("space")) toggleChannel(4); 	else if (isKeyDown("alt")) toggleAllchannels(4); else run("kb");	}
macro "boP 		[n5]"{ if (isKeyDown("space")) toggleChannel(5); 	else if (isKeyDown("alt")) toggleAllchannels(5); else run("km");	}
macro "bOp 		[n6]"{ if (isKeyDown("space")) toggleChannel(6); 	else if (isKeyDown("alt")) toggleAllchannels(6); else run("ko");	}
macro "Cyan		[n7]"{ if (isKeyDown("space")) toggleChannel(7);	else if (isKeyDown("alt")) toggleAllchannels(7); else run("Cyan");	}
macro "Magenta 	[n8]"{ if (isKeyDown("space")) run("8-bit"); 		else run("Magenta");	}
macro "Yellow 	[n9]"{ if (isKeyDown("space")) run("glasbey_on_dark");	else run("Yellow");}

macro "difference_of_gaussian 	[n*]"{ DoG();}

//--------------------------------------------------------------------------------------------------------------------------------------
//NOICE TOOLS
macro "ClearVolume	     [0]"	{if (isKeyDown("space")) fauteDeClearVolume();  else run("Open in ClearVolume");}
macro "my default LUTs   [1]"	{if (isKeyDown("space")) SetAllLUTs(); 			else if (isKeyDown("alt")) perso_Ask_LUTs(); 		else Set_LUTs();}
macro "good size  		 [2]"	{if (isKeyDown("space")) restorePosition(); 	else if (isKeyDown("alt")) fullScreen();		else goodSize();}
macro "3D Zproject++     [3]"	{if (isKeyDown("space")) Cool_3D_montage();		else my3D_project();}
macro "full scale montage[4]"	{if (isKeyDown("space")) run("Montage to Stack..."); 	else run("Make Montage...", "scale=1"); setOption("Changes", 0);}
macro "25x25 selection   [5]"	{if (isKeyDown("space")) makeRectangle(0,0,75,200); else {size=25; toUnscaled(size); size = round(size); getCursorLoc(x, y, null, null); call("ij.IJ.makeRectangle",x-(size/2),y-(size/2),size,size); showStatus(size+"x"+size);}}
macro "make it look good [6]"	{for (i=0; i<nImages; i++) { setBatchMode(1); selectImage(i+1); run("Appearance...", "  "); run("Appearance...", "black no"); setBatchMode(0);}}
macro "set destination   [7]" 	{if (isKeyDown("space")) { showStatus("Source set");	run("Alert ", "object=Image color=Orange duration=1000"); source = getTitle();} else if (isKeyDown("alt")) setCustomPosition(); else setTargetImage();}
macro "rename w/ id      [8]"	{if (isKeyDown("space")) rename(getImageID()); else run("Rename...");}
macro "coolify      	 [9]"	{if (isKeyDown("space")) saveAs("tif", getDirectory("temp")+"temp.tif"); else open(getDirectory("temp")+"temp.tif");}

// Set_noice_LUTs();
macro "selections [a]"	{ if (isKeyDown("alt"))		run("Select None");	  			else if (isKeyDown("space")) run("Restore Selection");	else run("Select All"); }
macro "auto 	  [A]"	{ if (isKeyDown("alt"))		Enhance_all_contrasts();	  	else if (isKeyDown("space")) Enhance_on_all_channels();	else {run("Enhance Contrast", "saturated=0.03"); call("ij.plugin.frame.ContrastAdjuster.update");}}
macro "Splitview  [b]"	{ if (isKeyDown("alt")) Property.set("CompositeProjection", "Invert"); else if (isKeyDown("space")) 	SplitView(0,2,0);				else 	SplitView(1,2,0); }
macro "iComposite [B]"	{ switchCompositeMode();}
marco "copy       [c]"	{ if (isKeyDown("alt")) run("Copy to System"); else run("Copy");}
macro "b&c 		  [C]"  { B_and_C(); }
macro "duplicat	  [D]"	{ if (isKeyDown("space")) memoryAndRecorder();				else run("Duplicate...", "duplicate");}
macro "Spliticate [d]"	{ if (isKeyDown("space"))	run("Duplicate...", " ");	 	else if (isKeyDown("alt")) {Stack.getPosition(ch, slice, frame); run("Duplicate...", "duplicate channels=&ch frames=&frame");}	else run("Split Channels");}
macro "Tile 	  [E]"	{ 	myTile();}
macro "edit lut   [e]"	{ if (isKeyDown("alt")) run("Edit LUT...");					else if (isKeyDown("space"))	seeAllLUTs();							else 	plotLUT();}
macro "toolSwitch [F]"	{ toolRoll();}
macro "gammaLUT	  [f]"	{ if (isKeyDown("alt")) run("Gaussian Blur 3D...", "x=1 y=1 z=1"); else if (isKeyDown("space")) setGammaLUTAllch(0.7);	else run("Gamma...");}
macro "Max 		  [G]"	{ if (isKeyDown("space"))	Z_project_all();				else if (isKeyDown("alt")) run("Z Project...", "projection=[Sum Slices] all"); else run("Z Project...", "projection=[Max Intensity] all");}
macro "Z Project  [g]"	{ if (isKeyDown("alt"))		test_All_Zprojections();		else if (isKeyDown("space")) fastColorCode("current");					else	run("Z Project...");}
macro "show all   [H]"	{ run("Show All");}
macro "overlay I  [i]"	{ if (isKeyDown("space"))	invertedOverlay3(); 			else if (isKeyDown("alt")) run("Invert LUT");	 				else 	{if      (Property.get("CompositeProjection") == "Sum") Property.set("CompositeProjection", "composite"); run("Invert LUTs");}}
macro "New Macro  [J]"	{ 	run("Input/Output...", "jpeg=100"); saveAs("Jpeg");}
macro "JPEG		  [j]"  { if (isKeyDown("space")) run("Text Window...", "name=poil width=40 height=7 menu"); else run("Macro");}
macro "multiplot  [k]"  { if (isKeyDown("alt")) multiPlot_Zaxis(); 					else multiPlot();}
macro "Cmd finder [l]"	{ if (isKeyDown("alt")) run("Action Bar", File.openUrlAsString("https://raw.githubusercontent.com/kwolbachia/Imagej-macro-addiction/main/LUT_Bar.ijm")); else if (isKeyDown("space"))	ultimateLUTgenerator(); else 	run("Find Commands...");}
macro "Copy paste [L]"  { if (isKeyDown("space")) rgbLUT_ToLUT(); else copyPasteLUTset();}
macro "Merge 	  [M]"	{ if (isKeyDown("space")) run("Merge Channels..."); 		else 	fastMerge();} 
macro "LUT baker  [m]"	{	LUTbaker();}
macro "Hela       [n]"	{ if (isKeyDown("space")) {cul = 0; if(nImages>0) {if(bitDepth()!=24) {getLut(r,g,b); cul=1;}} newImage("lut"+round(random*100), "8-bit ramp", 256, 32, 1); if(cul) setLut(r,g,b);} else Hela();}
macro "open paste [o]"	{ if ( nImages!=0) { if (startsWith(getTitle(), "Preview Opener")) openFromPreview();  else if (startsWith(getTitle(), "Lookup Tables")) setLUTfromMontage();} else open(String.paste);}
macro "Splitview  [p]"	{ if (isKeyDown("space")) 	SplitView(0,1,0); 				else 	SplitView(0,0,0); }
macro "composite  [Q]" 	{ compositeSwitch();	}
macro "Arrange ch [q]"	{ if (isKeyDown("alt"))	doCommand("Start Animation [\\]");  else if (isKeyDown("space"))	ReorderLUTsAsk(); 						else 	run("Arrange Channels...");}
macro "Adjust 	  [R]"	{ if (isKeyDown("space"))	Reset_All_Contrasts(); 			else if (isKeyDown("alt")) propagateContrast();							else	Auto_Contrast_on_all_channels();}
macro "r 	 	  [r]"	{ if (isKeyDown("alt"))		reduceMax();	 				else if (isKeyDown("space")) {run("Install...","install=["+getDirectory("macros")+"/StartupMacros.fiji.ijm]"); setTool(15);}	else Adjust_Contrast();}
macro "Splitview  [S]"	{ if (isKeyDown("alt"))   	getSplitViewPrefs();			else if (isKeyDown("space")) SplitView(1,0,0); 							else SplitView(1,1,0); }
macro "as tiff 	  [s]"	{ if (isKeyDown("space"))	ultimateSplitview(); 			else if (isKeyDown("alt")) { Save_all_opened_images_elsewhere();} 		else saveAs("Tiff");}
macro "test.ijm   [t]"	{ if (isKeyDown("alt"))		installMacroFromClipboard();	else if (isKeyDown("space")) run("Action Bar", String.paste);			else eval(String.paste);}
macro "rgb color  [u]"  { if (isKeyDown("space"))	myRGBconverter(); 				else if (isKeyDown("alt"))	RedGreen2OrangeBlue(); 						else 	switcher(); }
macro "pasta	  [v]"	{ if (isKeyDown("space"))	run("System Clipboard");		else if (isKeyDown("alt"))	open(getDirectory("temp")+"/copiedLut.lut");else 	run("Paste");}
macro "roll & FFT [x]"  { if (isKeyDown("space"))	channelsRoll();					else if (isKeyDown("alt"))	{run("Copy to System");	showStatus("copy to system");}		else	copyLUT(); }
macro "sync 	  [y]"	{ 	run("Synchronize Windows");}
macro "close      [w]"  { if (isKeyDown("space")) open(call("ij.Prefs.get","last.closed","")); else if (isKeyDown("alt")) close("\\Others"); else {path = getDirectory("image") + getTitle(); if (File.exists(path)) call("ij.Prefs.set","last.closed",path); close();}} //avoid "are you sure?" and stores path in case of misclick

// macro "test Tool - C000 T0508T  T5508e  Ta508s Tg508t"{
// }

function testFilters() {
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

//difference of gaussian
function DoG(){
	Dialog.createNonBlocking("DoG 2D");
	Dialog.addSlider("sigma 1", 0, 5, 1);
	Dialog.addSlider("sigma 2", 0, 20, 2);
	Dialog.show();
	sigma1 = Dialog.getNumber();
	sigma2 = Dialog.getNumber();
	run("CLIJ2 Macro Extensions","cl_device=");
	// difference of gaussian
	image1 = getTitle();
	Ext.CLIJ2_push(image1);
	image2 = "difference_of_gaussian_" + image1;
	Ext.CLIJ2_differenceOfGaussian2D(image1, image2, sigma1, sigma1, sigma2, sigma2);
	Ext.CLIJ2_pull(image2);
}

function videoBar(){
	video_Bar = 
	"<fromString>"+"\n"+
	"<stickToImageJ>"+"\n"+
	"<noGrid>"+"\n"+
	"<title> LUTs\n"+
	"<line>"+"\n"+
	"<separator>"+"\n"+
	"<text> import video"+"\n"+
	"<separator>"+"\n"+
	"<button>"+"\n"+
	"label= X "+"\n"+
	"bgcolor=orange"+"\n"+
	"arg=<close>"+"\n"+
	"</line>"+"\n"+
	"<DnDAction>"+"\n"+
	"path = getArgument();"+"\n"+
	"run('Movie (FFMPEG)...', 'choose='+ path +' first_frame=0 last_frame=-1');\n"+
	"</DnDAction>\n";
	run("Action Bar",video_Bar);
}

function montageLUTsBar(){
	text = "<fromString>\n"+
	"<stickToImageJ>"+"\n"+
	"<noGrid>\n"+
	"<line>\n"+
	"<title> LUTs\n"+
	"<text>drop a directory of LUTs\n"+
	"<separator>"+"\n"+
	"<button>"+"\n"+
	"label= X "+"\n"+
	"bgcolor=orange"+"\n"+
	"arg=<close>"+"\n"+
	"</line>\n"+
	"<DnDAction>\n"+
	"	saveSettings();\n"+
	"	lutdir = getArgument() + File.separator;\n"+
	"	list = getFileList(lutdir);\n"+
	"	setBatchMode(true);\n"+
	"	newImage('ramp', '8-bit Ramp', 256, 32, 1);\n"+
	"	newImage('luts', 'RGB White', 256, 48, 1);\n"+
	"	count = 0;\n"+
	"	setForegroundColor(255, 255, 255);\n"+
	"	setBackgroundColor(255, 255, 255);\n"+
	"	for (i=0; i<list.length; i++) {\n"+
	"		if (endsWith(list[i], '.lut')) {\n"+
	"			selectWindow('ramp');\n"+
	"			open(lutdir+list[i]);\n"+
	"		}\n"+
	"		else if (endsWith(list[i], '.tif')) {\n"+
	"			open(lutdir+list[i]);\n"+
	"			getLut(reds, greens, blues);\n"+
	"			selectWindow('ramp');\n"+
	"			setLut(reds, greens, blues);\n"+
	"		}\n"+
	"		run('Copy');\n"+
	"		selectWindow('luts');\n"+
	"		makeRectangle(0, 0, 256, 32);\n"+
	"		run('Paste');\n"+
	"		setJustification('center');\n"+
	"		setColor(0,0,0);\n"+
	"		setFont('SansSerif', 11, 'antialiased');\n"+
	"		drawString(list[i], 128, 48);\n"+
	"		run('Add Slice');\n"+
	"		run('Select All');\n"+
	"		run('Clear', 'slice');\n"+
	"		count++;\n"+
	"	}\n"+
	"	run('Delete Slice');\n"+
	"	rows = floor(count/4);\n"+
	"	if (rows<count/4) rows++;\n"+
	"	run('Canvas Size...', 'width=258 height=50 position=Center');\n"+
	"	run('Make Montage...', 'columns=4 rows='+rows+' scale=1 first=1 last='+count+' increment=1 border=0 use');\n"+
	"	rename('Lookup Tables');\n"+
	"	setBatchMode(false);\n"+
	"	restoreSettings();\n"+
	"</DnDAction>\n";
	run("Action Bar", text);
}

function numericalKeyboardBar(){
	text = "<fromString>\n"+
	"<title> LUTs\n"+
	"<disableAltClose> \n"+"<line>\n"+"<text>numbers\n"+"<button>\n"+"label=7\n"+"bgcolor=#8fadda\n"+"arg=run('Cyan		[n7]')\n"+"<button>\n"+"label=8\n"+"bgcolor=#ffd900\n"+"arg=run('Magenta 	[n8]');\n"+"<button>\n"+"label=9\n"+"bgcolor=#b57ad6\n"+"arg=run('Yellow 	[n9]');\n"+"</line>\n"+
	"<line>\n"+"<text>       \n"+"<button>\n"+"label=4\n"+"bgcolor=#8fadda\n"+"arg=run('Bop 		[n4]')\n"+"<button>\n"+"label=5\n"+"bgcolor=#ffd900\n"+"arg=run('boP 		[n5]');\n"+"<button>\n"+"label=6\n"+"bgcolor=#b57ad6\n"+"arg=run('bOp 		[n6]');\n"+"</line>\n"+
	"<line>\n"+"<text>       \n"+"<button>\n"+"label=1\n"+"bgcolor=#8fadda\n"+"arg=run('Gray 	[n1]')\n"+"<button>\n"+"label=2\n"+"bgcolor=#ffd900\n"+"arg=run('Green 	[n2]');\n"+"<button>\n"+"label=3\n"+"bgcolor=#b57ad6\n"+"arg=run('Red 		[n3]');\n"+"</line>\n"+
	"<line>\n"+"<text>       \n"+"<button>\n"+"label=0\n"+"bgcolor=#8fadda\n"+"arg=run('myTurbo 	[n0]')\n"+"</line>\n";
	run("Action Bar",text);
}
function memoryAndRecorder() {
	run("Record...");
	Table.setLocationAndSize(screenWidth-350, 0, 350, 200,"Recorder");
	run("Monitor Memory...");
	Table.setLocationAndSize(screenWidth-595, 0, 250, 120,"Memory");
}

function invert_all_LUTs() {
    // !! only works with linear LUTs (one color)
    // will convert all LUTs between inverted and non inverted 
    // and switch the new composite rendering mode accordingly
    requires("1.53o");
    getDimensions(width, height, channels, slices, frames);
    REDS = newArray(256); GREENS = newArray(256); BLUES = newArray(256);
    for (c = 1; c <= channels; c++) {
        if (is("composite")) Stack.setChannel(c);
        getLut(reds,greens,blues);
        RED = reds[255]; GREEN = greens[255]; BLUE = blues[255];
        if (is("Inverting LUT")) {
            for(i=0; i<256; i++) { 
                REDS[i]   = (RED/256)*(i+1);
                GREENS[i] = (GREEN/256)*(i+1);
                BLUES[i]  = (BLUE/256)*(i+1);
            }
	   		setLut(REDS, GREENS, BLUES);
            if (RED+GREEN+BLUE == 0) {
	        	run("Grays");
	        }
        }
        else {
        	//make inverted LUT
            REDS = newArray(256); GREENS = newArray(256); BLUES = newArray(256);
            for(i=0; i<256; i++) { 
                REDS[i]   = 255-(((255-RED)/256)*i);
                GREENS[i] = 255-(((255-GREEN)/256)*i);
                BLUES[i]  = 255-(((255-BLUE)/256)*i);
            }
        	setLut(REDS, GREENS, BLUES);
            if (RED+GREEN+BLUE == 765) {
	        	run("Grays"); 
	        	run("Invert LUT");
	        }
        }
    }
    // CompositeProjection mode switch :
    if      (Property.get("CompositeProjection") == "Invert") Property.set("CompositeProjection", "Sum");
    else if (Property.get("CompositeProjection") == "Min") Property.set("CompositeProjection", "Max");
    else if (Property.get("CompositeProjection") == "Max") Property.set("CompositeProjection", "Min");
    else Property.set("CompositeProjection", "Invert"); // if Composite Sum
    updateDisplay();
}

function switchCompositeMode(){
	getLut(reds,greens,blues);
	MODE = Property.get("CompositeProjection");
	if (!is("Inverting LUT")) {
		if   (MODE == "Max" || MODE == "Invert" || MODE == "Min") {Property.set("CompositeProjection", "Sum"); showStatus("Sum mode");}
		else {Property.set("CompositeProjection", "Max"); showStatus("Max mode");}
	}
	else {
		if   (MODE == "Invert") {Property.set("CompositeProjection", "Min"); showStatus("Min mode");}
		else {Property.set("CompositeProjection", "Invert"); showStatus("Invert mode");}
	}
	updateDisplay();
}

// Add scale bar to image in 1-2-5 series size
// adapted from there https://forum.image.sc/t/automatic-scale-bar-in-fiji-imagej/60774?u=k_taz
function quickScaleBar(){
	// set the appearance of scalebar
	if (isKeyDown("shift")) COLOR = "Black";
	else COLOR = "White";
	SCALEBAR_SIZE = 0.2;         // approximate size of the scale bar relative to image width
	getPixelSize(unit,w,h);
	if (unit == "pixels") exit("Image not spatially calibrated");
	IMAGE_WIDTH = w * minOf(Image.width,Image.height);  // image width in measurement units
	SCALEBAR_LENGTH = 1;            // initial scale bar length in measurement units
	// recursively calculate a 1-2-5 series until the length reaches SCALEBAR_SIZE, default to 1/10th of image width
	// 1-2-5 series is calculated by repeated multiplication with 2.3, rounded to one significant digit
	while (SCALEBAR_LENGTH < IMAGE_WIDTH * SCALEBAR_SIZE) 
		SCALEBAR_LENGTH = round((SCALEBAR_LENGTH*2.3)/(Math.pow(10,(floor(Math.log10(abs(SCALEBAR_LENGTH*2.3)))))))*(Math.pow(10,(floor(Math.log10(abs(SCALEBAR_LENGTH*2.3))))));
	SCALEBAR_SETTINGS = "height=" + (SCALEBAR_LENGTH/w)/7 + " font=" + minOf(Image.width,Image.height)/20 + " color=" + COLOR + " background=None location=[Lower Right] bold overlay";
	run("Scale Bar...", "width=&SCALEBAR_LENGTH "+SCALEBAR_SETTINGS);
}

function compositeSwitch(){
	if (!is("composite")) exit;
	Stack.getDisplayMode(mode);
	if (mode=="color"||mode=="greyscale") {Stack.setDisplayMode("composite");}
	else {Stack.setDisplayMode("color");}
}

//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
//Ah jérôme... \o/
macro "Table Action" {
	index = Table.getSelectionStart+1;
	if (isKeyDown("space")) index = getNumber("label number?", 1);
	if (index == -1) exit;
	setThreshold(index,index);
	run("Create Selection");
	resetThreshold();
}

function BioformatsBar(){
	BioFormats_Bar = 
	"<fromString>"+"\n"+
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
	"</DnDAction>\n";
	run("Action Bar",BioFormats_Bar);
}

function toolRoll() {
	if 		(toolID == 0) setTool(15);
	else setTool(0);
}

//ispired by Robert Haase Windows Position tool from clij
//IDEA : possible to drag lines or diagonals to trigger things?
function multiTool(){ //avec menu "que faire avec le middle click? **"
	/*
	 * shift = +1;
	 * ctrl = +2;
	 * cmd = +4;...
	 * alt = +8; middle click is just 8
	 * leftClick = +16;
	 * selection = +32
	 * e.g leftclick + alt = 24
	 */
	setupUndo();
	call("ij.plugin.frame.ContrastAdjuster.update");
	updateDisplay();
	getCursorLoc(x, y, z, flags);
	if (flags>=32) flags -= 32;
	if (flags == 8) { //middle mouse button
		if      (startsWith(getTitle(), "Preview Opener")) openFromPreview();  
		else if (startsWith(getTitle(), "Lookup Tables")) setLUTfromMontage(); 
		if (Image.height==32||Image.width==256) { plotLUT(); copyLUT();}
		else {
			if (middleClick) eval(String.paste);
			else compositeSwitch();
		}
	}
	if (flags == 16) {
		if 		(mainTool=="Move Windows")           moveWindows();
		else if (mainTool=="Contrast Adjuster")      liveContrast();
		else if (mainTool=="Gamma on LUT")           liveGamma();
		else if (mainTool=="slice / frame scroll")   liveScroll();
		else if (mainTool=="explorer")               explorer();
		else if (mainTool=="My Magic Wand")          magicWand();
		else if (mainTool=="Fly mode")			 	 flyMode();
	}
	if (getInfo("window.type") == "ResultsTable") result2label();
	if (flags == 9) 				if (bitDepth()!=24) pasteLUT();	//shift + middle click
	if (flags == 17)				liveContrast();					// shift + long click
	if (flags == 18||flags == 20)	liveGamma();					// ctrl + long click
	if (flags == 24)				liveScroll();					// alt + long click
	if (flags == 25)				squaredAutoContrast();			// shift + alt + long click
	if (flags == 26||flags == 28)	flyMode();
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
	wait(10);
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
	copyLUT();
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


function squaredAutoContrast() {
	if (bitDepth==24) exit("This macro won't work with rgb");
	size=75;
	getCursorLoc(x, y, z, flags);
	makeRectangle(x-size/2,y-size/2,size,size);
	Auto_Contrast_on_all_channels();
	run("Select None");
}


function explorer() {
	if (bitDepth==24) exit("This macro only works with grayscale images");
	size=50;
	x2=-1;y2=-1;
	while (true) {
		getCursorLoc(x, y, z, flags);
		if (flags>=32) flags -= 32;
		if (flags&16==0) {run("Select None"); exit();}
		if (x!=x2 || y!=y2) {
			makeRectangle(x-size/2,y-size/2,size,size);
			getStatistics(area, mean, min, max);
			setMinAndMax(min, max);
			showStatus("Display Range: "+min+" - "+max);
		}
		x2=x; y2 =y;
		wait(10);
	}
}

function flyMode(){
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

var targetSize = 500;
var tolerance = 100;
var nPixels = 500;
var newTolerance = tolerance;
var fit = "Fit Spline";

function magicWand() {
	getCursorLoc(x2, y2, z2, flags2);
	getCursorLoc(x, y, z, flags);
	if (flags>=32) flags -= 32; //remove "cursor in selection" flag
	if (flags==8) {
		doWand(x, y, newTolerance, "Legacy");
	}
	zoom = getZoom();
	getMinAndMax(min, max);
	factor = max/500;
	newTolerance = tolerance;
	run("Select None");
	estimateTolerance();
	getMinAndMax(min, max);
	while (flags >= 16) {
		getCursorLoc(x, y, z, flags);
		if (flags>=32) flags -= 32; //remove "cursor in selection" flag
		distance = (x*zoom-x2*zoom);
		if (distance<0) newTolerance = tolerance - pow(abs(distance), 1.5);
		else newTolerance = tolerance + pow(abs(distance), 1.5);
		run("Wand Tool...", "tolerance=&newTolerance mode=Legacy");
		wait(30);
	}
	tolerance = newTolerance;
	getRawStatistics(nPixels);
	showStatus("pixels number = "+nPixels);
	if (fit != "None"){
		run(fit);
		getSelectionCoordinates(xpoints, ypoints);
		makeSelection(4, xpoints, ypoints);
	}
}

function estimateTolerance(){
	getCursorLoc(x, y, z, modifiers);
	tolerance = 0;
	doWand(x,y);
	getMinAndMax(min, max);
	getRawStatistics(nPixels);
	while (nPixels<=targetSize) {
		tolerance += max/10;
		run("Wand Tool...", "tolerance=&tolerance");
		getRawStatistics(nPixels);
		if (tolerance > max) exit;
	}
}

function setFavoriteLUT(){
	saveAs("lut", getDirectory("temp")+"/favoriteLUT.lut");
	showStatus("new favorite LUT");
}

function pasteFavoriteLUT(){
	open(getDirectory("temp")+"/favoriteLUT.lut");
	showStatus("Paste LUT");
}

function copyLUT() {
	getCursorLoc(x, y, z, flags);
	if (flags == 40) {roiManager("Add"); exit;}
	saveAs("lut", getDirectory("temp")+"/copiedLut.lut");
	showStatus("Copy LUT");
}

function pasteLUT(){
	open(getDirectory("temp")+"/copiedLut.lut");
	showStatus("Paste LUT");
}

function fauteDeClearVolume(){//...
	title = getTitle();
	run("3D Viewer");
	call("ij3d.ImageJ3DViewer.setCoordinateSystem", "false");
	call("ij3d.ImageJ3DViewer.add", title, "None", title, "0", "true", "true", "true", "2", "0");
	close("Console");
}

function seeAllLUTs(){
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

function batchMerge() {
	directory = getDirectory("Select A folder");
	fileList = getFileList(directory);
	channels = getNumber("how many channels?", 2);
	for (i = 0; i < fileList.length; i++) if (!endsWith(fileList[i], ".tif")) exit("only keep tiff images in this folder");
	File.makeDirectory(directory + "/output");
	setBatchMode(true);
	for (i = 0; i < fileList.length; i+=channels) {
		showProgress(i/fileList.length);
		merge_options = "";
		for (k = 0; k < channels; k++) {
			current_imagePath = directory + fileList[k+i];
			run("Bio-Formats Importer", "open=&current_imagePath");
			merge_options += "c" + k+1 + "=[" + fileList[k+i] + "] ";
		}
		run("Merge Channels...", merge_options + " create");
		saveAs("tiff", directory + "/output/" + fileList[i]);
		run("Close All");
		
	}
	print("done");
	setBatchMode(false);
}

function labelSumProject(){
	setBatchMode(1);
	run("Duplicate...","duplicate");
	run("RGB Color");
	run("Z Project...", "projection=[Sum Slices]");
	setBatchMode(0);
}

function fetchOrPullStartupMacros() {
	sync_path = getDirectory("home") + "/Nextcloud/sync/FIJI/StartupMacros.fiji.ijm";
	if (!File.exists(sync_path)) sync_path = getDirectory("home") + "/Nextcloud2/sync/FIJI/StartupMacros.fiji.ijm";
	fiji_startup_path = getDirectory("macros")+"/StartupMacros.fiji.ijm";
	 //return true for Fetch and false for pull
	choice = getBoolean("Fetch or pull?", "Pull", "Fetch");
	if (!choice){
		//backup of current StMacros
		File.saveString(File.openAsString(fiji_startup_path), getDirectory("macros")+"/backups/StM_"+round(random*10000)+".ijm");
		//import new
		File.saveString(File.openAsString(sync_path), fiji_startup_path);
		run("Install...","install=["+fiji_startup_path+"]");
		showStatus("Fetch!");
	}
	else {
		//pull
		File.saveString(File.openAsString(fiji_startup_path), sync_path);
		showStatus("Pull!");
	}
}

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
	if (Glut == "current") pasteLUT();
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

function installMacroFromClipboard() {
	path = getDirectory("temp")+File.separator+"fromClipboard.ijm";
	string = File.openAsString(getDirectory("macros")+"/StartupMacros.fiji.ijm") + String.paste;
	File.saveString(string, path);
	run("Install...","install=["+path+"]");
	setTool(23);
}

function rotateLUT() {
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

//adapted from https://imagej.nih.gov/ij/macros/Show_All_LUTs.txt
//the "display LUTs" function caused problems with some lut names.
function displayLUTs(){
	if (isKeyDown("shift")) ApplyChrisLUTsMontage();
	else {
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
		if (rows<count/3) rows++;
		run("Canvas Size...", "width=258 height=50 position=Center");
		run("Make Montage...", "columns=3 rows="+rows+" scale=1 first=1 last="+count+" increment=1 border=0 use");
		rename("Lookup Tables");
		setBatchMode(false);
		restoreSettings();
	}
}

function setLUTfromMontage() {
	title = getTitle();
	if (!startsWith(title, "Lookup Tables"))	setTargetImage();
	else {
		setBatchMode(1);
		getCursorLoc(x, y, z, modifiers);
		YblocSize = 50;
		XblocSize = 258;
		linePosition = floor(y/YblocSize);
		rowPosition = floor(x/XblocSize);
		X_LUTposition = 1+(rowPosition*XblocSize);
		Y_LUTposition = 1+(linePosition*YblocSize);
		R = newArray(1); G = newArray(1); B = newArray(1);
		for (i = 0; i < 256; i++) {
			color = getPixel(i + X_LUTposition, 1 + Y_LUTposition);
			R[i] = (color>>16)&0xff; 	
			G[i] = (color>>8)&0xff;		
			B[i] = color&0xff;
		}
		if (R[100]+G[100]+B[100] == 765) exit();
		targetImage=call("ij.Prefs.get","Destination.title","");
		if (isOpen(targetImage)){
			selectWindow(targetImage);
			setLut(R, G, B);
		}
		else {
			newImage("lutFromMontage", "8-bit ramp", 256, 32, 1);
			setLut(R, G, B);
		}
		if (isOpen("LUT Profile")) plotLUT();
		copyLUT();
		close("lutFromMontage");
		selectWindow(title);
	}
}

function ApplyChrisLUTsMontage() {
	oridir = File.getDefaultDir;
	rootdir = getDir("imagej");
	startdir = rootdir + "scripts" + File.separator + "LUTs" + File.separator + "___Grays_.ijm";
	File.setDefaultDir(startdir);
	lutdir = getDir("Choose folder");
	File.setDefaultDir(oridir);
	count = 0;
	propertyList = "";
	saveSettings();
	setBatchMode(true);
	newImage("ramp", "8-bit Ramp", 256, 32, 1);
	newImage("luts", "RGB White", 256, 48, 1);
	setForegroundColor(255, 255, 255);
	setBackgroundColor(255, 255, 255);
	//recursive processing
	propertyList = processFiles(lutdir, propertyList);
	run("Delete Slice");
	rows = floor(count/4);
	if (rows<count/4) rows++;
	run("Canvas Size...", "width=258 height=50 position=Center");
	setBackgroundColor(0, 0, 0);
	run("Make Montage...", "columns=4 rows="+rows+" scale=1 increment=1 border=0 use");
	rename("Lookup Tables");
	Property.set("PropertyList",propertyList);
	setBatchMode(false);
	restoreSettings();

	function processFiles(dir,propertyList) {
		list = getFileList(dir);
		for (i=0; i<list.length; i++) {
			if (File.isDirectory(dir+list[i])) propertyList = processFiles(""+dir+list[i] , propertyList);
			else if (endsWith(list[i], "_.ijm")) {
				path = dir+list[i];
				propertyList = processFile(path, propertyList);
			}
		}
		return propertyList;
	}

	function processFile(path, propertyList) {
		selectWindow("ramp");
		script = File.openAsString(path);
		runMacro(path);
		propertyList = propertyList + script;
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
		return propertyList;
	}
}

function setTargetImage() {
	showStatus("Target image = "+ getTitle(), "flash image orange 200ms");
	call("ij.Prefs.set","Destination.title",getTitle());
}

function setCustomPosition() {
	showStatus("Custom position set");
	getLocationAndSize(savedLocX, savedLocY, width, height);
}

//if on a rgb image,get current pixel color and use it to create the LUT of destination image with setTargetImage()
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
		if (i==0) {dir = getDirectory("image"); File.setDefaultDir(dir);}
		all_IDs[i] = getImageID();
		all_paths += getTitle() +",,";
	}
	for (i=0; i<all_IDs.length; i++) {
		selectImage(all_IDs[i]); 
		if(!is("Virtual Stack") && bitDepth()!=24) {
			getDimensions(w, h, channels, slices, frames);
			getLut(reds,greens,blues);
			if (slices*frames!=1) run("Z Project...", "projection=[Max Intensity] all");
			setLut(reds,greens,blues);
		}
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
	saveAs("tiff", dir+"Preview Opener");
}

//Supposed to create an RGB snapshot of any kind of opened image
//check sourcecode for save as jpeg and stuff, how does it works?
function rgbSnapshot(){
	title = getTitle();
	Stack.getPosition(channel, slice, frame);
	getDimensions(width, height, channels, slices, frames);
	if (channels>1) Stack.getDisplayMode(mode);
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
	Set_LUTs();
	makeRectangle(173, 255, 314, 178);
	Enhance_on_all_channels();
	run("Select None");
	setOption("Changes",0);
	setBatchMode(0);
}

function channelsRoll(){
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
	close("LUT Profile");
	selectNone = 0; activeChannels="1"; normalize = 0;
	if (isKeyDown("space")) normalize = 1;
	getDimensions(width,  height, channels, slices, frames);
	Stack.getPosition(Channel, slice, frame);
	//if (selectionType()==-1) {showStatus("Needs a selection","flash #e14250 2000ms"); exit;}
	if (selectionType()==-1) {run("Select All");}
	if (bitDepth()==24){ run("Plot Profile"); exit;}
	if (channels>1) Stack.getActiveChannels(activeChannels);
	id=getImageID();
	
	call("ij.gui.ImageWindow.setNextLocation", savedLocX, savedLocY);
	run("Plots...", "width=400 height=200");
	Plot.create("MultiPlot", "Pixels", "Grey value");
	for (i=1; i<=channels; i++) {
		if (channels>1) Stack.setChannel(i);
		if (activeChannels.substring(i-1,i)) {
			p = getProfile();
			Array.getStatistics(p, min, max, mean, stdDev);
			if (normalize) for (k=0; k<p.length; k++) p[k] = Math.map(p[k], min, max, 0, 1);
			Plot.setColor(lutToHex2());
			Plot.setLineWidth(2);
			Plot.add("line", p);
		}
	}
	Stack.setPosition(Channel, slice, frame);
	if (channels>1) {Stack.setDisplayMode("color");	Stack.setDisplayMode("composite");}
	Plot.setBackgroundColor("#2f2f2f");
	Plot.setAxisLabelSize(14.0, "bold");
	Plot.setFormatFlags("11001100101111");
	if (normalize) Plot.setXYLabels("Pixels", "Normalized Intensity");
	Plot.update();

	selectWindow("MultiPlot");
	if (normalize) Plot.setLimits(0, p.length, 0, 1.01 );
	else  Plot.setLimitsToFit();
	Plot.freeze(1);
	selectImage(id);
	if (channels>1) Stack.setActiveChannels(activeChannels);
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

function multiPlot_Zaxis(){
	close("LUT Profile");
	selectNone = 0; activeChannels="1"; normalize = 0;
	if (isKeyDown("space")) normalize = 1;
	getDimensions(width,  height, channels, slices, frames);
	Stack.getPosition(Channel, slice, frame);
	if (selectionType()==-1) {run("Select All");}
	if (bitDepth()==24){ run("Plot Profile"); exit;}
	if (channels>1) Stack.getActiveChannels(activeChannels);
	id=getImageID();
	call("ij.gui.ImageWindow.setNextLocation", savedLocX, savedLocY);
	run("Plots...", "width=400 height=200");
	Plot.create("MultiPlot", "Frame", "Grey value");
	for (i=1; i<=channels; i++) {
		if (channels>1) Stack.setChannel(i);
		if (activeChannels.substring(i-1,i)) {
			LUTcolor = lutToHex2();
			setBatchMode(1);
			run("Plot Z-axis Profile");
			Plot.getValues(xpoints, p);
			Array.getStatistics(p, min, max, mean, stdDev);
			if (normalize) for (k=0; k<p.length; k++) p[k] = Math.map(p[k], min, max, 0, 1);
			Plot.setColor(LUTcolor);
			Plot.setLineWidth(2);
			Plot.add("line", p);
			close();
			setBatchMode(0);
		}
	}
	Stack.setPosition(Channel, slice, frame);
	if (channels>1) {Stack.setDisplayMode("color");	Stack.setDisplayMode("composite");}
	Plot.setBackgroundColor("#2f2f2f");
	Plot.setAxisLabelSize(14.0, "bold");
	Plot.setFormatFlags("11001100101111");
	if (normalize) Plot.setXYLabels("Pixels", "Normalized Intensity");
	Plot.update();
	selectWindow("MultiPlot");
	if (normalize) Plot.setLimits(0, p.length, 0, 1.01 );
	else  Plot.setLimitsToFit();
	Plot.freeze(1);
	selectImage(id);
	if (channels>1) Stack.setActiveChannels(activeChannels);
}

function plotLUT(){
	close("MultiPlot");
	if (nImages == 0) exit;
	if (bitDepth()==24) exit;
	id=getImageID();
	lutinance = newArray(0); //luminance of LUT...
	getLut(r,g,b);
	setBatchMode(1);
		newImage("temp", "8-bit ramp", 385, 32, 1);
		setLut(r,g,b);
		run("RGB Color");
		rename("temp");
		getDimensions(width, height, channels, slices, frames);
		inID = getImageID();
		run("Copy");
		newImage("temp", "RGB", width, height, 2);
		setSlice(1); 
		run("Paste");
		outID = getImageID();
		selectImage(inID);
		run("Duplicate...","duplicate");
		rename("temp");
		// run("Simulate Color Blindness", "mode=[Protanopia (no red)]");
		simulateFullDeuteranopia();	
		rename("temp");
		run("Copy");
		selectImage(outID);	
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
	call("ij.gui.ImageWindow.setNextLocation", savedLocX, savedLocY);
	run("Plots...", "width=400 height=265");
	Plot.create("LUT Profile", "Grey Value", "value");
	lutinance = getLUTinance(r,g,b);
	Plot.setColor("white");
	Plot.setLineWidth(2);
	Plot.add("line", lutinance);
	Plot.setColor("#ff4a4a");
	Plot.setLineWidth(2);
	Plot.add("line", r);
	Plot.setColor("#8ce400");
	Plot.setLineWidth(2);
	Plot.add("line", g);
	Plot.setColor("#60c3ff");
	Plot.setLineWidth(2);
	Plot.add("line", b);
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

function getLUTinance(reds,greens,blues){
	lutinance = newArray(0);
	for (i = 0; i < 256; i++) {
		rgb = newArray(reds[i],greens[i],blues[i]);
		lutinance[i] = getLum(rgb);
	}
	return lutinance;
}

function simulateFullDeuteranopia(){
	if (nImages==0) exit("No Image");
	getDimensions(width, height, channels, slices, frames);
	rgbSnapshot();

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
	Stack.setChannel(1); LUTmaker(40,183,255);
	Stack.setChannel(2); LUTmaker(249,112,40);
	setOption("Changes", 0);
}

function B_and_C(){
	run("Brightness/Contrast...");
	selectWindow("B&C");
	setLocation(150,300);
}

var xPositionBackup = 300;
var yPositionBackup = 300;
var widthPositionBackup = 400;
var heightPositionBackup = 400;

function goodSize() {
	getLocationAndSize(xPositionBackup, yPositionBackup, widthPositionBackup, heightPositionBackup);
	getDimensions(width, height, null, null, null);
	if (width/height <= 2.5) {
		newHeight = (screenHeight/10) * 8;
		newWidth = width * (newHeight / height);
		x = (screenWidth - newWidth) / 2;
		y = (screenHeight - newHeight) / 2;
		setLocation(x, y, newWidth, newHeight);
		run("Set... ", "zoom="+(getZoom()*100)-2);
	}
	else {
		run("Maximize");
		setLocation(0, 200);
	}
}

function fullScreen() {
	getLocationAndSize(xPositionBackup, yPositionBackup, widthPositionBackup, heightPositionBackup);
	setBatchMode(1);
	run("Set... ", "zoom=2000");
	setLocation(0, screenHeight/10, screenWidth, screenHeight*0.8);
	run("Set... ", "zoom="+round((screenWidth/getWidth())*100)-1);
}

function restorePosition(){
	setLocation(xPositionBackup, yPositionBackup, widthPositionBackup, heightPositionBackup);
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
	if (isKeyDown("shift")) EXIT_MODE = "exit and display";
	else EXIT_MODE = 0;
	setBatchMode(1);
	TITLE = getTitle();
	run("Duplicate...", "title=gaussed duplicate");
	getDimensions(width, height, channels, slices, frames);
	SIGMA = maxOf(height,width) / 3;
	run("Gaussian Blur...", "sigma=" + SIGMA + " stack");
	imageCalculator("Substract create stack", TITLE, "gaussed");
	rename(TITLE + "_corrected");
	setOption("Changes", 0);
	setBatchMode(EXIT_MODE);
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

function testAllCaluclatorModes() {
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

function rgb2Luminance(){
	title=getTitle();
	rgbSnapshot();
	rename(title+"_lum");
	run("8-bit");
	setOption("Changes", 0);
	run("Select None");
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

function my3D_project() {
	showStatus("3D project");
	run("3D Project...", "projection=[Mean Value] initial=312 total=96 rotation=12 interpolate");
	run("Animation Options...", "speed=8 loop start");
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
		// run("Z Project...", "projection=[Max Intensity]");
		// currentImage_name = getTitle();
		// saveAs("tiff", directory + currentImage_name);
		run("Close All");
	}
	print("done");
	setBatchMode(false);
}

/*--------
Set LUTs
--------*/
function perso_Ask_LUTs(){
	LUT_list = newArray("kb","ko","km","kg","CRL_BOP Blue","CRL_BOP Orange", "CRL_BOP Purple", "BOP Green" ,"Grays");
	Dialog.create("Set all LUTs");
	for(i=0; i<4; i++) Dialog.addRadioButtonGroup("LUT " + (i+1), LUT_list, 0, 4, chosen_LUTs[i]);
	Dialog.addCheckbox("noice?", 0);
	Dialog.show();
	for(k=0; k<4; k++) chosen_LUTs[k] = Dialog.getRadioButton();
	if (Dialog.getCheckbox()) for(k=0; k<4; k++) chosen_LUTs[k] = chosen_LUTs[k] + "_noice"; 
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
		Stack.setDisplayMode("color");Stack.setDisplayMode("composite");
	}
	else run(chosen_LUTs[0]);
}

function Set_noice_LUTs(){
	chosen_LUTs_backup = chosen_LUTs;
	chosen_LUTs = newArray("kb_noice","ko_noice","km_noice","kg_noice","Grays");
	Set_LUTs();
	chosen_LUTs = chosen_LUTs_backup;
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

//for args give gamma value, and r,g,b obtained by getLut(r,g,b) command.
function gammaLUT(gamma, reds, greens, blues) {
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
	if (is("Virtual Stack")) {showStatus("marche pas en virtual stack!"); wait(600); exit;}
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
	call("ij.plugin.frame.ContrastAdjuster.update");
}// Note : I discovered that the built-in command 'run("Enhance Contrast...", "saturated=0.001 use");' give same results
//		  but it only works on single channel stacks so this macro is still necessary for hyperstacks.

function reduceMax(){
	getDimensions(width, height, channels, slices, frames);
	message = "";
	for (i = 0; i < channels; i++) {
		Stack.setChannel(i+1);
		getMinAndMax(min, max);
		setMinAndMax(min, max+(0.1*max));
		message += "  Channel "+i+1+" = "+(max+(0.1*max));
	}
	showStatus(message, "flash orange 1500ms");
}

function Auto_Contrast_on_all_channels() {
	// if (is("Virtual Stack")) {showStatus("marche pas en virtual stack!"); exit;}
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
		Stack.setPosition(i, s, f);
		run("Enhance Contrast", "saturated=0.03 use");	
	}
	Stack.setPosition(ch, s, f);
	compositeSwitch(); compositeSwitch(); //trick for display update
	call("ij.plugin.frame.ContrastAdjuster.update");
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

function propagateContrast(){
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

function Z_project_all() {
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

function decon32_to_8bit() {
	for (i=0; i<nImages; i++) {
        selectImage(i+1);
        getDimensions(width, height, channels, slices, frames);
        if (channels > 1) {
        	for (k = 0; k < channels; k++) {
        	Stack.setChannel(k+1);
        	setMinAndMax(0,255);
        	}
        }
        run("8-bit");
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
	//SplitviewInteractor();

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
/*----------------------------------------------------------------------------------------------------------------------
main SplitView function : aguments works as follow :
color_Mode : 0 = grayscale , 1 = color 
montage_Style : 0 = linear montage , 1 = squared montage , 2 = vertical montage
labels : 0 = no , 1 = yes.
----------------------------------------------------------------------------------------------------------------------*/
function SplitView(color_Mode, montage_Style, labels) {
	setBatchMode(true);
	title = getTitle();
	saveSettings;
	Setup_SplitView(color_Mode, labels);//up until split
	restoreSettings;
	if (montage_Style==1)	squareView();
	if (montage_Style==0)	linearView();
	if (montage_Style==2)	verticalView();
	rename(title + " SplitView");
	setOption("Changes", 0);
	setBatchMode("exit and display");

	function Setup_SplitView(color_Mode, labels){
		setBackgroundColor(255,255,255);
		getDimensions(width, heigth, channels, Z, T);
		if (channels == 1) exit("only one channel");
		if (channels > 5)  exit("5 channels max");
		run("Duplicate...", "title=image duplicate");
		if ((Z>1)&&(T==1)) {T=Z; Z=1; Stack.setDimensions(channels,Z,T); } 
		tile = newArray(channels+1);	channels = channels;
		getDimensions(width,heigth,channels,Z,T);
		font_Size = heigth/9;
		run("Duplicate...", "title=split duplicate");
		run("Split Channels");
		selectWindow("image");
		Stack.setDisplayMode("composite")

		if (labels) {
			getLabels();
			setColor("white");
			setFont("SansSerif", font_Size, "bold antialiased");
			Overlay.drawString("Merge",heigth/20,font_Size);
			Overlay.show;
			run("Flatten","stack");
			rename("overlay"); tile[0] = getTitle();
			if(borderSize != 0) run("Canvas Size...", "width="+Image.width+borderSize+" height="+Image.height+borderSize+" position=Center");
			close("image");

			for (i = 1; i <= channels; i++) {
				selectWindow("C"+i+"-split");
				id = getImageID();
				getLut(reds, greens, blues); 
				setColor(reds[255], greens[255], blues[255]);
				if (!color_Mode) {
					getMinAndMax(min, max); 
					run("Grays"); 
					setMinAndMax(min, max);
				}
				Overlay.drawString(channel_Labels[i-1],heigth/20,font_Size);
				Overlay.show;
				if (Z*T>1) run("Flatten","stack");
				else { run("Flatten"); selectImage(id);	close();	}
				if(borderSize != 0) run("Canvas Size...", "width="+Image.width+borderSize+" height="+Image.height+borderSize+" position=Center");
				tile[i]=getTitle();
			}
		}
		else {
			run("RGB Color", "frames"); 
			rename("overlay"); tile[0] = getTitle(); 
			if(borderSize != 0) run("Canvas Size...", "width="+Image.width+borderSize+" height="+Image.height+borderSize+" position=Center");
			close("image");
			for (i = 1; i <= channels; i++) {
				selectWindow("C"+i+"-split");
				if (!color_Mode) {
					getMinAndMax(min, max); 
					run("Grays"); 
					setMinAndMax(min, max);
				}
				run("RGB Color", "slices"); 
				if(borderSize != 0) run("Canvas Size...", "width="+Image.width+borderSize+" height="+Image.height+borderSize+" position=Center");
				tile[i]=getTitle();	
			}
		}
	}
	
	function getLabels(){
		Dialog.createNonBlocking("Provide channel names");
		for (a = 0; a < 5; a++) Dialog.addString("Channel "+a+1, channel_Labels[a],12); 
		Dialog.addNumber("Font size", font_Size);
		Dialog.show();
		for (k = 0; k < 5; k++) {channel_Labels[k] = Dialog.getString();}
		font_Size = Dialog.getNumber();
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
							C1_C2 = Combine_Horizontally(tile[1],tile[2]);
		if (channels==2)			Combine_Horizontally(C1_C2,tile[0]);
		if (channels==3){	C3_Ov = Combine_Horizontally(tile[3],tile[0]);			Combine_Horizontally(C1_C2,C3_Ov);}
		if (channels>=4){	C3_C4 =	Combine_Horizontally(tile[3],tile[4]);	C1234 =	Combine_Horizontally(C1_C2,C3_C4);}
		if (channels==4)			Combine_Horizontally(C1234,tile[0]);
		if (channels==5){	C5_Ov = Combine_Horizontally(tile[5],tile[0]);			Combine_Horizontally(C1234,C5_Ov);}
	}
	
	function verticalView(){
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

var	color_Mode = "Colored";
var	montage_Style = "Linear";
var	labels = 0;
function getSplitViewPrefs(){
	if (nImages == 0) exit();
	Dialog.createNonBlocking("SplitView");
	Dialog.addRadioButtonGroup("color Mode", newArray("Colored","Grayscale"), 1, 3, color_Mode);
	Dialog.addRadioButtonGroup("Montage Style", newArray("Linear","Square","Vertical"), 1, 3, montage_Style);
	Dialog.addSlider("border size", 0, 50, Image.height * 0.02);
	Dialog.addCheckbox("label channels?", labels);
	Dialog.show();
	color_Mode = Dialog.getRadioButton();
	montage_Style = Dialog.getRadioButton();
	borderSize = Dialog.getNumber();
	labels = Dialog.getCheckbox();
	if	   (color_Mode=="Colored"   && montage_Style=="Linear")  { if(labels) SplitView(1,0,1); else SplitView(1,0,0); }
	else if(color_Mode=="Grayscale" && montage_Style=="Linear")  { if(labels) SplitView(0,0,1); else SplitView(0,0,0); }
	else if(color_Mode=="Colored"   && montage_Style=="Square")  { if(labels) SplitView(1,1,1); else SplitView(1,1,0); }
	else if(color_Mode=="Grayscale" && montage_Style=="Square")  { if(labels) SplitView(0,1,1); else SplitView(0,1,0); }
	else if(color_Mode=="Colored"   && montage_Style=="Vertical"){ if(labels) SplitView(1,2,1); else SplitView(1,2,0); }
	else if(color_Mode=="Grayscale" && montage_Style=="Vertical"){ if(labels) SplitView(0,2,1); else SplitView(0,2,0); }
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
		if (getInfo("os.name")!="Mac OS X") Dialog.createNonBlocking("The LUT baker");
		else Dialog.createNonBlocking("◊ The LUT baker ◊");
		Dialog.setLocation(x+w,y);
		for(i=0; i<CH; i++) {
			if(CH>1)Stack.setChannel(i+1);
			getLut(r,g,b); 
			R = r[255]; G = g[255]; B = b[255];
			Rz[i] = R; Gz[i] = G; Bz[i] = B;
			totR += R; totG += G; totB += B;
			if (getInfo("os.name")!="Mac OS X") Dialog.addMessage("_ LUT " + (i+1) + " _", 20, lutToHex(R,G,B));
			else Dialog.addMessage("◊ LUT " + (i+1) + "◊", 20, lutToHex(R,G,B));
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
		//inv = Dialog.getCheckbox();
		//undo = Dialog.getCheckbox();
		selectImage(id);
		for(k=0; k<CH; k++){
			Rz[k]=Dialog.getNumber();
			Gz[k]=Dialog.getNumber();
			Bz[k]=Dialog.getNumber();
			if (CH>1) Stack.setChannel(k+1);
			LUTmaker(Rz[k],Gz[k],Bz[k]);
		}
		// if (undo==1) { //Undo all modifications
		// 	for(k=0; k<CH; k++){
		// 		if (CH>1) Stack.setChannel(k+1);
		// 		LUTmaker(SavedRz[k],SavedGz[k],SavedBz[k]);
		// 	}
		// 	preview = 0;
		// }
	}
	if (CH>1) Stack.setChannel(ch);
	setBatchMode(0);
}

function LUTmaker(r,g,b){
	// function LUTmaker(r,g,b){
	// 	R = Array.resample(newArray(0,r),256);
	// 	G = Array.resample(newArray(0,g),256);
	// 	B = Array.resample(newArray(0,b),256);
	// 	setLut(R, G, B);
	// }
	R = newArray(256); G = newArray(256); B = newArray(256);
	for(i=0; i<256; i++) { 
		R[i] = (r/256)*(i+1);
		G[i] = (g/256)*(i+1);
		B[i] = (b/256)*(i+1);
	}
	setLut(R, G, B);
}

function invertedLUTmaker(){
	getLut(reds,greens,blues);
    RED = reds[255]; GREEN = greens[255]; BLUE = blues[255];
    // if grayscale just invert
    if(RED==GREEN && RED==BLUE) {
    	run("Invert LUT");
    	break;
    }
	else {
        REDS = newArray(256); GREENS = newArray(256); BLUES = newArray(256);
        for(i=0; i<256; i++) { 
            REDS[i]   = 255-(((255-RED)/256)*i);
            GREENS[i] = 255-(((255-GREEN)/256)*i);
            BLUES[i]  = 255-(((255-BLUE)/256)*i);
        }
    }
    setLut(REDS, GREENS, BLUES);
}

function lutToHex(R,G,B){
	if (R<16) xR = "0" + toHex(R); else xR = toHex(R);
	if (G<16) xG = "0" + toHex(G); else xG = toHex(G);
	if (B<16) xB = "0" + toHex(B); else xB = toHex(B);
	return "#"+xR+xG+xB;
}

function copyPasteLUTset(){
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
	makeRectangle(5,5,5,5); run("Select None"); //trick to update image display
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
	Stack.setPosition(Channel, slice, frame);
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
			LUTmaker(rgb[0],rgb[1],rgb[2]);
			//invertedLUTmaker();
		}
	}
}

var	startLum = 0;
var	stopLum = 255;
function ultimateLUTgenerator(){
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
		plotLUT();
		copyLUT();
		Dialog.createNonBlocking("new roll?");
		Dialog.addMessage("OK to reroll cancel to stop");
		Dialog.show();
	}
}

function twoComp150LUTs(){
	steps = getNumber("how many steps?", 1);
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
		if (red==max && blue<135 && (green/red)<0.5)  
			colorType = "red";
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
	title = getTitle();
	rgbSnapshot();
	run("Invert");
	run("HSB Stack");
	run("Macro...", "code=v=(v+128)%256 slice");
	run("RGB Color");
	rename(title+"_inv");
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
												LUTmaker(10,183,255);//////BLUE
	saveAs("LUT", lutsFolder + "/kb.lut");
	Stack.setChannel(2);
	makeRectangle(187, 0, 213, 213);
	run("Clear", "slice");
												LUTmaker(255,142,10);/////ORANGE
	saveAs("LUT", lutsFolder + "/ko.lut");
	Stack.setChannel(3);
	makeRectangle(187, 187, 213, 213);
	run("Clear", "slice");
												LUTmaker(195,39,223);/////PURP
	saveAs("LUT", lutsFolder + "/km.lut");
	Stack.setChannel(4);
	makeRectangle(0, 187, 213, 213);
	run("Clear", "slice");
												LUTmaker(50,206,22);////GREEN
	saveAs("LUT", lutsFolder + "/kg.lut");
	run("Select None");
	setOption("Changes", 0);
}

function rgbLUT_ToLUT(){
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

function randomFuzzyLUT(){
	basicErrorCheck();
	R = newArray(256); G = newArray(256); B = newArray(256);
	for(i=0; i<256; i++) { 
		color = randomColorByLuminance(i);
		R[i] = color[0];
		G[i] = color[1];
		B[i] = color[2];
		showProgress(i, 255);
	}
	setLut(R, G, B);
	copyLUT();
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
	plotLUT();
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
	if (isOpen("LUT Profile")) plotLUT();
	copyLUT();
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
	plotLUT();
	setBatchMode(0);
	copyLUT();
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
	plotLUT();
	setBatchMode(0);
	copyLUT();
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
	plotLUT();
	setBatchMode(0);
	copyLUT();
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
	copyLUT();
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
	copyLUT();
}

function convertTo_iMQ_Style() {
	if(nImages == 0) exit;
	getLut(r,g,b); 
	newImage("lut", "8-bit ramp", 192, 32, 1); 
	setLut(r,g,b);
	setBatchMode(1);
	run("RGB Color"); rename(1);
	newImage("iGrays", "8-bit ramp", 64, 32, 1);
	run("Invert LUT");
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

//color = reds, greens or blues from getLut
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

function getLUTinance(reds,greens,blues){
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



/*

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

macro"random cool LUTs [K]"{
	Types = newArray("blue","magenta");
	if (isKeyDown("space")) LUMINANCE = getNumber("luminance", 150);
	else LUMINANCE = 150;
	getDimensions(w,h,channels,s,f);
	if (channels>1){
		Stack.setDisplayMode("composite");
		Stack.setChannel(1);
		rgb = randomColorByTypeAndLum(LUMINANCE, "blue");
		LUTmaker(rgb[0],rgb[1],rgb[2]);
		rgb = getOppositeLinearLUT();
		Stack.setChannel(2);
		LUTmaker(rgb[0],rgb[1],rgb[2]);
	}
	if (channels > 2) {
		Stack.setChannel(3);
		rgb = randomColorByTypeAndLum(LUMINANCE, "magenta");
		LUTmaker(rgb[0],rgb[1],rgb[2]);
		rgb = getOppositeLinearLUT();
		if (channels == 4) {
			Stack.setChannel(4);
			LUTmaker(rgb[0],rgb[1],rgb[2]);
		}
	}
	compositeSwitch(); compositeSwitch();
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


// function getAllFunctions(){
// 	functions = File.openUrlAsString("https://imagej.nih.gov/ij/developer/macro/functions.html");
// 	functions = replace(functions, "&quot;", "\"");
// 	functions = split(functions, "\n");
// 	commands = newArray(0);
// 	c = 0;
// 	for (i=0; i<functions.length; i++) {
// 		line = functions[i];
// 		if (line.startsWith("<b>")) {
// 			commands[c]=line.substring(line.indexOf("<b>")+3,line.indexOf("</b>"));
// 			c++;
// 		}
// 	}
// 	for (i = 0; i < commands.length; i++) print(commands[i]);
// }

macro "Keyboard shortcuts cheat sheet [n/]" {
	Dialog.createNonBlocking("keyboard shortcuts");
	Dialog.addMessage("* Macro shortcuts :\n"+
	"[ C ]___Contrast window\n"+
	"[ Z ]___Channels Tool\n"+
	"[ Q ]___switch color and composite mode\n"+
	"[ R ]___Auto-contrast all channels\n"+
	"[ r ]___Auto-contrast active channel\n"+
	"[ A ]___Run Enhance Contrast, saturated=0.3\n"+
	"[ 1 ]___set LUTs\n"+
	"[ S ]___Colored Splitview\n"+
	"[ p ]___Grayscale Splitview\n"+
	"[ E ]___Tile : reorder windows to see all\n"+
	"[ y ]___Open the tool 'synchronize windows'\n"+
	"[ q ]___Arrange channels order\n"+
	"[ d ]___Split Channels\n"+
	"[ M ]___Merge channels\n"+
	"[ D ]___Duplicate (all dimensions)\n"+
	"[ g ]___Z projection dialog \n"+
	"[ G ]___Maximal intensity projection\n"+
	"[ s ]___Save as Tiff",12);
	Dialog.show();
}

//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------
macro "AutoRun" {
	// run all the .ijm scripts provided in macros/AutoRun/
	//autoRunDirectory = getDirectory("imagej") + "/macros/AutoRun/";
	//if (File.isDirectory(autoRunDirectory)) { list = getFileList(autoRunDirectory); Array.sort(list); for (i = 0; i < list.length; i++) {if (endsWith(list[i], ".ijm")) {runMacro(autoRunDirectory + list[i]);}}}
	run("Roi Defaults...", "color=orange stroke=2 group=0");
	// eval("js", "javax.swing.UIManager.setLookAndFeel('javax.swing.plaf.metal.MetalLookAndFeel');");
	setTool(15);
}
function UseHEFT() {state = call("ij.io.Opener.getOpenUsingPlugins");if (state=="false") {setOption("OpenUsingPlugins", true);showStatus("TRUE (images opened by HandleExtraFileTypes)");} else {setOption("OpenUsingPlugins", false);showStatus("FALSE (images opened by ImageJ)");}}

var pencilWidth=1,eraserWidth=10,leftClick=16,alt=8,brushWidth=10,floodType="8-connected";
macro 'Pencil Tool Options...' {pencilWidth = getNumber("Pencil Width (pixels):", pencilWidth);}
macro 'Paintbrush Tool Options...' {brushWidth = getNumber("Brush Width (pixels):", brushWidth);call("ij.Prefs.set", "startup.brush", brushWidth);}
macro 'Flood Fill Tool Options...' {Dialog.create("Flood Fill Tool");Dialog.addChoice("Flood Type:", newArray("4-connected", "8-connected"), floodType);Dialog.show();floodType = Dialog.getChoice();call("ij.Prefs.set", "startup.flood",floodType);}
macro "Set Drawing Color..."{run("Color Picker...");}
