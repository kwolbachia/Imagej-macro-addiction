<fromString>
<line>


<button>
label= Awesome LUT
bgcolor=#8fadda
arg=randomAwesomeLUT(3);


<button>
label=Awesome 150
bgcolor=#ffd900
arg=random150lumLUT(2);


<button>
label=Viridis-like
bgcolor=#b57ad6
arg=randomViridis(3);

</line>

<line>

<button>
label=opposite LUT
bgcolor=#ff815d
arg=createOppositeLUT();/////


<button>
label=enluminate LUT
bgcolor=yellow
arg=enluminateLUT();


<button>
label=Spline fit
bgcolor=#7ec1b4
arg=lutSplineFit(3);

</line>

<line>

<button>
label=Crop LUT
bgcolor=#8fc000
arg=cropLUT();

<button>
label=copy LUT
bgcolor=#ff456b
arg=copyLUT();


<button>
label=paste LUT
bgcolor=#8997ff
arg=pasteLUT();


<button>
label=show LUT
bgcolor=#00b8e1
arg=plotLUT();

</line>
<line>

<button>
label=random150 multi
bgcolor=#1ea208
arg=randomLightLUTs();

<button>
label=iMQ Style
bgcolor=##5b5b5b
arg=convertTo_iMQ_Style();


<button>
label=invert LUT 1
bgcolor=yellow
arg=invertLUT1();

<button>
label=ultimate
bgcolor=orange
arg=ultimateLUTgenerator();

</line>
<codeLibrary>
////

