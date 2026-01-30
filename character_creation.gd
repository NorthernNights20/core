extends Control

func get_index_by_text(button: OptionButton, text: String) -> int:
    for i in range(button.item_count):
        if button.get_item_text(i) == text:
            return i
    return -1

@onready var warning_popup = $WarningPopup

const DISCIPLINE_LABEL_PATHS = [
    "Discipline1Panel/Discipline1Container/Discipline1Label", 
    "Discipline2Panel/Discipline2Container/Discipline2Label", 
    "Discipline3Panel/Discipline3Container/Discipline3Label"
]




@onready var NextButton = $Background / NEXT


@onready var NameEdit = $Background / Panel2 / Panel / NameContainer / NameEdit
@onready var SectEdit = $Background / Panel2 / Panel / SectContainer / SectEdit
@onready var ClanEdit = $Background / Panel2 / Panel / ClanContainer / ClanEdit
@onready var NatureEdit = $Background / Panel2 / Panel / NatureContainer / NatureEdit
@onready var DemeanorEdit = $Background / Panel2 / Panel / DemeanorContainer / DemeanorEdit

@onready var PrimaryButton = $Background / AttributePanel / AttributeOrderPanel / PrimaryButton
@onready var SecondaryButton = $Background / AttributePanel / AttributeOrderPanel / SecondaryButton
@onready var TertiaryButton = $Background / AttributePanel / AttributeOrderPanel / TertiaryButton

@onready var PhysicalCounterNumber = $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalCounterBox / PhysicalCounterNumber
@onready var SocialCounterNumber = $Background / AttributePanel / AttributeListing / SocialPanel / SocialCounterBox / SocialCounterNumber
@onready var MentalCounterNumber = $Background / AttributePanel / AttributeListing / MentalPanel / MentalCounterBox / MentalCounterNumber

@onready var PrimaryAbilityButton = $Background / AbilityPanel / AbilityOrderPanel / PrimaryAbilityButton
@onready var SecondaryAbilityButton = $Background / AbilityPanel / AbilityOrderPanel / SecondaryAbilityButton
@onready var TertiaryAbilityButton = $Background / AbilityPanel / AbilityOrderPanel / TertiaryAbilityButton

@onready var TalentCounterNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsCounterBox / TalentsCounterNumber
@onready var SkillCounterNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsCounterBox / SkillsCounterNumber
@onready var KnowledgeCounterNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesCounterBox / KnowledgesCounterNumber




@onready var StrengthDots: = [
    $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StrengthPanel / StrengthPanelOrdering / Strength1, 
    $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StrengthPanel / StrengthPanelOrdering / Strength2, 
    $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StrengthPanel / StrengthPanelOrdering / Strength3, 
    $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StrengthPanel / StrengthPanelOrdering / Strength4, 
    $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StrengthPanel / StrengthPanelOrdering / Strength5
]

@onready var DexterityDots: = [
    $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / DexterityPanel / DexterityPanelOrdering / Dexterity1, 
    $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / DexterityPanel / DexterityPanelOrdering / Dexterity2, 
    $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / DexterityPanel / DexterityPanelOrdering / Dexterity3, 
    $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / DexterityPanel / DexterityPanelOrdering / Dexterity4, 
    $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / DexterityPanel / DexterityPanelOrdering / Dexterity5
]

@onready var StaminaDots: = [
    $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StaminaPanel / StaminaPanelOrdering / Stamina1, 
    $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StaminaPanel / StaminaPanelOrdering / Stamina2, 
    $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StaminaPanel / StaminaPanelOrdering / Stamina3, 
    $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StaminaPanel / StaminaPanelOrdering / Stamina4, 
    $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StaminaPanel / StaminaPanelOrdering / Stamina5
]

@onready var CharismaDots: = [
    $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / CharismaPanel / CharismaPanelOrdering / Charisma1, 
    $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / CharismaPanel / CharismaPanelOrdering / Charisma2, 
    $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / CharismaPanel / CharismaPanelOrdering / Charisma3, 
    $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / CharismaPanel / CharismaPanelOrdering / Charisma4, 
    $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / CharismaPanel / CharismaPanelOrdering / Charisma5
]

@onready var ManipulationDots: = [
    $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / ManipulationPanel / ManipulationPanelOrdering / Manipulation1, 
    $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / ManipulationPanel / ManipulationPanelOrdering / Manipulation2, 
    $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / ManipulationPanel / ManipulationPanelOrdering / Manipulation3, 
    $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / ManipulationPanel / ManipulationPanelOrdering / Manipulation4, 
    $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / ManipulationPanel / ManipulationPanelOrdering / Manipulation5
]

@onready var AppearanceDots: = [
    $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / AppearancePanel / AppearancePanelOrdering / Appearance1, 
    $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / AppearancePanel / AppearancePanelOrdering / Appearance2, 
    $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / AppearancePanel / AppearancePanelOrdering / Appearance3, 
    $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / AppearancePanel / AppearancePanelOrdering / Appearance4, 
    $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / AppearancePanel / AppearancePanelOrdering / Appearance5
]

@onready var PerceptionDots: = [
    $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / PerceptionPanel / PerceptionPanelOrdering / Perception1, 
    $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / PerceptionPanel / PerceptionPanelOrdering / Perception2, 
    $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / PerceptionPanel / PerceptionPanelOrdering / Perception3, 
    $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / PerceptionPanel / PerceptionPanelOrdering / Perception4, 
    $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / PerceptionPanel / PerceptionPanelOrdering / Perception5
]

@onready var IntelligenceDots: = [
    $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / IntelligencePanel / IntelligencePanelOrdering / Intelligence1, 
    $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / IntelligencePanel / IntelligencePanelOrdering / Intelligence2, 
    $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / IntelligencePanel / IntelligencePanelOrdering / Intelligence3, 
    $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / IntelligencePanel / IntelligencePanelOrdering / Intelligence4, 
    $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / IntelligencePanel / IntelligencePanelOrdering / Intelligence5
]

@onready var WitsDots: = [
    $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / WitsPanel / WitsPanelOrdering / Wits1, 
    $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / WitsPanel / WitsPanelOrdering / Wits2, 
    $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / WitsPanel / WitsPanelOrdering / Wits3, 
    $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / WitsPanel / WitsPanelOrdering / Wits4, 
    $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / WitsPanel / WitsPanelOrdering / Wits5
]

@onready var AlertnessDots: = [
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AlertnessContainer / Alertness1, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AlertnessContainer / Alertness2, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AlertnessContainer / Alertness3, 
]

@onready var AthleticsDots: = [
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AthleticsContainer / Athletics1, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AthleticsContainer / Athletics2, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AthleticsContainer / Athletics3, 
]

@onready var AwarenessDots: = [
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AwarenessContainer / Awareness1, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AwarenessContainer / Awareness2, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AwarenessContainer / Awareness3, 
]

@onready var BrawlDots: = [
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / BrawlContainer / Brawl1, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / BrawlContainer / Brawl2, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / BrawlContainer / Brawl3, 
]

@onready var EmpathyDots: = [
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / EmpathyContainer / Empathy1, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / EmpathyContainer / Empathy2, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / EmpathyContainer / Empathy3, 
]

@onready var ExpressionDots: = [
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / ExpressionContainer / Expression1, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / ExpressionContainer / Expression2, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / ExpressionContainer / Expression3, 
]

@onready var IntimidationDots: = [
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / IntimidationContainer / Intimidation1, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / IntimidationContainer / Intimidation2, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / IntimidationContainer / Intimidation3, 
]

@onready var LeadershipDots: = [
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / LeadershipContainer / Leadership1, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / LeadershipContainer / Leadership2, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / LeadershipContainer / Leadership3, 
]

@onready var StreetwiseDots: = [
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / StreetwiseContainer / Streetwise1, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / StreetwiseContainer / Streetwise2, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / StreetwiseContainer / Streetwise3, 
]

@onready var SubterfugeDots: = [
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / SubterfugeContainer / Subterfuge1, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / SubterfugeContainer / Subterfuge2, 
    $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / SubterfugeContainer / Subterfuge3, 
]


@onready var AnimalKenDots: = [
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / AnimalKenContainer / AnimalKen1, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / AnimalKenContainer / AnimalKen2, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / AnimalKenContainer / AnimalKen3, 
]

@onready var CraftsDots: = [
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / CraftContainer / Craft1, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / CraftContainer / Craft2, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / CraftContainer / Craft3, 
]

@onready var DriveDots: = [
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / DriveContainer / Drive1, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / DriveContainer / Drive2, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / DriveContainer / Drive3, 
]

@onready var EtiquetteDots: = [
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / EtiquetteContainer / Etiquette1, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / EtiquetteContainer / Etiquette2, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / EtiquetteContainer / Etiquette3, 
]

@onready var FirearmsDots: = [
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / FirearmsContainer / Firearms1, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / FirearmsContainer / Firearms2, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / FirearmsContainer / Firearms3, 
]

@onready var LarcenyDots: = [
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / LarcenyContainer / Larceny1, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / LarcenyContainer / Larceny2, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / LarcenyContainer / Larceny3, 
]


@onready var MeleeDots: = [
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / MeleeContainer / Melee1, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / MeleeContainer / Melee2, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / MeleeContainer / Melee3, 
]

@onready var PerformanceDots: = [
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / PerformanceContainer / Performance1, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / PerformanceContainer / Performance2, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / PerformanceContainer / Performance3, 
]

@onready var StealthDots: = [
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / StealthContainer / Stealth1, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / StealthContainer / Stealth2, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / StealthContainer / Stealth3, 
]

@onready var SurvivalDots: = [
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / SurvivalContainer / Survival1, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / SurvivalContainer / Survival2, 
    $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / SurvivalContainer / Survival3, 
]

@onready var AcademicsDots: = [
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / AcademicsContainer / Academics1, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / AcademicsContainer / Academics2, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / AcademicsContainer / Academics3, 
]

@onready var ComputerDots: = [
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / ComputerContainer / Computer1, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / ComputerContainer / Computer2, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / ComputerContainer / Computer3, 
]

