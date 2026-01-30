extends Node

const COLOR_DEFAULT = Color(1, 1, 1)
const COLOR_MODIFIED = Color(0.2, 1, 0.2)



var generation_dots: = 0
var min_generation_dots: = 0


@onready var character_creation_selector = $Charactercreationselection
var pending_character: CharacterData = null



@onready var GenerationNumberLabel = $Background / GenerationPanel / GenerationContainer / GenerationNumber




@onready var StrengthNumber = $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StrengthPanel / StrengthNumber
@onready var DexterityNumber = $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / DexterityPanel / DexterityNumber
@onready var StaminaNumber = $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StaminaPanel / StaminaNumber


@onready var CharismaNumber = $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / CharismaPanel / CharismaNumber
@onready var ManipulationNumber = $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / ManipulationPanel / ManipulationNumber
@onready var AppearanceNumber = $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / AppearancePanel / AppearanceNumber


@onready var PerceptionNumber = $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / PerceptionPanel / PerceptionNumber
@onready var IntelligenceNumber = $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / IntelligencePanel / IntelligenceNumber
@onready var WitsNumber = $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / WitsPanel / WitsNumber


@onready var AlertnessNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AlertnessContainer / AlertnessPanel / AlertnessNumber
@onready var AthleticsNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AthleticsContainer / AthleticsPanel / AthleticsNumber
@onready var AwarenessNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AwarenessContainer / AwarenessPanel / AwarenessNumber
@onready var BrawlNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / BrawlContainer / BrawlPanel / BrawlNumber
@onready var EmpathyNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / EmpathyContainer / EmpathyPanel / EmpathyNumber
@onready var ExpressionNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / ExpressionContainer / ExpressionPanel / ExpressionNumber
@onready var IntimidationNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / IntimidationContainer / IntimidationPanel / IntimidationNumber
@onready var LeadershipNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / LeadershipContainer / LeadershipsPanel / LeadershipNumber
@onready var StreetwiseNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / StreetwiseContainer / StreetwisePanel / StreetwiseNumber
@onready var SubterfugeNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / SubterfugeContainer / SubterfugePanel / SubterfugeNumber


@onready var AnimalKenNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / AnimalKenContainer / AnimalKenPanel / AnimalKenNumber
@onready var CraftsNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / CraftContainer / CraftPanel / CraftNumber
@onready var DriveNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / DriveContainer / DrivePanel / DriveNumber
@onready var EtiquetteNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / EtiquetteContainer / EtiquettePanel / EtiquetteNumber
@onready var FirearmsNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / FirearmsContainer / FirearmsPanel / FirearmsNumber
@onready var LarcenyNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / LarcenyContainer / LarcenylPanel / LarcenyNumber
@onready var MeleeNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / MeleeContainer / MeleePanel / MeleeNumber
@onready var PerformanceNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / PerformanceContainer / PerformancePanel / PerformanceNumber
@onready var StealthNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / StealthContainer / StealthPanel / StealthNumber
@onready var SurvivalNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / SurvivalContainer / SurvivalPanel / SurvivalNumber


@onready var AcademicsNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / AcademicsContainer / AcademicsPanel / AcademicsNumber
@onready var ComputerNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / ComputerContainer / ComputerlPanel / ComputerNumber
@onready var FinanceNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / FinanceContainer / FinancePanel / FinanceNumber
@onready var InvestigationNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / InvestigationContainer / InvestigationPanel / InvestigationNumber
@onready var LawNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / LawContainer / LawPanel / LawNumber
@onready var MedicineNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / MedicineContainer / MedicinePanel / MedicineNumber
@onready var OccultNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / OccultContainer / OccultPanel / OccultNumber
@onready var PoliticsNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / PoliticsContainer / PoliticsPanel / PoliticsNumber
@onready var ScienceNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / ScienceContainer / SciencePanel / ScienceNumber
@onready var TechnologyNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / TechnologyContainer / TechnologyPanel / TechnologyNumber

@onready var Discipline1Label = $Background / DisciplinePanel / DisciplineContainer / Discipline1 / Discipline1
@onready var Discipline1Number = $Background / DisciplinePanel / DisciplineContainer / Discipline1 / Discipline1NumberPanel / Discipline1Number

@onready var Discipline2Label = $Background / DisciplinePanel / DisciplineContainer / Discipline2 / Discipline2
@onready var Discipline2Number = $Background / DisciplinePanel / DisciplineContainer / Discipline2 / Discipline2NumberPanel / Discipline2Number

@onready var Discipline3Label = $Background / DisciplinePanel / DisciplineContainer / Discipline3 / Discipline3
@onready var Discipline3Number = $Background / DisciplinePanel / DisciplineContainer / Discipline3 / Discipline3NumberPanel / Discipline3Number

@onready var ConscienceLabel = $Background / VirtuePanel / VirtueContainer / Conscience / Conscience
@onready var ConscienceNumber = $Background / VirtuePanel / VirtueContainer / Conscience / ConscienceNumberPanel / ConscienceNumber

@onready var SelfControlLabel = $Background / VirtuePanel / VirtueContainer / SelfControl / SelfControl
@onready var SelfControlNumber = $Background / VirtuePanel / VirtueContainer / SelfControl / SelfControlNumberPanel / SelfControlNumber

@onready var CourageNumber = $Background / VirtuePanel / VirtueContainer / Courage / CourageNumberPanel / CourageNumber

@onready var AlliesNumber = $Background / BackgroundPanel / BackgroundListing / AlliesContainer / AlliesPanel / AlliesNumber
@onready var ContactsNumber = $Background / BackgroundPanel / BackgroundListing / ContactsContainer / ContactsPanel / ContactsNumber
@onready var DomainNumber = $Background / BackgroundPanel / BackgroundListing / DomainContainer / DomainPanel / DomainNumber
@onready var FameNumber = $Background / BackgroundPanel / BackgroundListing / FameContainer / FamePanel / FameNumber
@onready var GenerationNumber = $Background / BackgroundPanel / BackgroundListing / GenerationContainer / GenerationPanel / GenerationNumber
@onready var HavenNumber = $Background / BackgroundPanel / BackgroundListing / HavenContainer / HavenPanel / HavenNumber
@onready var HerdNumber = $Background / BackgroundPanel / BackgroundListing / HerdContainer / HerdPanel / HerdNumber
@onready var InfluenceNumber = $Background / BackgroundPanel / BackgroundListing / InfluenceContainer / InfluencePanel / InfluenceNumber
@onready var MentorNumber = $Background / BackgroundPanel / BackgroundListing / MentorContainer / MentorPanel / MentorNumber
@onready var ResourcesNumber = $Background / BackgroundPanel / BackgroundListing / ResourcesContainer / ResourcesPanel / ResourcesNumber
@onready var RetainersNumber = $Background / BackgroundPanel / BackgroundListing / RetainersContainer / RetainersPanel / RetainersNumber
@onready var RitualsNumber = $Background / BackgroundPanel / BackgroundListing / RitualsContainer / RitualsPanel / RitualsNumber
@onready var StatusNumber = $Background / BackgroundPanel / BackgroundListing / StatusContainer / StatusPanel / StatusNumber

@onready var WillpowerNumber = $Background / VirtuePanel / VirtueContainer / Willpower / WillpowerNumberPanel / WillpowerNumber

@onready var PathNumber = $Background / VirtuePanel / VirtueContainer / Path / PathNumberPanel / PathNumber

@onready var FreebiePointsCounter = $Background / FreebiePointsBox / FreebiePointsCounter

@onready var NameEdit = $Background / CharacterInformation / CharacterInformationPresentation / NameContainer / NameEdit
@onready var SectEdit = $Background / CharacterInformation / CharacterInformationPresentation / SectContainer / SectEdit
@onready var ClanEdit = $Background / CharacterInformation / CharacterInformationPresentation / ClanContainer / ClanEdit
@onready var NatureEdit = $Background / CharacterInformation / CharacterInformationPresentation / NatureContainer / NatureEdit
@onready var DemeanorEdit = $Background / CharacterInformation / CharacterInformationPresentation / DemeanorContainer / DemeanorEdit



@onready var MeritType1Option = $Background / Merit_FlawPanel / Merit_FlawContainer / MeritPanel / MeritContainer / Merit1Container / MeritType1Option
@onready var MeritType2Option = $Background / Merit_FlawPanel / Merit_FlawContainer / MeritPanel / MeritContainer / Merit2Container / MeritType2Option
@onready var MeritType3Option = $Background / Merit_FlawPanel / Merit_FlawContainer / MeritPanel / MeritContainer / Merit3Container / MeritType3Option
@onready var MeritType4Option = $Background / Merit_FlawPanel / Merit_FlawContainer / MeritPanel / MeritContainer / Merit4Container / MeritType4Option
@onready var MeritType5Option = $Background / Merit_FlawPanel / Merit_FlawContainer / MeritPanel / MeritContainer / Merit5Container / MeritType5Option


@onready var FlawType1Option = $Background / Merit_FlawPanel / Merit_FlawContainer / FlawPanel / FlawContainer / Flaw1Container / FlawType1Option
@onready var FlawType2Option = $Background / Merit_FlawPanel / Merit_FlawContainer / FlawPanel / FlawContainer / Flaw2Container / FlawType2Option
@onready var FlawType3Option = $Background / Merit_FlawPanel / Merit_FlawContainer / FlawPanel / FlawContainer / Flaw3Container / FlawType3Option
@onready var FlawType4Option = $Background / Merit_FlawPanel / Merit_FlawContainer / FlawPanel / FlawContainer / Flaw4Container / FlawType4Option
@onready var FlawType5Option = $Background / Merit_FlawPanel / Merit_FlawContainer / FlawPanel / FlawContainer / Flaw5Container / FlawType5Option

@onready var Merit1Option = $Background / Merit_FlawPanel / Merit_FlawContainer / MeritPanel / MeritContainer / Merit1Container / Merit1Option
@onready var Merit2Option = $Background / Merit_FlawPanel / Merit_FlawContainer / MeritPanel / MeritContainer / Merit2Container / Merit2Option
@onready var Merit3Option = $Background / Merit_FlawPanel / Merit_FlawContainer / MeritPanel / MeritContainer / Merit3Container / Merit3Option
@onready var Merit4Option = $Background / Merit_FlawPanel / Merit_FlawContainer / MeritPanel / MeritContainer / Merit4Container / Merit4Option
@onready var Merit5Option = $Background / Merit_FlawPanel / Merit_FlawContainer / MeritPanel / MeritContainer / Merit5Container / Merit5Option

@onready var Flaw1Option = $Background / Merit_FlawPanel / Merit_FlawContainer / FlawPanel / FlawContainer / Flaw1Container / Flaw1Option
@onready var Flaw2Option = $Background / Merit_FlawPanel / Merit_FlawContainer / FlawPanel / FlawContainer / Flaw2Container / Flaw2Option
@onready var Flaw3Option = $Background / Merit_FlawPanel / Merit_FlawContainer / FlawPanel / FlawContainer / Flaw3Container / Flaw3Option
@onready var Flaw4Option = $Background / Merit_FlawPanel / Merit_FlawContainer / FlawPanel / FlawContainer / Flaw4Container / Flaw4Option
@onready var Flaw5Option = $Background / Merit_FlawPanel / Merit_FlawContainer / FlawPanel / FlawContainer / Flaw5Container / Flaw5Option

@onready var StrengthIncreaseButton = $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StrengthButtonsContainer / StrengthIncrease
@onready var StrengthAddsNumber = $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StrengthPanelAdds / StrengthAddsNumber
@onready var StrengthDecreaseButton = $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StrengthButtonsContainer / StrengthDecrease


@onready var DexterityIncreaseButton = $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / DexterityButtonsContainer / DexterityIncrease
@onready var DexterityDecreaseButton = $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / DexterityButtonsContainer / DexterityDecrease
@onready var DexterityAddsNumber = $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / DexterityPanelAdds / DexterityAddsNumber

@onready var StaminaIncreaseButton = $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StaminaButtonsContainer / StaminaIncrease
@onready var StaminaDecreaseButton = $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StaminaButtonsContainer / StaminaDecrease
@onready var StaminaAddsNumber = $Background / AttributePanel / AttributeListing / PhysicalPanel / PhysicalAttributes / StaminaPanelAdds / StaminaAddsNumber

@onready var CharismaIncreaseButton = $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / CharismaButtonsContainer / CharismaIncrease
@onready var CharismaDecreaseButton = $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / CharismaButtonsContainer / CharismaDecrease
@onready var CharismaAddsNumber = $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / CharismaPanelAdds / CharismaAddsNumber

@onready var ManipulationIncreaseButton = $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / ManipulationButtonsContainer / ManipulationIncrease
@onready var ManipulationDecreaseButton = $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / ManipulationButtonsContainer / ManipulationDecrease
@onready var ManipulationAddsNumber = $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / ManipulationPanelAdds / ManipulationAddsNumber

@onready var AppearanceIncreaseButton = $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / AppearanceButtonsContainer / AppearanceIncrease
@onready var AppearanceDecreaseButton = $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / AppearanceButtonsContainer / AppearanceDecrease
@onready var AppearanceAddsNumber = $Background / AttributePanel / AttributeListing / SocialPanel / SocialAttributes / AppearancePanelAdds / AppearanceAddsNumber

@onready var PerceptionIncreaseButton = $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / PerceptionButtonsContainer / PerceptionIncrease
@onready var PerceptionDecreaseButton = $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / PerceptionButtonsContainer / PerceptionDecrease
@onready var PerceptionAddsNumber = $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / PerceptionPanelAdds / PerceptionAddsNumber

@onready var IntelligenceIncreaseButton = $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / IntelligenceButtonsContainer / IntelligenceIncrease
@onready var IntelligenceDecreaseButton = $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / IntelligenceButtonsContainer / IntelligenceDecrease
@onready var IntelligenceAddsNumber = $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / IntelligencePanelAdds / IntelligenceAddsNumber

@onready var WitsIncreaseButton = $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / WitsButtonsContainer / WitsIncrease
@onready var WitsDecreaseButton = $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / WitsButtonsContainer / WitsDecrease
@onready var WitsAddsNumber = $Background / AttributePanel / AttributeListing / MentalPanel / MentalAttributes / WitsPanelAdds / WitsAddsNumber


