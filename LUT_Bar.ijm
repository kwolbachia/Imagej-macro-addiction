<fromString>
<noGrid>
<title> LUTs

<line>

<button>
label=<html><html><font color='black'><b>  Awesome BW
bgcolor=lightgrey
arg=random_Awesome_LUT(4);

<button>
label=<html><font color='black'><b> Awesome 150
bgcolor=lightgrey
arg=random_150_lum_LUT(3);

<button>
label=<html><font color='black'><b> Viridis-like
bgcolor=lightgrey
arg=random_Viridis(4);

</line>//

<line>

<button>
label=<html><font color='black'><b> Opposite LUT
bgcolor=lightgrey
arg=create_Opposite_LUT();

<button>
label=<html><font color='black'><b> Spline fit
bgcolor=lightgrey
arg=lut_Spline_Fit(3);

<button>
label=<html><font color='black'><b> Spline 3-10
bgcolor=lightgrey
arg=lut_Spline_Fit_3_to_10();

</line>//

<line>

<button>
label=<html><font color='black'><b> Linearize LUT
bgcolor=lightgrey
arg=enluminate_LUT();

<button>
label=<html><font color='black'><b> Smooth LUT
bgcolor=lightgrey
arg=smooth_LUT();

<button>
label=<html><font color='black'><b> Crop LUT
bgcolor=lightgrey
arg=crop_LUT();

<button>
label=<html><font color='black'><b> Rotate LUT
bgcolor=lightgrey
arg=rotate_LUT();

</line>//
<line>

<button>
label=<html><font color='black'><b> iMQ Style
bgcolor=lightgrey
arg=convertTo_iMQ_Style();

<button>
label=<html><font color='black'><b> LUT Generator
bgcolor=lightgrey
arg=ultimate_LUT_Generator();

<button>
label=<html><font color='black'><b> Spline LUT Editor
bgcolor=lightgrey
arg=spline_LUT_maker();

</line>
//
<DnDAction>		
	dropped_Path = getArgument();
	if (endsWith(dropped_Path, ".tif")){
		id = getImageID();
		setBatchMode(1);
		run("TIFF Virtual Stack...", "open=["+dropped_Path+"]");
		id2 = getImageID();
		getDimensions(width, height, channels, slices, frames);
		for (i = 0; i < channels; i++) {
			selectImage(id2);
			Stack.setChannel(i+1);
			getLut(reds, greens, blues);
			selectImage(id);
			Stack.setChannel(i+1);
			setLut(reds, greens, blues);	
		}
		selectImage(id2);
		close();
	}
	else make_LUT_Montage_from_Path(dropped_Path);


	function make_LUT_Montage_from_Path(path){
		saveSettings();
		lut_Dir = path + File.separator;
		file_List = getFileList(lut_Dir);
		setBatchMode(true);
		newImage('ramp', '8-bit Ramp', 256, 32, 1);
		newImage('luts', 'RGB White', 256, 48, 1);
		count = 0;
		setForegroundColor(255, 255, 255);
		setBackgroundColor(255, 255, 255);
		//recursive processing
		processFiles(lut_Dir, file_List);
		run('Delete Slice');
		rows = floor(count/4);
		if (rows < count/4) rows++;
		run('Canvas Size...', 'width=258 height=50 position=Center');
		run('Make Montage...', 'columns=4 rows='+rows+' scale=1 first=1 last='+count+' increment=1 border=0 use');
		rename('Lookup Tables');
		setBatchMode(false);
		restoreSettings();

		function processFiles(folder, file_List) {
			file_List = getFileList(folder);
			for (i=0; i<file_List.length; i++) {
				if (File.isDirectory(folder + file_List[i])) processFiles(folder + file_List[i], file_List);
				else {
					path = folder+file_List[i];
					processFile(path);
				}
			}
		}

		function processFile(path) {
			if (endsWith(path, '.lut')) {
				selectWindow('ramp');
				open(path);
				getLut(reds, greens, blues);
				selectWindow('ramp');
				setLut(reds, greens, blues);
				run('Copy');
				selectWindow('luts');
				makeRectangle(0, 0, 256, 32);
				run('Paste');
				setJustification('center');
				setColor(0,0,0);
				setFont("SansSerif", 11, "antialiased");
				drawString(file_List[i], 128, 48);
				run('Add Slice');
				run('Select All');
				run('Clear', 'slice');
			}
			else {
				if(File.exists(path)){
					open(path);
					if (bitDepth()!=24) { 
						getLut(reds, greens, blues);
						selectWindow('ramp');
						setLut(reds, greens, blues);
						run('Copy');
						selectWindow('luts');
						makeRectangle(0, 0, 256, 32);
						run('Paste');
						setJustification('center');
						setColor(0, 0, 0);
						setFont('Arial', 14);
						drawString(file_List[i], 128, 48);
						run('Add Slice');
						run('Select All');
						run('Clear', 'slice');
					}
				}
			}
			count++;
		}
	}