@onready var FinanceDots: = [
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / FinanceContainer / Finance1, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / FinanceContainer / Finance2, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / FinanceContainer / Finance3, 
]

@onready var InvestigationDots: = [
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / InvestigationContainer / Investigation1, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / InvestigationContainer / Investigation2, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / InvestigationContainer / Investigation3, 
]

@onready var LawDots: = [
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / LawContainer / Law1, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / LawContainer / Law2, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / LawContainer / Law3, 
]

@onready var MedicineDots: = [
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / MedicineContainer / Medicine1, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / MedicineContainer / Medicine2, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / MedicineContainer / Medicine3, 
]

@onready var OccultDots: = [
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / OccultContainer / Occult1, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / OccultContainer / Occult2, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / OccultContainer / Occult3, 
]

@onready var PoliticsDots: = [
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / PoliticsContainer / Politics1, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / PoliticsContainer / Politics2, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / PoliticsContainer / Politics3, 
]

@onready var ScienceDots: = [
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / ScienceContainer / Science1, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / ScienceContainer / Science2, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / ScienceContainer / Science3, 
]

@onready var TechnologyDots: = [
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / TechnologyContainer / Technology1, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / TechnologyContainer / Technology2, 
    $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / TechnologyContainer / Technology3, 
]

@onready var Discipline1Label = $Background / DisciplinePanel / DisciplineContainer / Discipline1Panel / Discipline1Container / Discipline1Label
@onready var Discipline2Label = $Background / DisciplinePanel / DisciplineContainer / Discipline2Panel / Discipline2Container / Discipline2Label
@onready var Discipline3Label = $Background / DisciplinePanel / DisciplineContainer / Discipline3Panel / Discipline3Container / Discipline3Label
@onready var DisciplineNumberLabel = $Background / DisciplinePanel / DisciplineNumberContainer / DisciplineNumberLabel

@onready var Discipline1Dots: = [
    $Background / DisciplinePanel / DisciplineContainer / Discipline1Panel / Discipline1Container / Discipline1ButtonContainer / Discipline1Button1, 
    $Background / DisciplinePanel / DisciplineContainer / Discipline1Panel / Discipline1Container / Discipline1ButtonContainer / Discipline1Button2, 
    $Background / DisciplinePanel / DisciplineContainer / Discipline1Panel / Discipline1Container / Discipline1ButtonContainer / Discipline1Button3
]

@onready var Discipline2Dots: = [
    $Background / DisciplinePanel / DisciplineContainer / Discipline2Panel / Discipline2Container / Discipline2ButtonContainer / Discipline2Button1, 
    $Background / DisciplinePanel / DisciplineContainer / Discipline2Panel / Discipline2Container / Discipline2ButtonContainer / Discipline2Button2, 
    $Background / DisciplinePanel / DisciplineContainer / Discipline2Panel / Discipline2Container / Discipline2ButtonContainer / Discipline2Button3
]

@onready var Discipline3Dots: = [
    $Background / DisciplinePanel / DisciplineContainer / Discipline3Panel / Discipline3Container / Discipline3ButtonContainer / Discipline3Button1, 
    $Background / DisciplinePanel / DisciplineContainer / Discipline3Panel / Discipline3Container / Discipline3ButtonContainer / Discipline3Button2, 
    $Background / DisciplinePanel / DisciplineContainer / Discipline3Panel / Discipline3Container / Discipline3ButtonContainer / Discipline3Button3
]


@onready var BackgroundCounterNumber = $Background / BackgroundPanel / BackgroundCounterBox / BackgroundCounterNumber

@onready var AlliesDots: = [
    $Background / BackgroundPanel / BackgroundListing / AlliesContainer / Allies1, 
    $Background / BackgroundPanel / BackgroundListing / AlliesContainer / Allies2, 
    $Background / BackgroundPanel / BackgroundListing / AlliesContainer / Allies3, 
    $Background / BackgroundPanel / BackgroundListing / AlliesContainer / Allies4, 
    $Background / BackgroundPanel / BackgroundListing / AlliesContainer / Allies5
]

@onready var ContactsDots: = [
    $Background / BackgroundPanel / BackgroundListing / ContactsContainer / Contacts1, 
    $Background / BackgroundPanel / BackgroundListing / ContactsContainer / Contacts2, 
    $Background / BackgroundPanel / BackgroundListing / ContactsContainer / Contacts3, 
    $Background / BackgroundPanel / BackgroundListing / ContactsContainer / Contacts4, 
    $Background / BackgroundPanel / BackgroundListing / ContactsContainer / Contacts5
]

@onready var DomainDots: = [
    $Background / BackgroundPanel / BackgroundListing / DomainContainer / Domain1, 
    $Background / BackgroundPanel / BackgroundListing / DomainContainer / Domain2, 
    $Background / BackgroundPanel / BackgroundListing / DomainContainer / Domain3, 
    $Background / BackgroundPanel / BackgroundListing / DomainContainer / Domain4, 
    $Background / BackgroundPanel / BackgroundListing / DomainContainer / Domain5
]

@onready var FameDots: = [
    $Background / BackgroundPanel / BackgroundListing / FameContainer / Fame1, 
    $Background / BackgroundPanel / BackgroundListing / FameContainer / Fame2, 
    $Background / BackgroundPanel / BackgroundListing / FameContainer / Fame3, 
    $Background / BackgroundPanel / BackgroundListing / FameContainer / Fame4, 
    $Background / BackgroundPanel / BackgroundListing / FameContainer / Fame5
]

@onready var GenerationDots: = [
    $Background / BackgroundPanel / BackgroundListing / GenerationContainer / Generation1, 
    $Background / BackgroundPanel / BackgroundListing / GenerationContainer / Generation2, 
    $Background / BackgroundPanel / BackgroundListing / GenerationContainer / Generation3, 
    $Background / BackgroundPanel / BackgroundListing / GenerationContainer / Generation4, 
    $Background / BackgroundPanel / BackgroundListing / GenerationContainer / Generation5
]

@onready var HavenDots: = [
    $Background / BackgroundPanel / BackgroundListing / HavenContainer / Haven1, 
    $Background / BackgroundPanel / BackgroundListing / HavenContainer / Haven2, 
    $Background / BackgroundPanel / BackgroundListing / HavenContainer / Haven3, 
    $Background / BackgroundPanel / BackgroundListing / HavenContainer / Haven4, 
    $Background / BackgroundPanel / BackgroundListing / HavenContainer / Haven5
]

@onready var HerdDots: = [
    $Background / BackgroundPanel / BackgroundListing / HerdContainer / Herd1, 
    $Background / BackgroundPanel / BackgroundListing / HerdContainer / Herd2, 
    $Background / BackgroundPanel / BackgroundListing / HerdContainer / Herd3, 
    $Background / BackgroundPanel / BackgroundListing / HerdContainer / Herd4, 
    $Background / BackgroundPanel / BackgroundListing / HerdContainer / Herd5
]

@onready var InfluenceDots: = [
    $Background / BackgroundPanel / BackgroundListing / InfluenceContainer / Influence1, 
    $Background / BackgroundPanel / BackgroundListing / InfluenceContainer / Influence2, 
    $Background / BackgroundPanel / BackgroundListing / InfluenceContainer / Influence3, 
    $Background / BackgroundPanel / BackgroundListing / InfluenceContainer / Influence4, 
    $Background / BackgroundPanel / BackgroundListing / InfluenceContainer / Influence5
]

@onready var MentorDots: = [
    $Background / BackgroundPanel / BackgroundListing / MentorContainer / Mentor1, 
    $Background / BackgroundPanel / BackgroundListing / MentorContainer / Mentor2, 
    $Background / BackgroundPanel / BackgroundListing / MentorContainer / Mentor3, 
    $Background / BackgroundPanel / BackgroundListing / MentorContainer / Mentor4, 
    $Background / BackgroundPanel / BackgroundListing / MentorContainer / Mentor5
]

@onready var ResourcesDots: = [
    $Background / BackgroundPanel / BackgroundListing / ResourcesContainer / Resources1, 
    $Background / BackgroundPanel / BackgroundListing / ResourcesContainer / Resources2, 
    $Background / BackgroundPanel / BackgroundListing / ResourcesContainer / Resources3, 
    $Background / BackgroundPanel / BackgroundListing / ResourcesContainer / Resources4, 
    $Background / BackgroundPanel / BackgroundListing / ResourcesContainer / Resources5
]

@onready var RetainersDots: = [
    $Background / BackgroundPanel / BackgroundListing / RetainersContainer / Retainers1, 
    $Background / BackgroundPanel / BackgroundListing / RetainersContainer / Retainers2, 
    $Background / BackgroundPanel / BackgroundListing / RetainersContainer / Retainers3, 
    $Background / BackgroundPanel / BackgroundListing / RetainersContainer / Retainers4, 
    $Background / BackgroundPanel / BackgroundListing / RetainersContainer / Retainers5
]

@onready var RitualsDots: = [
    $Background / BackgroundPanel / BackgroundListing / RitualsContainer / Rituals1, 
    $Background / BackgroundPanel / BackgroundListing / RitualsContainer / Rituals2, 
    $Background / BackgroundPanel / BackgroundListing / RitualsContainer / Rituals3, 
    $Background / BackgroundPanel / BackgroundListing / RitualsContainer / Rituals4, 
    $Background / BackgroundPanel / BackgroundListing / RitualsContainer / Rituals5
]

@onready var StatusDots: = [
    $Background / BackgroundPanel / BackgroundListing / StatusContainer / Status1, 
    $Background / BackgroundPanel / BackgroundListing / StatusContainer / Status2, 
    $Background / BackgroundPanel / BackgroundListing / StatusContainer / Status3, 
    $Background / BackgroundPanel / BackgroundListing / StatusContainer / Status4, 
    $Background / BackgroundPanel / BackgroundListing / StatusContainer / Status5
]

@onready var VirtueCounterNumber = $Background / VirtuePanel / VBoxContainer / PathContainer / VirtueNumberContainer / VirtueNumberLabel