@onready var AlertnessAddsNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AlertnessContainer / AlertnessPanelAdds / AlertnessAddsNumber
@onready var AlertnessIncreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AlertnessContainer / AlertnessButtonsContainer / AlertnessIncrease
@onready var AlertnessDecreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AlertnessContainer / AlertnessButtonsContainer / AlertnessDecrease

@onready var AthleticsAddsNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AthleticsContainer / AthleticsPanelAdds / AthleticsAddsNumber
@onready var AthleticsIncreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AthleticsContainer / AthleticsButtonsContainer / AthleticsIncrease
@onready var AthleticsDecreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AthleticsContainer / AthleticsButtonsContainer / AthleticsDecrease

@onready var AwarenessAddsNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AwarenessContainer / AwarenessPanelAdds / AwarenessAddsNumber
@onready var AwarenessIncreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AwarenessContainer / AwarenessButtonsContainer / AwarenessIncrease
@onready var AwarenessDecreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / AwarenessContainer / AwarenessButtonsContainer / AwarenessDecrease

@onready var BrawlAddsNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / BrawlContainer / BrawlPanelAdds / BrawlAddsNumber
@onready var BrawlIncreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / BrawlContainer / BrawlButtonsContainer / BrawlIncrease
@onready var BrawlDecreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / BrawlContainer / BrawlButtonsContainer / BrawlDecrease

@onready var EmpathyAddsNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / EmpathyContainer / EmpathyPanelAdds / EmpathyAddsNumber
@onready var EmpathyIncreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / EmpathyContainer / EmpathyButtonsContainer / EmpathyIncrease
@onready var EmpathyDecreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / EmpathyContainer / EmpathyButtonsContainer / EmpathyDecrease

@onready var ExpressionAddsNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / ExpressionContainer / ExpressionPanelAdds / ExpressionAddsNumber
@onready var ExpressionIncreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / ExpressionContainer / ExpressionButtonsContainer / ExpressionIncrease
@onready var ExpressionDecreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / ExpressionContainer / ExpressionButtonsContainer / ExpressionDecrease

@onready var IntimidationAddsNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / IntimidationContainer / IntimidationPanelAdds / IntimidationAddsNumber
@onready var IntimidationIncreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / IntimidationContainer / IntimidationButtonsContainer / IntimidationIncrease
@onready var IntimidationDecreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / IntimidationContainer / IntimidationButtonsContainer / IntimidationDecrease

@onready var LeadershipAddsNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / LeadershipContainer / LeadershipPanelAdds / LeadershipAddsNumber
@onready var LeadershipIncreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / LeadershipContainer / LeadershipButtonsContainer / LeadershipIncrease
@onready var LeadershipDecreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / LeadershipContainer / LeadershipButtonsContainer / LeadershipDecrease

@onready var StreetwiseAddsNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / StreetwiseContainer / StreetwisePanelAdds / StreetwiseAddsNumber
@onready var StreetwiseIncreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / StreetwiseContainer / StreetwiseButtonsContainer / StreetwiseIncrease
@onready var StreetwiseDecreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / StreetwiseContainer / StreetwiseButtonsContainer / StreetwiseDecrease

@onready var SubterfugeAddsNumber = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / SubterfugeContainer / SubterfugePanelAdds / SubterfugeAddsNumber
@onready var SubterfugeIncreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / SubterfugeContainer / SubterfugeButtonsContainer / SubterfugeIncrease
@onready var SubterfugeDecreaseButton = $Background / AbilityPanel / AbilityListing / TalentsPanel / TalentsAbilities / SubterfugeContainer / SubterfugeButtonsContainer / SubterfugeDecrease


@onready var AnimalKenAddsNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / AnimalKenContainer / AnimalKenPanelAdds / AnimalKenAddsNumber
@onready var AnimalKenIncreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / AnimalKenContainer / AnimalKenButtonsContainer / AnimalKenIncrease
@onready var AnimalKenDecreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / AnimalKenContainer / AnimalKenButtonsContainer / AnimalKenDecrease

@onready var CraftsAddsNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / CraftContainer / CraftPanelAdds / CraftAddsNumber
@onready var CraftsIncreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / CraftContainer / CraftButtonsContainer / CraftIncrease
@onready var CraftsDecreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / CraftContainer / CraftButtonsContainer / CraftDecrease

@onready var DriveAddsNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / DriveContainer / DrivePanelAdds / DriveAddsNumber
@onready var DriveIncreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / DriveContainer / DriveButtonsContainer / DriveIncrease
@onready var DriveDecreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / DriveContainer / DriveButtonsContainer / DriveDecrease

@onready var EtiquetteAddsNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / EtiquetteContainer / EtiquettePanelAdds / EtiquetteAddsNumber
@onready var EtiquetteIncreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / EtiquetteContainer / EtiquetteButtonsContainer / EtiquetteIncrease
@onready var EtiquetteDecreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / EtiquetteContainer / EtiquetteButtonsContainer / EtiquetteDecrease

@onready var FirearmsAddsNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / FirearmsContainer / FirearmsPanelAdds / FirearmsAddsNumber
@onready var FirearmsIncreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / FirearmsContainer / FirearmsButtonsContainer / FirearmsIncrease
@onready var FirearmsDecreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / FirearmsContainer / FirearmsButtonsContainer / FirearmsDecrease

@onready var LarcenyAddsNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / LarcenyContainer / LarcenyPanelAdds / LarcenyAddsNumber
@onready var LarcenyIncreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / LarcenyContainer / LarcenyButtonsContainer / LarcenyIncrease
@onready var LarcenyDecreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / LarcenyContainer / LarcenyButtonsContainer / LarcenyDecrease

@onready var MeleeAddsNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / MeleeContainer / MeleePanelAdds / MeleeAddsNumber
@onready var MeleeIncreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / MeleeContainer / MeleeButtonsContainer / MeleeIncrease
@onready var MeleeDecreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / MeleeContainer / MeleeButtonsContainer / MeleeDecrease

@onready var PerformanceAddsNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / PerformanceContainer / PerformancePanelAdds / PerformanceAddsNumber
@onready var PerformanceIncreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / PerformanceContainer / PerformanceButtonsContainer / PerformanceIncrease
@onready var PerformanceDecreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / PerformanceContainer / PerformanceButtonsContainer / PerformanceDecrease

@onready var StealthAddsNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / StealthContainer / StealthPanelAdds / StealthAddsNumber
@onready var StealthIncreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / StealthContainer / StealthButtonsContainer / StealthIncrease
@onready var StealthDecreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / StealthContainer / StealthButtonsContainer / StealthDecrease

@onready var SurvivalAddsNumber = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / SurvivalContainer / SurvivalPanelAdds / SurvivalAddsNumber
@onready var SurvivalIncreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / SurvivalContainer / SurvivalButtonsContainer / SurvivalIncrease
@onready var SurvivalDecreaseButton = $Background / AbilityPanel / AbilityListing / SkillsPanel / SkillsAbilities / SurvivalContainer / SurvivalButtonsContainer / SurvivalDecrease


@onready var AcademicsAddsNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / AcademicsContainer / AcademicsPanelAdds / AcademicsAddsNumber
@onready var AcademicsIncreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / AcademicsContainer / AcademicsButtonsContainer / AcademicsIncrease
@onready var AcademicsDecreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / AcademicsContainer / AcademicsButtonsContainer / AcademicsDecrease

@onready var ComputerAddsNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / ComputerContainer / ComputerPanelAdds / ComputerAddsNumber
@onready var ComputerIncreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / ComputerContainer / ComputerButtonsContainer / ComputerIncrease
@onready var ComputerDecreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / ComputerContainer / ComputerButtonsContainer / ComputerDecrease

@onready var FinanceAddsNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / FinanceContainer / FinancePanelAdds / FinanceAddsNumber
@onready var FinanceIncreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / FinanceContainer / FinanceButtonsContainer / FinanceIncrease
@onready var FinanceDecreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / FinanceContainer / FinanceButtonsContainer / FinanceDecrease

@onready var InvestigationAddsNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / InvestigationContainer / InvestigationPanelAdds / InvestigationAddsNumber
@onready var InvestigationIncreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / InvestigationContainer / InvestigationButtonsContainer / InvestigationIncrease
@onready var InvestigationDecreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / InvestigationContainer / InvestigationButtonsContainer / InvestigationDecrease

@onready var LawAddsNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / LawContainer / LawPanelAdds / LawAddsNumber
@onready var LawIncreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / LawContainer / LawButtonsContainer / LawIncrease
@onready var LawDecreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / LawContainer / LawButtonsContainer / LawDecrease

@onready var MedicineAddsNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / MedicineContainer / MedicinePanelAdds / MedicineAddsNumber
@onready var MedicineIncreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / MedicineContainer / MedicineButtonsContainer / MedicineIncrease
@onready var MedicineDecreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / MedicineContainer / MedicineButtonsContainer / MedicineDecrease

@onready var OccultAddsNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / OccultContainer / OccultPanelAdds / OccultAddsNumber
@onready var OccultIncreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / OccultContainer / OccultButtonsContainer / OccultIncrease
@onready var OccultDecreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / OccultContainer / OccultButtonsContainer / OccultDecrease

@onready var PoliticsAddsNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / PoliticsContainer / PoliticsPanelAdds / PoliticsAddsNumber
@onready var PoliticsIncreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / PoliticsContainer / PoliticsButtonsContainer / PoliticsIncrease
@onready var PoliticsDecreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / PoliticsContainer / PoliticsButtonsContainer / PoliticsDecrease

@onready var ScienceAddsNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / ScienceContainer / SciencePanelAdds / ScienceAddsNumber
@onready var ScienceIncreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / ScienceContainer / ScienceButtonsContainer / ScienceIncrease
@onready var ScienceDecreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / ScienceContainer / ScienceButtonsContainer / ScienceDecrease

@onready var TechnologyAddsNumber = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / TechnologyContainer / TechnologyPanelAdds / TechnologyAddsNumber
@onready var TechnologyIncreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / TechnologyContainer / TechnologyButtonsContainer / TechnologyIncrease
@onready var TechnologyDecreaseButton = $Background / AbilityPanel / AbilityListing / KnowledgesPanel / KnowledgesAbilities / TechnologyContainer / TechnologyButtonsContainer / TechnologyDecrease


@onready var AlliesAddsNumber = $Background / BackgroundPanel / BackgroundListing / AlliesContainer / AlliesPanelAdds / AlliesAddsNumber
@onready var AlliesIncreaseButton = $Background / BackgroundPanel / BackgroundListing / AlliesContainer / AlliesButtonsContainer / AlliesIncrease
@onready var AlliesDecreaseButton = $Background / BackgroundPanel / BackgroundListing / AlliesContainer / AlliesButtonsContainer / AlliesDecrease

@onready var ContactsAddsNumber = $Background / BackgroundPanel / BackgroundListing / ContactsContainer / ContactsPanelAdds / ContactsAddsNumber
@onready var ContactsIncreaseButton = $Background / BackgroundPanel / BackgroundListing / ContactsContainer / ContactsButtonsContainer / ContactsIncrease
@onready var ContactsDecreaseButton = $Background / BackgroundPanel / BackgroundListing / ContactsContainer / ContactsButtonsContainer / ContactsDecrease

@onready var DomainAddsNumber = $Background / BackgroundPanel / BackgroundListing / DomainContainer / DomainPanelAdds / DomainAddsNumber
@onready var DomainIncreaseButton = $Background / BackgroundPanel / BackgroundListing / DomainContainer / DomainButtonsContainer / DomainIncrease
@onready var DomainDecreaseButton = $Background / BackgroundPanel / BackgroundListing / DomainContainer / DomainButtonsContainer / DomainDecrease

@onready var FameAddsNumber = $Background / BackgroundPanel / BackgroundListing / FameContainer / FamePanelAdds / FameAddsNumber
@onready var FameIncreaseButton = $Background / BackgroundPanel / BackgroundListing / FameContainer / FameButtonsContainer / FameIncrease
@onready var FameDecreaseButton = $Background / BackgroundPanel / BackgroundListing / FameContainer / FameButtonsContainer / FameDecrease

@onready var GenerationAddsNumber = $Background / BackgroundPanel / BackgroundListing / GenerationContainer / GenerationPanelAdds / GenerationAddsNumber
@onready var GenerationIncreaseButton = $Background / BackgroundPanel / BackgroundListing / GenerationContainer / GenerationButtonsContainer / GenerationIncrease
@onready var GenerationDecreaseButton = $Background / BackgroundPanel / BackgroundListing / GenerationContainer / GenerationButtonsContainer / GenerationDecrease

@onready var HavenAddsNumber = $Background / BackgroundPanel / BackgroundListing / HavenContainer / HavenPanelAdds / HavenAddsNumber
@onready var HavenIncreaseButton = $Background / BackgroundPanel / BackgroundListing / HavenContainer / HavenButtonsContainer / HavenIncrease
@onready var HavenDecreaseButton = $Background / BackgroundPanel / BackgroundListing / HavenContainer / HavenButtonsContainer / HavenDecrease

@onready var HerdAddsNumber = $Background / BackgroundPanel / BackgroundListing / HerdContainer / HerdPanelAdds / HerdAddsNumber
@onready var HerdIncreaseButton = $Background / BackgroundPanel / BackgroundListing / HerdContainer / HerdButtonsContainer / HerdIncrease
@onready var HerdDecreaseButton = $Background / BackgroundPanel / BackgroundListing / HerdContainer / HerdButtonsContainer / HerdDecrease

@onready var InfluenceAddsNumber = $Background / BackgroundPanel / BackgroundListing / InfluenceContainer / InfluencePanelAdds / InfluenceAddsNumber
@onready var InfluenceIncreaseButton = $Background / BackgroundPanel / BackgroundListing / InfluenceContainer / InfluenceButtonsContainer / InfluenceIncrease
@onready var InfluenceDecreaseButton = $Background / BackgroundPanel / BackgroundListing / InfluenceContainer / InfluenceButtonsContainer / InfluenceDecrease

