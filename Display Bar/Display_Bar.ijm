<fromString>
<stickToImageJ>
<noGrid>
<line>
/////////////////////under construction

<separator>
<text>Display
<separator>

<button>
label=Auto-contrast
bgcolor=#82c8ff
arg=<macro>
if (isKeyDown("shift")) AutoContrastOnAllChannels(); else if (isKeyDown("space")) ResetAllContrasts(); else Adjust_Contrast();
</macro>

<separator>

<button>
label= X 
bgcolor=#ff989c
arg=<close>
</line>

<separator>
<codeLibrary>

function Adjust_Contrast() { 
	setBatchMode(1);
	id = getImageID();
	getDimensions(width, height, channels, slices, frames);
	if (slices*frames*channels == 1) {
		getStatistics(area, mean, min, max, std, histogram);
	}
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
	close("temp");
	setBatchMode("exit and display");
	updateDisplay();
}// Note : I discovered that the built-in command 'run("Enhance Contrast...", "saturated=0.001 use");' give same results
//		  but it only works on single channel stacks so this macro is still necessary for hyperstacks.

function AutoContrastOnAllChannels() {
	getDimensions(w, h, CH, s, f);
	Stack.getPosition(ch, s, f);
	for (i = 1; i <= CH; i++) {
		Stack.setPosition(i, s, f);
		Adjust_Contrast();	
	}
	Stack.setPosition(ch, s, f);
	makeRectangle(5,5,5,5); run("Select None"); //trick for display update
}

function ResetAllContrasts() {
	showStatus("Reset all contrasts");
	Get_all_IDs();
	for (i=0; i<all_IDs.length; i++) {
		showProgress(i/all_IDs.length);
		selectImage(all_IDs[i]);
	    run("Auto-contrast on all channels");	
	}
}
var all_IDs = newArray(1);

function Get_all_IDs(){	
	all_IDs = newArray(nImages);
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		all_IDs[i] = getImageID(); 
	} 
}

</codeLibrary>