@onready var CourageDots: = [
    $Background / VirtuePanel / VBoxContainer / VirtuesContainer / CouragePanel / CourageContainer / Courage1, 
    $Background / VirtuePanel / VBoxContainer / VirtuesContainer / CouragePanel / CourageContainer / Courage2, 
    $Background / VirtuePanel / VBoxContainer / VirtuesContainer / CouragePanel / CourageContainer / Courage3, 
    $Background / VirtuePanel / VBoxContainer / VirtuesContainer / CouragePanel / CourageContainer / Courage4, 
    $Background / VirtuePanel / VBoxContainer / VirtuesContainer / CouragePanel / CourageContainer / Courage5
]

@onready var SelfControlDots: = [
    $Background / VirtuePanel / VBoxContainer / VirtuesContainer / SelfControlPanel / SelfControlContainer / SelfControl1, 
    $Background / VirtuePanel / VBoxContainer / VirtuesContainer / SelfControlPanel / SelfControlContainer / SelfControl2, 
    $Background / VirtuePanel / VBoxContainer / VirtuesContainer / SelfControlPanel / SelfControlContainer / SelfControl3, 
    $Background / VirtuePanel / VBoxContainer / VirtuesContainer / SelfControlPanel / SelfControlContainer / SelfControl4, 
    $Background / VirtuePanel / VBoxContainer / VirtuesContainer / SelfControlPanel / SelfControlContainer / SelfControl5
]


@onready var ConscienceDots: = [
    $Background / VirtuePanel / VBoxContainer / VirtuesContainer / ConsciencePanel / ConscienceContainer / Conscience1, 
    $Background / VirtuePanel / VBoxContainer / VirtuesContainer / ConsciencePanel / ConscienceContainer / Conscience2, 
    $Background / VirtuePanel / VBoxContainer / VirtuesContainer / ConsciencePanel / ConscienceContainer / Conscience3, 
    $Background / VirtuePanel / VBoxContainer / VirtuesContainer / ConsciencePanel / ConscienceContainer / Conscience4, 
    $Background / VirtuePanel / VBoxContainer / VirtuesContainer / ConsciencePanel / ConscienceContainer / Conscience5
]

@onready var PathButton = $Background / VirtuePanel / VBoxContainer / PathContainer / PathButton
@onready var ConscienceLabel = $Background / VirtuePanel / VBoxContainer / VirtuesContainer / ConsciencePanel / ConscienceContainer / Conscience
@onready var SelfControlLabel = $Background / VirtuePanel / VBoxContainer / VirtuesContainer / SelfControlPanel / SelfControlContainer / SelfControl




var attribute_categories = ["Physical", "Social", "Mental"]
var ability_categories = ["Talents", "Skills", "Knowledges"]


var physical_points_max: int = 0
var physical_points_remaining: int = 0
var strength_rating: int = 1
var dexterity_rating: int = 1
var stamina_rating: int = 1
var social_points_max: int = 0
var social_points_remaining: int = 0
var charisma_rating: int = 1
var manipulation_rating: int = 1
var appearance_rating: int = 1
var mental_points_max: int = 0
var mental_points_remaining: int = 0
var perception_rating: int = 1
var intelligence_rating: int = 1
var wits_rating: int = 1
var talent_points_max: int = 0
var talent_points_remaining: int = 0
var skill_points_max: int = 0
var skill_points_remaining: int = 0
var knowledge_points_max: int = 0
var knowledge_points_remaining: int = 0




var alertness_rating = 0
var athletics_rating = 0
var awareness_rating = 0
var brawl_rating = 0
var empathy_rating = 0
var expression_rating = 0
var intimidation_rating = 0
var leadership_rating = 0
var streetwise_rating = 0
var subterfuge_rating = 0


var animalken_rating = 0
var crafts_rating = 0
var drive_rating = 0
var etiquette_rating = 0
var firearms_rating = 0
var larceny_rating = 0
var melee_rating = 0
var performance_rating = 0
var stealth_rating = 0
var survival_rating = 0


var academics_rating = 0
var computer_rating = 0
var finance_rating = 0
var investigation_rating = 0
var law_rating = 0
var medicine_rating = 0
var occult_rating = 0
var politics_rating = 0
var science_rating = 0
var technology_rating = 0

var discipline_points_max: = 3
var discipline_points_remaining: = 3

var discipline1_rating: = 0
var discipline2_rating: = 0
var discipline3_rating: = 0


var allies_rating: = 0
var contacts_rating: = 0
var domain_rating: = 0
var fame_rating: = 0
var generation_rating: = 0
var haven_rating: = 0
var herd_rating: = 0
var influence_rating: = 0
var mentor_rating: = 0
var resources_rating: = 0
var retainers_rating: = 0
var rituals_rating: = 0
var status_rating: = 0

var virtue_points_max: = 7
var virtue_points_remaining: = 7

var courage_rating: = 1
var selfcontrol_rating: = 1
var conscience_rating: = 1
var Conviction: = 0
var Instinct: = 0


var selected_clan: String = ""


func _on_clan_edit_item_selected(index: int) -> void :
    selected_clan = ClanEdit.get_item_text(index)

    var use_option_buttons: = selected_clan == "Caitiff" or selected_clan == "Panders"

    var base_path = "Background/DisciplinePanel/DisciplineContainer/"
    var discipline_names = ["Discipline1", "Discipline2", "Discipline3"]
    for i in range(3):
        var container_path = base_path + "%sPanel/%sContainer" % [discipline_names[i], discipline_names[i]]
        var parent_node = get_node(container_path)
        var label_node = parent_node.get_node_or_null("%sLabel" % discipline_names[i])
        var option_node = parent_node.get_node_or_null("%sOption" % discipline_names[i])

        var selected_text: = ""
        if clan_discipline_map.has(selected_clan):
            selected_text = clan_discipline_map[selected_clan][i]

        if use_option_buttons:
            if not option_node:
                option_node = create_discipline_option_button("%sOption" % discipline_names[i], selected_text)
                parent_node.add_child(option_node)
            else:

                var index_to_select: int = option_node.get_item_count()
                for j in range(option_node.get_item_count()):
                    if option_node.get_item_text(j) == selected_text:
                        index_to_select = j
                        break
                option_node.select(index_to_select)


            option_node.visible = true
        else:
            if label_node:
                label_node.visible = true
            if option_node:
                option_node.visible = false


    if clan_discipline_map.has(selected_clan):
        var disciplines = clan_discipline_map[selected_clan]
        Discipline1Label.text = disciplines[0]
        Discipline2Label.text = disciplines[1]
        Discipline3Label.text = disciplines[2]
    else:
        Discipline1Label.text = ""
        Discipline2Label.text = ""
        Discipline3Label.text = ""


    discipline1_rating = 0
    discipline2_rating = 0
    discipline3_rating = 0
    discipline_points_remaining = 3
    DisciplineNumberLabel.text = str(discipline_points_remaining)


    if selected_clan == "Nosferatu" or selected_clan == "Nosferatu Antitribu":
        if appearance_rating > 1:
            var refunded = appearance_rating - 1
            social_points_remaining += refunded
        elif appearance_rating == 1:
            social_points_remaining += 0

        appearance_rating = 0
        initialize_dots(AppearanceDots, 0)

        for i in range(1, 6):
            var path = "Background/AttributePanel/AttributeListing/SocialPanel/SocialAttributes/AppearancePanel/AppearancePanelOrdering/Appearance%d" % i
            var button = get_node(path)
            if button:
                button.set_pressed_no_signal(false)
                button.toggle_mode = false
    else:

        if appearance_rating == 0:
            appearance_rating = 1
            social_points_remaining -= 1
            initialize_dots(AppearanceDots, 1)


        for i in range(1, 6):
            var path = "Background/AttributePanel/AttributeListing/SocialPanel/SocialAttributes/AppearancePanel/AppearancePanelOrdering/Appearance%d" % i
            var button = get_node(path)
            if button:
                button.toggle_mode = true


    update_attribute_counters()




var clan_discipline_map = {
    "Assamite Antitribu": ["Celerity", "Obfuscate", "Quietus"], 
    "Brujah": ["Celerity", "Potence", "Presence"], 
    "Brujah Antitribu": ["Celerity", "Potence", "Presence"], 
    "Daughters of Cacophony": ["Fortitude", "Melpominee", "Presence"], 
    "Gangrel": ["Animalism", "Fortitude", "Protean"], 
    "Giovanni": ["Dominance", "Necromancy", "Potence"], 
    "Country Gangrel": ["Animalism", "Fortitude", "Protean"], 
    "City Gangrel": ["Celerity", "Obfuscate", "Protean"], 
    "Malkavian": ["Auspex", "Dementation", "Obfuscate"], 
    "Malkavian Antitribu": ["Auspex", "Dementation", "Obfuscate"], 
    "Nosferatu": ["Animalism", "Obfuscate", "Potence"], 
    "Nosferatu Antitribu": ["Animalism", "Obfuscate", "Potence"], 
    "Ravnos Antitribu": ["Animalism", "Chimerstry", "Fortitude"], 
    "Toreador": ["Auspex", "Celerity", "Presence"], 
    "Toreador Antitribu": ["Auspex", "Celerity", "Presence"], 
    "Salubri Antitribu": ["Auspex", "Fortitude", "Valeren"], 
    "Samedi": ["Fortitude", "Obfuscate", "Thanatosis"], 
    "Serpents of the Light": ["Presence", "Obfuscate", "Serpentis"], 
    "Tremere": ["Auspex", "Dominate", "Thaumaturgy"], 
    "Tremere Antitribu": ["Auspex", "Dominate", "Thaumaturgy"], 
    "Ventrue": ["Dominate", "Fortitude", "Presence"], 
    "Ventrue Antitribu": ["Dominate", "Fortitude", "Presence"], 
    "Lasombra": ["Dominate", "Obtenebration", "Potence"], 
    "Tzimisce": ["Animalism", "Auspex", "Vicissitude"]
}

var path_virtue_map = {
    "Humanity": ["Conscience", "Self-Control"], 
    "Path of the Beast": ["Conviction", "Instinct"], 
    "Path of Harmony": ["Conscience", "Instinct"], 
    "Path of Death and the Soul": ["Conviction", "Self-Control"], 
    "Path of Caine": ["Conviction", "Instinct"], 
    "Path of Cathari": ["Conviction", "Instinct"], 
    "Path of Evil Revelations": ["Conviction", "Instinct"], 
    "Path of Feral Heart": ["Conviction", "Instinct"], 
    "Path of Honorable Accord": ["Conscience", "Self-Control"], 
    "Path of Lilith": ["Conviction", "Instinct"], 
    "Path of Metamorphosis": ["Conviction", "Instinct"], 
    "Path of Night": ["Conviction", "Instinct"], 
    "Path of Power and the Inner Voice": ["Conviction", "Instinct"], 
    "Path of Scorched Heart": ["Conviction", "Self-Control"], 
    "Path of Nocturnal Redemption": ["Conscience", "Self-Control"], 
    "Path of Redemption": ["Conscience", "Self-Control"]
}