@onready var MentorAddsNumber = $Background / BackgroundPanel / BackgroundListing / MentorContainer / MentorPanelAdds / MentorAddsNumber
@onready var MentorIncreaseButton = $Background / BackgroundPanel / BackgroundListing / MentorContainer / MentorButtonsContainer / MentorIncrease
@onready var MentorDecreaseButton = $Background / BackgroundPanel / BackgroundListing / MentorContainer / MentorButtonsContainer / MentorDecrease

@onready var ResourcesAddsNumber = $Background / BackgroundPanel / BackgroundListing / ResourcesContainer / ResourcesPanelAdds / ResourcesAddsNumber
@onready var ResourcesIncreaseButton = $Background / BackgroundPanel / BackgroundListing / ResourcesContainer / ResourcesButtonsContainer / ResourcesIncrease
@onready var ResourcesDecreaseButton = $Background / BackgroundPanel / BackgroundListing / ResourcesContainer / ResourcesButtonsContainer / ResourcesDecrease

@onready var RetainersAddsNumber = $Background / BackgroundPanel / BackgroundListing / RetainersContainer / RetainersPanelAdds / RetainersAddsNumber
@onready var RetainersIncreaseButton = $Background / BackgroundPanel / BackgroundListing / RetainersContainer / RetainersButtonsContainer / RetainersIncrease
@onready var RetainersDecreaseButton = $Background / BackgroundPanel / BackgroundListing / RetainersContainer / RetainersButtonsContainer / RetainersDecrease

@onready var RitualsAddsNumber = $Background / BackgroundPanel / BackgroundListing / RitualsContainer / RitualsPanelAdds / RitualsAddsNumber
@onready var RitualsIncreaseButton = $Background / BackgroundPanel / BackgroundListing / RitualsContainer / RitualsButtonsContainer / RitualsIncrease
@onready var RitualsDecreaseButton = $Background / BackgroundPanel / BackgroundListing / RitualsContainer / RitualsButtonsContainer / RitualsDecrease

@onready var StatusAddsNumber = $Background / BackgroundPanel / BackgroundListing / StatusContainer / StatusPanelAdds / StatusAddsNumber
@onready var StatusIncreaseButton = $Background / BackgroundPanel / BackgroundListing / StatusContainer / StatusButtonsContainer / StatusIncrease
@onready var StatusDecreaseButton = $Background / BackgroundPanel / BackgroundListing / StatusContainer / StatusButtonsContainer / StatusDecrease


@onready var ConscienceAddsNumber = $Background / VirtuePanel / VirtueContainer / Conscience / ConscienceNumberAddPanel / ConscienceAddsNumber
@onready var ConscienceIncreaseButton = $Background / VirtuePanel / VirtueContainer / Conscience / ConscienceButtonsContainer / ConscienceIncrease
@onready var ConscienceDecreaseButton = $Background / VirtuePanel / VirtueContainer / Conscience / ConscienceButtonsContainer / ConscienceDecrease

@onready var SelfControlAddsNumber = $Background / VirtuePanel / VirtueContainer / SelfControl / SelfControlNumberAddPanel / SelfControlAddsNumber
@onready var SelfControlIncreaseButton = $Background / VirtuePanel / VirtueContainer / SelfControl / SelfControlButtonsContainer / SelfControlIncrease
@onready var SelfControlDecreaseButton = $Background / VirtuePanel / VirtueContainer / SelfControl / SelfControlButtonsContainer / SelfControlDecrease

@onready var CourageAddsNumber = $Background / VirtuePanel / VirtueContainer / Courage / CourageNumberAddPanel / CourageAddsNumber
@onready var CourageIncreaseButton = $Background / VirtuePanel / VirtueContainer / Courage / CourageButtonsContainer / CourageIncrease
@onready var CourageDecreaseButton = $Background / VirtuePanel / VirtueContainer / Courage / CourageButtonsContainer / CourageDecrease

@onready var PathAddsNumber = $Background / VirtuePanel / VirtueContainer / Path / PathNumberAddPanel / PathAddsNumber
@onready var PathIncreaseButton = $Background / VirtuePanel / VirtueContainer / Path / PathButtonsContainer / PathIncrease
@onready var PathDecreaseButton = $Background / VirtuePanel / VirtueContainer / Path / PathButtonsContainer / PathDecrease

@onready var WillpowerAddsNumber = $Background / VirtuePanel / VirtueContainer / Willpower / WillpowerNumberAddPanel / WillpowerAddsNumber
@onready var WillpowerIncreaseButton = $Background / VirtuePanel / VirtueContainer / Willpower / WillpowerButtonsContainer / WillpowerIncrease
@onready var WillpowerDecreaseButton = $Background / VirtuePanel / VirtueContainer / Willpower / WillpowerButtonsContainer / WillpowerDecrease


@onready var Discipline1AddsNumber = $Background / DisciplinePanel / DisciplineContainer / Discipline1 / Discipline1NumberPanel2 / Discipline1Number
@onready var Discipline1IncreaseButton = $Background / DisciplinePanel / DisciplineContainer / Discipline1 / Discipline1ButtonsContainer / Discipline1Increase
@onready var Discipline1DecreaseButton = $Background / DisciplinePanel / DisciplineContainer / Discipline1 / Discipline1ButtonsContainer / Discipline1Decrease

@onready var Discipline2AddsNumber = $Background / DisciplinePanel / DisciplineContainer / Discipline2 / Discipline2NumberPanel2 / Discipline2Number
@onready var Discipline2IncreaseButton = $Background / DisciplinePanel / DisciplineContainer / Discipline2 / Discipline2ButtonsContainer / Discipline2Increase
@onready var Discipline2DecreaseButton = $Background / DisciplinePanel / DisciplineContainer / Discipline2 / Discipline2ButtonsContainer / Discipline2Decrease

@onready var Discipline3AddsNumber = $Background / DisciplinePanel / DisciplineContainer / Discipline3 / Discipline3NumberPanel2 / Discipline3Number
@onready var Discipline3IncreaseButton = $Background / DisciplinePanel / DisciplineContainer / Discipline3 / Discipline3ButtonsContainer / Discipline3Increase
@onready var Discipline3DecreaseButton = $Background / DisciplinePanel / DisciplineContainer / Discipline3 / Discipline3ButtonsContainer / Discipline3Decrease

@onready var Discipline4Option = $Background / DisciplinePanel / DisciplineContainer / Discipline4 / Discipline4
@onready var Discipline4Number = $Background / DisciplinePanel / DisciplineContainer / Discipline4 / Discipline4NumberPanel / Discipline4Number
@onready var Discipline4AddsNumber = $Background / DisciplinePanel / DisciplineContainer / Discipline4 / Discipline4NumberPanel2 / Discipline4Number
@onready var Discipline4IncreaseButton = $Background / DisciplinePanel / DisciplineContainer / Discipline4 / Discipline4ButtonsContainer / Discipline4Increase
@onready var Discipline4DecreaseButton = $Background / DisciplinePanel / DisciplineContainer / Discipline4 / Discipline4ButtonsContainer / Discipline4Decrease

@onready var Discipline1Option = $Background / DisciplinePanel / DisciplineContainer / Discipline1 / Discipline1
@onready var Discipline2Option = $Background / DisciplinePanel / DisciplineContainer / Discipline2 / Discipline2
@onready var Discipline3Option = $Background / DisciplinePanel / DisciplineContainer / Discipline3 / Discipline3

@onready var BackButton = $Background / BACK

@onready var CompleteButton = $Background / COMPLETE


var current_freebie_points: = 15
var selected_merits: = {}



var physical_merits: = [
    ["Acute Sense", 1], ["Ambidextrous", 1], ["Bruiser", 1], ["Catlike Balance", 1], 
    ["Early Riser", 1], ["Eat Food", 1], ["Friendly Face", 1], 
    ["Blush of Health", 2], ["Enchanting Voice", 2], 
    ["Crack Shot", 3], ["Daredevil", 3], ["Efficient Digestion", 3], ["Tough as Nails", 3], 
    ["Discerning Palate", 4], ["Huge Size", 4]
]

var mental_merits: = [
    ["Celestial Attunement", 1], 
    ["Coldly Logical", 1], 
    ["Common Sense", 1], 
    ["Concentration", 1], 
    ["Introspection", 1], 
    ["Kashaph", 1], 
    ["Language", 1], 
    ["Time Sense", 1], 
    ["Useful Knowledge", 1], 
    ["Code of Honor", 2], 
    ["Computer Aptitude", 2], 
    ["Eidetic Memory", 2], 
    ["Incantation", 2], 
    ["Light Sleeper", 2], 
    ["Natural Linguist", 2], 
    ["Calm Heart", 3], 
    ["Iron Will", 3], 
    ["Precocious", 3], 
    ["Grand Library", 2], 
    ["Grand Library", 4], 
    ["Grand Library", 6], 
    ["Grand Library", 7]
]

var social_merits: = [
    ["Elysium Regular", 1], 
    ["Former Ghoul", 1], 
    ["Harmless", 1], 
    ["Natural Leader", 1], 
    ["Prestigious Sire", 1], 
    ["Protégé", 1], 
    ["Rep", 1], 
    ["Sabbat Survivor", 1], 
    ["Boon", 1], 
    ["Bullyboy", 2], 
    ["Entrepreneur", 2], 
    ["Peacemaker", 2], 
    ["Prized Patch", 2], 
    ["Old Pal", 2], 
    ["Lawman’s Friend", 2], 
    ["Open Road", 2], 
    ["Sanctity", 2], 
    ["Scholar of Enemies", 2], 
    ["Scholar of Others", 2], 
    ["Friend of the Underground", 3], 
    ["Mole", 3], 
    ["Rising Star", 3], 
    ["Soapbox", 3], 
    ["Sugar Daddy", 3], 
    ["Broken Bond", 4], 
    ["Clan Friendship", 4], 
    ["Primogen/Bishop Friendship", 4], 
    ["Trophy Allegiance", 4], 
    ["Arcane", 1], 
    ["Paragon", 7]
]

var supernatural_merits: = [
    ["Deceptive Aura", 1], 
    ["Healing Touch", 1], 
    ["Inoffensive to Animals", 1], 
    ["Apostate", 2], 
    ["Medium", 2], 
    ["Magic Resistance", 2], 
    ["Without a Trace", 2], 
    ["Hidden Diablerie", 3], 
    ["Lucky", 3], 
    ["Oracular Ability", 3], 
    ["Spirit Mentor", 3], 
    ["Mark of Caine", 4], 
    ["Profane Trappings", 4], 
    ["True Love", 4], 
    ["Additional Discipline", 5], 
    ["Arcane", 5], 
    ["Demonic Patron", 5], 
    ["Psychic Leech", 5], 
    ["Touch of the Wyld", 5], 
    ["Unbondable", 5], 
    ["Blasphemous Pact", 6], 
    ["Nine Lives", 6], 
    ["True Faith", 7], 
    ["Unlucky", 1], 
    ["Unlucky", 2], 
    ["Unlucky", 3], 
    ["Unlucky", 4], 
    ["Unlucky", 5]
]

var selected_flaws: = {}


var physical_flaws: = [
    ["Hard of Hearing", 1], 
    ["Short", 1], 
    ["Smell of the Grave", 1], 
    ["Tic/Twitch", 1], 
    ["Bad Sight", 1], 
    ["Vulnerability to Silver", 2], 
    ["Bad Sight", 3], 
    ["Fourteenth Generation", 2], 
    ["Fifteenth Generation", 4], 
    ["Disfigured", 2], 
    ["Dulled Bite", 2], 
    ["Infectious Bite", 2], 
    ["One Eye", 2], 
    ["Vulnerability to Silver", 2], 
    ["Open Wound", 2], 
    ["Open Wound", 4], 
    ["Addiction", 3], 
    ["Deformity", 3], 
    ["Glowing Eyes", 3], 
    ["Lame", 3], 
    ["Lazy", 3], 
    ["Monstrous", 3], 
    ["Permanent Fangs", 3], 
    ["Permanent Wound", 3], 
    ["Slow Healing", 3], 
    ["Child", 4], 
    ["Disease Carrier", 4], 
    ["Deaf", 4], 
    ["Mute", 4], 
    ["Thin Blood", 4], 
    ["Flesh of the Corpse", 5], 
    ["Infertile Vitae", 5], 
    ["Blind", 6]
]

var mental_flaws: = [
    ["Deep Sleeper", 1], 
    ["Impatient", 1], 
    ["Nightmares", 1], 
    ["Prey Exclusion", 1], 
    ["Shy", 1], 
    ["Soft-Hearted", 1], 
    ["Speech Impediment", 1], 
    ["Unconvinced", 1], 
    ["Amnesia", 2], 
    ["Lunacy", 2], 
    ["Phobia", 2], 
    ["Short Fuse", 2], 
    ["Stereotype", 2], 
    ["Territorial", 2], 
    ["Thirst for Innocence", 2], 
    ["Vengeful", 2], 
    ["Victim of the Masquerade", 2], 
    ["Weak-Willed", 3], 
    ["Conspicuous Consumption", 4], 
    ["Guilt-Wracked", 4], 
    ["Flashbacks", 6]
]

var social_flaws: = [
    ["Botched Presentation", 1], 
    ["Dark Secret", 1], 
    ["Expendable", 1], 
    ["Incomplete Understanding", 1], 
    ["Infamous Sire", 1], 
    ["Mistaken Identity", 1], 
    ["New Arrival", 1], 
    ["New Kid", 1], 
    ["Recruitment Target", 1], 
    ["Sire’s Resentment", 1], 
    ["Special Responsibility", 1], 
    ["Sympathizer", 1], 
    ["Vulgar", 1], 
    ["Rivalry", 1], 
    ["Bound", 2], 
    ["Catspaw", 2], 
    ["Escaped Target", 2], 
    ["Expiration Date", 2], 
    ["Failure", 2], 
    ["Masquerade Breaker", 2], 
    ["Old Flame", 2], 
    ["Rival Sires", 2], 
    ["Uppity", 2], 
    ["Disgrace to the Blood", 3], 
    ["Former Prince", 3], 
    ["Hunted Like a Dog", 3], 
    ["Narc", 3], 
    ["Sleeping With the Enemy", 3], 
    ["Clan Enmity", 4], 
    ["Hunted", 4], 
    ["Loathsome Regnant", 4], 
    ["Oathbreaker", 4], 
    ["Trophy Arrogance", 4], 
    ["Outspoken Heretic", 4], 
    ["Overextended", 4], 
    ["Probationary Sect Member", 4], 
    ["Blood Hunted", 4], 
    ["Blood Hunted", 6], 
    ["Black Sheep", 5], 
    ["Laughingstock", 5], 
    ["Nameless", 5], 
    ["Red List", 7], 
    ["Enemy", 1], 
    ["Enemy", 2], 
    ["Enemy", 3], 
    ["Enemy", 4], 
    ["Enemy", 5]
]

