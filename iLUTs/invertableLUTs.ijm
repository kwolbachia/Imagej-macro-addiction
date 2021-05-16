<fromString>
<stickToImageJ>
<noGrid>
<line>
/*
2021/05/15 Terretaz Kevin @kWolbachia

ActionBar toolset for :
- personnalisation of linear LUTs combinaison
- possibility* to invert LUTs and see them displayed in imageJ whithout RGB conversion
- A splitview to see all channels and overlay in one window, reversible
- generate random invertable LUTs for inspiration ;)
- reorder LUTs in a similar way than the Arrange Channels tool.

note : the invert iLUTs tool will work from 2 to 4 channels.
these are the rules : 
- for 2 channel images the sum of all Reds, Greens and Blues must be == 255.
- for 3 and 4 channels, the sum must be 510 each.
overwise the result won't be satisfying.

Installation : provided you have the ActionBar plugin from @jmutterer installed and thanks to his magic, 
you just have to run this macro command line: 

run("Action Bar",File.openUrlAsString("https://raw.githubusercontent.com/kwolbachia/Imagej-macro-addiction/main/iLUTs/invertableLUTs.ijm"));

*/
<separator>
<text>LUTs tools
<separator>

<button>
label=Editor
bgcolor=#82c8ff
arg=<macro>
LUTbaker();
</macro>

<separator>

<button>
label=Invert iLUTs
bgcolor=#ffdd82
arg=<macro>
invert_iLUTs();
</macro>

<separator>

<button>
label=Splitview
bgcolor=#c3e08a
arg=<macro>
ultimateSplitview();
</macro>

<separator>

<button>
label=Reorder LUTs
bgcolor=#a7eadd
arg=<macro>
ReorderLUTs();
</macro>

<separator>

<button>
label=Random iLUTs
bgcolor=#c3b6ff
arg=<macro>
iLUTsGenerator();
</macro>

<separator>

<button>
label= X 
bgcolor=#ff989c
arg=<close>
</line>

<separator>

<codeLibrary>

function LUTbaker(){
	noRGB_errorCheck();
	Rz = newArray(4); Gz = newArray(4); Bz = newArray(4); preview = 1; randomize = 0;
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
		else Dialog.addMessage("LUTs probably won't be invertable :s");
		Dialog.addCheckbox("update changes", 1); 
		Dialog.addCheckbox("random invertable LUTs", randomize);
		Dialog.addCheckbox("invertable LUTs suggestion", 0);
		Dialog.addCheckbox("Reset all", 0);
		setBatchMode(0);
		Dialog.show();
		setBatchMode(1);
		preview = Dialog.getCheckbox();
		randomize = Dialog.getCheckbox();
		suggest = Dialog.getCheckbox();
		undo = Dialog.getCheckbox();
		selectImage(id);
		if (randomize+suggest+undo==0) for(k=0; k<CH; k++){
			Rz[k]=Dialog.getNumber();
			Gz[k]=Dialog.getNumber();
			Bz[k]=Dialog.getNumber();
			if (CH>1) Stack.setChannel(k+1);
			LUTmaker(Rz[k],Gz[k],Bz[k]);
		}
		if (randomize) iLUTsGenerator();
		if (suggest) good_iLUTs();
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

function invert_iLUTs(){
	noRGB_errorCheck();
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
			if(!is("Inverting LUT")){ 
				R=((256-r[255]/2)-128);
				G=((256-g[255]/2)-128);
				B=((256-b[255]/2)-128);
				LUTmaker(R,G,B);
				run("Invert LUT");		}
			else {
				R=((256-r[0])-128)*2;
				G=((256-g[0])-128)*2;
				B=((256-b[0])-128)*2;	
				LUTmaker(R,G,B);		}
			}
		if(CH>1)Stack.setChannel(ch); 
	setBatchMode(0);
}

function iLUTsGenerator(){
	noRGB_errorCheck();
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
}

function SplitviewInteractor(){
	getDimensions(w, h, ch, s, f);
	w=w/(ch+1);	overlay = (ch*w); id=getImageID();
	while (isOpen(id)) {
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

function ReorderLUTs(){
		noRGB_errorCheck();
		getDimensions(null, null, channels, null, null);
		Stack.getPosition(Channel, slice, frame);

	 //prompt LUTs order and ask for the new one
		Dialog.createNonBlocking("Reorder LUTs");
		for (i = 1; i <= channels; i++) {
			Stack.setChannel(i);
			getLut(r,g,b);
			if (is("Inverting LUT")) { R = r[0];   G = g[0];   B = b[0];   }
			else 					 { R = r[255]; G = g[255]; B = b[255]; }
			Dialog.addMessage("    LUT "+i, 20, lutToHex(R,G,B));
		}
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

function good_iLUTs(){
	getDimensions(width, height, channels, slices, frames);
	if (channels==1) exit("any lone linear LUT is invertable ;)");
	if (channels==2) {
		Stack.setChannel(1); LUTmaker(232,76,23);
		Stack.setChannel(2); LUTmaker(23,179,232);
	}
	if (channels==3) {
		Stack.setChannel(1); LUTmaker(36,216,246);
		Stack.setChannel(2); LUTmaker(226,106,164);
		Stack.setChannel(3); LUTmaker(248,188,100);
	}
	if (channels==4) {
		Stack.setChannel(1); LUTmaker(0,130,240);
		Stack.setChannel(2); LUTmaker(240,2,178);
		Stack.setChannel(3); LUTmaker(242,162,20);
		Stack.setChannel(4); LUTmaker(28,216,72);
	}
	if (channels>4) exit("this tool works with up to 4 channels");
}
</codeLibrary>