func _ready():
    print("[DEBUG] Character creation scene ready. Connecting signal.")
    NetworkManager.connect("name_check_result_received", Callable(self, "_on_name_check_result_received"))
    NextButton.pressed.connect(_on_next_button_pressed)

    initialize_character_creation_ui()
    initialize_attribute_order_buttons()
    initialize_ability_order_buttons()

    initialize_dots(StrengthDots, 1)
    initialize_dots(DexterityDots, 1)
    initialize_dots(StaminaDots, 1)
    initialize_dots(CharismaDots, 1)
    initialize_dots(ManipulationDots, 1)
    initialize_dots(AppearanceDots, 1)
    initialize_dots(PerceptionDots, 1)
    initialize_dots(IntelligenceDots, 1)
    initialize_dots(WitsDots, 1)

    update_physical_counter()
    update_social_counter()
    update_mental_counter()

    for i in StrengthDots.size():
        StrengthDots[i].pressed.connect(_make_dot_handler("Strength", i))
    for i in DexterityDots.size():
        DexterityDots[i].pressed.connect(_make_dot_handler("Dexterity", i))
    for i in StaminaDots.size():
        StaminaDots[i].pressed.connect(_make_dot_handler("Stamina", i))
    for i in CharismaDots.size():
        CharismaDots[i].pressed.connect(_make_dot_handler("Charisma", i))
    for i in ManipulationDots.size():
        ManipulationDots[i].pressed.connect(_make_dot_handler("Manipulation", i))
    for i in AppearanceDots.size():
        AppearanceDots[i].pressed.connect(_make_dot_handler("Appearance", i))
    for i in PerceptionDots.size():
        PerceptionDots[i].pressed.connect(_make_dot_handler("Perception", i))
    for i in IntelligenceDots.size():
        IntelligenceDots[i].pressed.connect(_make_dot_handler("Intelligence", i))
    for i in WitsDots.size():
        WitsDots[i].pressed.connect(_make_dot_handler("Wits", i))
    for i in AlertnessDots.size():
        AlertnessDots[i].pressed.connect(_make_ability_dot_handler("Alertness", i))
    for i in AthleticsDots.size():
        AthleticsDots[i].pressed.connect(_make_ability_dot_handler("Athletics", i))
    for i in AwarenessDots.size():
        AwarenessDots[i].pressed.connect(_make_ability_dot_handler("Awareness", i))
    for i in BrawlDots.size():
        BrawlDots[i].pressed.connect(_make_ability_dot_handler("Brawl", i))
    for i in EmpathyDots.size():
        EmpathyDots[i].pressed.connect(_make_ability_dot_handler("Empathy", i))
    for i in ExpressionDots.size():
        ExpressionDots[i].pressed.connect(_make_ability_dot_handler("Expression", i))
    for i in IntimidationDots.size():
        IntimidationDots[i].pressed.connect(_make_ability_dot_handler("Intimidation", i))
    for i in LeadershipDots.size():
        LeadershipDots[i].pressed.connect(_make_ability_dot_handler("Leadership", i))
    for i in StreetwiseDots.size():
        StreetwiseDots[i].pressed.connect(_make_ability_dot_handler("Streetwise", i))
    for i in SubterfugeDots.size():
        SubterfugeDots[i].pressed.connect(_make_ability_dot_handler("Subterfuge", i))

    for i in AnimalKenDots.size():
        AnimalKenDots[i].pressed.connect(_make_ability_dot_handler("AnimalKen", i))
    for i in CraftsDots.size():
        CraftsDots[i].pressed.connect(_make_ability_dot_handler("Crafts", i))
    for i in DriveDots.size():
        DriveDots[i].pressed.connect(_make_ability_dot_handler("Drive", i))
    for i in EtiquetteDots.size():
        EtiquetteDots[i].pressed.connect(_make_ability_dot_handler("Etiquette", i))
    for i in FirearmsDots.size():
        FirearmsDots[i].pressed.connect(_make_ability_dot_handler("Firearms", i))
    for i in LarcenyDots.size():
        LarcenyDots[i].pressed.connect(_make_ability_dot_handler("Larceny", i))
    for i in MeleeDots.size():
        MeleeDots[i].pressed.connect(_make_ability_dot_handler("Melee", i))
    for i in PerformanceDots.size():
        PerformanceDots[i].pressed.connect(_make_ability_dot_handler("Performance", i))
    for i in StealthDots.size():
        StealthDots[i].pressed.connect(_make_ability_dot_handler("Stealth", i))
    for i in SurvivalDots.size():
        SurvivalDots[i].pressed.connect(_make_ability_dot_handler("Survival", i))
    for i in TechnologyDots.size():
        TechnologyDots[i].pressed.connect(_make_ability_dot_handler("Technology", i))

    for i in AcademicsDots.size():
        AcademicsDots[i].pressed.connect(_make_ability_dot_handler("Academics", i))
    for i in ComputerDots.size():
        ComputerDots[i].pressed.connect(_make_ability_dot_handler("Computer", i))
    for i in FinanceDots.size():
        FinanceDots[i].pressed.connect(_make_ability_dot_handler("Finance", i))
    for i in InvestigationDots.size():
        InvestigationDots[i].pressed.connect(_make_ability_dot_handler("Investigation", i))
    for i in LawDots.size():
        LawDots[i].pressed.connect(_make_ability_dot_handler("Law", i))
    for i in MedicineDots.size():
        MedicineDots[i].pressed.connect(_make_ability_dot_handler("Medicine", i))
    for i in OccultDots.size():
        OccultDots[i].pressed.connect(_make_ability_dot_handler("Occult", i))
    for i in PoliticsDots.size():
        PoliticsDots[i].pressed.connect(_make_ability_dot_handler("Politics", i))
    for i in ScienceDots.size():
        ScienceDots[i].pressed.connect(_make_ability_dot_handler("Science", i))

    for i in Discipline1Dots.size():
        Discipline1Dots[i].pressed.connect(_make_discipline_dot_handler(i, 1))

    for i in Discipline2Dots.size():
        Discipline2Dots[i].pressed.connect(_make_discipline_dot_handler(i, 2))

    for i in Discipline3Dots.size():
        Discipline3Dots[i].pressed.connect(_make_discipline_dot_handler(i, 3))


    SectEdit.item_selected.connect(_on_sect_edit_item_selected)
    ClanEdit.item_selected.connect(_on_clan_edit_item_selected)


    PrimaryAbilityButton.item_selected.connect(_on_primary_ability_button_item_selected)
    SecondaryAbilityButton.item_selected.connect(_on_secondary_ability_button_item_selected)
    TertiaryAbilityButton.item_selected.connect(_on_tertiary_ability_button_item_selected)

    for i in range(5):
        AlliesDots[i].pressed.connect(_make_background_dot_handler("Allies", i))
        ContactsDots[i].pressed.connect(_make_background_dot_handler("Contacts", i))
        DomainDots[i].pressed.connect(_make_background_dot_handler("Domain", i))
        FameDots[i].pressed.connect(_make_background_dot_handler("Fame", i))
        GenerationDots[i].pressed.connect(_make_background_dot_handler("Generation", i))
        HavenDots[i].pressed.connect(_make_background_dot_handler("Haven", i))
        HerdDots[i].pressed.connect(_make_background_dot_handler("Herd", i))
        InfluenceDots[i].pressed.connect(_make_background_dot_handler("Influence", i))
        MentorDots[i].pressed.connect(_make_background_dot_handler("Mentor", i))
        ResourcesDots[i].pressed.connect(_make_background_dot_handler("Resources", i))
        RetainersDots[i].pressed.connect(_make_background_dot_handler("Retainers", i))
        RitualsDots[i].pressed.connect(_make_background_dot_handler("Rituals", i))
        StatusDots[i].pressed.connect(_make_background_dot_handler("Status", i))
    BackgroundCounterNumber.text = str(background_points_remaining)


    VirtueCounterNumber.text = str(virtue_points_remaining)

    initialize_dots(CourageDots, 1)
    initialize_dots(SelfControlDots, 1)
    initialize_dots(ConscienceDots, 1)

    for i in range(5):
        ConscienceDots[i].pressed.connect(_make_virtue_dot_handler("Conscience", i))
        SelfControlDots[i].pressed.connect(_make_virtue_dot_handler("SelfControl", i))
        CourageDots[i].pressed.connect(_make_virtue_dot_handler("Courage", i))

    PathButton.item_selected.connect(_on_path_button_item_selected)
    populate_ui_from_player_data()


const AVAILABLE_DISCIPLINES: = [
    "Animalism", "Auspex", "Celerity", "Chimerstry", "Dementation", "Dominate", 
    "Fortitude", "Necromancy", "Obfuscate", "Obtenebration", "Potence", "Presence", 
    "Protean", "Quietus", "Serpentis", "Thaumaturgy", "Vicissitude", "Abombwe", 
    "Bardo", "Daimoinon", "Flight", "Melpominee", "Mytherceria", "Obeah", 
    "Ogham", "Sanguinus", "Spiritus", "Temporis", "Thanatosis", "Valeren", 
    "Visceratika"
]

func create_discipline_option_button(node_name: String, selected_text: String) -> OptionButton:
    var option: = OptionButton.new()
    option.name = node_name

    for d in AVAILABLE_DISCIPLINES:
        option.add_item(d)


    var index: = -1
    for i in range(option.get_item_count()):
        if option.get_item_text(i) == selected_text:
            index = i
            break

    option.select(index)



    option.connect("item_selected", func(selected_index):
        var selected_discipline = option.get_item_text(selected_index)

        match node_name:
            "Discipline1Option":
                Discipline1Label.text = selected_discipline
            "Discipline2Option":
                Discipline2Label.text = selected_discipline
            "Discipline3Option":
                Discipline3Label.text = selected_discipline
    )

    return option







