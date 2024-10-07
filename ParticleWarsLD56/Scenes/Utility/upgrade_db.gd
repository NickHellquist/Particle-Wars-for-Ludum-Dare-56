extends Node
const ICON_PATH = "res://Graphics"
#const WEAPON_PATH = "res://Graphics/Items/Weapons/"
#const AFFINITY_PATH = "res://Graphics/Items/Affinities/"
const UPGRADES = {
	"knockback1":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Knockback",
		"details": "Knockback increased by 5%.",
		"Raretext": "Normal",
		"prerequisite": [],
		"rarity": "R",
		"level": "Level",
		"type": "weapon"
	},
	"knockback2":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Knockback",
		"details": "Knockback increased by 10%.",
		"Raretext": "Rare",
		"prerequisite": [],
		"rarity": "R25",
		"level": "Level",
		"type": "weapon"
	},
	"knockback3":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Knockback",
		"details": "Knockback increased by 15%.",
		"Raretext": "Very Rare",
		"prerequisite": [],
		"rarity": "R10",
		"level": "Level",
		"type": "weapon"
	},
	"attackspeed1":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Attack Speed",
		"details": "Attack Speed increased by 5%.",
		"Raretext": "Normal",
		"prerequisite": [],
		"rarity": "R",
		"level": "Level",
		"type": "weapon"
	},
	"attackspeed2":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Attack Speed",
		"details": "Attack Speed increased by 10%.",
		"Raretext": "Rare",
		"prerequisite": [],
		"rarity": "R25",
		"level": "Level",
		"type": "weapon"
	},
	"attackspeed3":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Attack Speed",
		"details": "Attack Speed increased by 20%.",
		"Raretext": "Very Rare",
		"prerequisite": [],
		"rarity": "R10",
		"level": "Level",
		"type": "weapon"
	},
	"movespeed1":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Movement Speed",
		"details": "Movement Speed increased by 5%.",
		"Raretext": "Rare",
		"prerequisite": [],
		"rarity": "R",
		"level": "Level",
		"type": "weapon"
	},
	"movespeed2":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Movement Speed",
		"details": "Movement Speed increased by 7.5%.",
		"Raretext": "Rare",
		"prerequisite": [],
		"rarity": "R25",
		"level": "Level",
		"type": "weapon"
	},
	"movespeed3":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Movement Speed",
		"details": "Movement Speed increased by 15%.",
		"Raretext": "Very Rare",
		"prerequisite": [],
		"rarity": "R10",
		"level": "Level",
		"type": "weapon"
	},
	"DashCooldown1":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Dash Cooldown",
		"details": "Dash Cooldown decreased by 2.5%.",
		"Raretext": "Normal",
		"prerequisite": [],
		"rarity": "R",
		"level": "Level",
		"type": "weapon"
	},
	"DashCooldown2":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Dash Cooldown",
		"details": "Dash Cooldown decreased by 5%.",
		"Raretext": "Rare",
		"prerequisite": [],
		"rarity": "R25",
		"level": "Level",
		"type": "weapon"
	},
	"DashCooldown3":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Dash Cooldown",
		"details": "Dash Cooldown decreased by 10%.",
		"Raretext": "Very Rare",
		"prerequisite": [],
		"rarity": "R10",
		"level": "Level",
		"type": "weapon"
	},
	"bulletsize1":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Attack Size",
		"details": "Attack Size increased by 5%.",
		"Raretext": "Normal",
		"prerequisite": [],
		"rarity": "R",
		"level": "Level",
		"type": "weapon"
	},
	"bulletsize2":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Attack Size",
		"details": "Attack Size increased by 7.5%.",
		"Raretext": "Rare",
		"prerequisite": [],
		"rarity": "R25",
		"level": "Level",
		"type": "weapon"
	},
	"bulletsize3":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Attack Size",
		"details": "Attack Size increased by 10%.",
		"Raretext": "Very Rare",
		"prerequisite": [],
		"rarity": "R10",
		"level": "Level",
		"type": "weapon"
	},
	"piercing1":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Enemy Piercing",
		"details": "Attack Pierces through 1 additional enemies.",
		"Raretext": "Normal",
		"prerequisite": [],
		"rarity": "R",
		"level": "Level",
		"type": "weapon"
	},
	"piercing2":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Enemy Piercing",
		"details": "Attack Pierces through 2 additional enemies.",
		"Raretext": "Rare",
		"prerequisite": [],
		"rarity": "R25",
		"level": "Level",
		"type": "weapon"
	},
	"piercing3":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Enemy Piercing",
		"details": "Attack Pierces through 3 additional enemies.",
		"Raretext": "Very Rare",
		"prerequisite": [],
		"rarity": "R10",
		"level": "Level",
		"type": "weapon"
	},
	"projectilespeed1":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Projectile Speed",
		"details": "Projectile Speed increased by 10%.",
		"Raretext": "Normal",
		"prerequisite": [],
		"rarity": "R",
		"level": "Level",
		"type": "weapon"
	},
	"projectilespeed2":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Projectile Speed",
		"details": "Projectile Speed increased by 15%.",
		"Raretext": "Rare",
		"prerequisite": [],
		"rarity": "R25",
		"level": "Level",
		"type": "weapon"
	},
	"projectilespeed3":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Projectile Speed",
		"details": "Projectile Speed increased by 20%.",
		"Raretext": "Very Rare",
		"prerequisite": [],
		"rarity": "R10",
		"level": "Level",
		"type": "weapon"
	},
	"xparea1":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Reacher",
		"details": "Experience grab area increased by 5%.",
		"Raretext": "Normal",
		"prerequisite": [],
		"rarity": "R",
		"level": "Level",
		"type": "weapon"
	},
	"xparea2":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Reacher",
		"details": "Experience grab area increased by 10%.",
		"Raretext": "Rare",
		"prerequisite": [],
		"rarity": "R25",
		"level": "Level",
		"type": "weapon"
	},
	"xparea3":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Reacher",
		"details": "Experience grab area increased by 15%.",
		"Raretext": "Very Rare",
		"prerequisite": [],
		"rarity": "R10",
		"level": "Level",
		"type": "weapon"
	},
	"Invinsibility1":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Invincibility",
		"details": "Your invincibility after being hit increased by 0.5s.",
		"Raretext": "Defensive Modifier",
		"prerequisite": [],
		"rarity": "R",
		"level": "Level 1",
		"type": "defensive_modifier"
	},
	"Invinsibility2":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Invincibility",
		"details": "Your invincibility after being hit increased by 0.25s.",
		"Raretext": "Defensive Modifier",
		"prerequisite": ["Invinsibility1"],
		"rarity": "R",
		"level": "Level 2",
		"type": "defensive_modifier"
	},
	"Invinsibility3":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Invincibility",
		"details": "Your invincibility after being hit increased by 0.25s.",
		"Raretext": "Defensive Modifier",
		"prerequisite": ["Invinsibility2"],
		"rarity": "R",
		"level": "Level 3",
		"type": "defensive_modifier"
	},
	"maxhp1":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Health",
		"details": "Max Health increased by +2 and healed for +2.",
		"Raretext": "Defensive Modifier",
		"prerequisite": [],
		"rarity": "R",
		"level": "Level 1",
		"type": "defensive_modifier"
	},
	"maxhp2":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Health",
		"details": "Max Health increased by +1 and healed for +1.",
		"Raretext": "Defensive Modifier",
		"prerequisite": ["maxhp1"],
		"rarity": "R",
		"level": "Level 2",
		"type": "defensive_modifier"
	},
	"safeguard1":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Safe Guard",
		"details": "If you get hit a large circle pushes back nearby enemies. Cooldown 60s.",
		"Raretext": "Defensive Modifier",
		"prerequisite": [],
		"rarity": "R",
		"level": "Level 1",
		"type": "defensive_modifier"
	},
	"safeguard2":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Safe Guard",
		"details": "Cooldown reduced by 15s.",
		"Raretext": "Defensive Modifier",
		"prerequisite": ["safeguard1"],
		"rarity": "R",
		"level": "Level 2",
		"type": "defensive_modifier"
	},
	"safeguard3":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Safe Guard",
		"details": "Cooldown reduced by 15s.",
		"Raretext": "Defensive Modifier",
		"prerequisite": ["safeguard2"],
		"rarity": "R",
		"level": "Level 3",
		"type": "defensive_modifier"
	},
	"baseammo1":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Ammunition",
		"details": "Shoots an additional projectile.",
		"Raretext": "Offensive Modifier",
		"prerequisite": [],
		"rarity": "R",
		"level": "Level 1",
		"type": "offensive_modifier"
	},
	"baseammo2":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Ammunition",
		"details": "Shoots an additional projectile.",
		"Raretext": "Offensive Modifier",
		"prerequisite": ["baseammo1"],
		"rarity": "R",
		"level": "Level 2",
		"type": "offensive_modifier"
	},
	"enemynear1":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Target Acquired",
		"details": "A red circle will become visible. If an enemie step inside this circle a bullet shoots one of them.",
		"Raretext": "Offensive Modifier",
		"prerequisite": [],
		"rarity": "R",
		"level": "Level 1",
		"type": "offensive_modifier"
	},
	"enemynear2":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Target Acquired",
		"details": "Target Acquired shoots and additional attack.",
		"Raretext": "Offensive Modifier",
		"prerequisite": ["enemynear1"],
		"rarity": "R",
		"level": "Level 2",
		"type": "offensive_modifier"
	},
	"enemynear3":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Target Acquired",
		"details": "Target Acquired shoots and additional attack.",
		"Raretext": "Offensive Modifier",
		"prerequisite": ["enemynear2"],
		"rarity": "R",
		"level": "Level 3",
		"type": "offensive_modifier"
	},
	"explosiveshot1":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Explosive Delight",
		"details": "Your projectiles has a 20% chance to release an explosion when hitting an enemy.",
		"Raretext": "Offensive Modifier",
		"prerequisite": [],
		"rarity": "R",
		"level": "Level 1",
		"type": "offensive_modifier"
	},
	"explosiveshot2":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Explosive Delight",
		"details": "Chance of explosion increased by 10%.",
		"Raretext": "Offensive Modifier",
		"prerequisite": ["explosiveshot1"],
		"rarity": "R",
		"level": "Level 2",
		"type": "offensive_modifier"
	},
	"explosiveshot3":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Explosive Delight",
		"details": "Chance of explosion increased by 20%.",
		"Raretext": "Offensive Modifier",
		"prerequisite": ["explosiveshot2"],
		"rarity": "R",
		"level": "Level 3",
		"type": "offensive_modifier"
	},
	"frenzy1":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Frenzy",
		"details": "Every 30s enter a frenzied state with much higher attack speed.",
		"Raretext": "Offensive Modifier",
		"prerequisite": [],
		"rarity": "R",
		"level": "Level 1",
		"type": "offensive_modifier"
	},
	"frenzy2":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Frenzy",
		"details": "Frenzied state duration increased by 2s.",
		"Raretext": "Offensive Modifier",
		"prerequisite": ["frenzy1"],
		"rarity": "R",
		"level": "Level 2",
		"type": "offensive_modifier"
	},
	"frenzy3":{
		"icon": ICON_PATH + "MainWeapon1ICONRED.png",
		"displayname": "Frenzy",
		"details": "Frenzied state duration increased by 3s.",
		"Raretext": "Offensive Modifier",
		"prerequisite": ["frenzy2"],
		"rarity": "R",
		"level": "Level 3",
		"type": "offensive_modifier"
	}
}
