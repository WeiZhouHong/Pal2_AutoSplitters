/*
The Legend of Sword and Fairy 2(PAL2) - ASL primarily by master_fiora
This ASL is compatible with The Legend of Sword and Fairy 2 versions: V1.05
*/

state("Pal2", "DVD V1.05"){
	byte frames: "Pal2.exe", 0x2A61A0;
	byte menuselect: "Pal2.exe", 0x365C4C;
	uint igt: "Pal2.exe", 0x2AA5B0;
	uint isLoading: "Pal2.exe", 0x2B4598;
	uint money: "Pal2.exe", 0x383AE0;
	uint itemcode: "Pal2.exe", 0x383AD0, 0x0, 0x0;
	uint map: "Pal2.exe", 0x2A66F8;
	uint CCU: "Pal2.exe", 0x5E4A28, 0x518, 0x118;
	uint role1: "Pal2.exe", 0x382BDC;
	uint role2: "Pal2.exe", 0x382FC4;
	uint role3: "Pal2.exe", 0x3833AC;
	uint role4: "Pal2.exe", 0x383794;
}

startup{
	
	vars.ASLVersion = "20200819 for pal2 DVD1.05";
	settings.Add("Remove loading time", true);

	vars.logFilePath = Directory.GetCurrentDirectory() + "\\Pal2-Autosplitter.log"; //same folder as LiveSplit.exe
	vars.log = (Action<string>)((string logLine) => {
		string time = System.DateTime.Now.ToString("dd/MM/yy hh:mm:ss:fff");
		System.IO.File.AppendAllText(vars.logFilePath, time + ": " + logLine + "\r\n");
	});
	try{
		vars.log("ASL file loaded(" + vars.ASLVersion + ")");
	}
	catch (System.IO.FileNotFoundException e){
		System.IO.File.Create(vars.logFilePath);
		vars.log("Autosplitter loaded, log file created");
	}

}

init
{	
	//gamestate
	refreshRate = 25; //same value as game-fpsrate
	vars.frameup = false;
	//meet boss
	vars.hairless = false;
	vars.mouse = false;
	vars.noob = false;
	vars.zombiecouple = false;
	vars.snake = false;
	vars.defense = false;
	vars.centipede = false;
	vars.deer = false;
	vars.rockmon =  false;
	vars.siblings = false;
	vars.bookworm = false;
	vars.RPMon = false;
	vars.fourPMon = false;
	vars.fivePMon = false;
	vars.BigPMon = false;
	vars.konglin = false;
	vars.sow = false;
	vars.lynx = false;
	vars.bestfriend = false;
	vars.wolf = false;
	vars.finalboss = false;
	
	byte[] exeMD5HashBytes = new byte[0];
	using (var md5 = System.Security.Cryptography.MD5.Create())
	{
		using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
		{
			exeMD5HashBytes = md5.ComputeHash(s); 
		} 
	}
	var MD5Hash = exeMD5HashBytes.Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
	print("MD5Hash: " + MD5Hash.ToString()); //DebugView
	
	if(MD5Hash == "6BF7F535002C59F5F5DB06F69053F9EF"){
		version = "1.05DVD"; 
		vars.log("Detected game version: " + version + " - MD5Hash: " + MD5Hash);
	}
	else{
		version = "old version"; 
		vars.log("other game version: " + version + " - MD5Hash: " + MD5Hash);	
	}
}

