//click once on the images you want to combine 
//double click on the tool

var list = newArray("");
var n = 0;
macro "Combine Tool - CfffCfc9D25D26D27D28D29D2aD2bD34D36D37D38D39D3aD3bD3cD44D46D47D48D49D4aD4bD4cD53D54D55D57D58D59D5aD5bD5cD5dD63D64D65D67D68D69D6aD6bD6cD6dD73D74D75D76D83D84D85D93D94D95Da4Db4C000D15D16D17D18D19D1aD1bD24D2cD33D35D3dD43D45D4dD52D56D5eD62D66D6eD72D77D78D79D7aD7bD7cD7dD7eD82D86D8eD92D96D9eDa3Da5DadDb3Db5DbdDc4DccDd5Dd6Dd7Dd8Dd9DdaDdbCc96D87D88D89D8aD8bD8cD8dD97D98D99D9aD9bD9cD9dDa6Da7Da8Da9DaaDabDacDb6Db7Db8Db9DbaDbbDbcDc5Dc6Dc7Dc8Dc9DcaDcbCbbbDaeDbeDcdDceDdcDddDdeDebDecDedDeeDfcDfd"{
	list[n] = getTitle();
	showStatus(list[n]);
	n++;
}
macro "Combine Tool Options"{
	txt = "";
	for (i = 0; i < lengthOf(list); i++) {
		txt += " stack"+i+1+"=["+list[i]+"]";
	}
	run("Combine...", txt);
	list = newArray("");
}

