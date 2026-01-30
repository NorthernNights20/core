extends Node







const ARMOR_DATA: = {
    "Class One": {"name": "Reinforced Clothing", "armor_rating": 1, "penalty": 0}, 
    "Class Two": {"name": "Armor T-Shirt", "armor_rating": 2, "penalty": 1}, 
    "Class Three": {"name": "Kevlar Vest", "armor_rating": 3, "penalty": 1, "visibility": "Noticeable"}, 
    "Class Four": {"name": "Flak Jacket", "armor_rating": 4, "penalty": 2, "visibility": "Noticeable"}, 
    "Class Five": {"name": "Full Riot Gear", "armor_rating": 5, "penalty": 3, "visibility": "Noticeable"}, 
}


const MELEE_WEAPONS: = {
    "Sap": {"damage": "Strength + 1", "conceal": "P", "blunt": true}, 
    "Club": {"damage": "Strength + 2", "conceal": "T", "blunt": true}, 
    "Knife": {"damage": "Strength + 1", "conceal": "J", "blunt": false}, 
    "Sword": {"damage": "Strength + 2", "conceal": "T", "blunt": false}, 
    "Axe": {"damage": "Strength + 3", "conceal": "N", "blunt": false}, 
    "Stake": {"damage": "Strength + 1", "conceal": "T", "blunt": false, "special": "stake-capable"}, 
}


const RANGED_WEAPONS: = {
    "Revolver, Lt.": {"damage": 4, "range": 12, "rate": 3, "capacity": 6, "conceal": "P"}, 
    "SW Bodyguard (.38 Special)": {"damage": 4, "range": 12, "rate": 3, "capacity": 6, "conceal": "P"}, 
    "Revolver, Hvy.": {"damage": 6, "range": 35, "rate": 2, "capacity": 6, "conceal": "J"}, 
    "Ruger Redhawk (.44 Magnum)": {"damage": 6, "range": 35, "rate": 2, "capacity": 6, "conceal": "J"}, 
    "Pistol, Lt.": {"damage": 4, "range": 20, "rate": 4, "capacity": "15+1", "conceal": "P"}, 
    "HK USP (9mm)": {"damage": 4, "range": 20, "rate": 4, "capacity": "15+1", "conceal": "P"}, 
    "Pistol, Hvy.": {"damage": 5, "range": 25, "rate": 3, "capacity": "13+1", "conceal": "J"}, 
    "Springfield XDM (.45 ACP)": {"damage": 5, "range": 25, "rate": 3, "capacity": "13+1", "conceal": "J"}, 
    "Rifle": {"damage": 8, "range": 200, "rate": 1, "capacity": "3+1", "conceal": "N"}, 
    "Beretta Tikka T3 (.30.06)": {"damage": 8, "range": 200, "rate": 1, "capacity": "3+1", "conceal": "N"}, 
    "SMG, Small": {"damage": 4, "range": 20, "rate": 3, "capacity": "17+1", "conceal": "J"}, 
    "Glock 18 (9mm)": {"damage": 4, "range": 20, "rate": 3, "capacity": "17+1", "conceal": "J"}, 
    "SMG, Large": {"damage": 4, "range": 50, "rate": 3, "capacity": "30+1", "conceal": "T"}, 
    "HK MP5 (9mm)": {"damage": 4, "range": 50, "rate": 3, "capacity": "30+1", "conceal": "T"}, 
    "Assault Rifle": {"damage": 7, "range": 150, "rate": 3, "capacity": "30+1", "conceal": "N"}, 
    "FN SCAR (5.56mm)": {"damage": 7, "range": 150, "rate": 3, "capacity": "30+1", "conceal": "N"}, 
    "Shotgun": {"damage": 8, "range": 20, "rate": 1, "capacity": "5+1", "conceal": "T"}, 
    "Remington 870 (12-Gauge)": {"damage": 8, "range": 20, "rate": 1, "capacity": "5+1", "conceal": "T"}, 
    "Shotgun, Semi-auto": {"damage": 8, "range": 20, "rate": 3, "capacity": "6+1", "conceal": "T"}, 
    "Benelli M4 Super 90 (12-Gauge)": {"damage": 8, "range": 20, "rate": 3, "capacity": "6+1", "conceal": "T"}, 
    "Crossbow": {"damage": 5, "range": 20, "rate": 1, "capacity": 1, "conceal": "T", "special": "stake-capable"}, 
}


func get_armor(armor_name: String) -> Dictionary:
    return ARMOR_DATA.get(armor_name, {})

func get_melee_weapon(weapon_name: String) -> Dictionary:
    return MELEE_WEAPONS.get(weapon_name, {})

func get_ranged_weapon(weapon_name: String) -> Dictionary:
    return RANGED_WEAPONS.get(weapon_name, {})