update{
	if(current.frames != old.frames){
		vars.frameup = true;
	}else if(current.frames == old.frames){
		vars.frameup = false;
		}else{
			vars.frameup = false;
			}
			
	if(current.CCU == 480 && current.map == 13){
		//vars.log("hairless true (" + current.CCU + ")");
		vars.hairless = true;
		}else if(current.CCU == 1100 && current.map == 58){
			//vars.log("mouse true (" + current.CCU + ")");
			vars.mouse = true;
		}else if(current.CCU == 720 && current.map == 43){
			//vars.log("noob true (" + current.CCU + ")");
			vars.noob = true;
		}else if(current.CCU == 1600 && current.map == 87){
			//vars.log("zombiecouple true (" + current.CCU + ")");
			vars.zombiecouple = true;
		}else if(current.CCU == 2000 && current.map == 111){
			//vars.log("snake true (" + current.CCU + ")");
			vars.snake = true;
		}else if(current.CCU == 28000 && current.map == 104){
			//vars.log("defense true (" + current.CCU + ")");
			vars.defense = true;
		}else if(current.CCU == 3500 && current.map == 119){
			//vars.log("Centipede true (" + current.CCU + ")");
			vars.centipede = true;
		}else if(current.CCU == 5300 && current.map == 128){
			//vars.log("deer true (" + current.CCU + ")");
			vars.deer = true;
		}else if(current.CCU == 6800 && current.map == 134){
			//vars.log("rockmon true (" + current.CCU + ")");
			vars.rockmon = true;
		}else if(current.CCU == 16000 && current.map == 146){
			//vars.log("siblings true (" + current.CCU + ")");
			vars.siblings = true;
		}else if(current.CCU == 12000 && current.map == 153){
			//vars.log("bookworm true (" + current.CCU + ")");
			vars.bookworm = true;
		}else if(current.CCU == 3600 && current.map == 601){
			//vars.log("RPMon true (" + current.CCU + ")");
			vars.RPMon = true;
		}else if(current.CCU == 3600 && current.map == 616){
			//vars.log("fourPMon true (" + current.CCU + ")");
			vars.fourPMon = true;
		}else if(current.CCU == 3600 && current.map == 181){
			//vars.log("fivePMon true (" + current.CCU + ")");
			vars.fivePMon = true;
		}else if(current.CCU == 6000 && current.map == 181){
			//vars.log("BigPMon true (" + current.CCU + ")");
			vars.BigPMon = true;
		}else if(current.CCU == 42000 && current.map == 183){
			//vars.log("konglin true (" + current.CCU + ")");
			vars.konglin = true;
		}else if(current.CCU == 18000 && current.map == 187){
			//vars.log("sow true (" + current.CCU + ")");
			vars.sow = true;
		}else if(current.CCU == 20000 && current.map == 154){
			//vars.log("lynx true (" + current.CCU + ")");
			vars.lynx = true;
		}else if(current.CCU == 32000 && current.map == 164){
			//vars.log("bestfriend true (" + current.CCU + ")");
			vars.bestfriend = true;
		}else if(current.CCU == 18000 && current.map == 582){
			//vars.log("wolf true (" + current.CCU + ")");
			vars.wolf = true;
		}else if(current.CCU == 54000 && current.map == 177){
			//vars.log("finalboss true (" + current.CCU + ")");
			vars.finalboss = true;
		}else if((current.igt < old.igt && current.menuselect == 2)| current.menuselect == 3){
			vars.hairless = false;
			vars.mouse = false;
			vars.noob = false;
			vars.zombiecouple = false;
			vars.snake = false;
			vars.defense = false;
			vars.centipede = false;
			vars.deer = false;
			vars.rockmon =  false;
			vars.siblings = false;
			vars.bookworm = false;
			vars.RPMon = false;
			vars.fourPMon = false;
			vars.fivePMon = false;
			vars.BigPMon = false;
			vars.konglin = false;
			vars.sow = false;
			vars.lynx = false;
			vars.bestfriend = false;
			vars.wolf = false;
			vars.finalboss = false;
			print("Reset all vars"); //DebugView
			vars.log("Reset all boss-vars!");
		}
}

isLoading{
	if(settings["Remove loading time"] && vars.frameup == false){
		print("Loading on MapID: " + current.map.ToString()); //DebugView
		return true;
	}
	else{
		return false;
	}
}