var supernatural_flaws: = [
    ["Cast No Reflection", 1], 
    ["Cold Breeze", 1], 
    ["Initiate of a Road", 1], 
    ["Repulsed by Garlic", 1], 
    ["Touch of Frost", 1], 
    ["Demon Hounded", 1], 
    ["Unlucky", 1], 
    ["Beacon of the Unholy", 2], 
    ["Deathsight", 2], 
    ["Eerie Presence", 2], 
    ["Kiss of Death", 2], 
    ["Lord of the Flies", 2], 
    ["Can't Cross Running Water", 3], 
    ["Cloaked in Shadow", 3], 
    ["Devil’s Mark", 3], 
    ["Haunted", 3], 
    ["Lord of the Night", 3], 
    ["Repelled by Crosses", 3], 
    ["Unholy Stain", 3], 
    ["Grip of the Damned", 4], 
    ["Dark Fate", 5], 
    ["Light-Sensitive", 5], 
    ["Harbinger of the Abyss", 5], 
    ["Vassal of the Clan", 6], 
    ["Methuselah’s Thirst", 7], 
    ["The Scourge", 7], 
    ["Cursed", 1], 
    ["Cursed", 2], 
    ["Cursed", 3], 
    ["Cursed", 4], 
    ["Cursed", 5]
]


var clan_flaws: = {
    "Assamite": [
        ["Outcast", 2], 
        ["Broken Antitribu", 3], 
        ["Multiple Curses", 3]
    ], 
    "Assamite Antitribu": [
        ["Outcast", 2], 
        ["Broken Antitribu", 3], 
        ["Multiple Curses", 3]
    ], 
    "Brujah": [
        ["Obvious Predator", 2]
    ], 
    "Brujah Antitribu": [
        ["Obvious Predator", 2]
    ], 

    "Caitiff": [
        ["Clan Weakness", 2], 
        ["Fangless", 2], 
        ["Ignorance", 2], 
        ["Bulimia", 4]
    ], 


    "City Gangrel": [
        ["Member of the Pack", 2], 
        ["Rat in a Cage", 2]
    ], 
    "Country Gangrel": [
        ["Member of the Pack", 2], 
        ["Rat in a Cage", 2]
    ], 
    "Gangrel": [
        ["Member of the Pack", 2], 
        ["Rat in a Cage", 2]
    ], 
    "Lasombra": [
        ["Uncontrollable Night Sight", 2], 
        ["Insubordinate", 3], 
        ["Unproven", 3]
    ], 
    "Lasombra Antitribu": [
        ["Uncontrollable Night Sight", 2], 
        ["Insubordinate", 3], 
        ["Unproven", 3]
    ], 
    "Malkavian": [
        ["Paper Trail", 2], 
        ["Stigmata", 2], 
        ["Infectious", 3], 
        ["Overstimulated", 3], 
        ["Dead Inside", 4]
    ], 
    "Malkavian Antitribu": [
        ["Paper Trail", 2], 
        ["Stigmata", 2], 
        ["Infectious", 3], 
        ["Overstimulated", 3], 
        ["Dead Inside", 4]
    ], 
    "Nosferatu": [
        ["Stench", 1], 
        ["Dangerous Secret", 1], 
        ["Anosmia", 2], 
        ["Parasitic Infestation", 2], 
        ["Bestial", 3], 
        ["Enemy Brood", 3], 
        ["Putrescent", 4], 
        ["Contagious", 5], 
        ["Incoherent", 5]
    ], 

    "Nosferatu Antitribu": [
        ["Stench", 1], 
        ["Dangerous Secret", 1], 
        ["Anosmia", 2], 
        ["Parasitic Infestation", 2], 
        ["Bestial", 3], 
        ["Enemy Brood", 3], 
        ["Putrescent", 4], 
        ["Contagious", 5], 
        ["Incoherent", 5]
    ], 

    "Panders": [
        ["Clan Weakness", 2], 
        ["Fangless", 2], 
        ["Ignorance", 2], 
        ["Bulimia", 4]
    ], 

    "Ravnos": [
        ["Chandala", 1], 
        ["Flawed Reality", 2], 
        ["Oathbreaker", 2], 
        ["Lost Svadharma", 3]
    ], 
    "Ravnos Antitribu": [
        ["Chandala", 1], 
        ["Flawed Reality", 2], 
        ["Oathbreaker", 2], 
        ["Lost Svadharma", 3]
    ], 
    "Toreador": [
        ["Tortured Artist", 1], 
        ["Private Life", 3]
    ], 
    "Toreador Antitribu": [
        ["Tortured Artist", 1], 
        ["Private Life", 3]
    ], 
    "Tremere": [
        ["Cloistered", 2], 
        ["Permanent Third Eye", 2], 
        ["Betrayer’s Mark", 3], 
        ["Bound to the Clan", 3], 
        ["Mage Blood", 5], 
        ["Thaumaturgically Inept", 5], 
        ["Arcane Curse", 1], 
        ["Arcane Curse", 2], 
        ["Arcane Curse", 3], 
        ["Arcane Curse", 4], 
        ["Arcane Curse", 5]
    ], 
    "Tremere Antitribu": [
        ["Arcane Curse", 1], 
        ["Cloistered", 2], 
        ["Permanent Third Eye", 2], 
        ["Betrayer’s Mark", 3], 
        ["Bound to the Clan", 3], 
        ["Mage Blood", 5], 
        ["Thaumaturgically Inept", 5]
    ], 
    "Tzimisce": [
        ["Unblinking", 1], 
        ["Ancestral Soil Dependence", 2], 
        ["Faceless", 3], 
        ["Privacy Obsession", 3], 
        ["Revenant Weakness", 3], 
        ["Consumption", 5]
    ], 
    "Ventrue": [
        ["Uncommon Vitae Preference", 2]
    ], 
    "Ventrue Antitribu": [
        ["Uncommon Vitae Preference", 2]
    ]
}

var selected_path_name: = ""