func initialize_character_creation_ui():
    var natures = ["Anarchist", "Architect", "Autocrat", "Bon Vivant", "Bravo", "Capitalist", "Caregiver", "Celebrant", "Chameleon", "Child", "Competitor", "Conformist", "Conniver", "Creep Show", "Critic", "Curmudgeon", "Dabbler", "Deviant", "Director", "Enigma", "Eye of the Storm", "Fanatic", "Gallant", "Guru", "Idealist", "Judge", "Loner", "Martyr", "Masochist", "Monster", "Nihilist", "Pedagogue", "Penitent", "Perfectionist", "Rebel", "Rogue", "Sadist", "Scientist", "Sociopath", "Soldier", "Survivor", "Thrill-Seeker", "Traditionalist", "Trickster", "Visionary"]
    for nature in natures:
        NatureEdit.add_item(nature)
        DemeanorEdit.add_item(nature)

    SectEdit.clear()
    SectEdit.add_item("Camarilla")
    SectEdit.add_item("Sabbat")
    SectEdit.selected = -1

    ClanEdit.clear()
    ClanEdit.custom_minimum_size = Vector2(200, 0)

    PathButton.clear()
    for path_name in path_virtue_map.keys():
        PathButton.add_item(path_name)
    PathButton.selected = 0


func _on_sect_edit_item_selected(index: int):
    var selected_sect = SectEdit.get_item_text(index)
    ClanEdit.clear()

    var camarilla_clans = [
        "Caitiff", "Brujah", "Daughters of Cacophony", "Gangrel", "Malkavian", "Nosferatu", "Toreador", "Tremere", "Ventrue", "Giovanni"
    ]
    var sabbat_clans = [
        "Lasombra", "Tzimisce", "Assamite Antitribu", "Brujah Antitribu", "Country Gangrel", "City Gangrel", "Daughters of Cacophony", 
        "Malkavian Antitribu", "Nosferatu Antitribu", "Panders", "Ravnos Antitribu", "Salubri Antitribu", "Samedi", "Serpents of the Light", "Toreador Antitribu", 
        "Tremere Antitribu", "Ventrue Antitribu"
    ]

    if selected_sect == "Camarilla":
        for clan in camarilla_clans:
            ClanEdit.add_item(clan)
    elif selected_sect == "Sabbat":
        for clan in sabbat_clans:
            ClanEdit.add_item(clan)

    ClanEdit.selected = -1


    Discipline1Label.text = ""
    Discipline2Label.text = ""
    Discipline3Label.text = ""


func initialize_attribute_order_buttons():
    PrimaryButton.clear()
    for cat in attribute_categories:
        PrimaryButton.add_item(cat)
    PrimaryButton.selected = -1
    SecondaryButton.clear()
    TertiaryButton.clear()



func _on_primary_button_item_selected(index: int):
    var selected_primary = PrimaryButton.get_item_text(index)
    SecondaryButton.clear()
    for cat in attribute_categories:
        if cat != selected_primary:
            SecondaryButton.add_item(cat)
    SecondaryButton.selected = -1
    TertiaryButton.clear()
    reset_all_physical()
    update_attribute_counters()

func _on_secondary_button_item_selected(index: int):
    var selected_primary = PrimaryButton.get_item_text(PrimaryButton.selected)
    var selected_secondary = SecondaryButton.get_item_text(index)
    TertiaryButton.clear()
    for cat in attribute_categories:
        if cat != selected_primary and cat != selected_secondary:
            TertiaryButton.add_item(cat)
            TertiaryButton.select(0)
    reset_all_physical()
    update_attribute_counters()

func _on_tertiary_button_item_selected(_index: int):
    reset_all_physical()
    update_attribute_counters()

func update_attribute_counters():
    PhysicalCounterNumber.text = "0"
    SocialCounterNumber.text = "0"
    MentalCounterNumber.text = "0"

    var primary = ""
    var secondary = ""
    var tertiary = ""

    if PrimaryButton.selected >= 0:
        primary = PrimaryButton.get_item_text(PrimaryButton.selected)
    if SecondaryButton.selected >= 0:
        secondary = SecondaryButton.get_item_text(SecondaryButton.selected)
    if TertiaryButton.selected >= 0:
        tertiary = TertiaryButton.get_item_text(TertiaryButton.selected)


    var physical_total: = 0
    if primary == "Physical": physical_total += 7
    if secondary == "Physical": physical_total += 5
    if tertiary == "Physical": physical_total += 3

    physical_points_max = physical_total
    physical_points_remaining = physical_points_max - (
        (strength_rating - 1) + (dexterity_rating - 1) + (stamina_rating - 1)
    )
    PhysicalCounterNumber.text = str(physical_points_remaining)


    var social_total: = 0
    if primary == "Social": social_total += 7
    if secondary == "Social": social_total += 5
    if tertiary == "Social": social_total += 3

    social_points_max = social_total


    if selected_clan == "Nosferatu" or selected_clan == "Nosferatu Antitribu":
        social_points_remaining = social_points_max - (
            (charisma_rating - 1) + (manipulation_rating - 1) + appearance_rating
        )
    else:
        social_points_remaining = social_points_max - (
            (charisma_rating - 1) + (manipulation_rating - 1) + (appearance_rating - 1)
        )

    SocialCounterNumber.text = str(social_points_remaining)




    var mental_total: = 0
    if primary == "Mental": mental_total += 7
    if secondary == "Mental": mental_total += 5
    if tertiary == "Mental": mental_total += 3

    mental_points_max = mental_total
    mental_points_remaining = mental_points_max - (
        (perception_rating - 1) + (intelligence_rating - 1) + (wits_rating - 1)
)
    MentalCounterNumber.text = str(mental_points_remaining)



func _make_dot_handler(stat: String, index: int) -> Callable:
    return func():

        if stat == "Appearance" and selected_clan == "Nosferatu":
            return

        var new_value: = index + 1
        var current_value: = 1
        var remaining_points: = 0

        match stat:
            "Strength":
                current_value = strength_rating
                remaining_points = physical_points_remaining
            "Dexterity":
                current_value = dexterity_rating
                remaining_points = physical_points_remaining
            "Stamina":
                current_value = stamina_rating
                remaining_points = physical_points_remaining
            "Charisma":
                current_value = charisma_rating
                remaining_points = social_points_remaining
            "Manipulation":
                current_value = manipulation_rating
                remaining_points = social_points_remaining
            "Appearance":
                current_value = appearance_rating
                remaining_points = social_points_remaining
            "Perception":
                current_value = perception_rating
                remaining_points = mental_points_remaining
            "Intelligence":
                current_value = intelligence_rating
                remaining_points = mental_points_remaining
            "Wits":
                current_value = wits_rating
                remaining_points = mental_points_remaining

        var added_cost: = new_value - current_value
        if added_cost > 0 and added_cost > remaining_points:
            match stat:
                "Strength": initialize_dots(StrengthDots, strength_rating)
                "Dexterity": initialize_dots(DexterityDots, dexterity_rating)
                "Stamina": initialize_dots(StaminaDots, stamina_rating)
                "Charisma": initialize_dots(CharismaDots, charisma_rating)
                "Manipulation": initialize_dots(ManipulationDots, manipulation_rating)
                "Appearance": initialize_dots(AppearanceDots, appearance_rating)
                "Perception": initialize_dots(PerceptionDots, perception_rating)
                "Intelligence": initialize_dots(IntelligenceDots, intelligence_rating)
                "Wits": initialize_dots(WitsDots, wits_rating)
            return

        set_attribute_value(stat, new_value)



func initialize_dots(dot_array: Array, active: int):
    for i in range(dot_array.size()):
        dot_array[i].toggle_mode = true
        dot_array[i].button_pressed = i < active

func update_physical_counter():
    PhysicalCounterNumber.text = str(physical_points_remaining)

func update_social_counter():
    SocialCounterNumber.text = str(social_points_remaining)

func update_mental_counter():
    MentalCounterNumber.text = str(mental_points_remaining)

func set_attribute_value(stat: String, new_value: int):
    var old_value: int
    var dots: Array
    var point_pool: String = ""

    match stat:
        "Strength":
            old_value = strength_rating
            dots = StrengthDots
            point_pool = "physical"
        "Dexterity":
            old_value = dexterity_rating
            dots = DexterityDots
            point_pool = "physical"
        "Stamina":
            old_value = stamina_rating
            dots = StaminaDots
            point_pool = "physical"
        "Charisma":
            old_value = charisma_rating
            dots = CharismaDots
            point_pool = "social"
        "Manipulation":
            old_value = manipulation_rating
            dots = ManipulationDots
            point_pool = "social"
        "Appearance":
            old_value = appearance_rating
            dots = AppearanceDots
            point_pool = "social"
        "Perception":
            old_value = perception_rating
            dots = PerceptionDots
            point_pool = "mental"
        "Intelligence":
            old_value = intelligence_rating
            dots = IntelligenceDots
            point_pool = "mental"
        "Wits":
            old_value = wits_rating
            dots = WitsDots
            point_pool = "mental"


    var new_cost = max(0, new_value - 1)
    var old_cost = max(0, old_value - 1)
    var difference = new_cost - old_cost

    if point_pool == "physical":
        physical_points_remaining -= difference
    elif point_pool == "social":
        social_points_remaining -= difference
    elif point_pool == "mental":
        mental_points_remaining -= difference

    match stat:
        "Strength": strength_rating = new_value
        "Dexterity": dexterity_rating = new_value
        "Stamina": stamina_rating = new_value
        "Charisma": charisma_rating = new_value
        "Manipulation": manipulation_rating = new_value
        "Appearance": appearance_rating = new_value
        "Perception": perception_rating = new_value
        "Intelligence": intelligence_rating = new_value
        "Wits": wits_rating = new_value


    if point_pool == "physical":
        update_physical_counter()
    elif point_pool == "social":
        update_social_counter()
    elif point_pool == "mental":
        update_mental_counter()


    for i in range(dots.size()):
        dots[i].button_pressed = i < new_value


func reset_all_physical():
    strength_rating = 1
    dexterity_rating = 1
    stamina_rating = 1
    initialize_dots(StrengthDots, 1)
    initialize_dots(DexterityDots, 1)
    initialize_dots(StaminaDots, 1)
    update_attribute_counters()
    update_physical_counter()


