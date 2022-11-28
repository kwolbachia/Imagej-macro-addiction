// Kevin Terretaz 
//adapted from Aleš Kladnik there https://forum.image.sc/t/automatic-scale-bar-in-fiji-imagej/60774

var add_text = true;

macro "Live Scale Bar Tool - C000 T0508B  T5508a  Ta508r"{
	getPixelSize(unit,w,h);
	if (unit == "pixels") exit("Image not spatially calibrated");
	bar_length = 1;	// initial scale bar length in measurement units
	bar_relative_size = 0;
	bar_height = 0;
	if (add_text == true) text_parameter = "bold";
	else text_parameter = "hide";
	font_size = minOf(Image.width, Image.height) / 30; // estimation of "good" font size
	getCursorLoc(x2, y2, z2, flags2);
	getCursorLoc(last_x, last_y, z, flags);
	while (flags >= 16) {			
		getCursorLoc(x, y, z, flags);
		getDisplayedArea(area_x, area_y, width, height);
		//if mouse moved
		if (x != last_x || y != last_y) {
			// approximate size of the scale bar relative to image width
			bar_relative_size = round(((width-(x - area_x))/width) * 10);

			// recursively calculate a 1-2-5-10-20... series
			// 1-2-5 series is calculated by repeated multiplication with 2.3, rounded to one significant digit
			for (i = 0; i < bar_relative_size; i++) {
				magical_formula = Math.pow( 10, (floor( Math.log10( abs(bar_length * 2.3)))));
				bar_length = round( (bar_length*2.3) / magical_formula) * magical_formula;
			}

			bar_height = round(((height - (y - area_y)) / height) * Image.height/20);

			//if size or height values changed from last loop, update scale bar
			if (bar_relative_size != lastSIZE || bar_height != lastHEIGHT) 
				run("Scale Bar...", "width=&bar_length height=&bar_height font=&font_size color=White background=None location=[Lower Right] "+ text_parameter +" overlay");
			showStatus("height = "+bar_height+ "px   length = "+ bar_length + unit);
			bar_length = 1;
		}
		//save changes
		lastSIZE = bar_relative_size;
		lastHEIGHT = bar_height;
		getCursorLoc(last_x, last_y, z, flags);
		wait(10);
	}
}

macro "Live Scale Bar Tool Options"{
	add_text = getBoolean("Do you want text?", "Yes", "No");
}