func _ready():
    print("Loaded FreebieUI for: ", PlayerData.character_name)

    CompleteButton.connect("pressed", Callable(self, "_on_complete_pressed"))

    selected_path_name = PlayerData.path_name

    StrengthNumber.text = str(PlayerData.strength)
    DexterityNumber.text = str(PlayerData.dexterity)
    StaminaNumber.text = str(PlayerData.stamina)

    CharismaNumber.text = str(PlayerData.charisma)
    ManipulationNumber.text = str(PlayerData.manipulation)
    AppearanceNumber.text = str(PlayerData.appearance)

    PerceptionNumber.text = str(PlayerData.perception)
    IntelligenceNumber.text = str(PlayerData.intelligence)
    WitsNumber.text = str(PlayerData.wits)

    AlertnessNumber.text = str(PlayerData.alertness)
    AthleticsNumber.text = str(PlayerData.athletics)
    AwarenessNumber.text = str(PlayerData.awareness)
    BrawlNumber.text = str(PlayerData.brawl)
    EmpathyNumber.text = str(PlayerData.empathy)
    ExpressionNumber.text = str(PlayerData.expression)
    IntimidationNumber.text = str(PlayerData.intimidation)
    LeadershipNumber.text = str(PlayerData.leadership)
    StreetwiseNumber.text = str(PlayerData.streetwise)
    SubterfugeNumber.text = str(PlayerData.subterfuge)

    AnimalKenNumber.text = str(PlayerData.animal_ken)
    CraftsNumber.text = str(PlayerData.crafts)
    DriveNumber.text = str(PlayerData.drive)
    EtiquetteNumber.text = str(PlayerData.etiquette)
    FirearmsNumber.text = str(PlayerData.firearms)
    LarcenyNumber.text = str(PlayerData.larceny)
    MeleeNumber.text = str(PlayerData.melee)
    PerformanceNumber.text = str(PlayerData.performance)
    StealthNumber.text = str(PlayerData.stealth)
    SurvivalNumber.text = str(PlayerData.survival)

    AcademicsNumber.text = str(PlayerData.academics)
    ComputerNumber.text = str(PlayerData.computer)
    FinanceNumber.text = str(PlayerData.finance)
    InvestigationNumber.text = str(PlayerData.investigation)
    LawNumber.text = str(PlayerData.law)
    MedicineNumber.text = str(PlayerData.medicine)
    OccultNumber.text = str(PlayerData.occult)
    PoliticsNumber.text = str(PlayerData.politics)
    ScienceNumber.text = str(PlayerData.science)
    TechnologyNumber.text = str(PlayerData.technology)

    Discipline1Label.text = PlayerData.discipline_1_name
    Discipline1Number.text = str(PlayerData.discipline_1)

    Discipline2Label.text = PlayerData.discipline_2_name
    Discipline2Number.text = str(PlayerData.discipline_2)

    Discipline3Label.text = PlayerData.discipline_3_name
    Discipline3Number.text = str(PlayerData.discipline_3)


    if PlayerData.uses_conscience:
        ConscienceLabel.text = "Conscience"
        ConscienceNumber.text = str(PlayerData.conscience)
    elif PlayerData.uses_conviction:
        ConscienceLabel.text = "Conviction"
        ConscienceNumber.text = str(PlayerData.conscience)


    if PlayerData.uses_self_control:
        SelfControlLabel.text = "Self-Control"
        SelfControlNumber.text = str(PlayerData.self_control)
    elif PlayerData.uses_instinct:
        SelfControlLabel.text = "Instinct"
        SelfControlNumber.text = str(PlayerData.self_control)


    CourageNumber.text = str(PlayerData.courage)

    AlliesNumber.text = str(PlayerData.allies)
    ContactsNumber.text = str(PlayerData.contacts)
    DomainNumber.text = str(PlayerData.domain)
    FameNumber.text = str(PlayerData.fame)
    GenerationNumber.text = str(PlayerData.generation)
    HavenNumber.text = str(PlayerData.haven)
    HerdNumber.text = str(PlayerData.herd)
    InfluenceNumber.text = str(PlayerData.influence)
    MentorNumber.text = str(PlayerData.mentor)
    ResourcesNumber.text = str(PlayerData.resources)
    RetainersNumber.text = str(PlayerData.retainers)
    RitualsNumber.text = str(PlayerData.rituals)
    StatusNumber.text = str(PlayerData.status)

    WillpowerNumber.text = str(PlayerData.courage)

    var path_rating = 0

    if PlayerData.uses_conscience:
        path_rating += PlayerData.conscience
    if PlayerData.uses_conviction:
        path_rating += PlayerData.conscience
    if PlayerData.uses_self_control:
        path_rating += PlayerData.self_control
    if PlayerData.uses_instinct:
        path_rating += PlayerData.self_control

    PathNumber.text = str(path_rating)

    FreebiePointsCounter.text = "15"

    NameEdit.text = PlayerData.character_name
    SectEdit.text = PlayerData.sect
    ClanEdit.text = PlayerData.clan
    NatureEdit.text = PlayerData.nature
    DemeanorEdit.text = PlayerData.demeanor



    var merit_options = [
        MeritType1Option, 
        MeritType2Option, 
        MeritType3Option, 
        MeritType4Option, 
        MeritType5Option
    ]

    for option in merit_options:
        option.clear()
        option.add_item("")
        option.add_item("Physical")
        option.add_item("Mental")
        option.add_item("Social")
        option.add_item("Supernatural")
        option.add_item("Clan")
        option.select(0)


    var flaw_options = [
        FlawType1Option, 
        FlawType2Option, 
        FlawType3Option, 
        FlawType4Option, 
        FlawType5Option
    ]

    for option in flaw_options:
        option.clear()
        option.add_item("")
        option.add_item("Physical")
        option.add_item("Mental")
        option.add_item("Social")
        option.add_item("Supernatural")
        option.add_item("Clan")
        option.select(0)

    populate_merit_option_button(Merit1Option, physical_merits)
    populate_merit_option_button(Merit2Option, physical_merits)
    populate_merit_option_button(Merit3Option, physical_merits)
    populate_merit_option_button(Merit4Option, physical_merits)
    populate_merit_option_button(Merit5Option, physical_merits)


    Merit1Option.connect("item_selected", Callable(self, "_on_merit_option_selected").bind(Merit1Option))
    Merit2Option.connect("item_selected", Callable(self, "_on_merit_option_selected").bind(Merit2Option))
    Merit3Option.connect("item_selected", Callable(self, "_on_merit_option_selected").bind(Merit3Option))
    Merit4Option.connect("item_selected", Callable(self, "_on_merit_option_selected").bind(Merit4Option))
    Merit5Option.connect("item_selected", Callable(self, "_on_merit_option_selected").bind(Merit5Option))

    MeritType1Option.connect("item_selected", Callable(self, "_on_merit_type_selected").bind(MeritType1Option, Merit1Option))
    MeritType2Option.connect("item_selected", Callable(self, "_on_merit_type_selected").bind(MeritType2Option, Merit2Option))
    MeritType3Option.connect("item_selected", Callable(self, "_on_merit_type_selected").bind(MeritType3Option, Merit3Option))
    MeritType4Option.connect("item_selected", Callable(self, "_on_merit_type_selected").bind(MeritType4Option, Merit4Option))
    MeritType5Option.connect("item_selected", Callable(self, "_on_merit_type_selected").bind(MeritType5Option, Merit5Option))

    Flaw1Option.connect("item_selected", Callable(self, "_on_flaw_option_selected").bind(Flaw1Option))
    Flaw2Option.connect("item_selected", Callable(self, "_on_flaw_option_selected").bind(Flaw2Option))
    Flaw3Option.connect("item_selected", Callable(self, "_on_flaw_option_selected").bind(Flaw3Option))
    Flaw4Option.connect("item_selected", Callable(self, "_on_flaw_option_selected").bind(Flaw4Option))
    Flaw5Option.connect("item_selected", Callable(self, "_on_flaw_option_selected").bind(Flaw5Option))

    FlawType1Option.connect("item_selected", Callable(self, "_on_flaw_type_selected").bind(FlawType1Option, Flaw1Option))
    FlawType2Option.connect("item_selected", Callable(self, "_on_flaw_type_selected").bind(FlawType2Option, Flaw2Option))
    FlawType3Option.connect("item_selected", Callable(self, "_on_flaw_type_selected").bind(FlawType3Option, Flaw3Option))
    FlawType4Option.connect("item_selected", Callable(self, "_on_flaw_type_selected").bind(FlawType4Option, Flaw4Option))
    FlawType5Option.connect("item_selected", Callable(self, "_on_flaw_type_selected").bind(FlawType5Option, Flaw5Option))

    populate_flaw_option_button(Flaw1Option, get_flaw_list_by_type(FlawType1Option.get_item_text(FlawType1Option.selected)))
    populate_flaw_option_button(Flaw2Option, get_flaw_list_by_type(FlawType2Option.get_item_text(FlawType2Option.selected)))
    populate_flaw_option_button(Flaw3Option, get_flaw_list_by_type(FlawType3Option.get_item_text(FlawType3Option.selected)))
    populate_flaw_option_button(Flaw4Option, get_flaw_list_by_type(FlawType4Option.get_item_text(FlawType4Option.selected)))
    populate_flaw_option_button(Flaw5Option, get_flaw_list_by_type(FlawType5Option.get_item_text(FlawType5Option.selected)))

    for option in flaw_options:
        option.clear()
        option.add_item("")
        option.add_item("Physical")
        option.add_item("Mental")
        option.add_item("Social")
        option.add_item("Supernatural")
        option.add_item("Clan")
        option.select(0)

    StrengthIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(StrengthNumber, StrengthAddsNumber, 5))
    StrengthDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(StrengthNumber, StrengthAddsNumber, 5))

    DexterityIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(DexterityNumber, DexterityAddsNumber, 5))
    DexterityDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(DexterityNumber, DexterityAddsNumber, 5))

    StaminaIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(StaminaNumber, StaminaAddsNumber, 5))
    StaminaDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(StaminaNumber, StaminaAddsNumber, 5))

    CharismaIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(CharismaNumber, CharismaAddsNumber, 5))
    CharismaDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(CharismaNumber, CharismaAddsNumber, 5))

    ManipulationIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(ManipulationNumber, ManipulationAddsNumber, 5))
    ManipulationDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(ManipulationNumber, ManipulationAddsNumber, 5))

    AppearanceIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(AppearanceNumber, AppearanceAddsNumber, 5))
    AppearanceDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(AppearanceNumber, AppearanceAddsNumber, 5))

    PerceptionIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(PerceptionNumber, PerceptionAddsNumber, 5))
    PerceptionDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(PerceptionNumber, PerceptionAddsNumber, 5))

    IntelligenceIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(IntelligenceNumber, IntelligenceAddsNumber, 5))
    IntelligenceDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(IntelligenceNumber, IntelligenceAddsNumber, 5))

    WitsIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(WitsNumber, WitsAddsNumber, 5))
    WitsDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(WitsNumber, WitsAddsNumber, 5))


    AlertnessIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(AlertnessNumber, AlertnessAddsNumber, 2))
    AlertnessDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(AlertnessNumber, AlertnessAddsNumber, 2))

    AthleticsIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(AthleticsNumber, AthleticsAddsNumber, 2))
    AthleticsDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(AthleticsNumber, AthleticsAddsNumber, 2))

    AwarenessIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(AwarenessNumber, AwarenessAddsNumber, 2))
    AwarenessDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(AwarenessNumber, AwarenessAddsNumber, 2))

    BrawlIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(BrawlNumber, BrawlAddsNumber, 2))
    BrawlDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(BrawlNumber, BrawlAddsNumber, 2))

    EmpathyIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(EmpathyNumber, EmpathyAddsNumber, 2))
    EmpathyDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(EmpathyNumber, EmpathyAddsNumber, 2))

    ExpressionIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(ExpressionNumber, ExpressionAddsNumber, 2))
    ExpressionDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(ExpressionNumber, ExpressionAddsNumber, 2))

    IntimidationIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(IntimidationNumber, IntimidationAddsNumber, 2))
    IntimidationDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(IntimidationNumber, IntimidationAddsNumber, 2))

    LeadershipIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(LeadershipNumber, LeadershipAddsNumber, 2))
    LeadershipDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(LeadershipNumber, LeadershipAddsNumber, 2))

    StreetwiseIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(StreetwiseNumber, StreetwiseAddsNumber, 2))
    StreetwiseDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(StreetwiseNumber, StreetwiseAddsNumber, 2))

    SubterfugeIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(SubterfugeNumber, SubterfugeAddsNumber, 2))
    SubterfugeDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(SubterfugeNumber, SubterfugeAddsNumber, 2))


    AnimalKenIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(AnimalKenNumber, AnimalKenAddsNumber, 2))
    AnimalKenDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(AnimalKenNumber, AnimalKenAddsNumber, 2))

    CraftsIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(CraftsNumber, CraftsAddsNumber, 2))
    CraftsDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(CraftsNumber, CraftsAddsNumber, 2))

    DriveIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(DriveNumber, DriveAddsNumber, 2))
    DriveDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(DriveNumber, DriveAddsNumber, 2))

    EtiquetteIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(EtiquetteNumber, EtiquetteAddsNumber, 2))
    EtiquetteDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(EtiquetteNumber, EtiquetteAddsNumber, 2))

    FirearmsIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(FirearmsNumber, FirearmsAddsNumber, 2))
    FirearmsDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(FirearmsNumber, FirearmsAddsNumber, 2))

    LarcenyIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(LarcenyNumber, LarcenyAddsNumber, 2))
    LarcenyDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(LarcenyNumber, LarcenyAddsNumber, 2))

    MeleeIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(MeleeNumber, MeleeAddsNumber, 2))
    MeleeDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(MeleeNumber, MeleeAddsNumber, 2))

    PerformanceIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(PerformanceNumber, PerformanceAddsNumber, 2))
    PerformanceDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(PerformanceNumber, PerformanceAddsNumber, 2))

    StealthIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(StealthNumber, StealthAddsNumber, 2))
    StealthDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(StealthNumber, StealthAddsNumber, 2))

    SurvivalIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(SurvivalNumber, SurvivalAddsNumber, 2))
    SurvivalDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(SurvivalNumber, SurvivalAddsNumber, 2))


    AcademicsIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(AcademicsNumber, AcademicsAddsNumber, 2))
    AcademicsDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(AcademicsNumber, AcademicsAddsNumber, 2))

    ComputerIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(ComputerNumber, ComputerAddsNumber, 2))
    ComputerDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(ComputerNumber, ComputerAddsNumber, 2))

    FinanceIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(FinanceNumber, FinanceAddsNumber, 2))
    FinanceDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(FinanceNumber, FinanceAddsNumber, 2))

    InvestigationIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(InvestigationNumber, InvestigationAddsNumber, 2))
    InvestigationDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(InvestigationNumber, InvestigationAddsNumber, 2))

    LawIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(LawNumber, LawAddsNumber, 2))
    LawDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(LawNumber, LawAddsNumber, 2))

    MedicineIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(MedicineNumber, MedicineAddsNumber, 2))
    MedicineDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(MedicineNumber, MedicineAddsNumber, 2))

    OccultIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(OccultNumber, OccultAddsNumber, 2))
    OccultDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(OccultNumber, OccultAddsNumber, 2))

    PoliticsIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(PoliticsNumber, PoliticsAddsNumber, 2))
    PoliticsDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(PoliticsNumber, PoliticsAddsNumber, 2))

    ScienceIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(ScienceNumber, ScienceAddsNumber, 2))
    ScienceDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(ScienceNumber, ScienceAddsNumber, 2))

    TechnologyIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(TechnologyNumber, TechnologyAddsNumber, 2))
    TechnologyDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(TechnologyNumber, TechnologyAddsNumber, 2))


    AlliesIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(AlliesNumber, AlliesAddsNumber, 2))
    AlliesDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(AlliesNumber, AlliesAddsNumber, 2))

    ContactsIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(ContactsNumber, ContactsAddsNumber, 2))
    ContactsDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(ContactsNumber, ContactsAddsNumber, 2))

    DomainIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(DomainNumber, DomainAddsNumber, 2))
    DomainDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(DomainNumber, DomainAddsNumber, 2))

    FameIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(FameNumber, FameAddsNumber, 2))
    FameDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(FameNumber, FameAddsNumber, 2))

    GenerationIncreaseButton.connect("pressed", Callable(self, "_on_generation_increase"))
    GenerationDecreaseButton.connect("pressed", Callable(self, "_on_generation_decrease"))


    HavenIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(HavenNumber, HavenAddsNumber, 2))
    HavenDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(HavenNumber, HavenAddsNumber, 2))

    HerdIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(HerdNumber, HerdAddsNumber, 2))
    HerdDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(HerdNumber, HerdAddsNumber, 2))

    InfluenceIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(InfluenceNumber, InfluenceAddsNumber, 2))
    InfluenceDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(InfluenceNumber, InfluenceAddsNumber, 2))

    MentorIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(MentorNumber, MentorAddsNumber, 2))
    MentorDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(MentorNumber, MentorAddsNumber, 2))

    ResourcesIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(ResourcesNumber, ResourcesAddsNumber, 2))
    ResourcesDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(ResourcesNumber, ResourcesAddsNumber, 2))

    RetainersIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(RetainersNumber, RetainersAddsNumber, 2))
    RetainersDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(RetainersNumber, RetainersAddsNumber, 2))

    RitualsIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(RitualsNumber, RitualsAddsNumber, 2))
    RitualsDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(RitualsNumber, RitualsAddsNumber, 2))

    StatusIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(StatusNumber, StatusAddsNumber, 2))
    StatusDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(StatusNumber, StatusAddsNumber, 2))


    ConscienceIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(ConscienceNumber, ConscienceAddsNumber, 2))
    ConscienceDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(ConscienceNumber, ConscienceAddsNumber, 2))

    SelfControlIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(SelfControlNumber, SelfControlAddsNumber, 2))
    SelfControlDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(SelfControlNumber, SelfControlAddsNumber, 2))

    CourageIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(CourageNumber, CourageAddsNumber, 2))
    CourageDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(CourageNumber, CourageAddsNumber, 2))


    PathIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(PathNumber, PathAddsNumber, 2))
    PathDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(PathNumber, PathAddsNumber, 2))


    WillpowerIncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(WillpowerNumber, WillpowerAddsNumber, 1))
    WillpowerDecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(WillpowerNumber, WillpowerAddsNumber, 1))


    Discipline1IncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(Discipline1Number, Discipline1AddsNumber, 7))
    Discipline1DecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(Discipline1Number, Discipline1AddsNumber, 7))

    Discipline2IncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(Discipline2Number, Discipline2AddsNumber, 7))
    Discipline2DecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(Discipline2Number, Discipline2AddsNumber, 7))

    Discipline3IncreaseButton.connect("pressed", Callable(self, "_on_stat_increase_pressed").bind(Discipline3Number, Discipline3AddsNumber, 7))
    Discipline3DecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(Discipline3Number, Discipline3AddsNumber, 7))

    var all_disciplines = [
        "Abombwe", "Animalism", "Auspex", "Bardo", "Celerity", "Chimerstry", "Daimoinon", 
        "Dementation", "Dominate", "Flight", "Fortitude", "Melpominee", "Mytherceria", 
        "Necromancy", "Obeah", "Obfuscate", "Obtenebration", "Ogham", "Potence", "Presence", 
        "Protean", "Quietus", "Sanguinus", "Serpentis", "Spiritus", "Temporis", 
        "Thanatosis", "Thaumaturgy", "Valeren", "Vicissitude", "Visceratika"
    ]


    var core_disciplines = [
        PlayerData.discipline_1_name, 
        PlayerData.discipline_2_name, 
        PlayerData.discipline_3_name
    ]


    var bonus_options = []
    for D in all_disciplines:
        if D not in core_disciplines:
            bonus_options.append(D)


    Discipline4Option.clear()
    Discipline4Option.add_item("")
    for D in bonus_options:
        Discipline4Option.add_item(D)

    Discipline4Number.text = "0"
    Discipline4IncreaseButton.connect("pressed", func():
        if Discipline4Option.get_selected_id() == 0:
            return
        _on_stat_increase_pressed(Discipline4Number, Discipline4AddsNumber, 7)
    )
    Discipline4DecreaseButton.connect("pressed", Callable(self, "_on_stat_decrease_pressed").bind(Discipline4Number, Discipline4AddsNumber, 7))

    BackButton.connect("pressed", Callable(self, "_on_back_pressed"))

    generation_dots = PlayerData.generation
    min_generation_dots = PlayerData.generation
    update_generation_display()


    var all_adds_labels = [
        StrengthAddsNumber, DexterityAddsNumber, StaminaAddsNumber, 
        CharismaAddsNumber, ManipulationAddsNumber, AppearanceAddsNumber, 
        PerceptionAddsNumber, IntelligenceAddsNumber, WitsAddsNumber, 

        AlertnessAddsNumber, AthleticsAddsNumber, AwarenessAddsNumber, BrawlAddsNumber, 
        EmpathyAddsNumber, ExpressionAddsNumber, IntimidationAddsNumber, LeadershipAddsNumber, 
        StreetwiseAddsNumber, SubterfugeAddsNumber, 

        AnimalKenAddsNumber, CraftsAddsNumber, DriveAddsNumber, EtiquetteAddsNumber, 
        FirearmsAddsNumber, LarcenyAddsNumber, MeleeAddsNumber, PerformanceAddsNumber, 
        StealthAddsNumber, SurvivalAddsNumber, 

        AcademicsAddsNumber, ComputerAddsNumber, FinanceAddsNumber, InvestigationAddsNumber, 
        LawAddsNumber, MedicineAddsNumber, OccultAddsNumber, PoliticsAddsNumber, 
        ScienceAddsNumber, TechnologyAddsNumber, 

        AlliesAddsNumber, ContactsAddsNumber, DomainAddsNumber, FameAddsNumber, 
        GenerationAddsNumber, HavenAddsNumber, HerdAddsNumber, InfluenceAddsNumber, 
        MentorAddsNumber, ResourcesAddsNumber, RetainersAddsNumber, RitualsAddsNumber, StatusAddsNumber, 

        ConscienceAddsNumber, SelfControlAddsNumber, CourageAddsNumber, 
        PathAddsNumber, WillpowerAddsNumber, 

        Discipline1AddsNumber, Discipline2AddsNumber, Discipline3AddsNumber, Discipline4AddsNumber
    ]

    for label in all_adds_labels:
        label.text = "0"


