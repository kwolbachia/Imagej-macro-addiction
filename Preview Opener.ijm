macro "Preview Opener Tool - N66C000D34D35D36D37D38D39D3aD3bD3cD3dD3eD44D49D4eD54D59D5eD64D69D6eD74D79D7eD84D85D86D87D88D89D8aD8bD8cD8dD8eD94D99D9eDa4Da9DaeDb4Db9DbeDc4Dc9DceDd4Dd5Dd6Dd7Dd8Dd9DdaDdbDdcDddDdeDe4De9DeeC95fD4aD4bD4cD4dD5aD5bD5cD5dD6aD6bD6cD6dD7aD7bD7cD7dC09bC5ffCf05Cf85C8bfDeaDebDecDedCfc0D9aD9bD9cD9dDaaDabDacDadDbaDbbDbcDbdDcaDcbDccDcdCf5bCaf8Cfb8Ccf8D95D96D97D98Da5Da6Da7Da8Db5Db6Db7Db8Dc5Dc6Dc7Dc8Cf5dDe5De6De7De8C8fdCfa8D45D46D47D48D55D56D57D58D65D66D67D68D75D76D77D78Bf0C000D04D09D0eD14D19D1eD24D29D2eD34D35D36D37D38D39D3aD3bD3cD3dD3eD44D49D4eD54D59D5eD64D69D6eD74D79D7eD84D85D86D87D88D89D8aD8bD8cD8dD8eC95fC09bC5ffCf05Cf85D45D46D47D48D55D56D57D58D65D66D67D68D75D76D77D78C8bfD0aD0bD0cD0dD1aD1bD1cD1dD2aD2bD2cD2dCfc0Cf5bCaf8Cfb8Ccf8Cf5dD05D06D07D08D15D16D17D18D25D26D27D28C8fdD4aD4bD4cD4dD5aD5bD5cD5dD6aD6bD6cD6dD7aD7bD7cD7dCfa8B0fC000D03D07D13D17D23D27D30D31D32D33D34D35D36D37D43D47D53D57D63D67D73D77D80D81D82D83D84D85D86D87C95fC09bC5ffCf05Cf85C8bfCfc0D44D45D46D54D55D56D64D65D66D74D75D76Cf5bD04D05D06D14D15D16D24D25D26Caf8Cfb8D40D41D42D50D51D52D60D61D62D70D71D72Ccf8Cf5dC8fdD00D01D02D10D11D12D20D21D22Cfa8Nf0C000D30D31D32D33D34D35D36D37D43D47D53D57D63D67D73D77D80D81D82D83D84D85D86D87D93D97Da3Da7Db3Db7Dc3Dc7Dd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7De3De7C95fC09bD94D95D96Da4Da5Da6Db4Db5Db6Dc4Dc5Dc6C5ffD40D41D42D50D51D52D60D61D62D70D71D72Cf05D90D91D92Da0Da1Da2Db0Db1Db2Dc0Dc1Dc2Cf85C8bfCfc0Cf5bDe4De5De6Caf8D44D45D46D54D55D56D64D65D66D74D75D76Cfb8Ccf8Cf5dC8fdDe0De1De2Cfa8"{
	title = getTitle();
	if (startsWith(title, "Preview Opener")) openFromPreview();
	else showStatus("click on a 'Preview Opener.tif' image");
}
macro "Preview Opener Tool Options"{
	if (!isOpen("Preview Opener.tif")) makePreviewOpener();
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
//in their curent state. Will close all but the montage.
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

//Supposed to create RGB snapshot of any kind of opened image
function rgbSnapshot(){
	Stack.getPosition(channel, slice, frame);
	getDimensions(width, height, channels, slices, frames);
	if 		(bitDepth()==24) run("Duplicate..."," ");
	else if (channels==1) run("Duplicate...", "title=toClose channels=&channels slices=&slice frames=&frame");
	else 	run("Duplicate...", "duplicate title=toClose slices=&slice frames=&frame");
	run("RGB Color", "keep");
	rename("snap");
	close("toClose");
	setOption("Changes", 0);
}