func initialize_ability_order_buttons():
    PrimaryAbilityButton.clear()
    for cat in ability_categories:
        PrimaryAbilityButton.add_item(cat)
    PrimaryAbilityButton.selected = -1

    SecondaryAbilityButton.clear()
    TertiaryAbilityButton.clear()

func _on_primary_ability_button_item_selected(index: int):
    var selected_primary = PrimaryAbilityButton.get_item_text(index)
    SecondaryAbilityButton.clear()
    for cat in ability_categories:
        if cat != selected_primary:
            SecondaryAbilityButton.add_item(cat)
    SecondaryAbilityButton.selected = -1
    TertiaryAbilityButton.clear()
    reset_all_abilities()
    update_ability_counters()

func _on_secondary_ability_button_item_selected(index: int):
    if PrimaryAbilityButton.selected == -1:
        return

    var selected_primary = PrimaryAbilityButton.get_item_text(PrimaryAbilityButton.selected)
    var selected_secondary = SecondaryAbilityButton.get_item_text(index)

    TertiaryAbilityButton.clear()
    for cat in ability_categories:
        if cat != selected_primary and cat != selected_secondary:
            TertiaryAbilityButton.add_item(cat)

    TertiaryAbilityButton.selected = -1
    reset_all_abilities()
    update_ability_counters()


func _on_tertiary_ability_button_item_selected(_index: int):
    reset_all_abilities()
    update_ability_counters()

func update_ability_counters():
    TalentCounterNumber.text = "0"
    SkillCounterNumber.text = "0"
    KnowledgeCounterNumber.text = "0"

    var primary = ""
    var secondary = ""
    var tertiary = ""

    if PrimaryAbilityButton.selected >= 0:
        primary = PrimaryAbilityButton.get_item_text(PrimaryAbilityButton.selected)
    if SecondaryAbilityButton.selected >= 0:
        secondary = SecondaryAbilityButton.get_item_text(SecondaryAbilityButton.selected)
    if TertiaryAbilityButton.selected >= 0:
        tertiary = TertiaryAbilityButton.get_item_text(TertiaryAbilityButton.selected)

    var talent_total: = 0
    if primary == "Talents": talent_total += 13
    if secondary == "Talents": talent_total += 9
    if tertiary == "Talents": talent_total += 5
    talent_points_max = talent_total
    talent_points_remaining = talent_total
    TalentCounterNumber.text = str(talent_points_remaining)

    var skill_total: = 0
    if primary == "Skills": skill_total += 13
    if secondary == "Skills": skill_total += 9
    if tertiary == "Skills": skill_total += 5
    skill_points_max = skill_total
    skill_points_remaining = skill_total
    SkillCounterNumber.text = str(skill_points_remaining)

    var knowledge_total: = 0
    if primary == "Knowledges": knowledge_total += 13
    if secondary == "Knowledges": knowledge_total += 9
    if tertiary == "Knowledges": knowledge_total += 5
    knowledge_points_max = knowledge_total
    knowledge_points_remaining = knowledge_total
    KnowledgeCounterNumber.text = str(knowledge_points_remaining)

func _make_ability_dot_handler(stat: String, index: int) -> Callable:
    return func():
        var current_value: = 1
        var remaining_points: = 0
        var dots: Array

        match stat:

            "Alertness": current_value = alertness_rating;remaining_points = talent_points_remaining;dots = AlertnessDots
            "Athletics": current_value = athletics_rating;remaining_points = talent_points_remaining;dots = AthleticsDots
            "Awareness": current_value = awareness_rating;remaining_points = talent_points_remaining;dots = AwarenessDots
            "Brawl": current_value = brawl_rating;remaining_points = talent_points_remaining;dots = BrawlDots
            "Empathy": current_value = empathy_rating;remaining_points = talent_points_remaining;dots = EmpathyDots
            "Expression": current_value = expression_rating;remaining_points = talent_points_remaining;dots = ExpressionDots
            "Intimidation": current_value = intimidation_rating;remaining_points = talent_points_remaining;dots = IntimidationDots
            "Leadership": current_value = leadership_rating;remaining_points = talent_points_remaining;dots = LeadershipDots
            "Streetwise": current_value = streetwise_rating;remaining_points = talent_points_remaining;dots = StreetwiseDots
            "Subterfuge": current_value = subterfuge_rating;remaining_points = talent_points_remaining;dots = SubterfugeDots


            "AnimalKen": current_value = animalken_rating;remaining_points = skill_points_remaining;dots = AnimalKenDots
            "Crafts": current_value = crafts_rating;remaining_points = skill_points_remaining;dots = CraftsDots
            "Drive": current_value = drive_rating;remaining_points = skill_points_remaining;dots = DriveDots
            "Etiquette": current_value = etiquette_rating;remaining_points = skill_points_remaining;dots = EtiquetteDots
            "Firearms": current_value = firearms_rating;remaining_points = skill_points_remaining;dots = FirearmsDots
            "Larceny": current_value = larceny_rating;remaining_points = skill_points_remaining;dots = LarcenyDots
            "Melee": current_value = melee_rating;remaining_points = skill_points_remaining;dots = MeleeDots
            "Performance": current_value = performance_rating;remaining_points = skill_points_remaining;dots = PerformanceDots
            "Stealth": current_value = stealth_rating;remaining_points = skill_points_remaining;dots = StealthDots
            "Survival": current_value = survival_rating;remaining_points = skill_points_remaining;dots = SurvivalDots


            "Academics": current_value = academics_rating;remaining_points = knowledge_points_remaining;dots = AcademicsDots
            "Computer": current_value = computer_rating;remaining_points = knowledge_points_remaining;dots = ComputerDots
            "Finance": current_value = finance_rating;remaining_points = knowledge_points_remaining;dots = FinanceDots
            "Investigation": current_value = investigation_rating;remaining_points = knowledge_points_remaining;dots = InvestigationDots
            "Law": current_value = law_rating;remaining_points = knowledge_points_remaining;dots = LawDots
            "Medicine": current_value = medicine_rating;remaining_points = knowledge_points_remaining;dots = MedicineDots
            "Occult": current_value = occult_rating;remaining_points = knowledge_points_remaining;dots = OccultDots
            "Politics": current_value = politics_rating;remaining_points = knowledge_points_remaining;dots = PoliticsDots
            "Science": current_value = science_rating;remaining_points = knowledge_points_remaining;dots = ScienceDots
            "Technology": current_value = technology_rating;remaining_points = knowledge_points_remaining;dots = TechnologyDots

        if talent_points_max == 0 and skill_points_max == 0 and knowledge_points_max == 0:
            dots[index].button_pressed = false
            return

        var new_value: = index + 1

        if current_value == 1 and index == 0:
            set_ability_value(stat, 0)
            return

        if new_value > 3:
            dots[index].button_pressed = false
            return

        var added_cost: = new_value - current_value
        if added_cost > 0 and added_cost > remaining_points:
            dots[index].button_pressed = false
            return

        set_ability_value(stat, new_value)






func reset_all_abilities():

    alertness_rating = 0
    athletics_rating = 0
    awareness_rating = 0
    brawl_rating = 0
    empathy_rating = 0
    expression_rating = 0
    intimidation_rating = 0
    leadership_rating = 0
    streetwise_rating = 0
    subterfuge_rating = 0
    initialize_dots(AlertnessDots, 0)
    initialize_dots(AthleticsDots, 0)
    initialize_dots(AwarenessDots, 0)
    initialize_dots(BrawlDots, 0)
    initialize_dots(EmpathyDots, 0)
    initialize_dots(ExpressionDots, 0)
    initialize_dots(IntimidationDots, 0)
    initialize_dots(LeadershipDots, 0)
    initialize_dots(StreetwiseDots, 0)
    initialize_dots(SubterfugeDots, 0)


    animalken_rating = 0
    crafts_rating = 0
    drive_rating = 0
    etiquette_rating = 0
    firearms_rating = 0
    larceny_rating = 0
    melee_rating = 0
    performance_rating = 0
    stealth_rating = 0
    survival_rating = 0
    initialize_dots(AnimalKenDots, 0)
    initialize_dots(CraftsDots, 0)
    initialize_dots(DriveDots, 0)
    initialize_dots(EtiquetteDots, 0)
    initialize_dots(FirearmsDots, 0)
    initialize_dots(LarcenyDots, 0)
    initialize_dots(MeleeDots, 0)
    initialize_dots(PerformanceDots, 0)
    initialize_dots(StealthDots, 0)
    initialize_dots(SurvivalDots, 0)


    academics_rating = 0
    computer_rating = 0
    finance_rating = 0
    investigation_rating = 0
    law_rating = 0
    medicine_rating = 0
    occult_rating = 0
    politics_rating = 0
    science_rating = 0
    technology_rating = 0
    initialize_dots(AcademicsDots, 0)
    initialize_dots(ComputerDots, 0)
    initialize_dots(FinanceDots, 0)
    initialize_dots(InvestigationDots, 0)
    initialize_dots(LawDots, 0)
    initialize_dots(MedicineDots, 0)
    initialize_dots(OccultDots, 0)
    initialize_dots(PoliticsDots, 0)
    initialize_dots(ScienceDots, 0)
    initialize_dots(TechnologyDots, 0)

    update_ability_counters()