func populate_merit_option_button(option_button: OptionButton, merit_list: Array):
    var selected_names = []


    for val in selected_merits.values():
        selected_names.append(val)


    var current_text: = ""
    if option_button.selected > 0:
        current_text = option_button.get_item_text(option_button.selected)
        selected_names.erase(current_text)


    option_button.clear()
    option_button.add_item("")

    for merit in merit_list:
        var label = "%s (%d)" % [merit[0], merit[1]]
        if label not in selected_names:
            option_button.add_item(label)


    if current_text != "":
        for i in option_button.item_count:
            if option_button.get_item_text(i) == current_text:
                option_button.select(i)
                break



func _on_merit_option_selected(index: int, option_button: OptionButton) -> void :
    var previous_name = ""
    var previous_cost = 0


    if selected_merits.has(option_button):
        previous_name = selected_merits[option_button]

        var old_text = ""
        for i in option_button.item_count:
            var label = option_button.get_item_text(i)
            if label.begins_with(previous_name + " ("):
                old_text = label
                break
        if old_text != "":
            previous_cost = int(old_text.get_slice("(", 1).trim_suffix(")"))
            current_freebie_points += previous_cost
        selected_merits.erase(option_button)

    var selected_text = option_button.get_item_text(index)

    if selected_text == "":
        update_freebie_counter()
        return

    var selected_name = selected_text.get_slice(" (", 0)
    var merit_cost = int(selected_text.get_slice("(", 1).trim_suffix(")"))


    for other_button in selected_merits.keys():
        if other_button != option_button and selected_merits[other_button] == selected_name:
            option_button.select(0)
            update_freebie_counter()
            return


    if current_freebie_points - merit_cost < 0:
        option_button.select(0)
        update_freebie_counter()
        return


    current_freebie_points -= merit_cost
    selected_merits[option_button] = selected_name
    update_freebie_counter()


    populate_merit_option_button(Merit1Option, get_merit_list_by_type(MeritType1Option.get_item_text(MeritType1Option.selected)))
    populate_merit_option_button(Merit2Option, get_merit_list_by_type(MeritType2Option.get_item_text(MeritType2Option.selected)))
    populate_merit_option_button(Merit3Option, get_merit_list_by_type(MeritType3Option.get_item_text(MeritType3Option.selected)))
    populate_merit_option_button(Merit4Option, get_merit_list_by_type(MeritType4Option.get_item_text(MeritType4Option.selected)))
    populate_merit_option_button(Merit5Option, get_merit_list_by_type(MeritType5Option.get_item_text(MeritType5Option.selected)))




func update_freebie_counter():
    FreebiePointsCounter.text = str(current_freebie_points)

func get_merit_list_by_type(type: String) -> Array:
    match type:
        "Physical":
            return physical_merits
        "Mental":
            return mental_merits
        "Social":
            return social_merits
        "Supernatural":
            return supernatural_merits
        "Clan":
            var clan = PlayerData.clan
            if clan_merits.has(clan):
                return clan_merits[clan]
            else:
                return []
        _:
            return []




func _on_merit_type_selected(index: int, type_button: OptionButton, target_option: OptionButton):
    var selected_type = type_button.get_item_text(index)


    if selected_merits.has(target_option):
        current_freebie_points += get_merit_cost_by_name(selected_merits[target_option])
        selected_merits.erase(target_option)
        update_freebie_counter()

    target_option.clear()
    target_option.add_item("")
    target_option.select(0)

    if selected_type == "":
        return

    var merit_list = get_merit_list_by_type(selected_type)
    populate_merit_option_button(target_option, merit_list)

func get_merit_cost_by_name(merit_name: String) -> int:
    var all_merits = physical_merits + mental_merits + social_merits + supernatural_merits
    if clan_merits.has(PlayerData.clan):
        all_merits += clan_merits[PlayerData.clan]
    for merit in all_merits:
        if merit[0] == merit_name:
            return merit[1]
    return 0



var clan_merits: = {
    "Assamite": [
        ["Sectarian Ally", 1], 
        ["Thousand Meter Killer", 1]
    ], 
    "Assamite Antitribu": [
        ["Sectarian Ally", 1], 
        ["Thousand Meter Killer", 1]
    ], 

    "Brujah": [
        ["Fury’s Focus", 3], 
        ["Dynamic Personality", 5]
    ], 
    "Brujah Antitribu": [
        ["Fury’s Focus", 3], 
        ["Dynamic Personality", 5]
    ], 

    "Caitiff": [
        ["Personal Masquerade", 3]
    ], 

    "Gangrel": [
        ["Hive-Minded", 1], 
        ["Skald", 2], 
        ["Lesser Mark of the Beast", 4], 
        ["Totemic Change", 5]
    ], 
    "City Gangrel": [
        ["Hive-Minded", 1], 
        ["Skald", 2], 
        ["Lesser Mark of the Beast", 4], 
        ["Totemic Change", 5]
    ], 
    "Country Gangrel": [
        ["Hive-Minded", 1], 
        ["Skald", 2], 
        ["Lesser Mark of the Beast", 4], 
        ["Totemic Change", 5]
    ], 

    "Lasombra": [
        ["Court Favorite", 1], 
        ["Eyes of Shadow", 1], 
        ["Bigger Boys Came", 2], 
        ["Call of the Sea", 2], 
        ["Controllable Night Sight", 2], 
        ["Secret Stash", 2], 
        ["Aura of Command", 3], 
        ["King or Queen of Shadow", 4], 
        ["Long-Term Planning", 4], 
        ["Instrument of God", 5]
    ], 
    "Lasombra Antitribu": [
        ["Court Favorite", 1], 
        ["Eyes of Shadow", 1], 
        ["Bigger Boys Came", 2], 
        ["Call of the Sea", 2], 
        ["Controllable Night Sight", 2], 
        ["Secret Stash", 2], 
        ["Aura of Command", 3], 
        ["King or Queen of Shadow", 4], 
        ["Long-Term Planning", 4], 
        ["Instrument of God", 5]
    ], 

    "Malkavian": [
        ["Distracting Aura", 2], 
        ["Prophetic Dreams", 2], 
        ["Cold Read", 3]
    ], 
    "Malkavian Antitribu": [
        ["Distracting Aura", 2], 
        ["Prophetic Dreams", 2], 
        ["Cold Read", 3]
    ], 

    "Nosferatu": [
        ["Foul Blood", 1], 
        ["Lizard Limbs", 1], 
        ["Long Fingers", 1], 
        ["Monstrous Maw", 1], 
        ["Piscine", 1], 
        ["Slimy", 1], 
        ["Spawning Pool", 1], 
        ["Tunnel Rat", 1], 
        ["Sleep Unseen", 2], 
        ["Tough Hide", 2], 
        ["False Reflection", 3], 
        ["Patagia", 4], 
        ["Rugged Bad Looks", 5]
    ], 
    "Nosferatu Antitribu": [
        ["Foul Blood", 1], 
        ["Lizard Limbs", 1], 
        ["Long Fingers", 1], 
        ["Monstrous Maw", 1], 
        ["Piscine", 1], 
        ["Slimy", 1], 
        ["Spawning Pool", 1], 
        ["Tunnel Rat", 1], 
        ["Sleep Unseen", 2], 
        ["Tough Hide", 2], 
        ["False Reflection", 3], 
        ["Patagia", 4], 
        ["Rugged Bad Looks", 5]
    ], 

    "Panders": [
        ["Personal Masquerade", 3]
    ], 

    "Ravnos": [
        ["Antitoxin Blood", 1], 
        ["Brahmin", 1], 
        ["Kshatriya", 1], 
        ["Legerdemain", 1], 
        ["Mute Devotion", 1], 
        ["Vaishya", 1], 
        ["Critters", 2], 
        ["Ravnos Jati", 2], 
        ["Heart of Needles", 3]
    ], 
    "Ravnos Antitribu": [
        ["Antitoxin Blood", 1], 
        ["Brahmin", 1], 
        ["Kshatriya", 1], 
        ["Legerdemain", 1], 
        ["Mute Devotion", 1], 
        ["Vaishya", 1], 
        ["Critters", 2], 
        ["Ravnos Jati", 2], 
        ["Heart of Needles", 3]
    ], 

    "Toreador": [
        ["Indelible", 1], 
        ["Impressive Restraint", 2], 
        ["Master of the Masquerade", 2], 
        ["Slowed Degeneration", 5]
    ], 
    "Toreador Antitribu": [
        ["Indelible", 1], 
        ["Impressive Restraint", 2], 
        ["Master of the Masquerade", 2], 
        ["Slowed Degeneration", 5]
    ], 

    "Tremere": [
        ["Embraced without the Cup", 1], 
        ["Secret Society Member", 1], 
        ["Keys to the Library", 1], 
        ["Outside Haven", 2], 
        ["Unmarked Antitribu", 2], 
        ["Quartermaster", 3]
    ], 
    "Tremere Antitribu": [
        ["Embraced without the Cup", 1], 
        ["Secret Society Member", 1], 
        ["Keys to the Library", 1], 
        ["Outside Haven", 2], 
        ["Unmarked Antitribu", 2], 
        ["Quartermaster", 3]
    ], 

    "Tzimisce": [
        ["Bioluminescence", 1], 
        ["Pain Tolerance", 2], 
        ["Dracon’s Temperament", 3], 
        ["Haven Affinity", 3], 
        ["Revenant Disciplines", 3], 
        ["Promethean Clay", 5]
    ], 

    "Ventrue": [
        ["Connoisseur", 2], 
        ["Blessed by St. Gustav", 4]
    ], 
    "Ventrue Antitribu": [
        ["Connoisseur", 2], 
        ["Blessed by St. Gustav", 4]
    ]
}


func get_flaw_list_by_type(type: String) -> Array:
    match type:
        "Physical":
            return physical_flaws
        "Mental":
            return mental_flaws
        "Social":
            return social_flaws
        "Supernatural":
            return supernatural_flaws
        "Clan":
            var clan = PlayerData.clan
            if clan_flaws.has(clan):
                return clan_flaws[clan]
            else:
                return []
        _:
            return []

func populate_flaw_option_button(option_button: OptionButton, flaw_list: Array):
    var selected_names = []
    for val in selected_flaws.values():
        selected_names.append(val)

    var current_text: = ""
    if option_button.selected > 0:
        current_text = option_button.get_item_text(option_button.selected)
        selected_names.erase(current_text)

    option_button.clear()
    option_button.add_item("")

    for flaw in flaw_list:
        var label = "%s (%d)" % [flaw[0], flaw[1]]
        if label not in selected_names:
            option_button.add_item(label)

    if current_text != "":
        for i in option_button.item_count:
            if option_button.get_item_text(i) == current_text:
                option_button.select(i)
                break

func _on_flaw_option_selected(index: int, option_button: OptionButton) -> void :
    var previous_name = ""
    var previous_cost = 0

    if selected_flaws.has(option_button):
        previous_name = selected_flaws[option_button]
        var old_text = ""
        for i in option_button.item_count:
            var label = option_button.get_item_text(i)
            if label.begins_with(previous_name + " ("):
                old_text = label
                break
        if old_text != "":
            previous_cost = int(old_text.get_slice("(", 1).trim_suffix(")"))
            current_freebie_points -= previous_cost
        selected_flaws.erase(option_button)

    var selected_text = option_button.get_item_text(index)
    if selected_text == "":
        update_freebie_counter()
        return

    var selected_name = selected_text.get_slice(" (", 0)
    var flaw_cost = int(selected_text.get_slice("(", 1).trim_suffix(")"))

    for other_button in selected_flaws.keys():
        if other_button != option_button and selected_flaws[other_button] == selected_name:
            option_button.select(0)
            update_freebie_counter()
            return

    current_freebie_points += flaw_cost

    var total_flaw_points = 0
    for val in selected_flaws.values():
        total_flaw_points += get_flaw_cost_by_name(val)

    if total_flaw_points + flaw_cost > 7:
        option_button.select(0)
        update_freebie_counter()
        return

    selected_flaws[option_button] = selected_name
    update_freebie_counter()

    populate_flaw_option_button(Flaw1Option, get_flaw_list_by_type(FlawType1Option.get_item_text(FlawType1Option.selected)))
    populate_flaw_option_button(Flaw2Option, get_flaw_list_by_type(FlawType2Option.get_item_text(FlawType2Option.selected)))
    populate_flaw_option_button(Flaw3Option, get_flaw_list_by_type(FlawType3Option.get_item_text(FlawType3Option.selected)))
    populate_flaw_option_button(Flaw4Option, get_flaw_list_by_type(FlawType4Option.get_item_text(FlawType4Option.selected)))
    populate_flaw_option_button(Flaw5Option, get_flaw_list_by_type(FlawType5Option.get_item_text(FlawType5Option.selected)))

func _on_flaw_type_selected(index: int, type_button: OptionButton, target_option: OptionButton):
    var selected_type = type_button.get_item_text(index)

    if selected_flaws.has(target_option):
        current_freebie_points -= get_flaw_cost_by_name(selected_flaws[target_option])
        selected_flaws.erase(target_option)
        update_freebie_counter()

    target_option.clear()
    target_option.add_item("")
    target_option.select(0)

    if selected_type == "":
        return

    var flaw_list = get_flaw_list_by_type(selected_type)
    populate_flaw_option_button(target_option, flaw_list)

func get_flaw_cost_by_name(flaw_name: String) -> int:
    var all_flaws = physical_flaws + mental_flaws + social_flaws + supernatural_flaws
    if clan_flaws.has(PlayerData.clan):
        all_flaws += clan_flaws[PlayerData.clan]
    for flaw in all_flaws:
        if flaw[0] == flaw_name:
            return flaw[1]
    return 0


