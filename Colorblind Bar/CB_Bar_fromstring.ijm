<fromString>
<stickToImageJ>
<noGrid>
<line>

<text> Colorblind Bar
<separator>

<button>
label=convert
bgcolor=#ffae00
arg=noiceLUTs();
<separator>

<button>
label=B&C
bgcolor=#b48aff
arg=B_and_C();
<separator>

<button>
label=composite/RGB
bgcolor=#60c1ff
arg=switcher();
<separator>

<button>
label=test CB
bgcolor=#ffd03e
arg=testCB();
<separator>

<button>
label=reorder LUTs
bgcolor=#b4e297
arg=reorderLUTs();
<separator>

<button>
label=invert
bgcolor=white
arg=invertRoll();
<separator>

<button>
label= X 
bgcolor=#ff989c
arg=<close>

</line>



<codeLibrary>

function LUTmaker(r,g,b){
	R = newArray(256); G = newArray(256); B = newArray(256);
	for(i=0; i<256; i++) { 
		R[i] = (r/256)*(i+1);
		G[i] = (g/256)*(i+1);
		B[i] = (b/256)*(i+1);
	}
	setLut(R, G, B);
}

function noiceLUTs(){
	if (nImages==0) exit("no image");
	if (isKeyDown("shift")&&bitDepth() != 24) {
		getDimensions(width, height, channels, slices, frames);
		if (channels==2) {
			Stack.setChannel(1); LUTmaker(255,90,0); //orange
			Stack.setChannel(2); LUTmaker(0,165,255); //blue
		}
		if (channels == 3) {
			Stack.setChannel(1); LUTmaker(255,0,225); //LUTmaker(205,0,225);
			Stack.setChannel(2); LUTmaker(255,255,0); //LUTmaker(250,190,0); //alternatives I like
			Stack.setChannel(3); LUTmaker(0,255,255); //LUTmaker(0,255,230);
		}
	}
	else RGBtoMYC();
}

function RGBtoMYC(){
	showStatus("RGB to MYC");
	setBatchMode(1);
	if (bitDepth() == 24){ //if RGB
		getDimensions(width, height, channels, slices, frames);
		if (selectionType() != -1) {
			id = getImageID();
			run("Copy"); 
			getSelectionBounds(x, y, width, height);
			newImage("dup", "RGB", width, height, 1);
			run("Paste");
			run("Make Composite"); run("Remove Slice Labels");
			Stack.setChannel(1); LUTmaker(128,0,127); resetMinAndMax;
			Stack.setChannel(2); LUTmaker(127,128,0); resetMinAndMax;
			Stack.setChannel(3); LUTmaker(0,127,128); resetMinAndMax;
			run("Flatten");
			run("Copy");
			selectImage(id);
			run("Paste"); 
			run("Select None");
		}
		else {
			run("Duplicate...","duplicate");
			run("Make Composite"); run("Remove Slice Labels");
			Stack.setChannel(1); LUTmaker(128,0,127); resetMinAndMax;
			Stack.setChannel(2); LUTmaker(127,128,0); resetMinAndMax;
			Stack.setChannel(3); LUTmaker(0,127,128); resetMinAndMax;
			if (slices*frames == 1) { Stack.setDisplayMode("color"); Stack.setDisplayMode("composite"); run("Stack to RGB"); }
		}
	}
	else {
		Stack.setChannel(1); LUTmaker(128,0,127);
		Stack.setChannel(2); LUTmaker(127,128,0);
		Stack.setChannel(3); LUTmaker(0,127,128);
	}
	setOption("Changes", 0);
	setBatchMode(0);
}

function switcher(){ //RGB to Composite et vice versa 
	if (nImages==0) exit("no image");
	getDimensions(width, height, channels, slices, frames);
	if (bitDepth() == 24) {
		run("Duplicate...","duplicate");
		run("Make Composite");
		run("Remove Slice Labels");
	}
	else if (slices*frames > 1) run("RGB Color", "keep");
	else run("Stack to RGB");
}

function B_and_C(){
	if (nImages == 0) { run("Brightness/Contrast..."); exit; }
	id=getImageID();
	getLocationAndSize(x, y, width, height);
	run("Brightness/Contrast...");
	selectWindow("B&C");
	setLocation(x+width+30, y);
	selectImage(id);
}

function testCB(){
	if (nImages == 0) exit("no image");
	setBatchMode(1);
	getDimensions(width, height, channels, slices, frames);
	if (slices*frames > 1) run("RGB Color", "keep");
	if (bitDepth()!= 24) run("Stack to RGB");
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
	run("Make Montage...", "columns=4 rows=1 scale=1 font="+ width/15 + " label");
	setOption("Changes", 0);
	setBatchMode(0);
}

function reorderLUTs(){
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

function invertRoll(){
	if (nImages == 0) exit("no image");
	if (bitDepth()!= 24) exit("only works on RGB images");
	showStatus("RGB to MYC");
	setBatchMode(1);
	id=getImageID();
	run("Copy"); 
	getSelectionBounds(x, y, width, height);
	newImage("dup", "RGB", width, height, 1);
	run("Paste");
	run("Make Composite");
	Stack.setChannel(1); LUTmaker(0,255,0); run("Invert LUT");
	Stack.setChannel(2); LUTmaker(0,0,255); run("Invert LUT");
	Stack.setChannel(3); LUTmaker(255,0,0); run("Invert LUT");
	run("Flatten");
	run("Copy");
	selectImage(id);
	run("Paste"); run("Select None");
	setOption("Changes", 0);
	setBatchMode(0);
}

</codeLibrary>