func set_ability_value(stat: String, new_value: int):
    var old_value: int
    var dots: Array
    var point_pool: String = ""

    match stat:

        "Alertness":
            old_value = alertness_rating
            dots = AlertnessDots
            point_pool = "talent"
        "Athletics":
            old_value = athletics_rating
            dots = AthleticsDots
            point_pool = "talent"
        "Awareness":
            old_value = awareness_rating
            dots = AwarenessDots
            point_pool = "talent"
        "Brawl":
            old_value = brawl_rating
            dots = BrawlDots
            point_pool = "talent"
        "Empathy":
            old_value = empathy_rating
            dots = EmpathyDots
            point_pool = "talent"
        "Expression":
            old_value = expression_rating
            dots = ExpressionDots
            point_pool = "talent"
        "Intimidation":
            old_value = intimidation_rating
            dots = IntimidationDots
            point_pool = "talent"
        "Leadership":
            old_value = leadership_rating
            dots = LeadershipDots
            point_pool = "talent"
        "Streetwise":
            old_value = streetwise_rating
            dots = StreetwiseDots
            point_pool = "talent"
        "Subterfuge":
            old_value = subterfuge_rating
            dots = SubterfugeDots
            point_pool = "talent"


        "AnimalKen":
            old_value = animalken_rating
            dots = AnimalKenDots
            point_pool = "skill"
        "Crafts":
            old_value = crafts_rating
            dots = CraftsDots
            point_pool = "skill"
        "Drive":
            old_value = drive_rating
            dots = DriveDots
            point_pool = "skill"
        "Etiquette":
            old_value = etiquette_rating
            dots = EtiquetteDots
            point_pool = "skill"
        "Firearms":
            old_value = firearms_rating
            dots = FirearmsDots
            point_pool = "skill"
        "Larceny":
            old_value = larceny_rating
            dots = LarcenyDots
            point_pool = "skill"
        "Melee":
            old_value = melee_rating
            dots = MeleeDots
            point_pool = "skill"
        "Performance":
            old_value = performance_rating
            dots = PerformanceDots
            point_pool = "skill"
        "Stealth":
            old_value = stealth_rating
            dots = StealthDots
            point_pool = "skill"
        "Survival":
            old_value = survival_rating
            dots = SurvivalDots
            point_pool = "skill"


        "Academics":
            old_value = academics_rating
            dots = AcademicsDots
            point_pool = "knowledge"
        "Computer":
            old_value = computer_rating
            dots = ComputerDots
            point_pool = "knowledge"
        "Finance":
            old_value = finance_rating
            dots = FinanceDots
            point_pool = "knowledge"
        "Investigation":
            old_value = investigation_rating
            dots = InvestigationDots
            point_pool = "knowledge"
        "Law":
            old_value = law_rating
            dots = LawDots
            point_pool = "knowledge"
        "Medicine":
            old_value = medicine_rating
            dots = MedicineDots
            point_pool = "knowledge"
        "Occult":
            old_value = occult_rating
            dots = OccultDots
            point_pool = "knowledge"
        "Politics":
            old_value = politics_rating
            dots = PoliticsDots
            point_pool = "knowledge"
        "Science":
            old_value = science_rating
            dots = ScienceDots
            point_pool = "knowledge"
        "Technology":
            old_value = technology_rating
            dots = TechnologyDots
            point_pool = "knowledge"

    var new_cost = max(0, new_value)
    var old_cost = max(0, old_value)
    var difference = new_cost - old_cost

    if point_pool == "talent":
        talent_points_remaining -= difference
    elif point_pool == "skill":
        skill_points_remaining -= difference
    elif point_pool == "knowledge":
        knowledge_points_remaining -= difference


    match stat:
        "Alertness": alertness_rating = new_value
        "Athletics": athletics_rating = new_value
        "Awareness": awareness_rating = new_value
        "Brawl": brawl_rating = new_value
        "Empathy": empathy_rating = new_value
        "Expression": expression_rating = new_value
        "Intimidation": intimidation_rating = new_value
        "Leadership": leadership_rating = new_value
        "Streetwise": streetwise_rating = new_value
        "Subterfuge": subterfuge_rating = new_value

        "AnimalKen": animalken_rating = new_value
        "Crafts": crafts_rating = new_value
        "Drive": drive_rating = new_value
        "Etiquette": etiquette_rating = new_value
        "Firearms": firearms_rating = new_value
        "Larceny": larceny_rating = new_value
        "Melee": melee_rating = new_value
        "Performance": performance_rating = new_value
        "Stealth": stealth_rating = new_value
        "Survival": survival_rating = new_value

        "Academics": academics_rating = new_value
        "Computer": computer_rating = new_value
        "Finance": finance_rating = new_value
        "Investigation": investigation_rating = new_value
        "Law": law_rating = new_value
        "Medicine": medicine_rating = new_value
        "Occult": occult_rating = new_value
        "Politics": politics_rating = new_value
        "Science": science_rating = new_value
        "Technology": technology_rating = new_value


    TalentCounterNumber.text = str(talent_points_remaining)
    SkillCounterNumber.text = str(skill_points_remaining)
    KnowledgeCounterNumber.text = str(knowledge_points_remaining)

    for i in range(dots.size()):
        dots[i].button_pressed = i < new_value

func _make_discipline_dot_handler(index: int, discipline_index: int) -> Callable:
    return func():
        var current_value: = 0
        var dot_array: Array

        match discipline_index:
            1:
                if Discipline1Label.text == "":
                    Discipline1Dots[index].button_pressed = false
                    return
                current_value = discipline1_rating
                dot_array = Discipline1Dots
            2:
                if Discipline2Label.text == "":
                    Discipline2Dots[index].button_pressed = false
                    return
                current_value = discipline2_rating
                dot_array = Discipline2Dots
            3:
                if Discipline3Label.text == "":
                    Discipline3Dots[index].button_pressed = false
                    return
                current_value = discipline3_rating
                dot_array = Discipline3Dots

        var new_value: = index + 1

        if current_value == 1 and index == 0:
            new_value = 0

        if new_value > 3:
            dot_array[index].button_pressed = false
            return

        var difference = new_value - current_value

        if difference > discipline_points_remaining:
            dot_array[index].button_pressed = current_value > index
            return

        match discipline_index:
            1: discipline1_rating = new_value
            2: discipline2_rating = new_value
            3: discipline3_rating = new_value

        discipline_points_remaining -= difference
        DisciplineNumberLabel.text = str(discipline_points_remaining)

        for i in range(dot_array.size()):
            dot_array[i].button_pressed = i < new_value



var background_points_max: = 5
var background_points_remaining: = 5


func _make_background_dot_handler(stat: String, index: int) -> Callable:
    return func():
        var dot_array: Array
        var current_rating: = 0
        var rating_variable: = stat.to_lower() + "_rating"

        match stat:
            "Allies": dot_array = AlliesDots
            "Contacts": dot_array = ContactsDots
            "Domain": dot_array = DomainDots
            "Fame": dot_array = FameDots
            "Generation": dot_array = GenerationDots
            "Haven": dot_array = HavenDots
            "Herd": dot_array = HerdDots
            "Influence": dot_array = InfluenceDots
            "Mentor": dot_array = MentorDots
            "Resources": dot_array = ResourcesDots
            "Retainers": dot_array = RetainersDots
            "Rituals": dot_array = RitualsDots
            "Status": dot_array = StatusDots
            _: return


        if rating_variable in self:
            current_rating = self.get(rating_variable)

        var new_value: = index + 1


        if new_value == current_rating:
            new_value = index

        var difference = new_value - current_rating


        if difference > 0 and difference > background_points_remaining:

            for i in range(dot_array.size()):
                dot_array[i].button_pressed = i < current_rating
            return


        background_points_remaining -= difference
        self.set(rating_variable, new_value)
        BackgroundCounterNumber.text = str(background_points_remaining)


        for i in range(dot_array.size()):
            dot_array[i].button_pressed = i < new_value

func _make_virtue_dot_handler(virtue: String, index: int) -> Callable:
    return func():
        var dots: Array
        var current_value: int = 1
        match virtue:
            "Conscience":
                dots = ConscienceDots
                current_value = conscience_rating
            "SelfControl":
                dots = SelfControlDots
                current_value = selfcontrol_rating
            "Courage":
                dots = CourageDots
                current_value = courage_rating
            _: return

        var new_value = index + 1


        if index == 0 and current_value == 1:
            dots[0].button_pressed = true
            return

        if new_value == current_value:
            new_value -= 1

        var difference = new_value - current_value

        if difference > virtue_points_remaining:
            for i in range(dots.size()):
                dots[i].button_pressed = i < current_value
            return

        virtue_points_remaining -= difference

        match virtue:
            "Conscience": conscience_rating = new_value
            "SelfControl": selfcontrol_rating = new_value
            "Courage": courage_rating = new_value

        VirtueCounterNumber.text = str(virtue_points_remaining)

        for i in range(dots.size()):
            dots[i].button_pressed = i < new_value

var virtue_conscience: = true
var virtue_self_control: = true
var virtue_conviction: = false
var virtue_instinct: = false


func _on_path_button_item_selected(index: int) -> void :
    var selected_path = PathButton.get_item_text(index)

    if not path_virtue_map.has(selected_path):
        return

    var virtues = path_virtue_map[selected_path]


    virtue_conscience = false
    virtue_self_control = false
    virtue_conviction = false
    virtue_instinct = false


    for virtue in virtues:
        match virtue:
            "Conscience":
                ConscienceLabel.text = "Conscience"
                virtue_conscience = true
            "Conviction":
                ConscienceLabel.text = "Conviction"
                virtue_conviction = true
            "Self-Control":
                SelfControlLabel.text = "Self-Control"
                virtue_self_control = true
            "Instinct":
                SelfControlLabel.text = "Instinct"
                virtue_instinct = true


    conscience_rating = 1
    selfcontrol_rating = 1
    courage_rating = 1


    var free_dots = 0
    if virtue_conscience:
        free_dots += 1
    if virtue_self_control:
        free_dots += 1

    virtue_points_remaining = 7 - (2 - free_dots)
    VirtueCounterNumber.text = str(virtue_points_remaining)


    initialize_dots(ConscienceDots, 1)
    initialize_dots(SelfControlDots, 1)
    initialize_dots(CourageDots, 1)


func _on_next_button_pressed():
    var entered_name: String = NameEdit.text.strip_edges()
    print("[DEBUG] Next button pressed. Entered name:", entered_name)

    if entered_name == "":
        warning_popup.show_warning("You must enter a name before continuing.")
        return

    print("[DEBUG] Requesting name check from server")
    NetworkManager.request_name_check(entered_name)

func _continue_character_creation_step_2():
    print("[DEBUG] Continuing character creation step 2")
    if SectEdit.text.strip_edges() == "":
        warning_popup.show_warning("You must select a Sect before continuing.")
        return

    if ClanEdit.text.strip_edges() == "":
        warning_popup.show_warning("You must select a Clan before continuing.")
        return

    if NatureEdit.text.strip_edges() == "":
        warning_popup.show_warning("You must select a Nature before continuing.")
        return

    if DemeanorEdit.text.strip_edges() == "":
        warning_popup.show_warning("You must select a Demeanor before continuing.")
        return

    if PrimaryButton.text.strip_edges() == "":
        warning_popup.show_warning("Your attributes are faulty.")
        return

    if SecondaryButton.text.strip_edges() == "":
        warning_popup.show_warning("Your attributes are faulty.")
        return

    if TertiaryButton.text.strip_edges() == "":
        warning_popup.show_warning("Your attributes are faulty.")
        return

    if int(PhysicalCounterNumber.text) != 0 or int(SocialCounterNumber.text) != 0 or int(MentalCounterNumber.text) != 0:
        warning_popup.show_warning("You still have attribute points to distribute.")
        return

    if PrimaryAbilityButton.text.strip_edges() == ""\