func apply_freebie_increase(number_label: Label, adds_label: Label, cost: int) -> void :
    var current = number_label.text.to_int()
    var added = adds_label.text.to_int()
    var base = current - added


    var max_cap: = 5
    if number_label == WillpowerNumber or number_label == PathNumber:
        max_cap = 10

    if base + added >= max_cap:
        return

    if current_freebie_points < cost:
        return

    current += 1
    added += 1
    current_freebie_points -= cost

    number_label.text = str(current)
    adds_label.text = str(added)

    number_label.modulate = COLOR_MODIFIED if added > 0 else COLOR_DEFAULT
    update_freebie_counter()




func _on_stat_increase_pressed(number_label: Label, adds_label: Label, cost: int) -> void :
    apply_freebie_increase(number_label, adds_label, cost)

func apply_freebie_decrease(number_label: Label, adds_label: Label, cost: int) -> void :
    var current = number_label.text.to_int()
    var added = adds_label.text.to_int()

    if added <= 0:
        return

    current -= 1
    added -= 1
    current_freebie_points += cost

    number_label.text = str(current)
    adds_label.text = str(added)


    number_label.modulate = COLOR_MODIFIED if added > 0 else COLOR_DEFAULT
    update_freebie_counter()


func _on_stat_decrease_pressed(number_label: Label, adds_label: Label, cost: int) -> void :
    apply_freebie_decrease(number_label, adds_label, cost)

func _on_back_pressed():
    clear_freebies()
    current_freebie_points = 15
    update_freebie_counter()

    get_tree().change_scene_to_file("res://scene/character_creation.tscn")


func clear_freebies():

    var all_dots = [

        [StrengthNumber, StrengthAddsNumber], 
        [DexterityNumber, DexterityAddsNumber], 
        [StaminaNumber, StaminaAddsNumber], 


        [CharismaNumber, CharismaAddsNumber], 
        [ManipulationNumber, ManipulationAddsNumber], 
        [AppearanceNumber, AppearanceAddsNumber], 


        [PerceptionNumber, PerceptionAddsNumber], 
        [IntelligenceNumber, IntelligenceAddsNumber], 
        [WitsNumber, WitsAddsNumber], 

        [AlertnessNumber, AlertnessAddsNumber], 
        [AthleticsNumber, AthleticsAddsNumber], 
        [AwarenessNumber, AwarenessAddsNumber], 
        [BrawlNumber, BrawlAddsNumber], 
        [EmpathyNumber, EmpathyAddsNumber], 
        [ExpressionNumber, ExpressionAddsNumber], 
        [IntimidationNumber, IntimidationAddsNumber], 
        [LeadershipNumber, LeadershipAddsNumber], 
        [StreetwiseNumber, StreetwiseAddsNumber], 
        [SubterfugeNumber, SubterfugeAddsNumber], 


        [AnimalKenNumber, AnimalKenAddsNumber], 
        [CraftsNumber, CraftsAddsNumber], 
        [DriveNumber, DriveAddsNumber], 
        [EtiquetteNumber, EtiquetteAddsNumber], 
        [FirearmsNumber, FirearmsAddsNumber], 
        [LarcenyNumber, LarcenyAddsNumber], 
        [MeleeNumber, MeleeAddsNumber], 
        [PerformanceNumber, PerformanceAddsNumber], 
        [StealthNumber, StealthAddsNumber], 
        [SurvivalNumber, SurvivalAddsNumber], 


        [AcademicsNumber, AcademicsAddsNumber], 
        [ComputerNumber, ComputerAddsNumber], 
        [FinanceNumber, FinanceAddsNumber], 
        [InvestigationNumber, InvestigationAddsNumber], 
        [LawNumber, LawAddsNumber], 
        [MedicineNumber, MedicineAddsNumber], 
        [OccultNumber, OccultAddsNumber], 
        [PoliticsNumber, PoliticsAddsNumber], 
        [ScienceNumber, ScienceAddsNumber], 
        [TechnologyNumber, TechnologyAddsNumber], 


        [AlliesNumber, AlliesAddsNumber], 
        [ContactsNumber, ContactsAddsNumber], 
        [DomainNumber, DomainAddsNumber], 
        [FameNumber, FameAddsNumber], 
        [GenerationNumber, GenerationAddsNumber], 
        [HavenNumber, HavenAddsNumber], 
        [HerdNumber, HerdAddsNumber], 
        [InfluenceNumber, InfluenceAddsNumber], 
        [MentorNumber, MentorAddsNumber], 
        [ResourcesNumber, ResourcesAddsNumber], 
        [RetainersNumber, RetainersAddsNumber], 
        [RitualsNumber, RitualsAddsNumber], 
        [StatusNumber, StatusAddsNumber], 


        [ConscienceNumber, ConscienceAddsNumber], 
        [SelfControlNumber, SelfControlAddsNumber], 
        [CourageNumber, CourageAddsNumber], 


        [PathNumber, PathAddsNumber], 
        [WillpowerNumber, WillpowerAddsNumber], 


        [Discipline1Number, Discipline1AddsNumber], 
        [Discipline2Number, Discipline2AddsNumber], 
        [Discipline3Number, Discipline3AddsNumber], 
        [Discipline4Number, Discipline4AddsNumber]
]

    for pair in all_dots:
        var number_label = pair[0]
        var adds_label = pair[1]
        var base_value = number_label.text.to_int() - adds_label.text.to_int()
        number_label.text = str(base_value)
        adds_label.text = "0"
        number_label.modulate = COLOR_DEFAULT


    for button in selected_merits.keys():
        button.select(0)
    selected_merits.clear()

    for button in selected_flaws.keys():
        button.select(0)
    selected_flaws.clear()


    populate_merit_option_button(Merit1Option, get_merit_list_by_type(MeritType1Option.get_item_text(MeritType1Option.selected)))
    populate_merit_option_button(Merit2Option, get_merit_list_by_type(MeritType2Option.get_item_text(MeritType2Option.selected)))
    populate_merit_option_button(Merit3Option, get_merit_list_by_type(MeritType3Option.get_item_text(MeritType3Option.selected)))
    populate_merit_option_button(Merit4Option, get_merit_list_by_type(MeritType4Option.get_item_text(MeritType4Option.selected)))
    populate_merit_option_button(Merit5Option, get_merit_list_by_type(MeritType5Option.get_item_text(MeritType5Option.selected)))

    populate_flaw_option_button(Flaw1Option, get_flaw_list_by_type(FlawType1Option.get_item_text(FlawType1Option.selected)))
    populate_flaw_option_button(Flaw2Option, get_flaw_list_by_type(FlawType2Option.get_item_text(FlawType2Option.selected)))
    populate_flaw_option_button(Flaw3Option, get_flaw_list_by_type(FlawType3Option.get_item_text(FlawType3Option.selected)))
    populate_flaw_option_button(Flaw4Option, get_flaw_list_by_type(FlawType4Option.get_item_text(FlawType4Option.selected)))
    populate_flaw_option_button(Flaw5Option, get_flaw_list_by_type(FlawType5Option.get_item_text(FlawType5Option.selected)))

func update_generation_display():
    var generation_map = {
        0: "13th", 
        1: "12th", 
        2: "11th", 
        3: "10th", 
        4: "9th", 
        5: "8th"
    }

    var display_text = generation_map.get(generation_dots, "13th")
    GenerationNumberLabel.text = display_text

    GenerationNumber.text = str(generation_dots)
    GenerationAddsNumber.text = str(generation_dots - min_generation_dots)
    GenerationNumberLabel.modulate = COLOR_MODIFIED if generation_dots > min_generation_dots else COLOR_DEFAULT

    PlayerData.generation = generation_dots



func _on_generation_increase():
    if generation_dots >= 5:
        return
    if current_freebie_points < 1:
        return
    generation_dots += 1
    current_freebie_points -= 2
    update_generation_display()
    update_freebie_counter()

func _on_generation_decrease():
    if generation_dots <= min_generation_dots:
        return
    generation_dots -= 1
    current_freebie_points += 2
    update_generation_display()
    update_freebie_counter()

var generation_data: = {
    3: {"blood_pool_max": 100, "blood_per_turn": 100}, 
    4: {"blood_pool_max": 50, "blood_per_turn": 10}, 
    5: {"blood_pool_max": 40, "blood_per_turn": 8}, 
    6: {"blood_pool_max": 30, "blood_per_turn": 6}, 
    7: {"blood_pool_max": 20, "blood_per_turn": 4}, 
    8: {"blood_pool_max": 15, "blood_per_turn": 3}, 
    9: {"blood_pool_max": 14, "blood_per_turn": 2}, 
    10: {"blood_pool_max": 13, "blood_per_turn": 1}, 
    11: {"blood_pool_max": 12, "blood_per_turn": 1}, 
    12: {"blood_pool_max": 11, "blood_per_turn": 1}, 
    13: {"blood_pool_max": 10, "blood_per_turn": 1}, 
}

var selected_derangements: Array[String] = []

func _on_complete_pressed():
    print("✅ Complete button pressed!")

    var character = CharacterData.new()


    character.name = NameEdit.text
    character.clan = ClanEdit.text
    character.sect = SectEdit.text
    character.nature = NatureEdit.text
    character.demeanor = DemeanorEdit.text
    character.path_name = selected_path_name

    character.derangements = selected_derangements.duplicate()
    character.is_vampire = true


    if character.clan in ["Malkavian", "Malkavian Antitribu"] and character.derangements.is_empty():
        character_creation_selector.show_derangement_mode()
        character_creation_selector.connect("selection_made", Callable(self, "_on_derangement_selected"), CONNECT_ONE_SHOT)
        return

    character.current_zone = "OOC"


    character.strength = StrengthNumber.text.to_int()
    character.dexterity = DexterityNumber.text.to_int()
    character.stamina = StaminaNumber.text.to_int()
    character.charisma = CharismaNumber.text.to_int()
    character.manipulation = ManipulationNumber.text.to_int()
    character.appearance = AppearanceNumber.text.to_int()
    character.perception = PerceptionNumber.text.to_int()
    character.intelligence = IntelligenceNumber.text.to_int()
    character.wits = WitsNumber.text.to_int()


    character.courage = CourageNumber.text.to_int()
    character.willpower_max = WillpowerNumber.text.to_int()
    character.willpower_current = WillpowerNumber.text.to_int()
    character.path = PathNumber.text.to_int()


    if PlayerData.uses_conscience:
        character.conscience = ConscienceNumber.text.to_int()
    elif PlayerData.uses_conviction:
        character.conviction = ConscienceNumber.text.to_int()


    if PlayerData.uses_self_control:
        character.self_control = SelfControlNumber.text.to_int()
    elif PlayerData.uses_instinct:
        character.instinct = SelfControlNumber.text.to_int()


    character.generation = 13 - generation_dots
    apply_blood_pool_limits(character, character.generation)
    print("🧬 Generation set to:", character.generation)


    character.blood_pool = character.blood_pool_max


    if Discipline1Option.text != "":
        character.disciplines[Discipline1Label.text] = Discipline1Number.text.to_int()
    if Discipline2Option.text != "":
        character.disciplines[Discipline2Label.text] = Discipline2Number.text.to_int()
    if Discipline3Option.text != "":
        character.disciplines[Discipline3Label.text] = Discipline3Number.text.to_int()
    if Discipline4Option.get_selected_id() != 0:
        character.disciplines[Discipline4Option.text] = Discipline4Number.text.to_int()


    var T: int = int(character.disciplines.get("Thaumaturgy", 0))
    if T > 0:
        var paths_panel = get_node_or_null("ThaumaturgyPathLevels")
        if paths_panel == null:
            paths_panel = find_child("ThaumaturgyPathLevels", true, false)
        if paths_panel == null:
            push_error("ThaumaturgyPathLevels panel not found in this scene.")
        else:

            paths_panel.show_paths_mode(T, PackedStringArray(), "Thaumaturgy Dots")
            var path_payload = await paths_panel.selection_made
            if typeof(path_payload) == TYPE_ARRAY:
                character.thaumaturgy_paths = path_payload



        if is_instance_valid(character_creation_selector):
            character_creation_selector.show_thaumaturgy_ritual_mode()
            var ritual_name = await character_creation_selector.selection_made
            if typeof(ritual_name) == TYPE_STRING and String(ritual_name) != "":
                var rituals_arr: Array[String] = []
                rituals_arr.append("1:" + String(ritual_name))
                character.thaumaturgy_rituals = rituals_arr
        else:

            var picker = get_node_or_null("Charactercreationselection")
            if picker == null:
                picker = find_child("Charactercreationselection", true, false)
            if picker == null:
                push_error("Charactercreationselection panel not found in this scene.")
            else:
                picker.show_thaumaturgy_ritual_mode()
                var ritual_name_fallback = await picker.selection_made
                if typeof(ritual_name_fallback) == TYPE_STRING and String(ritual_name_fallback) != "":
                    var rituals_arr_fb: Array[String] = []
                    rituals_arr_fb.append("1:" + String(ritual_name_fallback))
                    character.thaumaturgy_rituals = rituals_arr_fb


    var N: int = int(character.disciplines.get("Necromancy", 0))
    if N > 0:
        var necro_panel = get_node_or_null("ThaumaturgyPathLevels")
        if necro_panel == null:
            necro_panel = find_child("ThaumaturgyPathLevels", true, false)
        if necro_panel == null:
            push_error("ThaumaturgyPathLevels panel not found in this scene.")
        else:
            var dm: Script = DisciplineManager.get_script()
            var necro_list: PackedStringArray = PackedStringArray()
            for p in dm.NECROMANCY_PATHS:
                necro_list.append(String(p))
            necro_panel.show_paths_mode(N, necro_list, "Necromancy Dots", "Necromancy Paths")
            var necro_payload = await necro_panel.selection_made
            if typeof(necro_payload) == TYPE_ARRAY:
                character.necromancy_paths = necro_payload


        if is_instance_valid(character_creation_selector):
            character_creation_selector.show_necromancy_ritual_mode()
            var ritual_name_necro = await character_creation_selector.selection_made
            if typeof(ritual_name_necro) == TYPE_STRING and String(ritual_name_necro) != "":
                var rituals_arr_necro: Array[String] = []
                rituals_arr_necro.append("1:" + String(ritual_name_necro))
                character.necromancy_rituals = rituals_arr_necro
        else:
            var picker_necro = get_node_or_null("Charactercreationselection")
            if picker_necro == null:
                picker_necro = find_child("Charactercreationselection", true, false)
            if picker_necro == null:
                push_error("Charactercreationselection panel not found in this scene.")
            else:
                picker_necro.show_necromancy_ritual_mode()
                var ritual_name_necro_fb = await picker_necro.selection_made
                if typeof(ritual_name_necro_fb) == TYPE_STRING and String(ritual_name_necro_fb) != "":
                    var rituals_arr_necro_fb: Array[String] = []
                    rituals_arr_necro_fb.append("1:" + String(ritual_name_necro_fb))
                    character.necromancy_rituals = rituals_arr_necro_fb


    character.allies = AlliesNumber.text.to_int()
    character.contacts = ContactsNumber.text.to_int()
    character.domain = DomainNumber.text.to_int()
    character.fame = FameNumber.text.to_int()
    character.generation_background = GenerationNumber.text.to_int()
    character.haven = HavenNumber.text.to_int()
    character.herd = HerdNumber.text.to_int()
    character.influence = InfluenceNumber.text.to_int()
    character.mentor = MentorNumber.text.to_int()
    character.resources = ResourcesNumber.text.to_int()
    character.retainers = RetainersNumber.text.to_int()
    character.rituals = RitualsNumber.text.to_int()
    character.status = StatusNumber.text.to_int()


    for option_button in selected_merits.keys():
        var label = option_button.get_item_text(option_button.selected)
        if label != "":
            character.merits.append(label)

    for option_button in selected_flaws.keys():
        var label = option_button.get_item_text(option_button.selected)
        if label != "":
            character.flaws.append(label)


    character.alertness = AlertnessNumber.text.to_int()
    character.athletics = AthleticsNumber.text.to_int()
    character.awareness = AwarenessNumber.text.to_int()
    character.brawl = BrawlNumber.text.to_int()
    character.empathy = EmpathyNumber.text.to_int()
    character.expression = ExpressionNumber.text.to_int()
    character.intimidation = IntimidationNumber.text.to_int()
    character.leadership = LeadershipNumber.text.to_int()
    character.streetwise = StreetwiseNumber.text.to_int()
    character.subterfuge = SubterfugeNumber.text.to_int()

    character.animal_ken = AnimalKenNumber.text.to_int()
    character.crafts = CraftsNumber.text.to_int()
    character.drive = DriveNumber.text.to_int()
    character.etiquette = EtiquetteNumber.text.to_int()
    character.firearms = FirearmsNumber.text.to_int()
    character.larceny = LarcenyNumber.text.to_int()
    character.melee = MeleeNumber.text.to_int()
    character.performance = PerformanceNumber.text.to_int()
    character.stealth = StealthNumber.text.to_int()
    character.survival = SurvivalNumber.text.to_int()

    character.academics = AcademicsNumber.text.to_int()
    character.computer = ComputerNumber.text.to_int()
    character.finance = FinanceNumber.text.to_int()
    character.investigation = InvestigationNumber.text.to_int()
    character.law = LawNumber.text.to_int()
    character.medicine = MedicineNumber.text.to_int()
    character.occult = OccultNumber.text.to_int()
    character.politics = PoliticsNumber.text.to_int()
    character.science = ScienceNumber.text.to_int()
    character.technology = TechnologyNumber.text.to_int()


    var eligible_ability_keys: Array[String] = []
    if character.alertness >= 4: eligible_ability_keys.append("alertness")
    if character.athletics >= 4: eligible_ability_keys.append("athletics")
    if character.awareness >= 4: eligible_ability_keys.append("awareness")
    if character.brawl >= 4: eligible_ability_keys.append("brawl")
    if character.empathy >= 4: eligible_ability_keys.append("empathy")
    if character.expression >= 4: eligible_ability_keys.append("expression")
    if character.intimidation >= 4: eligible_ability_keys.append("intimidation")
    if character.leadership >= 4: eligible_ability_keys.append("leadership")
    if character.streetwise >= 4: eligible_ability_keys.append("streetwise")
    if character.subterfuge >= 4: eligible_ability_keys.append("subterfuge")

    if character.animal_ken >= 4: eligible_ability_keys.append("animal_ken")
    if character.crafts >= 4: eligible_ability_keys.append("crafts")
    if character.drive >= 4: eligible_ability_keys.append("drive")
    if character.etiquette >= 4: eligible_ability_keys.append("etiquette")
    if character.firearms >= 4: eligible_ability_keys.append("firearms")
    if character.larceny >= 4: eligible_ability_keys.append("larceny")
    if character.melee >= 4: eligible_ability_keys.append("melee")
    if character.performance >= 4: eligible_ability_keys.append("performance")
    if character.stealth >= 4: eligible_ability_keys.append("stealth")
    if character.survival >= 4: eligible_ability_keys.append("survival")

    if character.academics >= 4: eligible_ability_keys.append("academics")
    if character.computer >= 4: eligible_ability_keys.append("computer")
    if character.finance >= 4: eligible_ability_keys.append("finance")
    if character.investigation >= 4: eligible_ability_keys.append("investigation")
    if character.law >= 4: eligible_ability_keys.append("law")
    if character.medicine >= 4: eligible_ability_keys.append("medicine")
    if character.occult >= 4: eligible_ability_keys.append("occult")
    if character.politics >= 4: eligible_ability_keys.append("politics")
    if character.science >= 4: eligible_ability_keys.append("science")
    if character.technology >= 4: eligible_ability_keys.append("technology")

    if eligible_ability_keys.size() > 0:

        start_specialization_prompt_queue(character, eligible_ability_keys)
        return


    var serialized = serialize_character_data(character)
    NetworkManager.rpc("request_register_player_character", serialized)