</DnDAction>


<codeLibrary>//

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
	
	function spline_LUT_maker(){
		error_Check_for_LUTs();
		getLut(reds, greens, blues);
		start_Lum = get_Luminance(newArray(reds[0], greens[0], blues[0]));
		stop_Lum =  get_Luminance(newArray(reds[255], greens[255], blues[255]));
		steps = 4;
		Dialog.createNonBlocking("steps");
		Dialog.addSlider("how many steps?", 1, 8, steps);
		Dialog.show();
		steps =  Dialog.getNumber();
		red_Steps = newArray(0); 
		green_Steps = newArray(0); 
		blue_Steps = newArray(0);
		//extract the current colors of the LUT at every step
		for (i = 0; i < steps; i++) {
			red_Steps[i] =     reds[i * (255 / (steps-1))];
			green_Steps[i] = greens[i * (255 / (steps-1))];
			blue_Steps[i] =   blues[i * (255 / (steps-1))];
		}
		while (true) {
			getLocationAndSize(x, y, width, heigth);
			Dialog.createNonBlocking("colors");
			for (i = 0; i < steps; i++) {
				Dialog.addMessage("COLOR " + (i+1), 20, lut_To_Hex(red_Steps[i], green_Steps[i], blue_Steps[i]));
				Dialog.addSlider("red",	 0,255, red_Steps[i]);
				Dialog.addSlider("green",0,255, green_Steps[i]);
				Dialog.addSlider("blue", 0,255, blue_Steps[i]);
				color = newArray(green_Steps[i], green_Steps[i], blue_Steps[i]);
				Dialog.addMessage("actual lum:" + get_Luminance(color) + "  expected: " + i*((stop_Lum - start_Lum)/(steps-1)));
			}
			Dialog.setLocation(x + width, y);
			Dialog.show();
			for (i = 0; i < steps; i++) {
				red_Steps[i] = Dialog.getNumber();
				green_Steps[i] = Dialog.getNumber();
				blue_Steps[i] = Dialog.getNumber();
			}
			for(i=0; i<steps; i++) { 
				reds  [i*(255/steps)] =   red_Steps[i];
				greens[i*(255/steps)] = green_Steps[i];
				blues [i*(255/steps)] =  blue_Steps[i]; 
				showProgress(i / steps);
			}
			setBatchMode(1);
			reds =   spline_Color_2(red_Steps,(steps));
			greens = spline_Color_2(green_Steps,(steps));
			blues =  spline_Color_2(blue_Steps,(steps));
			setLut(reds, greens, blues);
			run("Select None");
			run("Remove Overlay");
			setBatchMode(0);
			plot_LUT();
			copy_LUT();
		}

		function lut_To_Hex(red, green, blue){
		    hex_Red =   IJ.pad(toHex(red), 2);
		    hex_Green = IJ.pad(toHex(green), 2);
		    hex_Blue =  IJ.pad(toHex(blue), 2);
			return "#" + hex_Red + hex_Green + hex_Blue;
		}

		function spline_Color_2(color,steps){
			Overlay.remove;
			X = newArray(0); Y = newArray(0);
			for (i = 0; i < steps; i++) X[i] = round((255 / (steps-1)) * i);
			for (i = 0; i < steps; i++) Y[i] = color[i];
			makeSelection("polyline", X, Y);
			run("Fit Spline");
			Overlay.addSelection("white");
			getSelectionCoordinates(splined_X, splined_Y);
			splined_Y = Array.resample(splined_Y, 256);
			Array.getStatistics(splined_Y, min, max, mean, stdDev);
			for (k=0; k<256; k++) splined_Y[k] = 255 - (maxOf(0, minOf(255, 255 - splined_Y[k])));
			X = Array.resample(X, 256);
			return splined_Y;
		}
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

	function smooth_LUT(){
		setBatchMode(true);
		sigma = 2;
		if (isKeyDown("shift")) sigma = getNumber("blurring sigma?", 2);
		title = "Smoothed_"+getTitle();
		getLut(reds, greens, blues);
		newImage(title, "8-bit ramp", 256, 32, 1);
		setLut(reds, greens, blues);
		run("Duplicate...","duplicate");
		run("RGB Color");
		run("Gaussian Blur...", "sigma=&sigma");
		for (i = 0; i < 256; i++) {
			c = getPixel(i, 2);
			reds[i] = (c>>16)&0xff; 	
			greens[i] = (c>>8)&0xff;		
			blues[i] = c&0xff;
		}
		selectWindow(title);
		setLut(reds, greens, blues);
		setBatchMode(false);
	}

	function ultimate_LUT_Generator(){
		colors = newArray("red","orange","yellow","green","cyan","blue","magenta","gray");
		//colors = newArray("red(10-167)","green(10-225)","blue(10-175)","cyan(10-190)","magenta(10-190)","yellow(10-225)","orange(10-190)","gray(0-255)");
		chosen_Colors = newArray("gray","gray","gray","gray","gray","gray","gray","gray");
		start_Lum = 0;
		stop_Lum = 255;
		steps = 4;
		Dialog.createNonBlocking("steps");
		Dialog.addSlider("how many steps?", 1, 8, steps);
		Dialog.show();
		steps =  Dialog.getNumber();
		Dialog.createNonBlocking("colors");
		Dialog.addSlider("start luminance?", 0, 255, start_Lum);
		Dialog.addSlider("stop luminance?", 0, 255, stop_Lum);
		for (i = 0; i < steps; i++) Dialog.addRadioButtonGroup("color " + i+1, colors, 1, 8, chosen_Colors[i]);
		Dialog.show();
		for (i = 0; i < steps; i++) chosen_Colors[i] = Dialog.getRadioButton();
		start_Lum = Dialog.getNumber();
		stop_Lum = Dialog.getNumber();
		while (true) {
			error_Check_for_LUTs();
			setBatchMode(1);
			reds = newArray(256); greens = newArray(256); blues = newArray(256);
			range = stop_Lum - start_Lum;
			for(i=0; i<steps; i++) { 
				targetLum = i * (range / (steps-1)) + start_Lum;
				color = random_Color_By_Type_And_Luminance(targetLum, chosen_Colors[i]);
				reds[i*(255/(steps-1))] = color[0];
				greens[i*(255/(steps-1))] = color[1];
				blues[i*(255/(steps-1))] = color[2]; 
				showProgress(i/steps);
			}
			reds = spline_Color(reds,(steps-1));
			greens = spline_Color(greens,(steps-1));
			blues = spline_Color(blues,(steps-1));
			setLut(reds, greens, blues);
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

	function lut_Spline_Fit_3_to_10(){
		setBatchMode(1);
		title = getTitle();
		channels = 7;
		getLut(reds, greens, blues);
		id = getImageID();
		newImage("LUTs", "8-bit color-mode", 256, 32*channels, channels, 1, 1);
		id2 = getImageID();
		newImage("ramp", "8-bit Ramp", 256, 32, 1);
		run("Copy");
		selectImage(id2);
		y = 0;
		for (i = 0; i < channels; i++) {
			selectImage(id2);
			Stack.setChannel(i+1);
			setLut(reds, greens, blues);
			makeRectangle(0, y, 256, 32);
			run("Paste");
			lut_Spline_Fit2(i+3);
			Property.setSliceLabel(i+3);
			y += 32;
		}
		run("Select None");
		Stack.setDisplayMode("color");
		setOption("Changes", 0);
		setBatchMode(0);
		
		function lut_Spline_Fit2(steps){
			getLut(r,g,b);
			reds = newArray(256); greens = newArray(256); blues = newArray(256);
			reds = spline_Color(r,steps);
			greens = spline_Color(g,steps);
			blues = spline_Color(b,steps);
			setLut(reds, greens, blues);
			run("Select None");
			run("Remove Overlay");
		}
	}

	function lut_Spline_Fit(steps){
		error_Check_for_LUTs();
		if (isKeyDown("shift")) steps = getNumber("how many steps?", 3);
		getLut(r,g,b);
		newImage("Smoothed LUT", "8-bit ramp", 256, 32, 1);
		reds = newArray(256); greens = newArray(256); blues = newArray(256);
		reds = spline_Color(r, steps);
		greens = spline_Color(g, steps);
		blues = spline_Color(b, steps);
		setLut(reds, greens, blues);
		run("Select None");
		run("Remove Overlay");
		plot_LUT();
	}

	function random_Awesome_LUT(steps) {
		error_Check_for_LUTs();
		if (isKeyDown("shift")) steps = getNumber("how many steps?", steps);
		setBatchMode(1);
		reds = newArray(256); greens = newArray(256); blues = newArray(256);
		for(i=0; i<=steps; i++) { 
			color = random_Color_By_Luminance(i*(255/steps));
			reds[i*(255/steps)] = color[0];
			greens[i*(255/steps)] = color[1];
			blues[i*(255/steps)] = color[2]; 
			showProgress(i/steps);
		}
		reds = spline_Color(reds,steps);
		greens = spline_Color(greens,steps);
		blues = spline_Color(blues,steps);
		setLut(reds, greens, blues);
		run("Select None");
		run("Remove Overlay");
		setBatchMode(0);
		plot_LUT();
		copy_LUT();
	} 

	function random_150_lum_LUT(steps) {
		error_Check_for_LUTs();
		if (isKeyDown("shift")) steps = getNumber("how many steps?", 3);
		setBatchMode(1);
		reds = newArray(256); greens = newArray(256); blues = newArray(256);
		for(i=0; i<=steps; i++) { 
			color = random_Color_By_Luminance(i*(150/steps)); 
			reds[i*(255/steps)] = color[0]; reds[0] = 0;
			greens[i*(255/steps)] = color[1]; greens[0] = 0;
			blues[i*(255/steps)] = color[2]; blues[0] = 0;
			showProgress(i/steps);
		}
		reds = spline_Color(reds, steps);
		greens = spline_Color(greens, steps);
		blues = spline_Color(blues, steps);
		setLut(reds, greens, blues);
		run("Select None");
		run("Remove Overlay");
		plot_LUT();
		setBatchMode(0);
		copy_LUT();
	}

	function random_Viridis(steps) {
		error_Check_for_LUTs();
		if (isKeyDown("shift")) steps = getNumber("how many steps?", 3);
		reds = newArray(256); greens = newArray(256); blues = newArray(256);
		baseColor = random_Color_By_Luminance(50);
		for(i=0; i<=steps; i++) { 
			color = random_Color_By_Luminance(i*(170/steps)+50);
			reds[i*(255/steps)] = color[0]; reds[0] = baseColor[0];
			greens[i*(255/steps)] = color[1]; greens[0] = baseColor[1];
			blues[i*(255/steps)] = color[2]; blues[0] = baseColor[2];
			showProgress(i/steps);
		}
		reds = spline_Color(reds,steps);
		greens = spline_Color(greens,steps);
		blues = spline_Color(blues,steps);
		setLut(reds, greens, blues);
		run("Select None");
		run("Remove Overlay");
		plot_LUT();
		setBatchMode(0);
		copy_LUT();
	}

	function create_Opposite_LUT(){
		error_Check_for_LUTs();
		setBatchMode(1);
		getLut(reds, greens, blues);
		newImage("opposite LUT", "8-bit ramp", 256, 32, 1);
		comp = newArray(0);
		for (i = 0; i < 256; i++) {
			comp = get_Complentary_Color(reds[i], greens[i], blues[i]);
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

	function enluminate_LUT(){
		error_Check_for_LUTs();
		setBatchMode(1);
		getLut(reds, greens, blues);
		start_Lum = get_Luminance(newArray(reds[0], greens[0], blues[0]));
		stop_Lum = get_Luminance(newArray(reds[255], greens[255], blues[255]));
		Dialog.createNonBlocking("colors");
		Dialog.addSlider("start luminance?", 0, 255, start_Lum);
		Dialog.addSlider("stop luminance?", 0, 255, stop_Lum);
		Dialog.show();
		start_Lum = Dialog.getNumber();
		stop_Lum = Dialog.getNumber();
		range = stop_Lum - start_Lum;
		for (i = 0; i < 256; i++) { 
			rgb = newArray(reds[i], greens[i], blues[i]);
			color = adjust_Color_To_Luminance(rgb, ((range/256) *i) + start_Lum);
			reds[i] = color[0];
			greens[i] = color[1];
			blues[i] = color[2];
			showProgress(i/255);
		}
		newImage("adjusted LUT", "8-bit ramp", 256, 32, 1);
		setLut(reds, greens, blues);
		setBatchMode(0);
		copy_LUT();
	}

	function crop_LUT(){
		id = toolID();
		run("Select All");
		setTool(0);
		waitForUser("adjust the selection to crop");
		setBatchMode(1);
		run("Duplicate...","duplicate");
		run("RGB Color");
		run("Scale...",	"x=- y=- width=256 height=65 interpolation=Bicubic average create");
		reds = newArray(1); greens = newArray(1); blues = newArray(1);
		for (i = 0; i < 256; i++) {
			color = getPixel(i, 2);
			reds[i] = (color>>16)&0xff; 	
			greens[i] = (color>>8)&0xff;		
			blues[i] = color&0xff;
		}
		newImage("new LUT", "8-bit ramp", 256, 32, 1);
		setLut(reds, greens, blues);
		setBatchMode(0);
		setTool(id);
	}

	function random_Color_By_Type_And_Luminance(luminance, target_Color_Type) {
		color = newArray(3); 
		loop = 1; 
		rgb_weight = newArray(0.299,0.587,0.114);
		color_Type = "";
		count = 0;
		while (loop) {
			if (count > 20000) exit("can't generate color "+target_Color_Type+" with a luminance of "+luminance);
			if (target_Color_Type == "gray") color = newArray(luminance, luminance, luminance);
			else color = random_Color_By_Luminance(luminance);
			Array.getStatistics(color, min, max, mean, stdDev);
			red = color[0]; 
			green = color[1]; 
			blue = color[2];
			if (red==max && (blue/red) <= 0.5 && (green/red) <= 0.5) 									color_Type = "red"; // 165 max lum
 
			if (red==max && blue==min && (blue/max) < 0.2 && (green/red) < 0.63 && (green/red) > 0.4)	color_Type = "orange"; //176

			if (blue==min && (blue/max) < 0.2 && (green/red) >= 0.8 && (red/green) > 0.9) 				color_Type = "yellow"; //232

			if (green==max && (red/green) < 0.85 && (blue/green) < 0.6) 								color_Type = "green"; // 231

			if (green==max && red==min && (red/max) < 0.2 && (blue/green) > 0.8)						color_Type = "cyan"; //194

			if (blue==max && red==min && (red/max) < 0.2 && (green/blue) < 0.85)						color_Type = "blue"; //171

			if (green==min && (green/max) < 0.4 && (green/red) < 0.65 && (green/blue) < 0.75) 			color_Type = "magenta"; //164

			if (red==green && blue==green) 																color_Type = "gray";

			if (color_Type == target_Color_Type) loop = 0;
			if (target_Color_Type == "any") loop = 0;
			if (luminance < 100 && (blue > 170 || red > 200)){color_Type = ""; loop=1;} //avoid screen saturation 
			count++;
			showProgress(count/20000);
		}	
		// s=""; for (i = 0; i < red; i+=2) s+="|"; print(s,red);
		// s=""; for (i = 0; i < green; i+=2) s+="|"; print(s,green);
		// s=""; for (i = 0; i < blue; i+=2) s+="|"; print(s,blue);
		// "     ";
		return color;
	}

	function convertTo_iMQ_Style() {
		if(nImages == 0) exit;
		greyZero = 0;
		if (isKeyDown("shift")) greyZero = 1;
		getLut(reds, greens, blues);
		newImage("lut", "8-bit ramp", 192, 32, 1);
		setLut(reds, greens, blues);
		setBatchMode(1);
		run("RGB Color"); rename(1);
		newImage("iGrays", "8-bit ramp", 64, 32, 1);
		run("Invert LUT");
		if (greyZero) {
			grey  = Array.resample(newArray(120,0),256);
			setLut(grey, grey, grey);
		}
		run("RGB Color");
		rename(2);
		run("Combine...", "stack1=2 stack2=1");
		selectWindow("Combined Stacks");
		for (i = 0; i < 256; i++) {
			color = getPixel(i, 2);
			reds[i] = (color>>16)&0xff; 	greens[i] = (color>>8)&0xff;		blues[i] = color&0xff;
		}
		newImage("iMQ Style LUT!", "8-bit ramp", 256, 32, 1);
		setLut(reds, greens, blues);
		setBatchMode(0);
	}

	//--------------------------------------------------------------------------------------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------------------------------------

	function error_Check_for_LUTs(){
		if (nImages == 0) newImage("LUT", "8-bit ramp", 256, 32, 1);
		if (nImages > 0) {
			if (getTitle() == "LUT Profile") close("LUT Profile");
			if (bitDepth()==24) newImage("LUT", "8-bit ramp", 256, 32, 1);
		}
	}

	function random_Color_By_Luminance(targetLum){ 
		rgb = newArray(3); loop=1; rgb_weight = newArray(0.299,0.587,0.114);
		luminance = 0;
		while (loop) {
			if (targetLum == 0) break;
			if (targetLum == 255) {
				rgb = newArray(255,255,255);
				break;
			}
			for (i = 0; i < 3; i++) {
				rgb[i] = round(random*255);
				luminance += round(rgb[i]*rgb_weight[i]);
			}
			if (luminance >= targetLum-1 && luminance <= targetLum+1) loop=0;
			if (targetLum < 127 && (rgb[2] > 170 || rgb[0] > 200)){color_Type = ""; loop=1;} //avoid screen saturation 
			luminance = 0;
		}
		return rgb;
	}

	function adjust_Color_To_Luminance(rgb, targetLum){
		inputLum = get_Luminance(rgb); rgb_weight = newArray(0.299,0.587,0.114);
		loop=1; luminance = 0; i=1;
		while (loop) {
			if (targetLum == 0) {
				rgb = newArray(0,0,0);
				break;
			}
			if (targetLum == 255) {
				rgb = newArray(255,255,255);
				break;
			}
			if (i==2) i = -1;
			if (inputLum < targetLum) {
				i++;
				rgb[i]++;
				if (rgb[i] > 255) rgb[i] = 255;
			}
			else if (inputLum > targetLum){
				i++;
				rgb[i]--;
				if (rgb[i] < 0) rgb[i] = 0;
			}
			for (k = 0; k < 3; k++) luminance += round(rgb[k] * rgb_weight[k]);
			if (luminance >= targetLum-1 && luminance <= targetLum+1) loop=0;
			luminance = 0;
		}
		return rgb;
	}

	//color = reds, greens or blues from getLut
	function spline_Color(color, steps){
		Overlay.remove;
		X = newArray(0); Y = newArray(0);
		for (i = 0; i <= steps; i++) X[i] = (255/steps)*i;
		for (i = 0; i <= steps; i++) Y[i] = color[X[i]];
		makeSelection("polyline", X,Y);
		run("Fit Spline");
		Overlay.addSelection("white");
		getSelectionCoordinates(splined_X, splined_Y);
		splined_Y = Array.resample(splined_Y,256);
		Array.getStatistics(splined_Y, min, max, mean, stdDev);
		for (k=0;k<256;k++) splined_Y[k] = 255-(maxOf(0,minOf(255,255-splined_Y[k])));
		X = Array.resample(X,256);
		return splined_Y;
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
		if (!isOpen("LUT Profile")) call("ij.gui.ImageWindow.setNextLocation", 0, screenHeight() - 470);
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

	function get_Complentary_Color(r, g, b){
		rgb = newArray(r, g, b);
		lum = get_Luminance(rgb);
		Array.getStatistics(rgb, min, max, mean, stdDev);
		third_number = (rgb[0]+rgb[1]+rgb[2])-(min+max);
		for (i = 0; i < 3; i++) {
			if      (rgb[i] == min) rgb[i] = max;
			else if (rgb[i] == third_number) rgb[i] = (max+min)-third_number;
			else if (rgb[i] == max) rgb[i] = min;
		}
		rgb2 = adjust_Color_To_Luminance(rgb,lum);
		return rgb2;
	}

	function get_Luminance(rgb){
		rgb_weight = newArray(0.299,0.587,0.114);
		luminance = 0;
		for (i = 0; i < 3; i++) luminance += round(rgb[i]*rgb_weight[i]);
		return luminance;
	}

	function copy_LUT() {
		saveAs("lut", getDirectory("temp")+"/copiedLut.lut");
		showStatus("Copy LUT");
	}

	function paste_LUT(){
		open(getDirectory("temp")+"/copiedLut.lut");
		showStatus("Paste LUT");
	}

	function simulate_Full_Deuteranopia(){
		// from the dichromacy plugin
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

	//Supposed to create an RGB snapshot of any kind of opened image
	//check sourcecode for save as jpeg and stuff, how does it works?
	function rgb_Snapshot(){
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


</codeLibrary>