start{
	if(current.igt == 0 && current.frames != old.frames && current.menuselect == 1){
		print("GameStart"); //DebugView
		return true;
	}
}


reset{
	if(current.igt == 0 && current.frames != old.frames && current.menuselect == 1 && current.itemcode <= 10000){
		print("Reset, new-item-code:" + current.itemcode.ToString()); //DebugView
		return true;
	}else{
		return false;
	}
}


split{
	if(vars.hairless == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("hairless kill (" + old.CCU + ")");
		vars.hairless = false;
		return true;
	}
	if(current.itemcode == 5116 && old.itemcode != current.itemcode){
		vars.log("slate1 kill (" + old.CCU + ")");
		return true;
	}
	if(current.itemcode == 5117 && old.itemcode != current.itemcode){
		vars.log("slate2 kill (" + old.CCU + ")");
		return true;
	}
	if(current.itemcode == 5118 && old.itemcode != current.itemcode){
		vars.log("slate3 kill (" + old.CCU + ")");
		return true;
	}
	if(current.itemcode == 5119 && old.itemcode != current.itemcode){
		vars.log("slate4 kill (" + old.CCU + ")");
		return true;
	}
	if(vars.mouse == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("mouse kill (" + old.CCU + ")");
		vars.mouse = false;
		return true;
	}
	if(vars.noob == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("noob kill (" + old.CCU + ")");
		vars.noob = false;
		return true;
	}

	if(vars.zombiecouple == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("zombiecouple kill (" + old.CCU + ")");
		vars.zombiecouple = false;
		return true;
	}	
	if(vars.snake == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("snake kill (" + old.CCU + ")");
		vars.snake = false;
		return true;
	}
	if(vars.defense == true && current.map == 112){
		vars.log("defense ten phase (" + old.CCU + ")");
		vars.defense = false;
		return true;
	}
	if(vars.deer == true && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("deer kill (" + old.CCU + ")");
		vars.deer = false;
		return true;
	}
	if(vars.centipede == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("centipede kill (" + old.CCU + ")");
		vars.centipede = false;
		return true;
	}
	if(vars.rockmon == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("rockmon kill (" + old.CCU + ")");
		vars.rockmon = false;
		return true;
	}
	if(vars.siblings == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("siblings kill (" + old.CCU + ")");
		vars.siblings = false;
		return true;
	}
	if(vars.bookworm == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("bookworm kill (" + old.CCU + ")");
		vars.bookworm = false;
		return true;
	}
	if(vars.RPMon == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("RPMon kill (" + old.CCU + ")");
		vars.RPMon = false;
		return true;
	}
	if(vars.fourPMon == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("RPMon kill (" + old.CCU + ")");
		vars.fourPMon = false;
		return true;
	}
	if(vars.fivePMon == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("RPMon kill (" + old.CCU + ")");
		vars.fivePMon = false;
		return true;
	}
	if(vars.BigPMon == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("BigPMon kill (" + old.CCU + ")");
		vars.BigPMon = false;
		return true;
	}
	if(vars.konglin == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("konglin kill (" + old.CCU + ")");
		vars.konglin = false;
		return true;
	}
	if(vars.sow == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("sow kill (" + old.CCU + ")");
		vars.sow = false;
		return true;
	}
	if(vars.lynx == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("lynx kill (" + old.CCU + ")");
		vars.lynx = false;
		return true;
	}
	if(vars.bestfriend == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("bestfriend kill (" + old.CCU + ")");
		vars.bestfriend = false;
		return true;
	}
	if(vars.wolf == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("wolf kill (" + old.CCU + ")");
		vars.wolf = false;
		return true;
	}
	if(vars.finalboss == true && old.CCU > 0 && (current.CCU == 0 | current.CCU > 65535)){
		vars.log("finalboss kill (" + old.CCU + ")");
		vars.finalboss = false;
		return true;
	}
}