func apply_blood_pool_limits(character: CharacterData, generation: int) -> void :
    var gen_table = {
        3: [999, 999], 
        4: [50, 10], 
        5: [40, 8], 
        6: [30, 6], 
        7: [20, 4], 
        8: [15, 3], 
        9: [14, 2], 
        10: [13, 1], 
        11: [12, 1], 
        12: [11, 1], 
        13: [10, 1]
    }

    var values = gen_table.get(generation, [10, 1])
    character.blood_pool_max = values[0]
    character.blood_per_turn = values[1]
    character.blood_pool = values[0]



func serialize_character_data(character: CharacterData) -> Dictionary:
    print("📦 Serializing character data...")

    var data: = {}


    data["name"] = character.name
    data["clan"] = character.clan
    data["sect"] = character.sect
    data["nature"] = character.nature
    data["demeanor"] = character.demeanor
    data["path_name"] = character.path_name
    data["current_zone"] = character.current_zone
    data["is_vampire"] = character.is_vampire


    data["generation"] = character.generation
    data["blood_pool"] = character.blood_pool
    data["blood_pool_max"] = character.blood_pool_max
    data["blood_per_turn"] = character.blood_per_turn

    data["path"] = character.path
    data["willpower_max"] = character.willpower_max
    data["willpower_current"] = character.willpower_current
    data["conscience"] = character.conscience
    data["self_control"] = character.self_control
    data["courage"] = character.courage
    data["conviction"] = character.conviction
    data["instinct"] = character.instinct
    data["experience_points"] = character.experience_points


    data["strength"] = character.strength
    data["dexterity"] = character.dexterity
    data["stamina"] = character.stamina
    data["charisma"] = character.charisma
    data["manipulation"] = character.manipulation
    data["appearance"] = character.appearance
    data["perception"] = character.perception
    data["intelligence"] = character.intelligence
    data["wits"] = character.wits


    data["alertness"] = character.alertness
    data["athletics"] = character.athletics
    data["awareness"] = character.awareness
    data["brawl"] = character.brawl
    data["empathy"] = character.empathy
    data["expression"] = character.expression
    data["intimidation"] = character.intimidation
    data["leadership"] = character.leadership
    data["streetwise"] = character.streetwise
    data["subterfuge"] = character.subterfuge

    data["animal_ken"] = character.animal_ken
    data["crafts"] = character.crafts
    data["drive"] = character.drive
    data["etiquette"] = character.etiquette
    data["firearms"] = character.firearms
    data["larceny"] = character.larceny
    data["melee"] = character.melee
    data["performance"] = character.performance
    data["stealth"] = character.stealth
    data["survival"] = character.survival

    data["academics"] = character.academics
    data["computer"] = character.computer
    data["finance"] = character.finance
    data["investigation"] = character.investigation
    data["law"] = character.law
    data["medicine"] = character.medicine
    data["occult"] = character.occult
    data["politics"] = character.politics
    data["science"] = character.science
    data["technology"] = character.technology


    data["allies"] = character.allies
    data["contacts"] = character.contacts
    data["domain"] = character.domain
    data["fame"] = character.fame
    data["generation_background"] = character.generation_background
    data["haven"] = character.haven
    data["herd"] = character.herd
    data["influence"] = character.influence
    data["mentor"] = character.mentor
    data["resources"] = character.resources
    data["retainers"] = character.retainers
    data["rituals"] = character.rituals
    data["status"] = character.status


    data["disciplines"] = character.disciplines.duplicate()
    data["thaumaturgy_paths"] = character.thaumaturgy_paths.duplicate()
    data["thaumaturgy_rituals"] = character.thaumaturgy_rituals.duplicate()
    data["necromancy_paths"] = character.necromancy_paths.duplicate()
    data["necromancy_rituals"] = character.necromancy_rituals.duplicate()
    data["merits"] = character.merits.duplicate()
    data["flaws"] = character.flaws.duplicate()
    data["derangements"] = character.derangements.duplicate()
    data["ability_specialties"] = character.ability_specialties.duplicate()

    return data


func _on_derangement_selected(derangement_key: String) -> void :
    if not selected_derangements.has(derangement_key):
        selected_derangements.append(derangement_key)
        print("📛 Derangement added:", derangement_key)
    else:
        print("⚠️ Derangement already selected:", derangement_key)


    _on_complete_pressed()

func start_specialization_prompt_queue(character: CharacterData, eligible_ability_keys: Array[String]) -> void :
    var panel: = get_node_or_null("CharacterCreationWordsInput")
    if panel == null:
        push_error("CharacterCreationWordsInput panel not found in this scene.")
        return

    var results: Array[String] = []

    for key in eligible_ability_keys:

        var parts: PackedStringArray = key.split("_")
        for i in range(parts.size()):
            parts[i] = String(parts[i]).capitalize()
        var display: String = " ".join(parts)


        panel.show_specialization_mode(key, display)
        var payload = await panel.selection_made


        if typeof(payload) == TYPE_STRING and String(payload) != "":
            results.append(String(payload))


    character.ability_specialties = results
    var serialized: = serialize_character_data(character)
    NetworkManager.rpc("request_register_player_character", serialized)

func start_thaumaturgy_paths_prompt(character: CharacterData, T: int, eligible_ability_keys: Array[String]) -> void :

    var panel = get_node_or_null("ThaumaturgyPathLevels")
    if panel == null:
        panel = find_child("ThaumaturgyPathLevels", true, false)
    if panel == null:
        push_error("ThaumaturgyPathLevels panel not found in this scene.")

        if eligible_ability_keys.size() > 0:
            start_specialization_prompt_queue(character, eligible_ability_keys)
        else:
            var serialized_fallback: = serialize_character_data(character)
            NetworkManager.rpc("request_register_player_character", serialized_fallback)
        return


    panel.show_paths_mode(T, PackedStringArray(), "Thaumaturgy Dots")


    var payload = await panel.selection_made
    if typeof(payload) == TYPE_ARRAY:
        character.thaumaturgy_paths = payload


    if eligible_ability_keys.size() > 0:
        start_specialization_prompt_queue(character, eligible_ability_keys)
    else:
        var serialized: = serialize_character_data(character)
        NetworkManager.rpc("request_register_player_character", serialized)

func start_thaumaturgy_ritual_prompt(character: CharacterData, T: int, _eligible_ability_keys: Array[String]) -> void :

    if T <= 0:
        return


    var picker = null
    if Engine.has_meta("dummy"): pass
    if is_instance_valid(character_creation_selector):
        picker = character_creation_selector
    else:
        picker = get_node_or_null("Charactercreationselection")
        if picker == null:
            picker = find_child("Charactercreationselection", true, false)

    if picker == null:
        push_error("Charactercreationselection panel not found in this scene.")
        return


    picker.show_thaumaturgy_ritual_mode()
    var ritual_name = await picker.selection_made

    if typeof(ritual_name) != TYPE_STRING or String(ritual_name).is_empty():
        return


    character.thaumaturgy_rituals = ["1:" + String(ritual_name)]

func start_necromancy_paths_prompt(character: CharacterData, N: int, eligible_ability_keys: Array[String]) -> void :

    var panel = get_node_or_null("ThaumaturgyPathLevels")
    if panel == null:
        panel = find_child("ThaumaturgyPathLevels", true, false)
    if panel == null:
        push_error("ThaumaturgyPathLevels panel not found in this scene.")

        if eligible_ability_keys.size() > 0:
            start_specialization_prompt_queue(character, eligible_ability_keys)
        else:
            var serialized_fallback: = serialize_character_data(character)
            NetworkManager.rpc("request_register_player_character", serialized_fallback)
        return

    var dm: Script = DisciplineManager.get_script()
    var necro_list: PackedStringArray = PackedStringArray()
    for p in dm.NECROMANCY_PATHS:
        necro_list.append(String(p))

    panel.show_paths_mode(N, necro_list, "Necromancy Dots", "Necromancy Paths")

    var payload = await panel.selection_made
    if typeof(payload) == TYPE_ARRAY:
        character.necromancy_paths = payload

    if eligible_ability_keys.size() > 0:
        start_specialization_prompt_queue(character, eligible_ability_keys)
    else:
        var serialized: = serialize_character_data(character)
        NetworkManager.rpc("request_register_player_character", serialized)

func start_necromancy_ritual_prompt(character: CharacterData, N: int, _eligible_ability_keys: Array[String]) -> void :

    if N <= 0:
        return

    var picker = null
    if Engine.has_meta("dummy"): pass
    if is_instance_valid(character_creation_selector):
        picker = character_creation_selector
    else:
        picker = get_node_or_null("Charactercreationselection")
        if picker == null:
            picker = find_child("Charactercreationselection", true, false)

    if picker == null:
        push_error("Charactercreationselection panel not found in this scene.")
        return

    picker.show_necromancy_ritual_mode()
    var ritual_name = await picker.selection_made

    if typeof(ritual_name) != TYPE_STRING or String(ritual_name).is_empty():
        return

    character.necromancy_rituals = ["1:" + String(ritual_name)]
