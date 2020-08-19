/*
The Legend of Sword and Fairy 2(PAL2) - ASL primarily by master_fiora
This ASL is compatible with The Legend of Sword and Fairy 2 versions: V1.05
*/

state("Pal2", "DVD V1.05"){
	byte menuselect: "Pal2.exe", 0x365C4C; 		//選單狀態1開始遊戲2前塵憶夢
	byte frames: "Pal2.exe", 0x2A61A0; 		//Frame0-24 每到25張增加1秒遊戲時間
	uint igt: "Pal2.exe", 0x2AA5B0; 		//遊戲內時間
	uint money: "Pal2.exe", 0x383AE0; 
	uint itemcode: "Pal2.exe", 0x383AD0, 0x0, 0x0; 	//最新取得物品
	uint map: "Pal2.exe", 0x2A66F8; 		//地圖編號
	uint CCU: "Pal2.exe", 0x5E4A28, 0x518, 0x118; 	//戰鬥時HP指向, 溢傷為負數變為42E
	uint role1: "Pal2.exe", 0x382BDC; 		//小虎HP
	uint role2: "Pal2.exe", 0x382FC4; 		//欺霜HP
	uint role3: "Pal2.exe", 0x3833AC; 		//蘇媚HP
	uint role4: "Pal2.exe", 0x383794; 		//憶如HP
}

