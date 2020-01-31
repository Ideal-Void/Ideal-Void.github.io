G.AddData({
name:'Pengaelic mod 1',
author:'Tux Penguin',
desc:'A simple mod that adds torches.',
engineVersion:1,
requires:['Default dataset*'],
sheets:{'pengaelicSheet':'img/pengaelic1ModIconSheet.png'},//custom stylesheet (note : broken in IE and Edge for the time being)
func:function()
{
	//The idea in this simple example mod is to add a few elements focused around hot sauce, because hot sauce is great and I use that stuff everywhere.
	//Torches are food for now until I figure out how the game works some more.
	//First we create a new resource :
	new G.Res({
		name:'torch',
		desc:'Made from [coal] and [stick]s, this [torch] stays lit for a while and will light up any cave for you.',
		icon:[0,0,'coalSheet'],
		turnToByContext:{'eat':{'health':0.03,'happiness':0.1},'decay':{'hot sauce':0.95,'spoiled food':0.05}},//that last part makes hot sauce effectively have a 95% chance of simply not rotting (in effect, it decays into itself)
		partOf:'food',
		category:'food',
	});
	
	//Then we augment the base data to incorporate our new resources :
		//adding a new mode to firekeepers so they can make torches
	G.getDict('firekeeper').modes['torch']={name:'Light torches',desc:'Turn 1 [coal] and 2 [stick]s into 1 [torch].',use:{'knapped tools':1}};
		//adding a new effect to firekeepers that handles the actual torch making and is only active when the unit has the mode "light torches"
	G.getDict('firekeeper').effects.push({type:'convert',from:{'coal':1,'stick':2},into:{'torch':1},every:3,mode:'torch'});
	
	//Then we add a new technology which is required by the artisans to gain access to the "hot sauce" mode :
	//new G.Tech({
	//	name:'hot sauce preparing',
	//	desc:'@[artisan]s can now produce [hot sauce] from [hot pepper]s and [herb]s//This special recipe allows a skilled craftsman to fully express the complex aromas present in hot peppers.',
	//	icon:[0,1,'spicySheet'],
	//	cost:{'insight':10},
	//	req:{'cooking':true},
	//});
	
	//Finally, we add a trait that amplifies the benefits of consuming hot sauce; it will take on average 20 years to appear once the conditions (knowing the "Hot sauce preparing" tech) is fulfilled.
	//new G.Trait({
	//	name:'hot sauce madness',
	//	desc:'@your people appreciate [hot sauce] twice as much and will be twice as happy from consuming it.',
	//	icon:[1,1,'spicySheet'],
	//	chance:20,
	//	req:{'hot sauce preparing':true},
	////	effects:[
	//		{type:'function',func:function(){G.getDict('hot sauce').turnToByContext['eat']['happiness']=0.2;}},//this is a custom function executed when we gain the trait
	//	],
	//});
	
	//There are many other ways of adding and changing content; refer to /data.js, the default dataset, if you want to see how everything is done in the base game. Good luck!
}
});