or SecondaryAbilityButton.text.strip_edges() == ""\
or TertiaryAbilityButton.text.strip_edges() == "":
        warning_popup.show_warning("Your abilities are faulty.")
        return

    if int(TalentCounterNumber.text) != 0 or int(SkillCounterNumber.text) != 0 or int(KnowledgeCounterNumber.text) != 0:
        warning_popup.show_warning("You still have ability points to distribute.")
        return

    if int(BackgroundCounterNumber.text) != 0:
        warning_popup.show_warning("You still have background points to distribute.")
        return

    if int(DisciplineNumberLabel.text) != 0:
        warning_popup.show_warning("You still have disciplines to increase!")
        return

    if int(VirtueCounterNumber.text) != 0:
        warning_popup.show_warning("You still have virtue points to distribute.")
        return




    PlayerData.character_name = NameEdit.text
    PlayerData.sect = SectEdit.get_item_text(SectEdit.selected)
    PlayerData.clan = ClanEdit.get_item_text(ClanEdit.selected)
    PlayerData.nature = NatureEdit.text
    PlayerData.demeanor = DemeanorEdit.text
    PlayerData.path = PathButton.get_item_text(PathButton.selected)
    PlayerData.path_name = PathButton.get_item_text(PathButton.selected)


    PlayerData.strength = strength_rating
    PlayerData.dexterity = dexterity_rating
    PlayerData.stamina = stamina_rating
    PlayerData.charisma = charisma_rating
    PlayerData.manipulation = manipulation_rating
    PlayerData.appearance = appearance_rating
    PlayerData.perception = perception_rating
    PlayerData.intelligence = intelligence_rating
    PlayerData.wits = wits_rating


    PlayerData.alertness = alertness_rating
    PlayerData.athletics = athletics_rating
    PlayerData.awareness = awareness_rating
    PlayerData.brawl = brawl_rating
    PlayerData.empathy = empathy_rating
    PlayerData.expression = expression_rating
    PlayerData.intimidation = intimidation_rating
    PlayerData.leadership = leadership_rating
    PlayerData.streetwise = streetwise_rating
    PlayerData.subterfuge = subterfuge_rating


    PlayerData.animal_ken = animalken_rating
    PlayerData.crafts = crafts_rating
    PlayerData.drive = drive_rating
    PlayerData.etiquette = etiquette_rating
    PlayerData.firearms = firearms_rating
    PlayerData.larceny = larceny_rating
    PlayerData.melee = melee_rating
    PlayerData.performance = performance_rating
    PlayerData.stealth = stealth_rating
    PlayerData.survival = survival_rating


    PlayerData.academics = academics_rating
    PlayerData.computer = computer_rating
    PlayerData.finance = finance_rating
    PlayerData.investigation = investigation_rating
    PlayerData.law = law_rating
    PlayerData.medicine = medicine_rating
    PlayerData.occult = occult_rating
    PlayerData.politics = politics_rating
    PlayerData.science = science_rating
    PlayerData.technology = technology_rating


    PlayerData.discipline_1 = discipline1_rating
    PlayerData.discipline_2 = discipline2_rating
    PlayerData.discipline_3 = discipline3_rating
    PlayerData.discipline_1_name = Discipline1Label.text
    PlayerData.discipline_2_name = Discipline2Label.text
    PlayerData.discipline_3_name = Discipline3Label.text


    PlayerData.conscience = conscience_rating
    PlayerData.self_control = selfcontrol_rating
    PlayerData.courage = courage_rating


    PlayerData.uses_conscience = virtue_conscience
    PlayerData.uses_self_control = virtue_self_control
    PlayerData.uses_conviction = virtue_conviction
    PlayerData.uses_instinct = virtue_instinct


    PlayerData.allies = allies_rating
    PlayerData.contacts = contacts_rating
    PlayerData.domain = domain_rating
    PlayerData.fame = fame_rating
    PlayerData.generation = generation_rating
    PlayerData.haven = haven_rating
    PlayerData.herd = herd_rating
    PlayerData.influence = influence_rating
    PlayerData.mentor = mentor_rating
    PlayerData.resources = resources_rating
    PlayerData.retainers = retainers_rating
    PlayerData.rituals = rituals_rating
    PlayerData.status = status_rating


    get_tree().change_scene_to_file("res://scene/FreebieUI.tscn")

func populate_ui_from_player_data():

    NameEdit.text = PlayerData.character_name

    var sect_index = get_index_by_text(SectEdit, PlayerData.sect)
    if sect_index != -1:
        SectEdit.select(sect_index)
        _on_sect_edit_item_selected(sect_index)

    var clan_index = get_index_by_text(ClanEdit, PlayerData.clan)
    if clan_index != -1:
        ClanEdit.select(clan_index)
        _on_clan_edit_item_selected(clan_index)

    var nature_index = get_index_by_text(NatureEdit, PlayerData.nature)
    if nature_index != -1:
        NatureEdit.select(nature_index)

    var demeanor_index = get_index_by_text(DemeanorEdit, PlayerData.demeanor)
    if demeanor_index != -1:
        DemeanorEdit.select(demeanor_index)

    var path_index = get_index_by_text(PathButton, PlayerData.path)
    if path_index != -1:
        PathButton.select(path_index)
        _on_path_button_item_selected(path_index)


    conscience_rating = PlayerData.conscience
    selfcontrol_rating = PlayerData.self_control
    courage_rating = PlayerData.courage
    initialize_dots(ConscienceDots, conscience_rating)
    initialize_dots(SelfControlDots, selfcontrol_rating)
    initialize_dots(CourageDots, courage_rating)


    strength_rating = PlayerData.strength
    dexterity_rating = PlayerData.dexterity
    stamina_rating = PlayerData.stamina
    charisma_rating = PlayerData.charisma
    manipulation_rating = PlayerData.manipulation
    appearance_rating = PlayerData.appearance
    perception_rating = PlayerData.perception
    intelligence_rating = PlayerData.intelligence
    wits_rating = PlayerData.wits

    initialize_dots(StrengthDots, strength_rating)
    initialize_dots(DexterityDots, dexterity_rating)
    initialize_dots(StaminaDots, stamina_rating)
    initialize_dots(CharismaDots, charisma_rating)
    initialize_dots(ManipulationDots, manipulation_rating)
    initialize_dots(AppearanceDots, appearance_rating)
    initialize_dots(PerceptionDots, perception_rating)
    initialize_dots(IntelligenceDots, intelligence_rating)
    initialize_dots(WitsDots, wits_rating)


    discipline1_rating = PlayerData.discipline_1
    discipline2_rating = PlayerData.discipline_2
    discipline3_rating = PlayerData.discipline_3
    Discipline1Label.text = PlayerData.discipline_1_name
    Discipline2Label.text = PlayerData.discipline_2_name
    Discipline3Label.text = PlayerData.discipline_3_name
    initialize_dots(Discipline1Dots, discipline1_rating)
    initialize_dots(Discipline2Dots, discipline2_rating)
    initialize_dots(Discipline3Dots, discipline3_rating)


    for background in [
        "allies", "contacts", "domain", "fame", "generation", "haven", "herd", 
        "influence", "mentor", "resources", "retainers", "rituals", "status"
    ]:
        var rating = PlayerData.get(background)
        self.set(background + "_rating", rating)
        var dots = self.get(background.capitalize() + "Dots")
        initialize_dots(dots, rating)


func _on_name_check_result_received(name_taken: bool) -> void :
    print("[DEBUG] _on_name_check_result_received called. Name taken:", name_taken)
    if name_taken:
        warning_popup.show_warning("A character with this name already exists. Please choose another.")
    else:
        _continue_character_creation_step_2()



var _is_web: = false
var _is_mobile_web: = false
var _vk_available: = false

func _init_cellphone_support():
    _is_web = OS.has_feature("web")
    _vk_available = DisplayServer.has_feature(DisplayServer.FEATURE_VIRTUAL_KEYBOARD)

    if _is_web and Engine.has_singleton("JavaScriptBridge"):
        _is_mobile_web = JavaScriptBridge.eval("\n\t\t\t(() => /Android|iPhone|iPad|iPod|Opera Mini|IEMobile|Mobile/i.test(navigator.userAgent))()\n\t\t"\
\
)

    if _is_web and _is_mobile_web and _vk_available:
        _setup_virtual_keyboard_hooks(self)

func _setup_virtual_keyboard_hooks(root: Node) -> void :
    for child in root.get_children():
        if child is LineEdit or child is TextEdit:
            _connect_vk_for_control(child)
        if child.get_child_count() > 0:
            _setup_virtual_keyboard_hooks(child)

func _connect_vk_for_control(ctrl: Control) -> void :
    if "virtual_keyboard_enabled" in ctrl:
        ctrl.virtual_keyboard_enabled = true

    if not ctrl.is_connected("focus_entered", Callable(self, "_on_vk_focus_entered")):
        ctrl.focus_entered.connect(_on_vk_focus_entered.bind(ctrl))
    if not ctrl.is_connected("focus_exited", Callable(self, "_on_vk_focus_exited")):
        ctrl.focus_exited.connect(_on_vk_focus_exited.bind(ctrl))

func _on_vk_focus_entered(ctrl: Control) -> void :
    if not (_is_web and _is_mobile_web and _vk_available):
        return
    var txt: = ""
    if ctrl is LineEdit:
        txt = ctrl.text
    elif ctrl is TextEdit:
        txt = ctrl.text
    var rect: = ctrl.get_global_rect()
    DisplayServer.virtual_keyboard_show(txt, rect)

func _on_vk_focus_exited(_ctrl: Control) -> void :
    if not (_is_web and _is_mobile_web and _vk_available):
        return
    DisplayServer.virtual_keyboard_hide()