startup{

	settings.Add("Remove loading time", true);
	settings.Add("BOSS AutoSplit", true, "BOSS AutoSplit");
		settings.Add("hairless", true, "查協", "BOSS AutoSplit");
		settings.Add("slate1", true, "石版一", "BOSS AutoSplit");
		settings.Add("slate2", true, "石版二", "BOSS AutoSplit");
		settings.Add("slate3", true, "石版三", "BOSS AutoSplit");
		settings.Add("slate4", true, "石版四", "BOSS AutoSplit");
		settings.Add("mouse", true, "鼠王", "BOSS AutoSplit");
		settings.Add("noob", true, "沈齊", "BOSS AutoSplit");
		settings.Add("zombiecoup", true, "夫妻", "BOSS AutoSplit");
		settings.Add("snake", true, "虞蛇", "BOSS AutoSplit");
		settings.Add("defense", true, "死守", "BOSS AutoSplit");
		settings.Add("centipede", true, "蜈王", "BOSS AutoSplit");
		settings.Add("deer", true, "白鹿", "BOSS AutoSplit");
		settings.Add("rockmon", true, "岩魔", "BOSS AutoSplit");
		settings.Add("siblings", true, "兄妹", "BOSS AutoSplit");
		settings.Add("bookworm", true, "秦儒", "BOSS AutoSplit");
		settings.Add("RPMon", true, "火畫", "BOSS AutoSplit");
		settings.Add("fourPMon", true, "四畫", "BOSS AutoSplit");
		settings.Add("fivePMon", true, "五畫", "BOSS AutoSplit");
		settings.Add("BigPMon", true, "大畫", "BOSS AutoSplit");
		settings.Add("konglin", true, "孔磷", "BOSS AutoSplit");
		settings.Add("sow", true, "豬女", "BOSS AutoSplit");
		settings.Add("lynx", true, "貓妖", "BOSS AutoSplit");
		settings.Add("bestfriend", true, "南松", "BOSS AutoSplit");
		settings.Add("wolf", true, "嘯狼", "BOSS AutoSplit");
		settings.Add("finalboss", true, "千葉", "BOSS AutoSplit");
	
	vars.ASLVersion = "2020-08-20 for Pal2 DVD V1.05";
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
	vars.hairless = false;		//查協
	vars.mouse = false;		//鼠王
	vars.noob = false;		//沈齊
	vars.zombiecouple = false;	//夫妻
	vars.snake = false;		//虞蛇
	vars.defense = false;		//死守
	vars.centipede = false;		//蜈王
	vars.deer = false;		//白鹿
	vars.rockmon =  false;		//岩魔
	vars.siblings = false;		//兄妹
	vars.bookworm = false;		//秦儒
	vars.RPMon = false;		//火畫
	vars.fourPMon = false;		//四畫
	vars.fivePMon = false;		//五畫
	vars.BigPMon = false;		//大畫
	vars.konglin = false;		//孔磷
	vars.sow = false;		//豬女
	vars.lynx = false;		//貓妖
	vars.bestfriend = false;	//南松
	vars.wolf = false;		//嘯狼
	vars.finalboss = false;		//千葉
	
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
			
	if(current.CCU == 480 && current.map == 13 && settings.Add["hairless"]){
		//vars.log("hairless true (" + current.CCU + ")");
		vars.hairless = true;
		}else if(current.CCU == 1100 && current.map == 58 && settings.Add["mouse"]){
			//vars.log("mouse true (" + current.CCU + ")");
			vars.mouse = true;
		}else if(current.CCU == 720 && current.map == 43 && settings.Add["noob"]){
			//vars.log("noob true (" + current.CCU + ")");
			vars.noob = true;
		}else if(current.CCU == 1600 && current.map == 87 && settings.Add["zombiecouple"]){
			//vars.log("zombiecouple true (" + current.CCU + ")");
			vars.zombiecouple = true;
		}else if(current.CCU == 2000 && current.map == 111 && settings.Add["snake"]){
			//vars.log("snake true (" + current.CCU + ")");
			vars.snake = true;
		}else if(current.CCU == 28000 && current.map == 104 && settings.Add["defense"]){
			//vars.log("defense true (" + current.CCU + ")");
			vars.defense = true;
		}else if(current.CCU == 3500 && current.map == 119 && settings.Add["centipede"]){
			//vars.log("Centipede true (" + current.CCU + ")");
			vars.centipede = true;
		}else if(current.CCU == 5300 && current.map == 128 && settings.Add["deer"]){
			//vars.log("deer true (" + current.CCU + ")");
			vars.deer = true;
		}else if(current.CCU == 6800 && current.map == 134 && settings.Add["rockmon"]){
			//vars.log("rockmon true (" + current.CCU + ")");
			vars.rockmon = true;
		}else if(current.CCU == 16000 && current.map == 146 && settings.Add["siblings"]){
			//vars.log("siblings true (" + current.CCU + ")");
			vars.siblings = true;
		}else if(current.CCU == 12000 && current.map == 153 && settings.Add["bookworm"]){
			//vars.log("bookworm true (" + current.CCU + ")");
			vars.bookworm = true;
		}else if(current.CCU == 3600 && current.map == 601 && settings.Add["RPMon"]){
			//vars.log("RPMon true (" + current.CCU + ")");
			vars.RPMon = true;
		}else if(current.CCU == 3600 && current.map == 616 && settings.Add["fourPMon"]){
			//vars.log("fourPMon true (" + current.CCU + ")");
			vars.fourPMon = true;
		}else if(current.CCU == 3600 && current.map == 181 && settings.Add["fivePMon"]){
			//vars.log("fivePMon true (" + current.CCU + ")");
			vars.fivePMon = true;
		}else if(current.CCU == 6000 && current.map == 181 && settings.Add["BigPMon"]){
			//vars.log("BigPMon true (" + current.CCU + ")");
			vars.BigPMon = true;
		}else if(current.CCU == 42000 && current.map == 183 && settings.Add["konglin"]){
			//vars.log("konglin true (" + current.CCU + ")");
			vars.konglin = true;
		}else if(current.CCU == 18000 && current.map == 187 && settings.Add["sow"]){
			//vars.log("sow true (" + current.CCU + ")");
			vars.sow = true;
		}else if(current.CCU == 20000 && current.map == 154 && settings.Add["lynx"]){
			//vars.log("lynx true (" + current.CCU + ")");
			vars.lynx = true;
		}else if(current.CCU == 32000 && current.map == 164 && settings.Add["bestfriend"]){
			//vars.log("bestfriend true (" + current.CCU + ")");
			vars.bestfriend = true;
		}else if(current.CCU == 18000 && current.map == 582 && settings.Add["wolf"]){
			//vars.log("wolf true (" + current.CCU + ")");
			vars.wolf = true;
		}else if(current.CCU == 54000 && current.map == 177 && settings.Add["finalboss"]){
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
			//print("Reset all vars");
			//vars.log("Reset all boss-vars!");
		}
}

isLoading{
	if(settings["Remove loading time"] && vars.frameup == false){
		//print("Loading on MapID: " + current.map.ToString()); //DebugView
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
		//print("Reset, new-item-code:" + current.itemcode.ToString());
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
	if(current.itemcode == 5116 && old.itemcode != current.itemcode && settings.Add["slate1"]){
		vars.log("slate1 kill (" + old.CCU + ")");
		return true;
	}
	if(current.itemcode == 5117 && old.itemcode != current.itemcode && settings.Add["slate2"]){
		vars.log("slate2 kill (" + old.CCU + ")");
		return true;
	}
	if(current.itemcode == 5118 && old.itemcode != current.itemcode && settings.Add["slate3"]){
		vars.log("slate3 kill (" + old.CCU + ")");
		return true;
	}
	if(current.itemcode == 5119 && old.itemcode != current.itemcode && settings.Add["slate4"]){
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
