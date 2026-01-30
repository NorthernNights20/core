extends Resource
class_name CharacterData

@export var is_storyteller: bool = false
@export var possessed_by: String = ""
@export var character_password: String = ""
@export var is_vampire: bool = false
@export var description: String = ""
@export var notes: String = ""
@export var enter_mode: int = 0



@export var custom_pool_1: int = 0
@export var custom_pool_2: int = 0



@export var name: String = ""
@export var clan: String = ""
@export var sect: String = ""
@export var nature: String = ""
@export var demeanor: String = ""
@export var path_name: String = ""
@export var experience_points: int = 0
@export var blood_bonds: = {}
@export var blood_bond_last_increment: Dictionary = {}
@export var vinculum: = {}
@export var vinculum_lock_until: Dictionary = {}




@export var current_zone: String = ""
@export var current_zone_category: String = ""
@export var current_viewpoint: String = ""
@export var derangements: Array[String] = []


@export var strength: int = 1
@export var dexterity: int = 1
@export var stamina: int = 1
@export var charisma: int = 1
@export var manipulation: int = 1
@export var appearance: int = 1
@export var perception: int = 1
@export var intelligence: int = 1
@export var wits: int = 1

@export var strength_blood_increased: int = 0
@export var dexterity_blood_increased: int = 0
@export var stamina_blood_increased: int = 0

@export var strength_progress: int = 0
@export var dexterity_progress: int = 0
@export var stamina_progress: int = 0
@export var charisma_progress: int = 0
@export var manipulation_progress: int = 0
@export var appearance_progress: int = 0
@export var perception_progress: int = 0
@export var intelligence_progress: int = 0
@export var wits_progress: int = 0




@export var alertness: int = 0
@export var athletics: int = 0
@export var awareness: int = 0
@export var brawl: int = 0
@export var empathy: int = 0
@export var expression: int = 0
@export var intimidation: int = 0
@export var leadership: int = 0
@export var streetwise: int = 0
@export var subterfuge: int = 0

@export var alertness_progress: int = 0
@export var athletics_progress: int = 0
@export var awareness_progress: int = 0
@export var brawl_progress: int = 0
@export var empathy_progress: int = 0
@export var expression_progress: int = 0
@export var intimidation_progress: int = 0
@export var leadership_progress: int = 0
@export var streetwise_progress: int = 0
@export var subterfuge_progress: int = 0



@export var animal_ken: int = 0
@export var crafts: int = 0
@export var drive: int = 0
@export var etiquette: int = 0
@export var firearms: int = 0
@export var larceny: int = 0
@export var melee: int = 0
@export var performance: int = 0
@export var stealth: int = 0
@export var survival: int = 0

@export var animal_ken_progress: int = 0
@export var crafts_progress: int = 0
@export var drive_progress: int = 0
@export var etiquette_progress: int = 0
@export var firearms_progress: int = 0
@export var larceny_progress: int = 0
@export var melee_progress: int = 0
@export var performance_progress: int = 0
@export var stealth_progress: int = 0
@export var survival_progress: int = 0



@export var academics: int = 0
@export var computer: int = 0
@export var finance: int = 0
@export var investigation: int = 0
@export var law: int = 0
@export var medicine: int = 0
@export var occult: int = 0
@export var politics: int = 0
@export var science: int = 0
@export var technology: int = 0

@export var academics_progress: int = 0
@export var computer_progress: int = 0
@export var finance_progress: int = 0
@export var investigation_progress: int = 0
@export var law_progress: int = 0
@export var medicine_progress: int = 0
@export var occult_progress: int = 0
@export var politics_progress: int = 0
@export var science_progress: int = 0
@export var technology_progress: int = 0




@export var conscience: int = 0
@export var self_control: int = 0
@export var courage: int = 1
@export var conviction: int = 0
@export var instinct: int = 0

@export var conscience_progress: int = 0
@export var self_control_progress: int = 0
@export var courage_progress: int = 0
@export var conviction_progress: int = 0
@export var instinct_progress: int = 0


@export var path: int = 7
@export var path_progress: int = 0
@export var generation: int = 13
@export var blood_pool: int = 10
@export var blood_pool_max: int = 10
@export var blood_per_turn: int = 1
@export var willpower_max: int = 1
@export var willpower_current: int = 1
@export var willpower_max_progress: int = 0


@export var disciplines: Dictionary = {}
@export var discipline_progress: Dictionary = {}



@export var allies: int = 0
@export var contacts: int = 0
@export var domain: int = 0
@export var fame: int = 0
@export var generation_background: int = 0
@export var haven: int = 0
@export var herd: int = 0
@export var influence: int = 0
@export var mentor: int = 0
@export var resources: int = 0
@export var retainers: int = 0
@export var rituals: int = 0
@export var status: int = 0

@export var allies_progress: int = 0
@export var contacts_progress: int = 0
@export var domain_progress: int = 0
@export var fame_progress: int = 0
@export var generation_background_progress: int = 0
@export var haven_progress: int = 0
@export var herd_progress: int = 0
@export var influence_progress: int = 0
@export var mentor_progress: int = 0
@export var resources_progress: int = 0
@export var retainers_progress: int = 0
@export var rituals_progress: int = 0
@export var status_progress: int = 0



@export var merits: Array[String] = []
@export var flaws: Array[String] = []




@export var ability_specialties: Array[String] = []
@export var thaumaturgy_paths: Array[String] = []
@export var thaumaturgy_rituals: Array[String] = []
@export var ritae_auctoritas_known: Array[String] = []
@export var ritae_ignoblis_known: Array[String] = []


@export var thaumaturgy_path_progress: Dictionary = {}


@export var necromancy_paths: Array[String] = []
@export var necromancy_rituals: Array[String] = []
@export var necromancy_path_progress: Dictionary = {}






@export var inventory_general: Array[String] = []


@export var inventory_armor: Array[String] = []
@export var inventory_weapons: Array[String] = []


@export var armor: String = ""
@export var mainhand: String = ""
@export var offhand: String = ""




@export var health_levels: Array[String] = [
    "Healthy", "Bruised", "Hurt", "Injured", "Wounded", "Mauled", "Crippled", "Incapacitated"
]

@export var health_index: int = 0
@export var aggravated_wounds: Array[String] = []
@export var last_aggravated_heal_date: String = ""

@export var is_in_torpor: bool = false

@export var blush_of_life: bool = false




@export var last_time_woken_up: String = ""

@export var last_ap_reset_stamp: String = ""




@export var action_points_max: int = 3
@export var action_points_current: int = 3






func deserialize_from_dict(data: Dictionary) -> void :
    var property_names: = []
    for p in get_property_list():
        property_names.append(p.name)

    for key in data.keys():
        if key == "script":
            continue
        if key in property_names:
            set(key, data[key])
        else:

            print("⚠️ Skipped unknown property in deserialize:", key)





@rpc("authority")
func receive_character_data(data: Dictionary) -> void :
    print("📥 Receiving character data on client:", data.get("name", "Unknown"))

    deserialize_from_dict(data)
    GameManager.character_data = self


    NetworkManager.on_character_received(self)


func serialize_to_dict() -> Dictionary:
    var dict: = {}
    for property in get_property_list():
        var prop_name = property.name
        dict[prop_name] = get(prop_name)
    return dict