function ultimateLUTgenerator(){
	colors = newArray("red","green","blue","cyan","magenta","yellow","orange","gray");
	//colors = newArray("red(10-167)","green(10-225)","blue(10-175)","cyan(10-190)","magenta(10-190)","yellow(10-225)","orange(10-190)","gray(0-255)");
	chosenColors = newArray("gray","gray","gray","gray","gray","gray","gray","gray");
	startLum = 0;
	stopLum = 255;
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

function lutSplineFit(steps){
	basicErrorCheck();
	if (isKeyDown("shift")) steps = getNumber("how many steps?", 3);
	getLut(r,g,b);
	newImage("Smoothed LUT", "8-bit ramp", 256, 32, 1);
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
	plotLUT();
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
	if (isKeyDown("shift")) steps = getNumber("how many steps?", 3);
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
	newImage("opposite LUT", "8-bit ramp", 256, 32, 1);
	comp = newArray(0);
	for (i = 0; i < 256; i++) {
		comp = complementary(reds[i],greens[i],blues[i]);
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

function enluminateLUT(){
	basicErrorCheck();
	setBatchMode(1);
	getLut(reds, greens, blues);
	startLum = getLum(newArray(reds[0], greens[0], blues[0]));
	stopLum = getLum(newArray(reds[255], greens[255], blues[255]));
	Dialog.createNonBlocking("colors");
	Dialog.addSlider("start luminance?", 0, 255, startLum);
	Dialog.addSlider("stop luminance?", 0, 255, stopLum);
	Dialog.show();
	startLum = Dialog.getNumber();
	stopLum = Dialog.getNumber();
	range = stopLum-startLum;
	for (i = 0; i < 256; i++) { 
		rgb = newArray(reds[i], greens[i], blues[i]);
		color = adjustColorToLuminance(rgb, ((range/256) *i) + startLum);
		reds[i] = color[0];
		greens[i] = color[1];
		blues[i] = color[2];
		showProgress(i/255);
	}
	newImage("adjusted LUT", "8-bit ramp", 256, 32, 1);
	setLut(reds, greens, blues);
	setBatchMode(0);
	copyLUT();
}

function invertLUT1(){
	basicErrorCheck();
	getLut(reds, greens, blues);
	rgb = newArray(reds[255],greens[255],blues[255]);
	lum = getLum(rgb);
	setBatchMode(1);
	comp = newArray(0);
	for (i = 0; i < 256; i++) {
		rgb = newArray(reds[i],greens[i],blues[i]);
		comp = adjustColorToLuminance(rgb,255-(lum/256)*i);
		reds[i] = comp[0];
		greens[i] = comp[1];
		blues[i] = comp[2];
		showProgress(i/255);
	}
	newImage("inverted LUT", "8-bit ramp", 256, 32, 1);
	setLut(reds, greens, blues);
	setBatchMode(0);
	copyLUT();
}

function cropLUT(){
	run("Select All");
	waitForUser("adjust the selection to crop");
	setBatchMode(1);
	run("Duplicate...","duplicate");
	run("RGB Color");
	run("Scale...",	"x=- y=- width=256 height=65 interpolation=Bicubic average create");
	R = newArray(1); G = newArray(1); B = newArray(1);
	for (i = 0; i < 256; i++) {
		c = getPixel(i, 2);
		R[i] = (c>>16)&0xff; 	
		G[i] = (c>>8)&0xff;		
		B[i] = c&0xff;
	}
	newImage("new LUT", "8-bit ramp", 256, 32, 1);
	setLut(R, G, B);
	setBatchMode(0);
}

function randomLightLUTs() {
	Types = newArray("blue","orange","magenta","green","any","any","any");
	getDimensions(w,h,channels,s,f);
	if (channels>1){
		Stack.setDisplayMode("composite");
		for(i=1; i<=channels; i++){
			Stack.setChannel(i);
			rgb = randomColorByTypeAndLum(150, Types[i-1]);
			LUTmaker(rgb[0],rgb[1],rgb[2]);
		}
	}
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
		if (blue==max && red==min && red<100 && (green/blue)<0.8)	colorType = "blue";
		if (blue==max && red==min && red<50 && (green/blue)>0.85)	colorType = "cyan";
		if (green==min && (green/red)<0.75 && (green/blue)<0.6) 	colorType = "magenta";
		if (red==max && blue==min && blue<50 && (green/red)<0.75)  	colorType = "orange";
		if (red==max && blue==min && blue<50 && (green/red)>0.9) 	colorType = "yellow";
		if (red==green && blue==green) 								colorType = "gray";
		if (colorType == targetColorType) loop = 0;
		if (targetColorType == "any") loop = 0;
		count++;
	}
	return rgb;
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

// function adjustColorToLuminance(rgb,lum){
// 	lum2 = getLum(rgb); rgb_weight = newArray(0.299,0.587,0.114);
// 	loop=1; luminance = 0;
// 	while (loop) {
// 		if (lum2<lum) {
// 			for (i = 0; i < 3; i++) {
// 				rgb[i] ++;
// 				if (rgb[i]>=255) rgb[i] = 255;
// 			}
// 		}
// 		else if (lum2>lum){
// 			for (i = 0; i < 3; i++) {
// 				rgb[i] --;
// 				if (rgb[i]<0) rgb[i] = 0;
// 			}
// 		}
// 		luminance = getLum(rgb);
// 		if (luminance>=lum-2 && luminance<=lum+2)loop=0;
// 		print(luminance);
// 		luminance = 0;
// 		Array.print(rgb);
// 	}
// 	return rgb;
// }

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

function plotLUT(){
	close("MultiPlot");
	if (nImages == 0) exit;
	alreadyOpenPlot = 0;
	if (bitDepth()==24) exit;
	if (isOpen("LUT Profile")) alreadyOpenPlot = 1;
	id=getImageID();
	lutinance = newArray(0); //luminance of LUT...
	getLut(r,g,b);
	setBatchMode(1);
		newImage("LUT for plot", "8-bit ramp", 385, 14, 1);
		setLut(r,g,b);
		run("Copy");
		close("LUT for plot");
	setBatchMode(0);
	run("Plots...", "width=400 height=200");
	Plot.create("LUT Profile", "Grey Value", "value");
	Plot.setColor("#ff4a4a");
	Plot.setLineWidth(2);
	Plot.add("line", r);
	Plot.setColor("#8ce400");
	Plot.setLineWidth(2);
	Plot.add("line", g);
	Plot.setColor("#60c3ff");
	Plot.setLineWidth(2);
	Plot.add("line", b);
	lutinance = getLUTinance(r,g,b);
	Plot.setColor("white");
	Plot.setLineWidth(2);
	Plot.add("line", lutinance);
	Plot.setBackgroundColor("#2f2f2f");
	Plot.setAxisLabelSize(14.0, "bold");
	Plot.setFormatFlags("0");
	Plot.addLegend("1__reds\n2__greens\n3__blues\n4__luminance", "Top-Left Transparent");
	Plot.update();
	selectWindow("LUT Profile");
	if (!alreadyOpenPlot) setLocation(50,300);
	Plot.setLimits(-5, 260, -25, 260);
	makeRectangle(82, 200, 385, 14);
	run("Paste"); run("Select None"); 
	setOption("Changes",0);
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

function LUTmaker(r,g,b){
	R = newArray(256); G = newArray(256); B = newArray(256);
	for(i=0; i<256; i++) { 
		R[i] = (r/256)*(i+1);
		G[i] = (g/256)*(i+1);
		B[i] = (b/256)*(i+1);
	}
	setLut(R, G, B);
}

function copyLUT() {
	saveAs("lut", getDirectory("temp")+"/copiedLut.lut");
	showStatus("Copy LUT");
}

function pasteLUT(){
	open(getDirectory("temp")+"/copiedLut.lut");
	showStatus("Paste LUT");
}
</codeLibrary>
