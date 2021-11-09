//click once on the images you want to merge 
//double click on the tool

var list = newArray("");
var n = 0;

macro "Merging Tool - C000 T3d15M "{
	list[n] = getTitle();
	showStatus(list[n]);
	n++;
}

macro "Merging Tool Options"{
	if(isKeyDown("shift")){ // if list is unmergable (press shift to reset the list
		showMessage("List reset");
		list = newArray("");
		n = 0;
		exit;
	}
	Merge(list); //function below
	list = newArray("");
	n = 0;
}

function Merge(list){
	txt = "";
	for (i=0; i<list.length; i++) {
		txt += "c" + i+1 + "=[" + list[i] + "] ";
	}
	run("Merge Channels...", txt + "create");
	String.copy(list[0]);
}
