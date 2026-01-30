extends Node
class_name ZoneData

@rpc("authority")
func receive_zone_category(category: String) -> void :
    MusicManager.set_ambiance_category(category)


var zones: = {
    "OOC": {
        "zone_name": "OOC", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Assets/UI/OOCIMAGE.png", 
                "description": "This is the Out-of-Character zone. Here, players can gather before entering the game world.", 
                "sound_path": "res://Assets/Sound/ooc_ambient.ogg"
            }, 
            "table": {
                "image_path": "res://Assets/UI/OOC_TableView.png", 
                "description": "You sit at the large wooden table. Notes, dice, and scribbles are everywhere.", 
                "sound_path": "res://Assets/Sound/table_murmur.ogg"
            }
        }, 
        "connected_zones": [""], 
        "characters": []
    }, 

    "Test1": {
        "zone_name": "Test1", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Test1.png", 
                "description": "This forgotten room smells like chalk and static. It waits for someone to remember why it exists.", 
                "sound_path": "res://sound/description/Test1.mp3"
            }
        }, 
        "connected_zones": [], 
        "characters": [], 
        "secret_entry_passwords": ["letmein", "testzone", "oocsecret"], 
        "accessible_from_zones": ["OOC"]
    }, 



    "Dorchester Square": {
        "zone_name": "DorchesterSquare", 
        "default_viewpoint": "Statue", 
        "category": "montreal_high_outside", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Statue": {
                "image_path": "res://Image/ViewpointImage/DorchesterStatue.png", 
                "description": "The Boer War Memorial stands crooked against the drifting mist, stubborn and tired, like a name half-forgotten. Beds of red impatiens ring its base, vivid against the stone, their color too sharp, like wounds left blooming in the gloom. Dorchester Square droops around it in silence, the benches slumping like broken backs, the trees whispering to one another in brittle voices. Across the cracked pathways, you catch glimpses of tiny crosses etched into the stones, scattered as if by lost hands. Beyond the iron fences, the city heaves and flickers, broken neon bleeding into the mist. It feels like a place the world forgot.... A patch of memory struggling not to vanish.", 
                "sound_path": "res://sound/description/Dorchester Square Statue.mp3"
            }, 
            "Building": {
                "image_path": "res://Image/ViewpointImage/DorchesterBuilding.png", 
                "description": "An old stone building rises alone by the edge of Dorchester Square, its walls cracked and worn by endless Montreal winters. It stands small and stubborn, a forgotten cherub surrounded by the steel giants of the city. A tired neon sign buzzes weakly against the facade, casting a sickly red glow: OUVERT. The letters flicker as if struggling to believe themselves. Its few windows, clouded and grime-streaked, offer no hint of life inside, only the heavy silence of a place long forgotten.", 
                "sound_path": "res://sound/description/Dorchester Square Building.mp3"
            }, 
            "Sunlife": {
                "image_path": "res://Image/ViewpointImage/DorchesterSunLife.png", 
                "description": "The Sun Life Building towers over Dorchester Square, its immense stonework standing as a monument to a colder age of wealth and power. It looms in stillness, vast and unmoving, while the city around it pulses with restless neon and noise. Once the tallest building in the entire British Empire, it carries that memory like a last ember of warmth, buried beneath the stone and silence.", 
                "sound_path": "res://sound/description/Dorchester Square SunLife.mp3"
            }
        }, 
        "connected_zones": ["Downtown Montreal", "Dorchester Square Building", "Rue de la Cathédrale"], 
        "characters": []
    }, 





    "Dorchester Square Building": {
        "zone_name": "DorchesterSquareBuilding", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/DorchesterInterior.png", 
                "description": "Inside the stone building, the air feels thick, stale, almost oily against the skin. Faint neon from outside leaks through tall, grimy windows, smearing sick pinks and bruised blues across the cracked floor. The tiles underfoot are uneven, scarred by years of neglect, some darkened by stains that have long since dried into memory. A narrow, rust-bitten stairwell curls downward into a pit of shadow, the railings cold and slick to the touch. The building holds its breath in a silence so complete it feels heavy. Yet from the mouth of the stairwell rises the faintest sliver of sound, a low and uncertain hum, as if something far below was still dreaming.", 
                "sound_path": "res://sound/description/DorchesterInterior.mp3"
            }, 
        }, 
        "connected_zones": ["Dorchester Square", "Dorchester Square Building, Stairwell 1"], 
        "characters": []
    }, 

    "Dorchester Square Building, Stairwell 1": {
        "zone_name": "DorchesterSquareBuildingStairwell1", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/DorchesterSquareBuildingStairwell1.png", 
                "description": "The spiral staircase sinks into the earth like a wound left to fester. The walls, once carefully laid with stone, have sagged inward over time, their surfaces bruised by moisture and stained with splashes of old, faded colors that seem neither natural nor deliberate. A crude iron railing traces the curve downward, bent in places, slick with cold. The steps themselves are worn thin, their centers hollowed by decades of uncertain footsteps, the stone darkened with grime and something older. At the bottom, the stairwell disappears into a perfect black, a heavy and unnatural darkness that seems to breathe against the walls. The hum you heard above is stronger here, a deep and broken vibration, too low for comfort, as if the building itself were whispering into the hollow of the earth.", 
                "sound_path": "res://sound/description/DorchesterSquareBuildingStairwell1.mp3"
            }, 
        }, 
        "connected_zones": ["Dorchester Square Building", "Dorchester Square Building, Stairwell 2"], 
        "characters": []
    }, 

    "Dorchester Square Building, Stairwell 2": {
        "zone_name": "DorchesterSquareBuildingStairwell2", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/DorchesterSquareBuildingStairwell2.png", 
                "description": "The stairwell coils downward, tighter and steeper with every step, until the walls seem to lean inward and the ground tilts beneath your feet. A faint dizziness clings to you, persistent and unwelcome, like the world itself is listing to one side. The silence breaks at the edges, where the low hum you first heard has thickened into a heavy purr, fast and rhythmic, alive in a way that feels almost feral. For a long while there is only darkness, pressing and absolute, but then a flickering light appears far below. It stains the stone in sickly patches of gold, wavering as if it breathes. The illusion of abandonment unravels. Beneath the grime, the chipped stone, and the years of dust, there is a trace of care, deliberate and careful. Someone still tends to this place. Not enough to comfort. Only enough to remind you that you are not alone.", 
                "sound_path": "res://sound/description/DorchesterSquareBuildingStairwell2.mp3"
            }, 
        }, 
        "connected_zones": ["Dorchester Square Building, Stairwell 1", "Dorchester Square Building, Stairwell 3"], 
        "characters": []
    }, 

    "Dorchester Square Building, Stairwell 3": {
        "zone_name": "DorchesterSquareBuildingStairwell3", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/DorchesterSquareBuildingStairwell3.png", 
                "description": "The stairwell bends and spills you onto a narrow platform, a ledge of battered stone barely clinging to the wall. The air grows heavier with each step, carrying a slow vibration that presses against your skin. The walls bleed muted colors that shift and shimmer at the edge of sight, too deep and too worn to catch clearly. The unease is no longer something you can shake off. It gathers around you, dense and rhythmic, thrumming through the stone underfoot. Far below, a sound rises, slow at first, then faster, shaping itself into something almost familiar. The tremors climb the railings, brushing your fingertips, moving through the soles of your boots. For a moment, standing still, you can almost mistake it for the breath of the earth itself. Then, between two beats, it sharpens. This is not the whisper of forgotten stone or the groan of empty tunnels. It is music. Heavy, alive, wild, spilling upward from somewhere unseen. Something waits down there, and it is already awake.", 
                "sound_path": "res://sound/description/DorchesterSquareBuildingStairwell3.mp3"
            }, 
        }, 
        "connected_zones": ["Dorchester Square Building, Stairwell 2", "Dorchester Square Building, Stairwell 4"], 
        "characters": []
    }, 

    "Dorchester Square Building, Stairwell 4": {
        "zone_name": "DorchesterSquareBuildingStairwell4", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/DorchesterSquareBuildingStairwell4.png", 
                "description": "The stairwell uncoils at last, spitting you onto a narrow landing carved into the rock. A door waits there, heavy and battered, leaning slightly on its hinges like it is just as tired of holding back the noise as you are of chasing it. The music is louder now, thick and pulsing through the cracks, but the door remains stubborn, unmoved, offering no grand revelation. No final warning. Just wood, stone, and the sound of something on the other side having a much better time than you are. For a moment, everything you carried with you on the way down, all the tension and expectation, hangs uselessly in the air. The only thing left to do is knock, or push, or turn back. If you still remember how.", 
                "sound_path": "res://sound/description/DorchesterSquareBuildingStairwell4.mp3"
            }, 
        }, 
        "connected_zones": ["Dorchester Square Building, Stairwell 3", "Crypt Club"], 
        "characters": []
    }, 

    "Crypt Club": {
        "zone_name": "DorchesterSquareBuildingStairwell4", 
        "default_viewpoint": "Front", 
        "category": "Club001", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Front": {
                "image_path": "res://Image/ViewpointImage/CryptClubEntrance.png", 
                "description": "The door gives way, and the world bursts open. Color spills across the stone like liquor. Red velvet couches sag under murmuring bodies, sharp laughter cuts through the thick air, and the vaulted ceilings, carved long ago for another purpose, catch every flicker of neon. The walls still remember. This was a crypt once, or something close to it, and no amount of light or music has chased away the cold in the stone. The music pounds, not just heard but felt through the bones of the floor. Smoke coils through the crowd, softening faces that seem too still, too poised, like statues warmed back to life. Conversations crash together in a tide of hunger and longing, sharp and bright against the dark. This is the pulse of the city. Not the towers, not the monuments, but here, underground, hidden among old bones, burning itself bright enough to be seen by the dead.", 
                "sound_path": "res://sound/description/CryptClubEntrance.mp3"
            }, 
            "Back": {
                "image_path": "res://Image/ViewpointImage/CryptClubBack.png", 
                "description": "At the far end of the club, the chaos gives way to a strange clearing. A dance floor sprawls under the old stone arches, slick with neon reflections, pounding with the heavy breath of the music. In the center, absurd and immovable, stands a throne. Blood-red velvet, cracked gold trim, the kind of thing that should belong to a fever dream or a failed revolution, not here among the sweat and bass.\tThe dancers twist and lurch around it, caught in the music, never touching, never even glancing at the thing. It does not belong, but it does not care. It watches, heavy and smug, basking in a ceremony nobody remembers starting."\
, 
                "sound_path": "res://sound/description/CryptClubBack.mp3"
            }
        }, 
        "connected_zones": ["Dorchester Square Building, Stairwell 4"], 
        "characters": []
    }, 




    "Rue de la Cathédrale": {
        "zone_name": "RuedelaCathédrale", 
        "default_viewpoint": "main", 
        "category": "montreal_high_outside", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/RueDeLaCathedrale.png", 
                "description": "The \"Rue de la Cathédrale\" curls along the edge of the \"Basilique Marie-Reine-du-Monde\", slick with rain and humming faintly under old streetlights.\n\nThe basilica itself rises in heavy, baroque lines, its domes and crosses clawing at a sky smeared with neon and soot. For a moment, it almost feels like the world should still be bending to it.\n\nBut the city has grown around it like a tide swallowing a rock.\n\nOn one side, the Sun Life Building, cold and massive, watches with the patience of an old king. On the other, the \"1000 de la Gauchetière\" scrapes the mist with its sterile glass bones. Together they pin the basilica in place, a monument to a grandiosity nobody has time for anymore.\n\nThe lights of the street stutter in the puddles. Somewhere farther off, a car coughs and dies in the distance. The old church stands silent, proud, and strangely small, like a voice trying to shout through a storm that has already moved on."\
\
\
\
, 
                "sound_path": "res://sound/description/RueDeLaCathedrale.mp3"
            }
        }, 
        "connected_zones": ["1000 de la Gauchetière", "Dorchester Square"], 
        "characters": []
    }, 


    "1000 de la Gauchetière": {
        "zone_name": "Gauchetiere", 
        "default_viewpoint": "Outer", 
        "category": "montreal_high_outside", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Outer": {
                "image_path": "res://Image/ViewpointImage/GauchetiereOuter.png", 
                "description": "At \"1000 de la Gauchetière\", the building gave up a long ago.\n\n\tIt is no longer a landmark. It is no longer a vision of the future.\n\n\tIt is a passage, a lobby, a slightly cleaner shortcut to the Bonaventure Metro tucked inside its bones.\n\n\tFootsteps fill the atrium, fast and careless. The city's blood pumping through marble floors and glass walls, never stopping to look around.\n\n\tAbove it all, the skating rink drifts in slow, ridiculous circles. A museum piece nobody asked for, spinning endlessly under lights that forget to shine.\n\n\tThe building no longer pretends to matter.\n\n\tIt holds the Metro in its gut, lets the city pass through its ribs, and stands there. A shell of ambition, pressed flat under all the weight it was supposed to carry."\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/GauchetiereOuter.mp3"
            }, 
            "Entrance": {
                "image_path": "res://Image/ViewpointImage/GauchetiereInner.png", 
                "description": "The entrance to \"Mille de la Gauchetière\" stands under the cold streetlights, its name stretched wide above the revolving doors in bold, aging letters.\n\n\tThere is no sign for the Metro. No hint that Bonaventure, the real reason anyone comes here, lies buried just beyond the glass.\n\n\tOnly the building’s own name, flaunted with the stubbornness of something too proud to admit it has been reduced to a hallway.\n\n\tOut of jealousy... out of spite, it offers no directions.\n\n\tIf you do not already know, you are not invited to learn.\n\n\tA few homeless figures drift near the entrance, quiet and half-seen, blending into the stone and glass like old stains."\
\
\
\
\
, 
                "sound_path": "res://sound/description/GauchetiereInner.mp3"
            }
        }, 
        "connected_zones": ["Rue de la Cathédrale", "Downtown Montreal", "Bonaventure Metro"], 
        "characters": []
    }, 






    "North Metro Maintenance Tunnels": {
        "zone_name": "North Metro Maintenance Tunnels", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/North-metro-maintenance-tunnels.png", 
                "description": "The tunnels in this section are narrow, the kind of space that forces shoulders to brush against damp, sweating walls. Old maintenance signage, rusted beyond legibility, clings crookedly to the concrete. The air hangs heavy, stagnant, carrying the tang of mildew, corroded metal, and the faint rot of something not entirely organic. Faded yellow paint still marks the floor’s edge where workers once walked, though in places it’s been worn down to bare stone by something dragging itself through, back and forth, over and over.\n\nPipes line the ceiling, many dripping in steady, echoing droplets, and electrical conduits snake along the walls with their insulation peeling away like old skin. Fluorescent tubes remain in their cages, but none have glowed for years; the only light comes in uneven shafts through corroded grates above, casting broken patterns of shadow.\n\nIt is in those shadows that an infestation breathes; cold, grave-like chill stealing over you as you realize that you are not alone in these tunnels. Something is hunting you."\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Saint-Michel Metro", "Saint-Michel Metro - Exterior", "Namur Metro"], 
        "characters": []
    }, 



    "Inbound Train": {
        "zone_name": "Inbound Train", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/metro-interior-blue-line.png", 
                "description": "The interior of the metro train feels a little worn, as if it's seen years of daily hustle and hurried journeys. The seats are a dull, faded blue, some with frayed edges or small stains that give away their age. The floor is a mix of scraped tiles and grimy patches where feet have dragged across, creating an uneven, rough surface underfoot. The air is thick with a blend of sweat, cologne, and the metallic scent of the train’s inner workings.\n\nThe overhead lights flicker occasionally, casting a dim glow over the passengers who are huddled in their own little worlds. Some wear headphones, eyes glazed over, while others stare out the fogged-up windows that are streaked with grime. The graffiti-tagged poles and walls are a stark contrast to the sterile cleanliness of the newer trains further up the line. Every so often, the train jerks forward with an unsettling squeal of metal, rattling those who are too tired to brace themselves.\n\nAt the back of the car, the atmosphere shifts. The clattering sound of heels and casual chatter grows louder as the train moves closer to downtown. The passengers’ attire shifts too—rough, faded jackets and scuffed shoes turn into sharp business suits and polished leather bags. There’s a subtle, almost imperceptible change in the air, as if the city’s pulse picks up with every passing station.\n\nThrough the windows, the view changes. Where graffiti once covered the walls, bright billboards and clean, glass buildings begin to rise, signaling the transition from gritty neighborhoods to gleaming downtown. The sounds, too, change—a cacophony of city noises—while the inside of the train feels the last remnants of the seedy edge slowly being swallowed by the buzz of the city’s heart."\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Saint-Michel Metro", "Namur Metro", "Bonaventure Metro", "South Metro Maintenance Tunnels"], 
        "characters": [], 
        "secret_entry_passwords": ["Inbound"], 
        "accessible_from_zones": ["Bonaventure Metro", "Saint-Michel Metro", "Namur Metro", "Place des Arts Metro"]
    }, 


    "South Metro Maintenance Tunnels": {
        "zone_name": "South Metro Maintenance Tunnels", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/south-metro-maintenane-tunnel.png", 
                "description": "The tunnels run like forgotten arteries beneath the city, a world abandoned by the living but not yet emptied of presence. The walls are poured concrete, flaking in places where water seeps through hairline cracks, leaving long rust-colored streaks that look like veins. Pipes line the ceilings and walls, some groaning faintly with the weight of water, others long dead, their joints crusted with mineral blooms. Every sound—the drip of condensation, the shuffle of rats, the distant echo of machinery from far-off lines—multiplies in the narrow space until it feels like the air itself is listening.\n\nStray light leaks in through grated vents, thin and broken, striping the darkness with pale shafts that reveal fragments: a discarded glove stiffened with age, a broken radio half-sunk in grime, a service hatch with its lock twisted long ago. Spray-painted symbols in layers mark the walls, some crude tags, others stranger—circles, arrows, or cryptic initials—hinting at the passage of those who use the tunnels for purposes not listed in any municipal records.\n\nThe air carries the sour tang of mold and rust, undercut by something faintly chemical, as if old spills have never fully dried. Here and there, the walls open into side corridors blocked by collapsed debris, or doorways leading into pitch-black service rooms, their contents long since stripped or scattered. The silence is never absolute; there is always a suggestion of motion at the edge of hearing, as if the tunnels breathe with their own hidden rhythm.\n\nIt feels less like a place of work and more like a buried labyrinth, a place where the city hides what it cannot dispose of: histories, secrets, and perhaps things that were never meant to be found."\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Place des Arts Metro", "Bonaventure Metro", "Inbound Train"], 
        "characters": [], 
    }, 


    "Outbound Train": {
        "zone_name": "Outbound Train", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/metro-orange-line.png", 
                "description": "The train hums like a tired heartbeat, carrying its cargo of lives through the city’s hidden veins. Light flickers in the windows, not steady, but fractured—brief flashes of tiled walls, black tunnels, and the blur of stations sliding past. The car itself feels like a vessel between worlds: plastic seats etched with names long forgotten, a floor scuffed into a dull map of footsteps that once pressed here and moved on.\n\nEach stop exhales a different breath. In the low-income district, the train swells with weary shoulders, work boots streaked with dust, the faint smell of sweat and machine oil. Voices murmur low, some trailing into silence as heads rest against rattling glass. As the train pushes deeper, the cadence shifts. Bags filled with produce and spices rustle against knees. A lullaby in a language not native to the city threads through the clatter of wheels. The air changes subtly, carrying the warmth of kitchens, of markets, of home carried on the body.\n\nThe faces in the car hold fragments of stories that do not meet each other’s eyes, yet share the same dim light, the same metal floor, the same unrelenting forward motion. It is a passage not just of geography but of belonging—the line itself a bridge between margins, each stop a threshold where one life fades into another."\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Bonaventure Metro", "Namur Metro", "Saint-Michel Metro", "North Metro Maintenance Tunnels"], 
        "characters": [], 
        "secret_entry_passwords": ["Outbound"], 
        "accessible_from_zones": ["Bonaventure Metro", "Saint-Michel Metro", "Namur Metro", "Place des Arts Metro"]
    }, 


    "Place des Arts Metro": {
        "zone_name": "Place des Arts Metro", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/place-des-arts-metro.png", 
                "description": "Beneath the city, Place-des-Arts station feels less like a passage for commuters and more like a cavern of forgetting. The concrete vaults arch above in heavy silence, their surfaces dulled to a shadowed grey. The lighting is uneven—fluorescent tubes flicker in pale rhythms, some humming faintly, others extinguished long ago, leaving stretches of platform in semi-darkness. Each patch of shadow seems deeper than it should be, as though the station breathes in long, heavy pauses.\n\nThe tiled walls reflect almost nothing. Their surfaces are scuffed, dulled, faintly damp, and in certain angles the patterns of stains resemble faces—blurred and mournful, never quite clear enough to focus on. Footsteps echo strangely here, not cleanly but stretched, as if someone else is walking just a fraction of a beat behind you. The sound of a train approaching grows into a howl through the tunnels, metallic and ragged, then diminishes too quickly, leaving a hollow quiet that presses on the chest."\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Namur Metro", "Bonaventure Metro", "Saint-Michel Metro", "Underground City", "South Metro Maintenance Tunnels"], 
        "characters": [], 
    }, 




    "Namur Metro": {
        "zone_name": "NamurMetro", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Line": {
                "image_path": "res://Image/ViewpointImage/NamurLine.png", 
                "description": "Namur s’endort dans l’écho des wagons,\n\tSes murs suintent l’hiver, la peur, le silence,\n\tChaque marche résonne un vieux nom,\n\tUne plainte oubliée sans délivrance.\n\n\tLe sol est fendu comme un cœur trop battu,\n\tL’air sent la rouille, la pluie, les adieux,\n\tQuelque chose attend, tapi, jamais vu,\n\tSous les pierres noircies, sous les cieux creux.\n\n\tIci le temps se courbe et se confesse,\n\tLes pas s’égarent, avalés sans retour.\n\tNamur conserve en elle une promesse :\n\tQu’un jour tout s’effondre. Même l’amour."\
\
\
\
\
\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/NamurLine.mp3"
            }, 
            "Main": {
                "image_path": "res://Image/ViewpointImage/NamurInterior.png", 
                "description": "Most people don’t really notice Namur. It’s not the kind of station that asks to be remembered.\n\n\tBuried under layers of concrete and old decisions, it sits quiet, a little stained, a little out of step.\n\n\tThe ceiling’s strange geometry hangs overhead like a question no one wants answered. The floors are always damp, the walls feel older than they should, and the turnstiles creak like they’ve been spinning since the '70s.\n\n\tNothing here feels urgent. It’s just another stop. Tired, but still working.\n\n\tNamur has the look of a place that used to matter a little more. Maybe it never did. It holds onto that uncertain feeling, like waiting for a train that’s technically on time but somehow never coming.\n\n\tThe lighting is off, the signs a bit faded, but the rhythm continues. People come and go, lost in their own loops.\n\n\tAnd the station keeps doing what it always has: carrying the weight of a city that doesn’t look back much. Not because it’s too bold to remember, but because memory takes time, and nobody here has any to spare."\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/NamurInterior.mp3"
            }
        }, 
        "connected_zones": ["Bonaventure Metro", "Place des Arts Metro", "Saint-Michel Metro", "Décarie Sector", "North Metro Maintenance Tunnels"], 
        "characters": []
    }, 


    "Décarie Sector": {
        "zone_name": "DecarieSector", 
        "default_viewpoint": "namur_outside", 
        "category": "montreal_high_outside", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Outside Namur Station": {
                "image_path": "res://Image/ViewpointImage/NamurOutside.png", 
                "description": "Namur doesn’t try to impress. A squat metro entrance tucked just off the Décarie, half-drowned in the noise of traffic and long-haul fatigue.\n\n\tThe building looks like it’s been standing still while the city forgets how to. Concrete walls stained with time, glass that reflects more past than present.\n\n\tThe glowing “MÉTRO” sign does its best to suggest function, but it’s the only thing here pretending to be awake.\n\n\tPeople don’t come to Namur for what’s on her side. They cross the street, cross the highway, toward something else entirely.\n\n\tIn the distance, the Orange Julep hums like a roadside relic, its glow leaking into the mist like a memory that won’t settle.\n\n\tA little farther, the old Blue Bonnets grounds stain the sky with a cold electric haze.\n\n\tIt’s almost funny: Namur is the stop, but everything people want is just beyond it.\n\n\tStill, the station stays. Not out of pride, not out of hope, just because that’s what it’s always done. Stand still, open late, and wait for someone heading somewhere else."\
\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/NamurOutside.mp3"
            }, 
            "Above Décarie Crossing": {
                "image_path": "res://Image/ViewpointImage/DecarieCrossing.png", 
                "description": "The overpass above the Décarie looks like any other slab of city infrastructure: useful, ignored, and falling apart in just the right ways.\n\n\tBy day, it’s a bottleneck of metal and misery, the rat race compressing itself into four narrow lanes of deadlock and frustration.\n\n\tHorns blare, tempers crack, and the sun bakes it all like a bad idea left out too long.\n\n\tBut by night? It’s almost peaceful. Empty, echoing, like the city held its breath and forgot to exhale. A few “vroom-vroom” and “beep-beep” there.\n\n\tNobody walks here after dark unless they have to. The lights hum. The rails are rusted. The concrete feels like it remembers things you’d rather not.\n\n\tIn the distance, buildings flicker in and out of view, their windows glowing like half-lidded eyes.\n\n\tIt’s not dangerous, not exactly. Just quiet in a way that makes you think too long.\n\n\tMost people stay inside when it gets like this. Not out of fear. Just instinct."\
\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/DecarieCrossing.mp3"
            }
        }, 
        "connected_zones": ["Namur Metro", "Orange Julep", "Blue Bonnets", "Côte-des-Neiges"], 
        "characters": []
    }, 

    "Orange Julep": {
        "zone_name": "OrangeJulep", 
        "default_viewpoint": "main", 
        "category": "montreal_high_outside", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/OrangeJulep.png", 
                "description": "The Orange Julep squats by the side of the Décarie Expressway, an enormous, fucking massive orange dropped into a city too tired to wonder why.\n\n\tIts surface is cracked and battered, drinking in the sour light of the streetlamps, a bloated relic that refuses to die.\n\n\tStrips of torn bunting twitch in the oily wind, clinging to rusted poles like old party favors from a celebration everyone forgot.\n\n\tThe highway groans without pause. Angry honks and screeching tires rise into the mist, swallowed by the night.\n\n\tFarther off, the lights of the old Blue Bonnets racetrack stab at the darkness, too clean, too empty, a carnival with no music.\n\n\tAnd yet, they still come.\n\n\tA thin line of patrons stretches from the service windows, hands shoved deep in their pockets, shoulders hunched against the rain.\n\n\tThey queue for the only thing the Julep still offers: the Julep Special, a frothy orange drink whose recipe is a secret so fiercely guarded it might as well be sacred.\n\n\tNo menus, no questions. Just the ritual, played out under the cracked skin of the giant fruit."\
\
\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/OrangeJulep.mp3"
            }
        }, 
        "connected_zones": ["Décarie Sector", "Blue Bonnets"], 
        "characters": []
    }, 

    "Blue Bonnets": {
        "zone_name": "BlueBonnets", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/BlueBonnet.png", 
                "description": "Blue Bonnets runs most nights. Not packed, not empty. Just enough to keep the engines turning.\n\n\tThe track lights buzz overhead, casting long shadows across worn pavement and concrete bleachers.\n\n\tThe signage is old, the colors are faded, but everything still works. Vendors sell warm beer and paper bags of fries.\n\n\tThe regulars line the fence, eyes locked on the dirt. You can still feel the tension before a race. Quiet. Sharp. Real.\n\n\tIt’s not a destination, but it has gravity. People don’t come here to be impressed.\n\n\tThey come to get out of the house, to feel something quick and alive pass in front of them.\n\n\tThe crowd swells when a favorite pulls ahead. A few bills change hands just fast enough not to be noticed.\n\n\tNo one talks about history. No one needs to.\n\n\tBlue Bonnets is doing exactly what it's supposed to do: keep the night moving, one lap at a time."\
\
\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/BlueBonnet.mp3"
            }
        }, 
        "connected_zones": ["Orange Julep", "Décarie Sector", "Blue Bonnets : Entrance"], 
        "characters": []
    }, 

    "Blue Bonnets : Entrance": {
        "zone_name": "BlueBonnetsEntrance", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/BlueBonnetEntrance.png", 
                "description": "The entrance hall at Blue Bonnets is fine. Nothing special, nothing broken.\n\n\tFluorescent lights buzz overhead, some warmer than others.\n\n\tThe tiles along the wall are set in colored diamond patterns, probably meant to feel lively. They don’t. But they try.\n\n\tThere’s a hotdog stand tucked into one corner and a small ice cream spot near the far side, both half-open, half-bored.\n\n\tThe kind of places that don’t push you to buy anything. They just exist, like the rest of the space.\n\n\tThe air carries a mix of fried onions, sugar, and damp concrete.\n\n\tMost people pass through without thinking, heading straight for the track, but if you stop for a second, the quiet hum of it all settles into something almost comfortable.\n\n\tNot inviting. Just familiar."\
\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/BlueBonnetEntrance.mp3"
            }
        }, 
        "connected_zones": ["Blue Bonnets", "Blue Bonnets : Hall"], 
        "characters": []
    }, 


    "Blue Bonnets : Hall": {
        "zone_name": "BlueBonnetsHall1", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/BlueBonnetHall1.png", 
                "description": "Farther in, the hall splits. One path keeps going straight, past shuttered windows and cheap tile, toward the regular stands.\n\n\tThe other turns upward, an old escalator groaning beneath yellowed lights.\n\n\tA plaque on the wall reads *Le Centaure* in serif gold. It points toward the buffet upstairs. Quieter, cleaner, more expensive.\n\n\tPeople don’t always decide out loud. Some glance up, think about it, and keep walking. Others take the ride.\n\n\tUp there, the chairs are padded, the drinks don’t come in plastic, and the food isn’t half-bad.\n\n\tDown here, it’s louder, messier, more real.\n\n\tIt’s not about class so much as mood. The building doesn’t judge. It just waits for you to make your call."\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/BlueBonnetHall1.mp3"
            }
        }, 
        "connected_zones": ["Blue Bonnets : Entrance", "Blue Bonnets : Stands", "Blue Bonnets : Hall Centaur"], 
        "characters": []
    }, 


    "The Final Curve": {
        "zone_name": "The Final Curve", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/the-final-curve.png", 
                "description": "The Final Curve at Blue Bonnets isn't just another stretch of racetrack, it's the private den of the Blue Blood and Soil pack, hidden behind locked service doors beneath the grandstand. From the outside it looks like a maintenance wing, but inside it opens into a velvet-lit lounge with tinted windows overlooking the last turn where horses thunder by in a frenzy of speed. Plush leather booths line the walls, stained with wine and vitae, while tables are littered with betting slips, half-finished glasses, and the remnants of indulgences. The air hums with muffled jazz and the scent of blood, the roar of the mortal crowd outside reduced to a distant thrum as if the room exists apart from reality. Security is tight, ghouls watch the entrance, checking passes and eyes alike, while the locks are reinforced with steel and silver. For mortals, the space is a gilded VIP gallery; for Cainites, it's a playground dressed as civility, where predators drink, gamble, and scheme under the steady rhythm of hooves pounding the dirt just beyond the glass.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Blue Bonnets : Hall"], 
        "characters": [], 
        "secret_entry_passwords": ["Break the Quiet"], 
        "accessible_from_zones": ["Blue Bonnets : Hall"]
    }, 


    "Blue Bonnets : Stands": {
        "zone_name": "BlueBonnetsStands", 
        "default_viewpoint": "Stand 1", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Stand 1": {
                "image_path": "res://Image/ViewpointImage/BlueBonnetStand1.png", 
                "description": "The first set of stands is nothing fancy. Plastic seats, most of them scratched or cracked at the edges, some still warm from the last person who sat there.\n\n\tThe floor sticks a little. Someone always spills something. But the view is good! A full sweep of the track behind tall glass panels, streaked with fingerprints and the occasional lost flyer taped from the inside.\n\n\tThe lighting overhead hums with that soft, uneven flicker that settles into the back of your eyes if you sit too long.\n\n\tYou hear the muffled buzz of the announcer somewhere, mixed with the rustle of betting slips and casual arguments.\n\n\tNobody dresses up down here. They come for the race, the rhythm, the motion. No distractions. Just seats, a view, and the next heat lining up."\
\
\
\
, 
                "sound_path": "res://sound/description/BlueBonnetStand1.mp3"
            }, 
            "Stand 2": {
                "image_path": "res://Image/ViewpointImage/BlueBonnetStand2.png", 
                "description": "Farther in, the crowd thins out. The seats stretch on in long, quiet rows, and most of them are empty.\n\n\tThe lights overhead flicker less out of neglect and more from habit. Paint chips from the ceiling. Dust gathers near the far edges where nobody really sits anymore.\n\n\tThe smell here is older — part dry concrete, part paper, part stale snack grease that never fully leaves.\n\n\tOut the window, the track keeps moving. The glass is streaked, but the view holds.\n\n\tSunset bleeds across the sky and reflects in a dozen uneven panels, cutting the dirt track in amber and violet.\n\n\tThere's a monitor hanging from the ceiling, too far back to see clearly. No one seems to mind.\n\n\tThe regulars who end up in this part don’t need the screen. They’ve been coming long enough to know how to watch."\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/BlueBonnetStand2.mp3"
            }, 
            "Stand 3": {
                "image_path": "res://Image/ViewpointImage/BlueBonnetStand3.png", 
                "description": "The farther you go, the more it all starts to blur together. Row after row, seat after seat, same angle, same dust, same fluorescent hum from above.\n\n\tThe backs of the chairs are scuffed in the same places. The gum underneath is the same pale gray.\n\n\tTime doesn’t feel like it passes here so much as it loops. One lap, then another.\n\n\tThis part of the stands isn't empty out of neglect. It’s just quiet. Some people like it that way.\n\n\tYou can sit without talking. You can watch without being watched.\n\n\tYou hear the same horse names get called. The same bets placed. The same small reactions: cheers, groans, silence.\n\n\tMonotony isn’t failure here. It’s rhythm. It's what the building was made for."\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/BlueBonnetStand3.mp3"
            }
        }, 
        "connected_zones": ["Blue Bonnets : Hall"], 
        "characters": []
    }, 


    "Blue Bonnets : Hall Centaur": {
        "zone_name": "BlueBonnetsHallCentaur", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/BlueBonnetHallCentaur.png", 
                "description": "The stairs up to Le Centaure aren’t elegant. Just concrete and tile, lit by flickering strips of neon that shift between a tired red and a cold, humming blue.\n\n\tThe walls are close here, lined with stains that no one’s bothered to clean in a long time.\n\n\tThe air grows heavier with each step, like the oxygen’s been filtered through too many stories, none of them pleasant.\n\n\tYou start to hear less from the track below. The crowd noise fades. The footsteps echo longer.\n\n\tNo one says anything, but something about this stretch makes people straighten up a little. Like they’re being watched, or expected.\n\n\tThere’s no sign of luxury yet, just a narrow turn and another flight of stairs.\n\n\tStill, the name hangs in your mind: Le Centaure. Sounds classy. Feels distant."\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/BlueBonnetHallCentaur.mp3"
            }
        }, 
        "connected_zones": ["Blue Bonnets : Hall", "Le Centaure"], 
        "characters": []
    }, 

    "Le Centaure": {
        "zone_name": "LeCentaure", 
        "default_viewpoint": "Entrance", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Entrance": {
                "image_path": "res://Image/ViewpointImage/BlueBonnetCentaurEntrance.png", 
                "description": "This isn’t what you pictured. Le Centaure was supposed to be the nice part, the break from the grime.\n\n\tBut the first thing that greets you is silence. Not calm, but muffled, like the sound’s been drained out of the room on purpose.\n\n\tThe escalator behind you hums softly, empty. Ahead, the carpet is patterned and clean, but it feels damp underfoot. The kind of damp that doesn’t come from water.\n\n\tThere’s a wide glass wall, floor to ceiling, showing the track below. But the view doesn’t reassure. The lights outside flicker orange through the mist, each one oddly distant, like you're watching someone else's memory.\n\n\tThe air smells faintly of old plastic and something sweet gone wrong.\n\n\tNo one’s here to welcome you. No music plays. Just that strange hush, like the building is waiting to see who turns back first."\
\
\
\
\
, 
                "sound_path": "res://sound/description/BlueBonnetCentaurEntrance.mp3"
            }, 
            "Buffet": {
                "image_path": "res://Image/ViewpointImage/BlueBonnetCentaur.png", 
                "description": "The hallway opens up into what passes for the buffet. A long, glass counter reflects the light in soft golds and greens, warped by age and neglect.\n\n\tThe wallpaper peels near the ceiling, and a tired potted plant leans into the window like it's trying to escape.\n\n\tBut behind the counter, things are… alive.\n\n\tA small, well-dressed asian man with slicked-back hair and deep crow’s feet tends a hotplate, carefully twirling spaghetti with metal tongs like it’s a delicate art. The steam rises slowly, quietly.\n\n\tTo the side, a tall woman in a starched apron carves ham with practiced speed, her thick Russian accent slicing through the quiet each time she asks, 'Next?'\n\n\tNobody’s speaking much. The food smells fine. It looks fine. But the whole room feels like a performance running just a beat too slow. Like everyone involved knows the lines, but forgot what they meant.\n\n\tPast the buffet, the dining area stretches wide under a low ceiling and soft light. The carpet is thick and patterned, muting every step. Tables are arranged in gentle, orderly rows, dressed in white linen and set with silverware that never seems to tarnish.\n\n\tThere’s no host. No one takes your name. You simply find your place. And there’s always a place. No matter how many guests are seated, there’s always one more table waiting, clean and unclaimed.\n\n\tThe clinking of utensils is steady but low. Conversations stay hushed, almost rehearsed. A couple near the window eats in silence. A man in a grey suit pours himself wine from a bottle that wasn’t there a minute ago.\n\n\tNo one seems in a hurry. And though the room isn’t full, it feels occupied. Not crowded, just watched. As if the walls themselves are paying attention, just in case you forget where you are."\
\
\
\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/BlueBonnetCentaur.mp3"
            }
        }, 
        "connected_zones": ["Blue Bonnets : Hall Centaur"], 
        "characters": []
    }, 
















"Boulevard Industriel": {
    "zone_name": "MontrealNordBoulevardIndustriel", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/MontrealNordBoulevardIndustriel.png", 
            "description": "Boulevard Industriel sinks into itself after dark. The factories stand hollow, rust curling up their sides, dock doors left half open like yawns that never finish.\nWeed-choked lots stretch between broken fences. The rail line murmurs low, but never stops for anyone.\nInside, the air tastes like metal and time. Fluorescents twitch overhead. Machinery sleeps under tarps that shift when no one’s near.\nIt’s quiet, mostly. Then something creaks. Then nothing again.\nYou were sure this place was empty. You’re less sure now.", 
            "sound_path": "res://sound/description/MontrealNordBoulevardIndustriel.mp3"
        }, 
        "Outside Factory 13": {
            "image_path": "res://Image/ViewpointImage/factory-13.png", 
            "description": "Factory 13 looms at the heart of the derelict industrial sector like a monument to exhaustion. Its brick skin is flaking, scabbed with rust where pipes once gleamed, and its broken windows gape like a hundred hollow eyes. The number itself — 13 — still stenciled in faded white above the main doors, is more curse than label, as though the place always knew what it would become.\nThe warehouses flanking it are no better — long, gutted husks with roofs caved in, skeletal beams exposed against the sky. Loading docks yawn open, their ramps sagging, concrete chipped and scarred from decades of disuse. Grass pushes through fissures in the asphalt, and the air smells faintly of ash, oil, and mildew — as if the entire district is slowly rotting in place.", 
            "sound_path": "res://sound/description/MontrealNordBoulevardIndustriel.mp3"
        }, 
        "Between the Warehouses": {
            "image_path": "res://Image/ViewpointImage/between-warehouses-industriel.png", 
            "description": "The alleys stretch like veins between the hulks of abandoned warehouses, long chasms of brick and rust where sunlight dies quickly. Cracked pavement buckles under the weight of weeds pushing through, their roots blackened by oil and old runoff. The air tastes metallic, tinged with mildew and forgotten chemicals, as though the buildings still exhale the labor of another age.\nGraffiti climbs the walls in layers, words and sigils half-scrubbed away, some in scripts no one admits to knowing. Rusted pipes and fire escapes curl downward like broken ribs, their shadows quivering across puddles that never seem to dry. Rats move here in nervous bursts, as though wary of something larger, unseen.", 
            "sound_path": "res://sound/description/MontrealNordBoulevardIndustriel.mp3"
        }
    }, 
    "connected_zones": ["Montréal-Nord"], 
    "characters": []
}, 



    "Factory 13": {
        "zone_name": "Factory 13", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/factory-13-interior.png", 
                "description": "The factory squats at the edge of the city like a rusted carcass, its windows long since shattered, its walls tattooed with graffiti and peeling paint. Inside, the air is thick with chemical rot and the ghost of machine oil, as if the building remembers when its veins ran hot with labor. Now, instead of conveyor belts and sparks, there are only broken mattresses, scavenged couches, and bodies slumped in shadows.\nA single lantern flickers where the roof leaks, light trembling across faces gaunt and hollow-eyed. Pipes drip steadily, their rhythm joining the low murmur of whispers — though not all belong to the living. Some corners hum faintly, as though voices are caught in the walls, carried along rusted ducts that once fed machines.\nThe addicts drift in and out of stupor, but their nodding heads sometimes turn in unison, as though listening to something beneath the drone of their own breath. Shadows move too easily across the floor, stretching like fingers, curling over bare ankles. In the dark beyond the lantern, a draft stirs with the scent of iron and damp stone — not from the factory, but from somewhere deeper, somewhere below.\nThose who stay too long claim to see lights sparking in the rafters, blue and insectile, flaring like the memory of welding torches. Others whisper that the walls throb faintly, as if the factory were still alive, feeding on the lives squandered here. Nobody leaves unchanged: some stagger out with hollow eyes, muttering prayers to gods they never believed in; others never make it to the door, claimed by the silence that waits between each drip of the leaking pipes.", 
                "sound_path": "res://sound/description/MontrealNordBoulevardIndustriel.mp3"
            }
        }, 
        "connected_zones": ["Boulevard Industriel"], 
        "characters": []
    }, 



    "Alexander's Haven": {
        "zone_name": "Alexander's Haven", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/alex_haven.png", 
                "description": "The exterior of the row home is plain and unremarkable—easy to overlook, blending into its surroundings. Nothing about it draws attention.\n"\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Montréal-Nord", "Alex's Place: Living Room"], 
        "characters": [], 
        "secret_entry_passwords": ["Tobias"], 
        "accessible_from_zones": ["Montréal-Nord"]
    }, 


    "Alex's Place: Living Room": {
        "zone_name": "Alex's Place: Living Room", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/alex_livingroom.png", 
                "description": "The interior of the home opens into a sparse living space. Two large, comfortable couches face a modest coffee table, with a television and stereo nearby. The windows are smothered by thick, heavy curtains, sealing out every trace of daylight and creating an atmosphere of quiet seclusion.\n"\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Alexander's Haven", "Alex's Place: Kitchen", "Alex's Place: Garden", "Alex's Place: Bedroom"], 
        "characters": []
    }, 


    "Alex's Place: Kitchen": {
        "zone_name": "Alex's Place: Kitchen", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/alex_kitchen.png", 
                "description": "Almost barren in appearance, the kitchen holds little more than a cooker/oven and two dog bowls on the floor. The fridge is stocked with blood bags, some of them mixed with drugs. The room carries a sterile emptiness, more functional than lived-in.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Alex's Place: Living Room"], 
        "characters": []
    }, 


    "Alex's Place: Garden": {
        "zone_name": "Alex's Place: Garden", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/alex_garden.png", 
                "description": "A closed-off yard where two more dog bowls sit alongside a small, cozy doghouse. This is usually where Tobias, the dog, can be found when he’s not accompanying Alexander to the church", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Alex's Place: Living Room"], 
        "characters": []
    }, 


    "Alex's Place: Bedroom": {
        "zone_name": "Alex's Place: Bedroom", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/alex_bedroom.png", 
                "description": "The bedroom is the heart of the haven, rich with personality. Tapestries hang across the walls, and the windows are heavily veiled with layers of thick curtains and additional coverings, ensuring total darkness. The floor is covered with soft carpet.\n\nA large desk sits against one wall, cluttered with sketches—anatomical drawings, viscerally detailed plans for fleshcrafting, and other artwork inspired by Alexander’s experiences. Above it, accessible by a ladder, rests a lofted bed. Its high, raised sides and thick bedding give it the feeling of a warm, enclosed nest.\n\nThe walk-in wardrobe is packed with an extensive collection of clothing, and the bookshelves lining the walls are filled to capacity—medical research texts, works on anatomy and art, and countless volumes of fiction and stories."\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Alex's Place: Living Room"], 
        "characters": []
    }, 


    "Alex's Place: Lab": {
        "zone_name": "Alex's Place: Lab", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/alex_lab.png", 
                "description": "Behind a secret panel in the walk-in wardrobe, is revealed a small, tiled room with a single drain in the floor, set up as a perfect laboratory space for a surgeon... or perhaps, an at home morgue.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Alex's Place: Bedroom"], 
        "characters": [], 
        "secret_entry_passwords": ["Lab"], 
        "accessible_from_zones": ["Alex's Place: Bedroom"]
    }, 





    "Old Montreal": {
        "zone_name": "OldMontreal", 
        "default_viewpoint": "main", 
        "category": "montreal_high_outside", 
        "is_neighborhood": true, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/OldMontreal.png", 
                "description": "Old Montreal doesn’t sleep. It waits. Quietly. With precision.\n\n\tThe streets are narrow and ceremonial, lined with facades too symmetrical to be human. Stone and brick arranged like commandments. Balconies twist in cold flourishes. Gas lamps cast soft halos through rising mist. Neon from the port seeps across the windows, smearing false color on old-world geometry. It looks preserved. It feels enforced.\n\n\tBeneath your feet, the paving stones click in patterns that don’t repeat. You hear church bells from two directions, ringing out of sync. Latin inscriptions blur under moss and rain. You read them anyway. You’re not sure why. The river murmurs against the edge of the city, but the real tide is in the walls.\n\n\tThere is no skyline here, only hierarchy. The cathedrals loom without metaphor. The courts have weight even when empty. Somewhere behind those windows, there are still names being spoken in dead dialects. Paper trails older than you snake through vaults that never open. Everything has been signed already. You’re just walking through the aftermath."\
\
\
, 
                "sound_path": "res://sound/description/OldMontreal.mp3"
            }
        }, 
        "connected_zones": ["Rue Saint Pierre", "Lachine Canal", "Downtown Montreal", "Pointe-du-Moulin", "Centre-Sud", "Sud-Ouest"], 
        "characters": []
    }, 



    "Librairie Bertrand": {
        "zone_name": "Librairie Bertrand", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Librarie_Betrand.png", 
                "description": "Quiet, the scent of paper & ink floods into your nose. The building holds a ginger warmth, a reminder of the day before in it. English & French books line the shelves in equal measure. With long halls of bookshelves & large open windows that bare its interior fully to the outside world. For those who'd call themselves Cainites, it reeks of a lack of privacy. The only hope to feed being tired people in the night or those perusing late at night. \n\nSometimes an attendent can be rarely seen on the weekends, though they largely pay people no mind as long as no visible crimes or attempted theft is being undertaken."\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Rue Saint Pierre", "Librairie Bertrand Basement"], 
        "characters": []
    }, 


    "Librairie Bertrand Basement": {
        "zone_name": "Librairie Bertrand Basement", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Librarie_Bertrand_Basement.png", 
                "description": "It's a little warm down here, though not damp. Books tower around you, all collections & older books that need protecting, things that are actually considered valuable. It's finely kept, but eerily silent, if one looks amongst some of the bookshelves. Jars of teeth can be found, a small storage closet holds a vacuum, a broom & has a floor of bloodstained black brick.\n\nA singular drain lies the center of it, looking recently installed. It does not take a genius to figure out something is WRONG here."\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Librairie Betrand"], 
        "characters": [], 
        "secret_entry_passwords": ["Penknife"], 
        "accessible_from_zones": ["Librairie Bertrand"]
    }, 


    "Saint-Pierre-Apôtre Church": {
        "zone_name": "Saint-Pierre-Apôtre Church", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Saint-Pierre_Church.png", 
                "description": "Countless people flood this Roman Catholic church, there's a frenetic energy to the place. The gloom that characterizes Rue Saint Pierre feels so far away when one enters. A newly constructed bell tower that rings out in triumph. A church of thirty six stained glass windows, a church dedicated to Saint Peter. \n\nA church that has been declared?\n\nO p e n.\n\nEveryone welcomed: remarried, divorced or homosexual. Brunches are held after mass, workshops offered on queer themes & what had seemed to many to be a controversial choice. Feels already like it was the only right choice, amongst a city that suffocates many kine feel like they can finally breathe within these walls.\n\nWhile Cainites feel uncomfortable, in a place where faith abounds bright & strong."\
\
\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Rue Saint Pierre"], 
        "characters": []
    }, 


    "Rue Saint Pierre": {
        "zone_name": "Rue Saint Pierre", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Rue-saint-pierre.png", 
                "description": "Once the 'Wall Street' of Montreal, built over the Saint Pierre river. This busy throughfare was the heart of old Montreal & is still a significant part of the Lower Town. Yet a gloom hangs over it, an uncertainty as bankers & shopkeepers steadily trickle out. As the last of the Industrial elements of what was once one of the most important parts of the city fade into irrelevance. \n\nRue Saint Pierre finds its opulent historical shops & buildings being transformed into apartments. Finds itself turning from everything, a place of power into a place defined by its subservience to others. \n\nNewly opening Hotels are being stuffed with tourists, restaurants dandy out mockeries of Montreals culture to the gullible. While countless turn to faith, as the churches power rises. Saint-Pierre-Apôtre Church is newly renovated, filling its pews with any & all, inclusive where other Roman Catholics might turn some away.\n\nTo all Cainites, a nagging feeling might be scratching at them. With this change comes a power vacuum, one that it feels something besides them is filling. Faith might not yet be dead in a street named for a Saint."\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Librairie Bertrand", "Saint-Pierre-Apôtre Church", "Old Montreal"], 
        "characters": []
    }, 



    "Hotel Soleil Levant Exterior": {
        "zone_name": "Hotel Exterior", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Hotel_Exterior.png", 
                "description": "This grand hotel looms above the street like a relic from another age. Its stone façade, once pristine, is now weather worn, and marred by the slow creep of ivy. Rows of tall, dark windows stare blankly outward, gaping maws that reveal nothing of the interior.\n\nAbove the entrance, a neon sign written in elegant cursive bears the name Le Soleil Levant. The letters sputter faintly, buzzing like dying insects. In the center of the sign, a small sun icon hangs crooked, its bulbs long burnt out; just one more broken promise,\n\nThough the street outside bustles with life, the space directly in front of the hotel always seems quiet, as if sound itself refuses to linger near the threshold."\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Old Montreal", "Hotel Soleil Levant Lobby"], 
        "characters": [], 
        "secret_entry_passwords": ["Welcome"], 
        "accessible_from_zones": ["Old Montreal"]
    }, 


    "Hotel Soleil Levant Lobby": {
        "zone_name": "Hotel Soleil Levant Lobby", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Hotel_Lobby.png", 
                "description": "The cavernous lobby stretches out in all directions. A picture of luxury left to decay. The onyx and marble mosaic covering the floor swirls in patterns that seem to shift when you look away, pulling the eye toward the sweeping staircases that ascend into shadow. \n\nA dilapidated fountain marks the center of the space, though its flow has slowed to a quiet trickle, and the marble statuette within has long since toppled over, pieces scattered throughout the basin.\n\nHigh above, the ceiling, once painted to look like the night sky, has now begun to crack and peel, gold-leaf stars gleaming like watchful eyes. A few chandeliers still hang, providing the space with light, though the glow feels cold and sterile.\n\nThe atmosphere is hushed, expectant, as though every footstep is being judged."\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Hotel Soleil Levant Exterior", "Hotel Soleil Levant Conference Room", "Hotel Soleil Levant Pool Room", ], 
        "characters": []
    }, 


    "Hotel Soleil Levant Conference Room": {
        "zone_name": "Hotel Conference Room", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Hotel_Conference_Room.png", 
                "description": "A long, wooden table stretches through the murky room. High backed chairs surround the table, and are themselves surrounded by a heavy darkness that the lone lamp hanging from the ceiling is unable to pierce. The table’s polished surface is disturbed by a single deep gouge that runs through its center towards the chair placed at its head, farthest from the door.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Hotel Soleil Levant Lobby"], 
        "characters": []
    }, 


    "Hotel Soleil Levant Pool Room": {
        "zone_name": "Pool Room", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Hotel_Soleil_Pool.png", 
                "description": "The pool’s empty basin stretches like an open grave through the middle of the room. The tiles faded and cracked in places, with stubborn dark stains spotted here and there. Around the edge is a velvet rope, half rotted away, with a gap just in front of the rusted ladder that serves as the pool’s sole entrance. An eclectic assortment of chairs ring around the outside of the barrier to form a spectating area.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Hotel Soleil Levant Lobby"], 
        "characters": []
    }, 


    "Hotel Soleil Levant Elevator": {
        "zone_name": "Hotel Elevator", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Hotel_Soleil_Elevator.png", 
                "description": "The elevator looks like it’s survived decades without a proper upgrade. The doors wheeze open unevenly, one side always lagging behind the other, revealing a cramped box lined with wood paneling that’s gone dull and scuffed. The brass rail is sticky to the touch, its shine long since rubbed away. The carpet underfoot is threadbare at the center, the pattern worn down to a flat gray, with faint stains that never seem to come out. A single fluorescent bulb buzzes overhead, casting a sickly glow that makes the space feel smaller than it is. The buttons are scratched, some with their numbers worn almost smooth, and a few light up weakly as though they’re struggling to stay alive. Every time the elevator lurches into motion, it shudders and rattles just enough to remind you it hasn’t been inspected in a while.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Hotel Soleil Levant Lobby"], 
        "characters": [], 
        "secret_entry_passwords": ["goingup"], 
        "accessible_from_zones": ["Hotel Soleil Levant Lobby"]
    }, 










"Pointe-du-Moulin": {
    "zone_name": "PointeDuMoulin", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/PointeDuMoulin.png", 
            "description": "Something is wrong at the edge of the island.\n\nPointe-du-Moulin stretches into the river like it’s trying to escape the city. The land is landfill and bone, poured out in unnatural shapes. Wind moves in loops. Fog rolls in from the canal and never leaves. Warehouses stand too tall, too narrow, windows too dark to reflect anything. Their doors are chained shut, but still rattle at night. The silence here feels constructed, like someone killed the sound on purpose.\n\nYou walk five minutes in and forget what direction you came from. Footsteps echo when you stop. Light posts flicker in patterns that don't match the power grid. Dogs refuse to follow past the rail cut. People say it’s just old industrial space, but no one comes here twice without changing something in their face. The peninsula holds its breath. It knows you don’t belong. And it’s waiting for you to realize it."\
\
, 
            "sound_path": "res://sound/description/PointeDuMoulin.mp3"
        }
    }, 
    "connected_zones": ["Silo No. 5", "Lachine Canal", "Old Montreal", "Sud-Ouest"], 
    "characters": []
}, 


"Silo No. 5": {
    "zone_name": "SiloNo5", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/SiloNo5.png", 
            "description": "Across the water from Old Montreal, it waits.\n\nSilo No. 5 breaks the view like a warning carved into the skyline. Behind the tourist shops and wedding photographers, it sits on the far shore, massive and silent, refusing to disappear.\n\nPeople ask what it is, but no one really knows. It was built to hold something. It still does. The grain is long gone, but the weight remains.\n\nIts walls are mottled with rust and old salt, streaked like a corpse left out in the rain. Dozens of sealed doors mark its skin like surgical scars. Catwalks lead to nowhere. Windows reflect no light.\n\nThe building does not seem abandoned. It seems contained.\n\nFrom across the water, it feels dormant, but not dead. And if you look long enough, a thought starts to form that doesn’t feel like your own. Something is inside. Something that remembers being full."\
\
\
\
\
, 
            "sound_path": "res://sound/description/SiloNo5.mp3"
        }
    }, 
    "connected_zones": ["Pointe-du-Moulin"], 
    "characters": []
}, 













    "Saint-Michel Metro – Exterior": {
        "zone_name": "SaintMichelMetroExterior", 
        "default_viewpoint": "main", 
        "category": "montreal_high_outside", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/StMichelMetroStationExterior.png", 
                "description": "The end of the line. The concrete here feels heavier.\n\n\tRust crawls down the walls. Tags layer like old bruises. A single streetlamp buzzes overhead, flickering in slow panic.\n\n\tThe stairs sink into the ground, wet around the edges. Something hums below, low and constant, like breath through a cracked mask.\n\n\tA man stands near the railing, smoking nothing, watching nothing. His jacket hasn’t moved in minutes.\n\n\tBuses hiss, pause, move on. No one lingers. Not here. The metro waits with its mouth open, patient and damp.\n\n\tNot a station. A stop."\
\
\
\
\
, 
                "sound_path": "res://sound/description/SaintMichelMetroExterior.mp3"
            }
        }, 
        "connected_zones": ["Saint-Michel", "Saint-Michel Metro", "North Metro Maintenance Tunnels"], 
        "characters": []
    }, 

    "Saint-Michel Metro": {
        "zone_name": "SaintMichelMetroLine", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/SaintMichelMetroLine.png", 
                "description": "Bleu qui penche, bleu sans bord,\n\ttrain fantôme, souffle mort.\n\tLes horloges fondent en vapeur,\n\tle temps s'effiloche dans la peur.\n\n\tUn chant grince sous les néons,\n\tappel perdu, faux horizon.\n\tNul départ, nul appareil,\n\tjuste le bleu,\n\tet son sommeil."\
\
\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/SaintMichelMetroLine.mp3"
            }
        }, 
        "connected_zones": ["Bonaventure Metro", "Namur Metro", "Place des Arts Metro", "Saint-Michel Metro – Exterior", "North Metro Maintenance Tunnels"], 
        "characters": []
    }, 






    "Bonaventure Metro": {
        "zone_name": "BonaventureMetro", 
        "default_viewpoint": "Entrance", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Entrance": {
                "image_path": "res://Image/ViewpointImage/BonaventureEntrance.png", 
                "description": "The Bonaventure Metro entrance lies buried in stone and tired neon, a hollowed space built only to be used.\n\n\tOpened in 1967 to link the new towers to the veins of the city, it was never meant to dazzle.\n\n\tNo signs boast of destinations. No architecture tries to impress.\n\n\tThe lights hum overhead, the tiled floor echoes under passing footsteps, and the station breathes quietly in the dark, doing its work without pride and without thanks."\
\
\
, 
                "sound_path": "res://sound/description/BonaventureEntrance.mp3"
            }, 
            "line": {
                "image_path": "res://Image/ViewpointImage/BonaventureLine.png", 
                "description": "[b]Sous Gauchetière[/b]\n\n\tJe chante bas sous vos trottoirs,\n\toù dorment pierres et vieux miroirs.\n\tSous mille pas, sous mille tours,\n\tje porte encore vos jours trop lourds.\n\n\tPersonne ne voit, personne n'entend,\n\tle souffle usé d'un Montréal vivant.\n\tJe creuse ma voix dans vos détours,\n\tet j'oublie vos promesses d'amour."\
\
\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/BonaventureLine.mp3"
            }
        }, 
        "connected_zones": ["1000 de la Gauchetière", "Namur Metro", "Place des Arts Metro", "Saint-Michel Metro", "South Metro Maintenance Tunnels"], 
        "characters": []
    }, 



"Sainte-Gertrude Church": {
  "zone_name": "SainteGertrudeChurch", 
  "default_viewpoint": "Main", 
  "category": "montreal_high_outside", 
  "is_neighborhood": false, 
  "viewpoints": {
    "Main": {
      "image_path": "res://Image/ViewpointImage/SaintGertrudeChurch.png", 
      "description": "The Sainte-Gertrude Church rises from the neighborhood like something left behind by an older version of the city.\nIts white stone façade has dulled to the color of old teeth. The bell tower still stands straight, but the bells do not ring. Not anymore.\nThe grounds feel empty even during the day. The hedges are trimmed but never fresh. No cars park out front. No one walks up the steps. Lights flicker in the vestibule at odd hours, but no one opens the doors.\nPeople pass by in silence. They do not stare. They do not speak its name unless they have to.", 
      "sound_path": "res://sound/description/SaintGertrudeChurch.mp3"
    }, 
    "Rectory Lawn": {
      "image_path": "res://Image/ViewpointImage/SaintGertrudeChurchRectoryLawn.png", 
      "description": "Beside Sainte Gertrude Church lays a vacant lawn of dead grass and equally dead hopes. The dirt may be sanctified but it is as tired and weary as the other residents of Montreal Nord. It is a non-place, existing between destinations, peppered with litter from the street and the occasional ambitious clump of weeds. Behind it lays the Church rectory, solid and silent.", 
      "sound_path": "[same as Sainte Gertrude Church, maybe add sound of throwing rocks or kicked cans.]"
    }
  }, 
  "connected_zones": ["Sainte-Gertrude : Main Hall", "Montréal-Nord"], 
  "characters": [], 
  "secret_entry_passwords": ["Gertrude"], 
  "accessible_from_zones": ["Montréal-Nord"]
}, 



"Sainte-Gertrude : Main Hall": {
    "zone_name": "SainteGertrudeMainHall", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/EgliseSainteGertrudeMainHall.png", 
            "description": "The main hall stretches long and tall, cavernous and bone-white, as if carved from light that forgot how to shine.\n\nRows of wooden pews sag toward the center like they’ve been praying too long. Dust lingers in the air but never settles. It moves when no one walks.\n\nThe ceiling arches high above, smooth and unadorned. No murals, no saints. Just pale plaster, cracked at the seams.\n\nA single crucifix hangs behind the altar, unlit, its figure weathered down to a suggestion.\n\nThe windows are stained glass, but the colors have drained from them. What remains is muted, warped. Nothing lands clean on the floor."\
\
\
\
, 
            "sound_path": "res://sound/description/EgliseSainteGertrudeMainHall.mp3"
        }
    }, 
    "connected_zones": ["Sainte-Gertrude : Bunkroom", "Sainte-Gertrude : Bell Tower", "Sainte-Gertrude : Lower Levels", "Sainte-Gertrude Church"], 
    "characters": []
}, 

"Sainte-Gertrude : Bunkroom": {
  "zone_name": "SainteGertrudeBunkroom", 
  "default_viewpoint": "main", 
  "category": "", 
  "is_neighborhood": false, 
  "viewpoints": {
    "main": {
      "image_path": "res://Image/ViewpointImage/SainteGertrudeBunkroom.png", 
      "description": "Scorch marks adorn the walls. The constant smell of ash, smoke, and old blood fill one's nostrils inside. And dust, plenty of dust. There are posters and Sabbat glyphs splattered sporadically.\n\nIt's a shared sleeping area - a side room with multiple steel cots. Some of the blankets are bloodstained. There is also a bullet riddled locker. The room feels more like a forward operating base than a home, but there are some touches of identity within. Graffiti tags. Remnants of a burned flag of some sort. A broken guitar that hasn't been touched in years.\n\nOverall, it is deliberately austere. As if purpose has been carved out from a rotting corpse of a building. No real comfort dwells here. For now.", 
      "sound_path": ""
    }
  }, 
  "connected_zones": ["Sainte-Gertrude : Main Hall"], 
  "characters": []
}, 

"Sainte-Gertrude : Lower Levels": {
  "zone_name": "SainteGertrudeLowerLevels", 
  "default_viewpoint": "main", 
  "category": "", 
  "is_neighborhood": false, 
  "viewpoints": {
    "main": {
      "image_path": "res://Image/ViewpointImage/Sainte Gertrude - Lower Levels.png", 
      "description": "The lower levels of Sainte Gertrude are host to many monsters, most of all the Pack Priest and his rats. They stalk the stone halls, red eyes gleaming and ever watchful. Rooms split off from long, dark corridors: libraries, studies, sparring rooms, interrogation rooms, storage rooms. The air smells of mildew and purpose. This is where the Pack lives and breathes, training, learning, and turning a derelict shell into a fortress. Caged single bulb lights hang along the walls at intervals, dim but enough to find your way.", 
      "sound_path": "[rat squeaks, subtle dripping sound. Footsteps on stone.]"
    }
  }, 
  "connected_zones": ["Sainte-Gertrude : Main Hall", "Sainte-Gertrude : Laboratory", "Sainte-Gertrude : Training Room", "Sainte-Gertrude : Library", "Sainte-Gertrude : Bunker"], 
  "characters": []
}, 

"Sainte-Gertrude : Ductus' Office": {
  "zone_name": "SainteGertrudeDuctusOffice", 
  "default_viewpoint": "main", 
  "category": "", 
  "is_neighborhood": false, 
  "viewpoints": {
    "main": {
      "image_path": "res://Image/ViewpointImage/SainteGertrudeDuctusOffice.png", 
      "description": "A heavy, paneled dark wood door separates this room from the rest of the church. It is old, but not in the same way as Sainte Gertrude's, the dingy plaster cracking under the weight of time and neglect.\n\nThe room is... sized. Neither large nor small, not cluttered or particularly spartan. There are no windows. Red velvet drapes flank the walls, obscuring their imperfections and creating the illusion of an old Soviet stateroom in this forgotten corner of Montreal.\n\nMaps and framed pieces of Sabbat propaganda hang in prominent positions, with a large footlocker pushed against the back wall. A salvaged metal desk sits in the center of the room, as cold and practical as its owner. A wheeled leather executive chair sits behind it in silent command of the room, watchful and waiting.\n\nThe room is always cold, chill like the grave, and the weight of it presses in. Judging you.", 
      "sound_path": "[none, or ambient open/close of a lighter]"
    }
  }, 
  "connected_zones": ["Sainte-Gertrude : Main Hall"], 
  "characters": [], 
  "secret_entry_passwords": ["Lighter"], 
  "accessible_from_zones": ["Sainte-Gertrude : Main Hall"]
}, 

"Sainte-Gertrude : Bell Tower": {
  "zone_name": "SainteGertrudeBellTower", 
  "default_viewpoint": "Storage", 
  "category": "", 
  "is_neighborhood": false, 
  "viewpoints": {
    "Storage": {
      "image_path": "res://Image/ViewpointImage/SaintGetrudeBellTowerStorage.png", 
      "description": "It is quiet, here. The darkness presses in closely, yet still you feel exposed as the wind whistles through the broken windows on the bell platform above. A ladder leads up to your left, but to your right is yawning darkness, a place where things are dumped to be forgotten.\n\nYet someone has made a home here. A canvas tarp is anchored at two corners, creating a nest-like hammock where a hodgepodge of blankets and pillows are piled to create comfort in an otherwise comfortless place. Shielded by boxes and crates, one could almost overlook it. A camp lantern hangs above, offering meager light and an old scent of cigarettes, blood and feathers lingers in the nose.", 
      "sound_path": ""
    }, 
    "Tower Platform": {
      "image_path": "res://Image/ViewpointImage/SainteGertrudeBellTowerPlatform.png", 
      "description": "From Sainte Gertrude's steeple, Montreal Nord sprawls out in all its messy glory.", 
      "sound_path": ""
    }
  }, 
  "connected_zones": ["Sainte-Gertrude : Main Hall"], 
  "characters": []
}, 




"Sainte-Gertrude : Laboratory": {
    "zone_name": "SainteGertrudeLaboratory", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/sainte-gertrude_laboratory.png", 
            "description": "The laboratory ceiling is low and oppressive, its stone walls sweating with damp, the mortar between them cracked and crumbling. The air hangs heavy with the mingled scents of rust, mildew, and something sharper—iron and rot, the unmistakable tang of opened flesh. The stone floor is uneven, leaving gaps where water pools in stagnant, dark puddles.\n\nTables stand at the center, none uniform, dragged together from mismatched sources: a butcher’s block scarred with deep cuts, a dented steel gurney with one wheel missing, a metal slab laid flat across barrels. Each is stained, the grain of the wood and the seams of the metal darkened with things that were never properly cleaned away. Overhead, naked bulbs dangle from twisted wires strung across hooks in the ceiling, their light harsh and uneven, buzzing and sputtering with each flicker. Shadows cling to the corners, stretching long over heaps of discarded tools.\n\nThe equipment is a patchwork of the stolen and the improvised—rusted bone saws beside carpentry blades, clamps meant for welding now turned to hold flesh, surgical scissors dulled from misuse. Glass jars line crude shelves made of stacked bricks and planks; some hold cloudy formalin suspensions, where pale shapes drift within, others contain only stains, residues of whatever once filled them. A refrigerator hums in the corner, scavenged from a kitchen decades past, its gasket cracked, its contents wrapped in butcher’s paper and sealed with string.\n\nAgainst one wall, a stone slab doubles as both dissection table and mortuary bed, its surface slick with condensation. Nearby, a drain in the floor gapes. The drip of water through the ceiling creates a slow, steady rhythm, like a heartbeat, echoing faintly through the chamber.\n\nThe whole place feels less like it was built than accreted—an anatomy of scavenged refuse stitched together with desperation and intent. The cellar does not whisper of science or medicine but of obsession, of experiments never meant to see daylight, of secrets carved open and left to fester beneath the stone.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Sainte-Gertrude : Lower Levels"], 
    "characters": []
}, 


"Sainte-Gertrude : Training Room": {
    "zone_name": "SainteGertrudeTrainingRoom", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/sainte-gertrude_training_room.png", 
            "description": "The training room feels like a fortress built out of scraps, its stone walls close and damp, the ceiling low enough that the beams overhead seem ready to press down on anyone who stands tall. The air is thick with dust, sweat, and the faint metallic tang of rust. It is a place of discipline, but also desperation—salvaged together from whatever could be found, not built to impress, only to endure.\n\nAt the center lies a crude sparring circle, the floor marked with a stark chalk line, defining the space where bruises and lessons are earned. Combat dummies stand at crooked angles—some are sandbags stuffed into duct-taped coveralls, others wooden poles wrapped in rags and leather belts, their surfaces split and scarred from countless strikes. Punching bags hang from chains bolted into ceiling beams, the chains creaking with each sway. Their canvas hides are patched with mismatched fabrics, darkened with sweat and split grain where fists and feet have landed too many times.\n\nAlong the far wall, a row of targets—plywood boards painted with rings, dented sheet metal, even traffic signs stolen long ago—bears the marks of blades and arrows.\n\nThe walls themselves are a gallery of violence: swords, axes, and makeshift weapons mounted on crude wooden racks, each one mismatched and worn. Some blades are rust-pitted, others sharpened to a hungry gleam.\n\nLanterns and bare bulbs strung haphazardly along wires cast harsh pools of light, leaving shadows to pool in the corners like silent onlookers. Every surface bears scars of use—stone chipped by thrown blades, beams splintered by wild strikes, mats stained from falls.\n\nThe room feels alive with the echoes of countless bouts: grunts, blows, and the rhythm of fists slamming into canvas. It is not a place of ceremony but of survival—a workshop of violence, born from what the world discarded, meant to turn bodies into weapons.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Sainte-Gertrude : Lower Levels"], 
    "characters": []
}, 


"Sainte-Gertrude : Library": {
    "zone_name": "SainteGertrudeLibrary", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/sainte_gertrude_library.png", 
            "description": "Wooden shelves, warped and sagging with age, line the pack's library walls. They are crammed with volumes bound in cracked leather and flaking vellum, their spines scrawled with gold script long dulled to tarnish. Some books are simple, bound in undecorated leather, while others are bound with strange clasps or chains as if to restrain what they contain. Stacks of loose folios sit atop the shelves in precarious towers, their edges blackened by candle flame or stained with substances that time alone cannot explain. Between them, reliquaries, ritual objects, and fragments of bone rest like forgotten bookmarks, left behind by hands that may not have been entirely human.\n\nLanterns hang at intervals, their glass darkened with soot, casting weak orange halos that cannot pierce the corners. Shadows gather thickly, stretching over the piles of manuscripts and scrolls, making the whole room seem deeper, older, than it should be. The silence is absolute, save for the soft creak of shelves settling or the occasional whisper of parchment shifting as if something unseen is turning the pages.\n\nThe atmosphere suggests not mere scholarship but devotion: this is a place where study was worship, where knowledge was dangerous and treated as sacred, where the stone itself seems to listen. Every shadow hints at a secret, every silence at a presence just beyond the edge of perception. It feels less like a library kept for people, and more like one built to keep the books themselves contained.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Sainte-Gertrude : Lower Levels"], 
    "characters": []
}, 


"Drogo's Study": {
    "zone_name": "DrogoStudy", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/sainte_gertrude_drogos_study.png", 
            "description": "Off to the side, through a narrow arched doorway in the Library, lies a study chamber: a small, cloistered room with a single heavy desk of rough oak, gouged with knife marks and ink stains. Candlesticks squat on its surface, their wax melted into stalagmites and stalactites that have fused with the wood. A chair, its back cracked and repaired with wire, sits pushed slightly away, as though someone rose abruptly and never returned. On the desk lies a scattering of quills, dried bottles of ink, and a few open texts frozen mid-thought, their words written in cramped hands, illuminated with symbols that draw the eye yet feel dangerous to linger upon.\n\nA private collection dominates the shelves, with a carefully preserved copy of the Book of Nod, open on an ornate reading stand.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Sainte-Gertrude : Library"], 
    "characters": [], 
    "secret_entry_passwords": ["Drogo"], 
    "accessible_from_zones": ["Sainte-Gertrude : Library"]
}, 


    "Sainte-Gertrude : Bunker": {
        "zone_name": "Sainte Gertrude : Bunker", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/sainte-gertrude-bunker.png", 
                "description": "The bunk lies deep beneath the church, carved into a secondary basement level that was never meant to exist. The air is damp, unsettled, carrying the raw scent of freshly turned earth mixed with stone dust and candle smoke. Rough timber beams shore up the low ceiling, their edges still sharp from hurried sawing, and the walls are an uneven patchwork of brick, old mortar, and exposed soil where the digging broke through.\n\n\n\nA narrow corridor leads into the chamber, where a row of iron-framed cots has been set up, their thin mattresses sagging under coarse woolen blankets. Buckets and crates serve as tables, cluttered with tin cups, stubbed candles, and a few dog-eared prayer books whose pages curl from the damp. Lantern light throws long shadows across the rough walls, shadows that bend and stretch strangely where the soil bulges inward, as though the earth is restless.\n\n The air here is heavy - suffocating for living things, but the undead are unaffected.\n\nThe ceiling drips in places, each drop echoing sharply in the confined dark, and the air never loses its chill. A faint hum can be felt through the stone—the vibration of the city above, blurred by distance and prayer. Yet it is quieter here than any sanctum upstairs, a silence so heavy it presses against the ears.\n\n\n\nThis place is meant for hiding, or for endurance. The bunk feels less like shelter and more like a refuge carved against inevitability, as though those who sleep here hope the church’s weight above will shield them from what moves unseen below."\
\
\
\
\
\
\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Sainte-Gertrude : Lower Levels"], 
        "characters": []
    }, 




    "Sainte-Gertrude : Tunnel": {
        "zone_name": "Sainte Gertrude : Tunnel", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/sainte-gertrude-tunnel.png", 
                "description": "The tunnel begins as a narrow doorway hidden behind shelving in the church's basement bunker, the kind of place few would think to look. Its threshold is rough-hewn, stone and brick broken through by hands more desperate than careful, and beyond it lies a passage that smells of damp earth and old plaster.\n\nThe walls are uneven, patched with mismatched brick and crumbling mortar, reinforced here and there with scavenged timber that bows under the weight of what presses above. Water seeps through in thin rivulets, pooling in shallow depressions along the floor, and the air carries the metallic tang of rust mixed with mold.\n\nThe tunnel ends in another concealed hatch, this one in the school basement storage—hidden beneath warped floorboards and behind a stack of unused desks. The transition is abrupt: from raw, secret earth to the hollow reek of chalk dust and varnish, as if the passage doesn’t just connect two places, but two worlds—the sacred and the mundane, bound together by something they both sought to conceal."\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Sainte-Gertrude : Lower Levels"], 
        "characters": [], 
        "secret_entry_passwords": ["SecretTunnel"], 
        "accessible_from_zones": ["Sainte-Gertrude : Lower Levels"]
    }, 





    "Downtown Montreal": {
        "zone_name": "Downtown Montreal", 
        "default_viewpoint": "Downtown Montreal", 
        "category": "montreal_high_outside", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Downtown Montreal": {
                "image_path": "res://Image/ViewpointImage/DowntownMontreal.png", 
                "description": "They call it \"La Ville des Miracles Noires,\" The City of Black Miracles.\n\tA place where prayers go to die and are reborn as something sharper, something with teeth.\n\tDowntown Montreal leans against the dark like a bruised fighter, towers bending under old ambitions and flickering lights, the streets humming with the low, feverish pulse of a city that has already made peace with the end.\n\tGlass skyscrapers claw at the sky, forgotten plazas crumble between them, and the Metro murmurs below it all, carrying the city’s tired blood from station to station.\n\tHere, survival is a superstition, whispered by fools.\n\tThe wise live fast, burn brightly, and carry nothing with them but the heat of their own collapse.\n\tIts streets stretch wide and broken, lined with neon storefronts clinging to life, while the towers above whisper deals and debts into the freezing night.\n\tNobody owns this place.\n\tNot anymore."\
\
\
\
\
\
\
\
, 

                "sound_path": "res://sound/description/DowntownMontreal.mp3"
            }
        }, 
        "connected_zones": ["Dorchester Square", "Rue Sainte-Catherine", "Quartier des Spectacles", "McGill – Downtown Campus", "Old Montreal", "Westmount", "Centre-Sud", "Sud-Ouest"], 
        "characters": []
    }, 




    "Quartier des Spectacles": {
        "zone_name": "Quartier des Spectacles", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/quartiers-des-spectacles.png", 
                "description": "In the Quartier des Spectacles, everything shimmers like a stage set, built to dazzle the eye. Neon floods façades, giant screens pulse with color, fountains leap in rhythm and the lights seem too carefully choreographed, as though the very neighborhood were performing for its audience.\n\nBut beneath the wash of brightness lies something quieter, heavier. The wide boulevards and glassy new constructions sit atop older bones—streets that once knew cabarets, vaudeville houses, and dive bars where shadows carried their own kind of rhythm. Even now, behind the LED glow, brick walls remain pitted and scarred, alleys narrow to dark throats, and some windows never open, their panes black like blind eyes.\n\nIt is a district that insists on being seen, and yet much of it seems designed to distract. The music masks the silences between buildings. The projected lights hide the dim, forgotten corners where no one lingers long. There is a sense of orchestration—every public gathering choreographed to keep you from noticing what waits behind the curtains.\n\nThose who stray from the illuminated arteries find themselves in odd, liminal spaces: stairwells that smell of mildew and dust, where a faint draft seems to breathe against your skin; forgotten passageways linking theaters and galleries, too long, too narrow, like veins. The Quartier’s energy is real, but so is the exhaustion beneath it, like an actor’s painted smile stretched over a secret bruise.\n\nHere, performance is not just entertainment but camouflage. The lights and music conceal the city’s darker rhythm, one that beats slowly, insistently, in the quiet corners—reminding you that every show must end, and when it does, the mask slips."\
\
\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Place des Arts", "Centre-Sud", "Downtown Montreal", "Plateau Mont Royal"], 
        "characters": []
    }, 


    "Place des Arts": {
        "zone_name": "Place des Arts", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/place-des-arts.png", 
                "description": "Place des Arts feels like a concrete citadel planted in the middle of downtown Montreal, monumental but austere, more fortress than festival. The architecture is all sharp lines and pale, weather-stained stone, the plazas stretching wide and bare under the open sky. The fountains sputter in summer but often sit empty, their basins stained with algae, while pigeons and cigarette butts gather in their absence.\n\nThe square itself has a rawness then, a sense of urban grit. Its expanses of concrete are too broad, too exposed, leaving pedestrians small and scattered across it. At night, fluorescent streetlamps cast sickly pools of light that emphasize the emptiness more than they dispel it. The shadows of the surrounding towers creep over the plaza, and wind rushes through the open space, carrying scraps of litter in restless circles.\n\nThe theaters and halls loom over all of it—majestically, yes, but with a cold grandeur, their walls streaked with soot and their banners fading in the harsh weather. Place des Arts in this decade is a temple to high culture, but one that feels out of joint with its surroundings, aloof amid the changing downtown. Concert-goers in fine clothes slip quickly inside, while outside, the square becomes a shortcut for workers, students, and the homeless, who huddle in corners away from the wind.\n\nBeneath it, the underground city offers refuge but not warmth: tiled corridors buzzing with fluorescent light, stairwells smelling faintly of mildew, and escalators that clatter endlessly. The hum of the metro rises through the walls, a constant reminder that the city’s pulse flows just below the polished veneer.\n\n The Place des Arts is caught between ambition and decay, spectacle and emptiness—a cultural stage set where the performance inside glitters, but the concrete plazas outside whisper of urban loneliness, as though the institution itself were performing against the city’s own entropy."\
\
\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Quartier des Spectacles", "Underground City"], 
        "characters": []
    }, 


    "Underground City": {
        "zone_name": "Underground City", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/underground-city.png", 
                "description": "The tunnels around Place des Arts are some of the most unsettling stretches of the Underground City—long, echoing corridors where modernist ambition has already begun to sour into neglect. The walls are clad in pale tiles, once gleaming, now dulled and cracked, their grout lines stained with grime. The lighting is fluorescent and uneven, tubes buzzing overhead, some blinking in a pulse that seems almost intentional, like a signal only the walls can read.\nThe air here is damp, carrying the smell of concrete dust and old rainwater that seeps down from the plazas above. When the fountains outside go still in winter, their silence seems to bleed down through the walls, adding to the hollow quiet of the corridors. Even during the day, foot traffic thins quickly once you leave the main arteries. The further you walk, the more the space feels like a set left behind after the performance, hallways echoing with the ghosts of audiences who never returned.\nAt night, when the shops close and the entrances are barred, the tunnels slip into a kind of suspended dream. The echoes become sharper, the corners darker. You catch glimpses in the mirrored panels of shuttered boutiques—shapes that seem to hesitate when you move, lagging just slightly behind your reflection. The stairwells leading up into Place des Arts itself are wide and brutalist, their concrete stained with damp patches, their handrails cold to the touch. Some claim you can hear faint music drifting down them when the halls above are empty—notes of piano or strings, dissonant and distant, as though rehearsed by unseen hands.\nThis segment of the Underground City feels like a liminal stage beneath a stage—Place des Arts above dazzling in light and performance, while below, its shadow broods in concrete silence, whispering of rehearsals no one living should attend."\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Place des Arts", "Complexe Desjardins", "Place des Arts Metro"], 
        "characters": []
    }, 

    "Cirque du Monstres": {
        "zone_name": "Cirque du Monstres", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/cirque_du_monstres.png", 
                "description": "In the tunnels only just below the bustling streets of Montreal's arts districts, a hidden gem sits in darkness. Passed by word of mouth and the occasional promotional poster in clubs and advertised outside select places of business that cater to the young, artistic, and alternative, the Cirque Du Monstres claims whatever free space it can - moving week to week, putting on incredible performances of acrobatics, juggling, snake charming, and stage magic.\n\nThe Circus always has a surreal feeling; Music, bright and cacophonic whispers through old industrial access tunnels to herald the start of a show. It calls people onward toward flickering lights and shadows cast by firelight, not electricity; It's not quite an Old World sound, but one that never existed - a dream of an idea of a time and a place, apart from the 'now' - a place of possibility, wonder... and just a hint of danger.\n \n\nThe Cirque Du Monstres is a place for those who do not fit the mold of the usual artistic establishment... or even society at large. The stage is temporary, the scaffolds and structure easily broken down and taken elsewhere, including rigging for the various acrobatic routines. A number of artists, acrobats and performers are mentioned on the promotional flyers, including someone referred to only as 'The Dancing Crow'.\n"\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Underground City"], 
        "characters": [], 
        "secret_entry_passwords": ["monsters"], 
        "accessible_from_zones": ["Underground City"]
    }, 


    "Complexe Desjardins": {
        "zone_name": "Complexe Desjardins", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/complexe-desjardins.png", 
                "description": "Complexe Desjardins stands as both a monument to modern commerce and a strange, cavernous crossroads in the center of downtown Montreal. Its three towers loom above, but what most people remember is the interior—a massive atrium where natural light pours down through glass skylights, diffused across tiers of concrete balconies and wide walkways.\n\n\nBy day, the place hums with the rhythm of offices, shoppers, and travelers. The ground level buzzes with food courts and scattered fountains, their tiled basins rimmed with damp mineral stains. Escalators glide constantly, carrying people between levels like blood through veins, while the echo of footsteps and chatter merges into a constant hum. The mall-like corridors radiating outward are lined with shops—some polished, others already showing signs of fatigue: flickering neon, outdated signage, displays that seem frozen in time.\n\n\nYet even in the daylight bustle, there is a coldness to the scale.The concrete is pale but impersonal, softened only slightly by plants and banners that never quite disguise the weight of the architecture. Sound doesn’t just echo here—it hangs, overlapping in a way that makes voices seem both close and far at once.\nAt night, when the crowds thin, the atmosphere shifts. The atrium’s openness becomes cavernous, almost void-like, and the fountains gurgle too loudly in the emptiness. Fluorescent lights wash everything in a sterile glow that makes the tiled floors look yellowed and worn. The connecting tunnels to the Underground City stretch away from its lower levels, yawning into corridors where foot traffic dwindles to nothing. Down there, the hum of escalators and ventilation fans seems amplified, filling the silence like mechanical breathing.It’s a space of convergence, but also of uncanny dislocation, a mall and a machine at once, as if the city had hollowed out a vast chamber just to see what would gather inside."\
\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Rue Sainte-Catherine", "Underground City"], 
        "characters": []
    }, 



    "A lonely, barren room": {
        "zone_name": "A lonely, barren room", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/EveHaven1-min.png", 
                "description": "This small room in the infrastructure of the city's underground has somehow been untouched by recent developments, perhaps forgotten by city planners, or overlooked as not worth the time and money. Someone, though, has dragged in some bare essentials over time, making the place technically livable. A small table repurposed as an uncomfortable bed, and a smalled bench to use as a wobbly table for the occasional times when it occupant has enough possessions in the moment to put something somewhere.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Complexe Desjardins", "Underground City"], 
        "characters": [], 
        "secret_entry_passwords": ["Sewerlubri"], 
        "accessible_from_zones": ["Complexe Desjardins"]
    }, 






    "Rue Sainte-Catherine": {
        "zone_name": "Rue Sainte-Catherine", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/rue-sainte-catherine.png", 
                "description": "Rue Sainte-Catherine is the restless artery of downtown Montreal—long, crowded, and contradictory. It’s where neon and grit live side by side, a place of shopping bags and cigarette smoke, of laughter, traffic, and the hum of something slightly off beneath it all. By day, the street is alive with students from Concordia and UQAM, office workers spilling out for lunch, and shoppers weaving between department stores, boutiques, and arcades.By night, Sainte-Catherine changes. The neon signs flare brighter, casting pinks and greens across wet pavement, while the shadows lengthen in the alleys that break away from the main drag.\nThe pavement is cracked, litter gathers in corners, and the homeless take shelter in doorways, their presence a stark reminder of the city’s fractures. Steam rises from the grates in winter, blurring the lights into ghostly halos. The metro entrances yawn at intervals, stairwells leading down into fluorescent tunnels, as though the street itself has a hidden labyrinth beneath it.\n\n Rue Sainte-Catherine is neither clean nor safe, but it is alive—electric with movement, layered in contradictions. Glamorous and decayed, commercial and carnal, it is the city’s stage and its shadow at once. In the quieter hours, the street feels endless, haunted by its own neon reflections."\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Complexe Desjardins", "Downtown Montreal"], 
        "characters": []
    }, 






"Punkhouse - Sans Nom": {
    "zone_name": "PunkhouseSansNom", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/sansnom-punkhouse.png", 
            "description": "A tired three-story house at the end of an alley, once carved into cheap apartments for factory workers. The landlord disappeared years ago, so no one’s paid rent in forever. Windows are cracked and patched with plywood, graffiti layers every surface - anti-police slogans, anarchist scrawl, Sabbat sigils hidden in punk tags. The front door is barricaded with scavenged car doors and rebar.\n\nThe front stoop doubles as a gathering spot for wayward souls and night strays. Rusted bikes and stolen shopping carts litter the yard. A burned-out car frame sits permanently on the curb, used as a bonfire pit when the pack hosts ragers. Flyers for long-dead shows and causes peel from telephone poles. The few remaining neighbors know better than to complain. The sounds of police sirens do not reach this place.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Downtown Montreal", "Punkhouse - Sans Nom : Main"], 
    "characters": [], 
    "secret_entry_passwords": ["sansnom"], 
    "accessible_from_zones": ["Downtown Montreal"]
}, 

"Punkhouse - Sans Nom : Main": {
    "zone_name": "Punkhouse: Main", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/punkhouse-main.png", 
            "description": "The walls of the main room are stripped to bare brick and spray-painted with slogans in a bad French-English mix: “PAS DE DIEU, PAS DE MAÎTRES, JUSTE LE SANG.” Old couches, some missing legs, are arranged haphazardly in a circle around a cracked table stained with candle wax and what might be blood.\n\nA door leading to what was once a kitchen is marked with “PAS FUMER ICI SI TU VEUX VIVRE FUCKO”.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Punkhouse - Sans Nom", "Punkhouse - Sans Nom : Lab", "Punkhouse - Sans Nom : Depths"], 
    "characters": []
}, 

"Punkhouse - Sans Nom : Lab": {
    "zone_name": "Punkhouse: Lab", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/punkhouse-lab.png", 
            "description": "It used to be a kitchen. The fridge hums sometimes but doesn’t reliably keep cold. It seems consigned to its new duties, packed with reagent bottles, jars of powder, and unlabeled vials of cloudy liquid instead of food. The oven door is permanently open, its racks turned into makeshift drying trays for chemicals and herbs.\n\nShelves that once held dishes now bow under mason jars stuffed with dubious compounds - some crystalline, some sludgy, a few clearly organic in origin. There’s a box of pharmacy pill bottles, their labels half-peeled, and several small notebooks smeared with coffee, blood, and chemical burns.\n\nAgainst one wall is the “bomb bench”: an old door laid across sawhorses, littered with wires, nails, glass bottles, and duct tape. A cracked Polaroid camera hangs above it, used to snap progress shots in case the artisan blows himself up and someone needs to figure out what went wrong.\n\nEvery surface smells of acetone, bleach, and vinegar. The sink is perpetually clogged with unidentifiable sludge, and the tap water runs rusty. The floor is sticky with old spills. The boombox in the corner refuses to turn off, perpetually blasting music into the air—drowning out hissing burners and the faint chemical pop of reactions gone sideways. A chair for company sits in the corner.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Punkhouse - Sans Nom : Main"], 
    "characters": []
}, 

"Punkhouse - Sans Nom : Depths": {
    "zone_name": "Punkhouse: Depths", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/punkhouse-depths.png", 
            "description": "The depths of the house stretch beneath the cracked foundation like a half-forgotten warren. A steep stairwell drops into darkness where the air is always damp and tinged with mildew, old ash, and chemical rot. Down here, the space is carved into makeshift bedrooms, each more like a shelter than a home.\n\nWalls are built from scavenged plywood, dented lockers, hollow doors pulled from alleys. Curtains made from bed sheets, flags, or tarps hang where walls couldn’t be made solid. Inside each space, the “beds” range from stained mattresses on palettes to piles of blankets on the concrete floor. Stray furniture—a broken dresser, a desk rescued from a curb, a steel gurney—has been dragged down and repurposed.\n\nThe hallway that links them is narrow, illuminated by Christmas lights stapled overhead, half of them flickering, the other half burnt out. Pipes run along the ceiling, dripping steadily into rusting pans and plastic tubs, the constant tap-tap-tap echoing like a clock that never stops.\n\nAt the far end, past the bedrooms, the basement opens into a communal chamber and ritual space. It is a lounge, host to a dented steel table, ringed with mismatched chairs and crates.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Punkhouse - Sans Nom : Main"], 
    "characters": []
}, 




"McGill – Downtown Campus": {
    "zone_name": "McGillDowntownCampus", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/mcgill_downtown.png", 
            "description": "McGill’s downtown campus sits like a question posed to the city around it. Surrounded by churches and the heavy breath of history, it doesn’t kneel or rebel. It negotiates. Limestone and copper, brick and glass, each building speaking in its own strange cadence. The place feels thoughtful in the way of someone watching you from a window you hadn’t noticed. You walk its paths and feel the ground has been considered. Not sacred. Not modern. Just aware. The result isn’t harmony. It’s something colder, more honest. A new ancient rising at the foot of the mountain, knowing exactly what it is.", 
            "sound_path": "res://sound/description/mcgill_downtown.mp3"
        }
    }, 
    "connected_zones": ["Peel–Pine Stairwell", "Downtown Montreal", "Plateau Mont Royal"], 
    "characters": []
}, 




"Peel–Pine Stairwell": {
    "zone_name": "PeelPineStairwell", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/peelpine_stairwell.png", 
            "description": "At the corner of Peel and Pine, the stairs begin without ceremony, slipping up into the trees with a tilt that feels too steep, too narrow, like they were never meant for comfort. The concrete is cracked and damp in places, bordered by rusted railings and patches of green that crowd close as if trying to hide what lies ahead. There’s no clear reason for the unease that settles in as you climb, only a slow tightening in the chest, a quiet certainty that something is watching from beyond the bend. The city noise fades too quickly, and the path bends out of sight as though leading not into a park, but toward something waiting just out of reach.", 
            "sound_path": "res://sound/description/peelpine_stairwell.mp3"
        }
    }, 
    "connected_zones": ["Mount Royal – Lower Stair", "McGill – Downtown Campus"], 
    "characters": []
}, 

"Professor Usaz's Home": {
    "zone_name": "Professor Usaz's Home", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Assets/UI/ProfessorUsaz.png", 
            "description": "The room feels lived in and quietly scholarly. Shelves line the walls, each one heavy with old books and rolled parchments, their covers worn and their pages yellowed with time. A single armchair rests near a small fireplace, its cushions shaped by years of use. A solid oak desk stands nearby, its surface scattered with papers, notes, and an ink-stained blotter. Though the home is simple and unpretentious, it carries a sense of warmth and familiarity. The faint scent of paper and pipe smoke lingers in the air, giving the place a feeling of calm and quiet focus.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Peel-Pine Stairwell"], 
    "characters": [], 
    "secret_entry_passwords": ["Faulkner"], 
    "accessible_from_zones": ["Peel-Pine Stairwell"]
}, 




"Mount Royal – Lower Stair": {
    "zone_name": "MountRoyalLowerStair", 
    "default_viewpoint": "main", 
    "category": "Forest001", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/mountroyal_lowerstair.png", 
            "description": "At the foot of Mount Royal, the stairs rise in silence. The little lights of the night do not follow you here. Trees press in close, their limbs twisted like old thoughts. The stone is wet and uneven, each step inviting and indifferent. A rusted rail guides the way, but it feels more like a boundary than a help. Below, water slips into a tunnel with no name. Above, the forest thickens. You climb not because you want to, but because something in you already has.", 
            "sound_path": "res://sound/description/mountroyal_lowerstair.mp3"
        }
    }, 
    "connected_zones": ["Mount Royal – Upper Stair", "Peel–Pine Stairwell"], 
    "characters": []
}, 

"Mount Royal – Upper Stair": {
    "zone_name": "MountRoyalUpperStair", 
    "default_viewpoint": "main", 
    "category": "Forest001", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/mountroyal_upperstair.png", 
            "description": "The stairs vanish upward into a black canopy, slick with rain and the smell of soil. Behind you, the city flickers with neon, engines, and the hum of the living, but here it’s all gone. You are still in Montreal, technically. But that no longer matters. The noise does not reach this far, not past the first few steps. Only the cold does. The trees lean in, too close, like they have been waiting for someone to notice. The railing is cold iron and the path ahead bends just enough to hide whatever waits at the top. You keep climbing anyway. Something has already decided you will.", 
            "sound_path": "res://sound/description/mountroyal_upperstair.mp3"
        }
    }, 
    "connected_zones": ["Mount Royal – Grand Staircase", "Mount Royal – Lower Stair"], 
    "characters": []
}, 

"Mount Royal – Grand Staircase": {
    "zone_name": "MountRoyalGrandStaircase", 
    "default_viewpoint": "main", 
    "category": "Forest001", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/mountroyal_grandstaircase.png", 
            "description": "The Grand Staircase cuts up the mountain with a kind of civic pride that feels forced, its symmetry too clean against the wild slope it tries to tame. The stone is polished where thousands have passed, but the air stays heavy and damp, filled with the scent of root rot and iron. You can see the skyline behind you if you turn, but it looks small now, unreal, like a stage set left lit after the actors have gone home. The higher you climb, the more the structure feels like a monument to something unspoken. Not celebration. Not grief. Just presence. Quiet and watching.", 
            "sound_path": "res://sound/description/mountroyal_grandstaircase.mp3"
        }
    }, 
    "connected_zones": ["Mount Royal – Trail Split", "Mount Royal – Upper Stair"], 
    "characters": []
}, 

"Mount Royal – Trail Split": {
    "zone_name": "MountRoyalTrailSplit", 
    "default_viewpoint": "main", 
    "category": "Forest001", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/mountroyal_trailsplit.png", 
            "description": "At the top of the Grand Staircase, the world hesitates. The trees thicken and the sky disappears, leaving only the soft dark of the path and the way it splits without reason. No signs, no lights, just the hum of stillness pressed close. The forest is deeper here, more certain of itself. You are meant to choose, but the choice feels wrong, like stepping into a sentence you did not begin. Behind you, the stone steps end cleanly. Ahead, the trail folds into shadow. One direction pulls, the other waits. Neither welcomes.", 
            "sound_path": "res://sound/description/mountroyal_trailsplit.mp3"
        }
    }, 
    "connected_zones": ["Mount Royal – The Cross", "Mount Royal - Overlook", "Mount Royal – Grand Staircase"], 
    "characters": []
}, 

"Mount Royal - Overlook": {
    "zone_name": "MontRoyalOverlook", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/montroyaloverlook.png", 
            "description": "The trees pull back here, not like an invitation but a hesitation, as if the forest itself is afraid of the view. The path that leads in is narrow and disloyal, half-swallowed by roots and disuse, never marked on any official map. At its end, the city waits. Distant. Red-lit. Alive with motion it doesn’t understand. Towers rise from the dark like teeth. Streets glow faintly, pulsing with the tired blood of midnight traffic. There is no rail. Only the wind, and the drop, and the sense that you were never supposed to find this place. But you did. And now it sees you too.", 
            "sound_path": "res://sound/description/montroyaloverlook.mp3"
        }
    }, 
    "connected_zones": ["Mount Royal – Trail Split"], 
    "characters": []
}, 

"Mount Royal – The Cross": {
    "zone_name": "MountRoyalTheCross", 
    "default_viewpoint": "main", 
    "category": "Forest001", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/mountroyal_thecross.png", 
            "description": "And then, through the trees, it appears. The Cross. Towering and radiant, humming with unnatural color that stains the ground in shades of violet and blood. It rises from the earth like something unearthed rather than built, too large and too precise, as if it had been waiting. The fence around it offers no protection, only distance. Everything here feels paused, as though even the forest is holding its breath. You do not speak. You do not move quickly. The city is far below now and irrelevant. This is not a landmark. It is a revelation. And it sees you.", 
            "sound_path": "res://sound/description/mountroyal_thecross.mp3"
        }
    }, 
    "connected_zones": ["Mount Royal – Trail Split"], 
    "characters": []
}, 






"Westmount": {
    "zone_name": "Westmount", 
    "default_viewpoint": "core", 
    "category": "montreal_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "core": {
            "image_path": "res://Image/ViewpointImage/Westmount.png", 
            "description": "Westmount rests heavy on the hillside, wrapped in old money and quiet pride, a pocket of privilege pretending the city beyond the trees does not exist.\n\nStone manors and heavy greystones crouch behind iron fences, their windows casting faint glows onto manicured streets built to last longer than memory.\n\nDowntown flickers in the distance, a smear of broken color across the horizon, bleeding through the night like a wound no one here dares to name.\n\nThey fret over the noise, the lights, the restless fever of the streets below.\n\nBut it is not the city that watches them.\n\nIt is Mount Royal, crouched and breathing, patient as stone, waiting for the moment when the earth remembers what was built on its back."\
\
\
\
\
, 
            "sound_path": "res://sound/description/Westmount.mp3"
        }
    }, 
    "connected_zones": ["Downtown Montreal", "Côte-des-Neiges", "Notre-Dame-de-Grâce", "Sud-Ouest"], 
    "characters": []
}, 


    "The Iron Fangs": {
        "zone_name": "The Iron Fangs", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/TheIronFangs_Main.png", 
                "description": "The Iron Fangs' house stands on a quiet, sloping street in Westmount.\nIt is a solitary, three-story greystone townhouse, pressed tightly between two similar but more ornate properties,\ncausing it to look like a stark, grey scar in the otherwise opulent block.\n\nThe architecture is severe. The original 19th-century facade has been stripped of all ornamentation,\nleaving flat, imposing stone surfaces. The windows are minimal, tall, and narrow—dark voids in the stone during the night.\n\nOn the ground floor, they have been subtly reinforced with interior ironwork, visible only upon close inspection.\n\nThere is no garden, only a short flight of stone steps leading to a heavy, featureless door of dark, treated wood.\nThe building projects an aura of absolute silence and anonymity.\nIt is a monument to privacy, a place that does not invite visitors and promises nothing to those who pass by.\nIt is the perfect shell for a predator who values order and control above all else."\
\
\
\
\
\
\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["The Iron Corridor", "Westmount"], 
        "characters": [], 
        "secret_entry_passwords": ["myfangsareiron"], 
        "accessible_from_zones": ["Westmount"]
    }, 


    "The Iron Corridor": {
        "zone_name": "The Iron Corridor", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/TheIronFangs_Hallway.png", 
                "description": "The interior passageways are extensions of the haven's severe philosophy.\nCold stone floors and walls, unadorned by any decoration, create an oppressive sense of order and security.\nThe lighting is dim and purely functional."\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["The Iron War Room", "The Iron Fangs"], 
        "characters": []
    }, 


    "The Iron Fangs - Jericho": {
        "zone_name": "The Iron Fangs - Jericho", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/TheIronFangs_Jericho.png", 
                "description": "Jericho’s room in the Iron Fangs’ haven is modest yet thoughtfully kept, reflecting discipline wrapped in artistry. A dark wooden desk rests against the wall, organized with a worn Bible, a script or two, and his cherished fountain pen. Above it, a few clipped pages of poetry and philosophy offer quiet inspiration—never cluttered, always intentional. A single candle, half-burned, tells of long nights spent writing, praying, remembering.\n\nThe bed is simple, neatly made with dark sheets, more functional than indulgent. A small wardrobe holds tailored coats and gloves—elegant, but not ostentatious. And upon the wall, in a plain black frame, hangs the most personal thing in the room: a photograph of his old pack. Their faces captured in rare stillness, a moment before the fall. He keeps it at eye level—not for grief, but resolve. A reminder of where he came from… and why he refuses to run."\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["The Iron Corridor"], 
        "characters": [], 
        "secret_entry_passwords": ["jericho"], 
        "accessible_from_zones": ["The Iron Corridor"]
    }, 


    "The Concealed Iron": {
        "zone_name": "The Concealed Iron", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/TheIronFangs_SecretPassage.png", 
                "description": "This hidden passage is an extension of the Haven's severe architecture.\nIt is a narrow, cold corridor carved directly through raw, dark stone, its walls left rough and unadorned. The passage extends into the darkness, emphasizing its long, winding nature and the deliberate, indirect path to the quarters. Lighting is minimal, provided only by a very few dim, functional amber or oil-lamp lights set into the wall, which serve only to prevent absolute blackness. The air itself feels heavy and chill, underscoring the sense that this is a secret, secure vein of the house, built for necessity and evasion, not for movement."\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Lucian's Quarters", "The Iron Corridor"], 
        "characters": [], 
        "secret_entry_passwords": ["teiubesc"], 
        "accessible_from_zones": ["The Iron Corridor"]
    }, 


    "The Iron War Room": {
        "zone_name": "The Iron War Room", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/TheIronFangs_Command.png", 
                "description": "The Iron Fangs' primary living space is a Command Center.\nThe interior is a stark fusion of the building's original stone and brutalist functionality.\nAll decor is stripped away, leaving only what is necessary for his war: a large desk for maps and strategy,\ntools for the maintenance of his weapons, and a single, unforgiving chair.\nThe lighting is cold and functional, designed for work, not comfort."\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["The Iron Gymnasium", "The Iron Corridor"], 
        "characters": []
    }, 



    "he Iron Gymnasium": {
        "zone_name": "The Iron Gymnasium", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/TheIronFangs_TrainingRoom.png", 
                "description": "The training room is a cold space with high ceilings, and walls of rough-cut stone that absorb all light and sound.\n\nThe floor is packed, dark earth or worn stone, marked with scuff lines from past exercises.\nThe only features are minimal, functional equipment—perhaps a heavy punching bag hanging from a thick chain,\nand a simple rack holding practice weapons (staves, dull swords).\n\nThe light is provided by a few bare, utilitarian bulbs near the ceiling, casting long,\nharsh shadows that emphasize the room's brutal purpose and total lack of comfort.\n\nIt is a space built only for discipline and combat readiness."\
\
\
\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["The Iron War Room"], 
        "characters": []
    }, 


    "Lucian's Quarters": {
        "zone_name": "Lucian's Quarters", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/TheIronFangs_Lucians_Quarters.png", 
                "description": "Lucian's personal space is a reflection of his military discipline.\nThe room is spartan and obsessively neat, containing only a perfectly made bed,\na weapon rack for his saber and pistol, and a single trunk.\nThere is no personal clutter, only the essentials for a soldier at war."\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["The Concealed Iron"], 
        "characters": []
    }, 




    "Notre-Dame-de-Grâce": {
        "zone_name": "NDG", 
        "default_viewpoint": "Main", 
        "category": "montreal_high_outside", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/NDG.png", 
                "description": "NDG stretches wide and low across the hillside, a maze of battered brick and narrow streets that never quite forget the weight of the city pressing down.\n\n\tThe mood here is heavy but honest, worn into the sidewalks and stitched into the tired faces that pass without hurry.\n\n\tIt is not a place built for dreams but for endurance, for the slow unremarkable victories of another day survived.\n\n\tFar off downtown burns in restless colors, louder and faster than anything here.\n\n\tThe mountain leans closer too, its shadow a constant presence, but NDG does not flinch.\n\n\tIt moves at its own rhythm, slow, heavy, stubborn enough to outlast the noise."\
\
\
\
\
, 
                "sound_path": "res://sound/description/NDG.mp3"
            }
        }, 
        "connected_zones": ["Côte Saint-Luc", "Côte-des-Neiges", "Montreal West", "Sud-Ouest", "Westmount"], 
        "characters": []
    }, 

"Côte-des-Neiges": {
    "zone_name": "CoteDesNeiges", 
    "default_viewpoint": "Main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/CoteDesNeiges.png", 
            "description": "Côte-des-Neiges doesn’t shine. It leans. Into the mountain, into itself, into the weight of too many lives stacked too quickly.\nLanguages blur on the wind. The street signs offer translation, not clarity. Groceries hum with incense and cheap fluorescent light. The buildings don’t rise, they huddle.\nSomewhere beneath the concrete, the mountain breathes. Not loudly. Just enough to remind you it’s older than your prayers. Older than any city that thought it could claim it.\nChildren here grow up translating their parents’ fears. The church bells still ring, but softer now, as if apologizing. And the paths into the woods are still there, even when no one talks about them.\nCôte-des-Neiges remembers what the city forgets. And it waits. Quiet. Watching.", 
            "sound_path": "res://sound/description/CotedesNeiges.mp3"
        }
    }, 
    "connected_zones": ["Décarie Sector", "Notre-Dame-de-Grâce", "Westmount", "Saint-Laurent", "Côte Saint-Luc", "Ahuntsic-Cartierville", "Parc-Extension"], 
    "characters": []
}, 



"Montreal West": {
    "zone_name": "MontrealWest", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/montreal_west.png", 
            "description": "Montreal West is not a place but a refusal, a quiet held so tightly it hums, streets arranged like old arguments, Protestant grids imposed on land that still remembers wolves. The lamps are too white, the air too clean, the houses too still, like someone designed the neighborhood from memory and got the texture wrong. Nothing bleeds here. Not openly. The sidewalks are edged with hedge-trimmed diplomacy, and the train tracks run like old surgical scars beneath it all. Somewhere between the golf course and the commuter rail, God was put in a filing cabinet and left there to yellow.", 
            "sound_path": "res://sound/description/montreal_west.mp3"
        }
    }, 
    "connected_zones": ["Lachine Canal", "Côte-des-Neiges", "Notre-Dame-de-Grâce", "Lachine", "LaSalle", "Sud-Oest"], 
    "characters": []
}, 


"Lachine": {
    "zone_name": "MontrealLachine", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/montreal_lachine.png", 
            "description": "Lachine is where the city began lying to itself, a mouth carved into the island to chase trade and ended up swallowing time instead. The canal, once the lifeblood of empire and ambition, still cuts through the borough like a prophecy written in stone and silt. Grain towers lean like tired saints, rail lines vanish into the weeds, and old brick warehouses sleep beside the water, dreaming of steam and soot. This is Montreal before neon, before glass, a place where the bones of industry still press up through the pavement, reminding everything modern that it is temporary.", 
            "sound_path": "res://sound/description/montreal_lachine.mp3"
        }
    }, 
    "connected_zones": ["Lachine Catholic Cemetery", "Boulevard Saint-Joseph", "Lachine Canal", "Montreal West", "Côte Saint-Luc", "Dorval", "Saint-Laurent", "LaSalle"], 
    "characters": []
}, 




    "Lachine Canal": {
        "zone_name": "Lachine Canal", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Lachine-canal.png", 
                "description": "Although the Lachine Canal once served as the gateway between the Great Lakes and the Rest of the World, it has fallen into disuse since the Saint Lawrence Seaway opened in 1959.\n\nToday, the canal is dotted with abandoned and crumbling factories and docks. The structures are used by homeless and runaways who seek shelter from the elements, their parents or even their pasts. \n\nThe Sabbat usually raid these factories when *stocking up* for blood feasts."\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Singer Sewing Machine Factory", "Textiles du Petomane", "Lachine", "LaSalle", "Sud-Ouest", "Montreal West", "Old Montreal", "Pointe-du-Moulin"], 
        "characters": []
    }, 


    "Singer Sewing Machine Factory": {
        "zone_name": "Singer Sewing Machine Factory", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/singer-sewing-factory.png", 
                "description": "The old Singer Sewing Machine Factory was one of the last businesses to die on the Canal. Now it is a last resort refuge for the desperate, and a playground for the inhumane. If it wasn't for the stench of piss and putrefaction, the waterside scene of an old factory would seem romantic. But the moment this area quit making people money, people stopped caring. \n\nThe windows are almost all broken from years of rock throwing. Some of them house jagged shards still in the frame, and covered in dried blood. There seems to be no lack of an open point of entry, or garbage surrounding the building."\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Singer Factory Floor", "Lachine Canal"], 
        "characters": []
    }, 


    "Singer Factory Floor": {
        "zone_name": "Singer Factory Floor", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/singer-interior.png", 
                "description": "The work floor was once an assembly line, cranking out sewing machines to N. America s housewives, and tailors. Now it s an empty shell full of litter, old oil drums used as fire pits, and crude graffiti made up of spray paint, feces and blood. The smells of piss and putrefaction are strong here. \n\n Fuck Trudeau!!  is spray painted on the floor almost immediately after entering. \n\nThere is a skittering across the concrete. It should just be rats, right?"\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Singer Sewing Machine Factory"], 
        "characters": []
    }, 


    "Textiles du Petomane": {
        "zone_name": "Textiles du Petomane", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/petomane-factory.png", 
                "description": "The Wm. J. le Petomane Textile Factory should be condemned. It probably would be if anyone gave a shit. A storm will come through here one day, and it will collapse this building on whoever is squatting here at the time.\n\nThe smell of the polluted canal is strong here. The sounds of its waters rush against the nearby banks. They draw eyes to the water where they spot the bow of a half-sunken tug boat. No light seems to be coming from within."\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Lachine Canal", "Petomane Factory Floor"], 
        "characters": []
    }, 


    "Petomane Factory Floor": {
        "zone_name": "Petomane Factory Floor", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/petomane-interior.png", 
                "description": "The 2nd floor of the Factory is starting to come down onto the 1st. The place stinks of vermin waste. What you hope are rats skitter unseen across both floors. \n\nOutside of the garbage and filth people have brought in over the years, there isn t much here. This place was cleaned out when they closed down leaving the rotten wood and rusting frame of this one thriving business. "\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Textiles du Petomane"], 
        "characters": []
    }, 















"Lachine Catholic Cemetery": {
    "zone_name": "MontrealLachineCatholicCemetery", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/montreal_lachine_catholic_cemetery.png", 
            "description": "The Lachine Catholic Cemetery does not mourn; it settles into itself with the quiet certainty of stone and soil. Headstones lean like tired men at mass, their names worn down by weather and time. The wrought-iron gate hangs open just enough to suggest invitation, but the gravel path beyond feels more like a threshold than a welcome. Pine needles collect in the corners of forgotten plots, and the wind moves like something trying not to be noticed. This place remembers a different town, one built on rosaries and railway schedules, when the parish still believed eternity could be measured in parish records and cold marble. Now it is a museum of grief no one visits, a hollow quiet where the dead are kept orderly and the living know better than to linger.", 
            "sound_path": "res://sound/description/montreal_lachine_catholic_cemetery.mp3"
        }
    }, 
    "connected_zones": ["Within Lachine Catholic Cemetery", "Lachine"], 
    "characters": []
}, 

"Within Lachine Catholic Cemetery": {
    "zone_name": "MontrealLachineCatholicCemeteryInterior", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/montreal_lachine_catholic_cemetery_interior.png", 
            "description": "It sure is spooky here.", 
            "sound_path": "res://sound/description/montreal_lachine_catholic_cemetery_interior.mp3"
        }
    }, 
    "connected_zones": ["Lachine Catholic Cemetery"], 
    "characters": []
}, 


"Boulevard Saint-Joseph": {
    "zone_name": "MontrealBoulevardSaintJoseph", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/montreal_boulevard_saint_joseph.png", 
            "description": "This is the boulevard where Lachine puts on its good shirt. The one without the holes, ironed flat and sprayed with cheap cologne. Boulevard Saint-Joseph is clean in the way morgues are clean. Tiled, scrubbed, and humming under fluorescent lights. Tourists drift past flower beds arranged by forgotten committees. There are plaques, benches, municipal promises. But nothing grows here except suspicion. Behind the smiling cafés, families sleep three to a room. Behind the heritage signs, drywall peels in long, curling strips like a confession.\n\nThe canal once spat out visitors here, so the city built a stage. They swept the concrete. They put lanterns in the trees. No one talks about the break-ins, the overdoses, the way the wind seems to carry sirens from streets you are not supposed to see. But they are there, stitched just behind the brick. You can feel them if you stand still long enough. The hum of rot beneath civic pride. The long ache of a place pretending it was never poor.\n\nThe boulevard smiles for the photo. Its eyes are elsewhere.", 
            "sound_path": "res://sound/description/montreal_boulevard_saint_joseph.mp3"
        }
    }, 
    "connected_zones": ["El Meson Front", "Lachine"], 
    "characters": []
}, 


"El Meson Front": {
    "zone_name": "MontrealElMesonFront", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/montreal_el_meson_front.png", 
            "description": "The front of El Meson is holding itself together with salsa and spite. The stucco is peeling, the sign is half-lit, and the patio furniture has clearly seen some things, but the smell ( charred meat, lime, grease, smoke ) is the kind of perfume that makes you forgive architecture. A busted speaker inside plays the same ranchera it did yesterday and the day before that, as if time here isn’t linear but circular and full of laughter. Stray cats drift through like ghosts of old customers, and the pigeons look at you like they know your order. Something about this place insists it is still alive. Not just open. Alive.", 
            "sound_path": "res://sound/description/montreal_el_meson_front.mp3"
        }
    }, 
    "connected_zones": ["El Meson Inside", "Boulevard Saint-Joseph"], 
    "characters": []
}, 

"El Meson Inside": {
    "zone_name": "MontrealElMesonInside", 
    "default_viewpoint": "main", 
    "category": "Restaurant001", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/montreal_el_meson_inside.png", 
            "description": "Inside El Meson, it's always just past midnight and nobody’s ready to go home. The air buzzes with music from a busted jukebox that somehow always hits the right song, something warm and nostalgic with too much reverb. Laughter bounces off the tiled walls, mixing with the sizzle from the kitchen and the clatter of plates that have been refilled twice already. A glowing red crucifix watches from above the bar like it’s in on the joke. The chandeliers rattle with every cheer, and the Virgin portraits look amused under the neon light. Tables are packed with regulars and strangers alike, passing tacos and ghost stories in the same breath. The floor is sticky in spots and the tequila is cheaper if you don't ask questions. And no matter how late you stumble in, the cook’s cousin or brother or maybe just some guy who lives upstairs always greets you with the same booming “¡Hola señor!” like you’ve been expected all along. This is a place that doesn’t close. It just pauses for breath.", 
            "sound_path": "res://sound/description/montreal_el_meson_inside.mp3"
        }
    }, 
    "connected_zones": ["El Meson Front"], 
    "characters": []
}, 


    "Montréal-Nord": {
        "zone_name": "MontrealNord", 
        "default_viewpoint": "main", 
        "category": "montreal_high_outside", 
        "is_neighborhood": true, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/MontrealNord.png", 
                "description": "The pavement is stained before you arrive. Oil, piss, something darker. Montréal-Nord doesn’t hide it. It presents the violence like a menu.\n\n\tA man shouts from a balcony. Another one doesn’t respond. Minutes later, there’s glass on the ground and a woman screaming into a disconnected phone.\n\n\tNeon buzzes above a dépanneur with bulletproof glass. Inside, the cashier counts pills into a napkin. No one speaks. You hear the hum of a fridge and the click of a safety switch.\n\n\tKids play soccer near a taped-off alley. One of them kicks too hard and the ball rolls into blood. They laugh and keep going.\n\n\tIn the stairwell, someone is crying. It sounds like they’ve been doing it for days.\n\n\tEverything smells like metal and snowmelt. The lights twitch. The shadows twitch back. You walk faster, but the city doesn’t let go. It clamps around you like a hand.\n\n\tNothing breathes here. It seethes."\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/MontrealNord.mp3"
            }
        }, 
        "connected_zones": ["Boulevard Saint-Michel : Montréal-Nord", "Boulevard Industriel", "Saint-Michel", "Saint Leonard", "Ahuntsic-Cartierville", "Rivière-des-Prairies"], 
        "characters": []
    }, 




    "Boulevard Saint-Michel : Montréal-Nord": {
        "zone_name": "Boulevard Saint-Michel", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/boulevard-saint-michel.png", 
                "description": " The Boulevard Saint-Michel - where the working people press together into a too short stretch of bars, restaurants and clubs, hoping to drown the hard day's work into a glass (or five).  Here, fights and disappearances are just a matter of time - and  few are missed, in the constant flux of migrants struggling to make a life for themselves. Drug deals go down in back alleys and prostitutes loiter on the sidewalks.\n\nForeign faces cluster together in hopes of making a community in an unfamiliar and hostile place. Clinging to those small threads of similarity to ground them in the isolating pulse of a city all too keen to take, until there was nothing more to give. Here they drown their sorrows, dance away worries, and make all the poor decisions that will haunt them at work the next day, when the hangover comes calling."\
\
, 
                "sound_path": ""
            }, 
   "Alleyways": {
                "image_path": "res://Image/ViewpointImage/AlleywayBoulevardSaintMichelMontrealNord.png", 
                "description": "Just beyond the thrum of Boulevard Saint-Michel, where neon signs burn and music spills from open doorways, the alleyways begin like hidden fractures in the city's body. Step a few paces off the boulevard and the sound of revelry muffles, collapsing into echoes, the bass of nightclub speakers reduced to a dull vibration that seems to pulse through the stone.\n\nThe alleys are narrow, hemmed in by the back walls of bars and cafés, their bricks sweat-stained and tagged with graffiti layered over decades. Trash bins overflow, their metal sides dented and streaked with something sticky, sweet, and sour in the air. Light comes in uneven patches from lamps bolted high on walls, most of them flickering or haloed with grime. It feels as though the alleyways are waiting-narrow channels of brick and shadow, pressing in close, swallowing whatever wanders too far from the lights of Saint-Michel."\
\
, 
                "sound_path": ""
            }
        }, 
        "connected_zones": ["Couche-Tard : Boulevard Saint-Michel", "Montréal-Nord"], 
        "characters": []
    }, 

    "Couche-Tard : Boulevard Saint-Michel": {
        "zone_name": "Couche-TardBoulevard Saint-Michel", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Couche-TardBoulevardSaint-Michel.png", 
                "description": "A neon 'open' sign blazes from the window all hours of the night. The fluorescent lights flicker overhead, illuminating the cigarettes and lotto cards on sale behind the counter. It is what it is, and makes no pretension otherwise. In that way, it is comforting.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Boulevard Saint-Michel : Montréal-Nord"], 
        "characters": []
    }, 



    "Saint-Michel": {
        "zone_name": "SaintMichel", 
        "default_viewpoint": "main", 
        "category": "montreal_high_outside", 
        "is_neighborhood": true, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/SaintMichel.png", 
                "description": "The ground here remembers being torn open.\n\n\tSaint-Michel sprawls over a quarry full of water, junk, and rot. The factories cough smoke or sit hollow. The air sticks. Everything smells like rust and burnt wires.\n\n\tTriplexes lean close. The alleys stay wet. Furniture lives on balconies year-round. Oil stains run down the stairs. Nothing moves fast. Fights start slow, then don’t stop.\n\n\tThe metro buzzes like a nerve. Sirens pass without slowing. Fires start and no one asks why.\n\n\tSaint-Michel doesn’t wait. It watches. It presses. It wants to see what breaks first. It hopes so dearly that it'll be itself."\
\
\
\
, 
                "sound_path": "res://sound/description/SaintMichel.mp3"
            }

        }, 
        "connected_zones": ["Saint-Michel Metro – Exterior", "Avenue Charland", "Montréal-Nord", "Saint Leonard", "Ahuntsic-Cartierville", "Rosemont", "La Petite-Patrie", "Villeray"], 
        "characters": []
    }, 

"Avenue Charland": {
    "zone_name": "Avenue Charland", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/avenue_charland.png", 
            "description": "Avenue Charland runs tight between its rows of worn brick, where neon leaks down in streaks and the fog bends the light into crooked halos. Signs buzz overhead, painting the wet pavement in sickly color. Puddles stretch the reflections into claws, each lamp and bar sign warped until it feels more like a wound than a glow. The street itself feels narrow not from its width, but from the weight pressing in on both sides.\n\nHere, doorways lean forward as if listening. Graffiti coils into symbols no one remembers writing. The air tastes of metal, damp stone, and smoke, heavy enough that every breath feels stolen. Avenue Charland is not silent, but its voice is buried under the static of its own lights, muttering just low enough that you cannot decide if you should leave or listen.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Avenue Charland : Hole in One", "Saint-Michel"], 
    "characters": []
}, 

"Avenue Charland : Hole in One": {
    "zone_name": "Avenue Charland: Hole in One", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/holeinone.png", 
            "description": "The Hole in One in Saint-Michel sits like a bruise on the block, equal parts neon lure and concrete bunker. The exterior is a low, squat building with a retrofitted façade that pretends at glamour. Cheap neon tubing shaped into a martini glass glows above the front doors, the word HOLE blinking more often than it stays lit, while the “IN ONE” buzzes faintly, half-fried from years of neglect. The windows are blacked out, painted or tinted so no one on the street can peek in, and the entrance is set into a recessed alcove framed by flickering red lights. A hand-painted sign advertises nightly shows and “VIP Rooms,” letters peeling under the glow.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Avenue Charland", "Hole in One"], 
    "characters": []
}, 

"Hole in One": {
    "zone_name": "Hole in One", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/holeinoneinside.png", 
            "description": "The main floor of the club sprawls out in a wide rectangle, anchored by a long, sticky bar running along the left-hand wall. Behind it, bottles of liquor, cheap and mid-shelf mostly, are lined up in front of a huge mirror clouded with age. A tired looking barmaid in fishnets and a leather miniskirt tends to the regulars, her tired smile rehearsed, but her eyes sharp.\n\nA couple of security cameras peek from above the shelves, their feeds piped somewhere back to the manager’s office, watching every angle.\n\nAround the stage, rows of small round tables press close together, sticky rings of old drinks staining their surfaces. Patrons sit slouched in their chairs, throwing bills or staring with glassy eyes. Farther back, booths line the walls in shadow, offering more privacy for deals, whispered conversations, or whatever else money can buy here.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Avenue Charland : Hole in One"], 
    "characters": []
}, 

"Hole in One: Blake's Office": {
    "zone_name": "Hole in One: Blake's Office", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/holeinoneblakeoffice.png", 
            "description": "Blake’s office is everything you’d expect from a seedy strip club manager who thinks he’s living the high life. The smell hits first: a mix of stale cigar smoke, cheap cologne, and the faint chemical tang of whatever drug residue lingers in the carpet fibers.\n\nThe centerpiece is a massive waterbed, its black vinyl sheets tacky with age, rimmed with brass piping, and surrounded by mirrors bolted to the walls and ceiling, so every angle of excess can be seen twice over. The mattress sloshes with any movement, sending lazy waves across the surface. A red silk throw lies crumpled at the foot, like an afterthought of decadence.\n\nAlong the right-hand wall sits a couch in gaudy cheetah print, threadbare at the arms but still loud enough to draw the eye. It’s flanked by two glass topped end tables, stacked with ashtrays, pill bottles, and a couple of empty bottles of liquor. The floor beneath is littered with cigarette butts, old magazines, and the occasional wrapper from fast food left to rot.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Hole in One"], 
    "characters": [], 
    "secret_entry_passwords": ["Blake"], 
    "accessible_from_zones": ["Hole in One"]
}, 


"Saint Leonard": {
    "zone_name": "Saint Leonard", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Saint_Leonard.png", 
            "description": "Saint Leonard pretends at suburbia, but the asphalt remembers the farms. Rows of bungalows sit where grapevines once stretched, and the smell of soil still clings to basements and garages. The streets are wide, the houses close, and everyone knows everyone else’s curtains. It feels safe until the sodium lamps flicker and the alleys fill with steam from the sewer grates. The kids who grew up here wear leather now, leaning against parked cars outside strip malls, smoking with the same hands their fathers used to prune vines. Old men play cards in cafés that never close, their voices hoarse with dialect and suspicion. The night is calm but restless, lit in slices of red and green from corner bars.", 
            "sound_path": "res://sound/description/Saint_Leonard.mp3"
        }
    }, 
    "connected_zones": ["Montréal-Nord", "Saint-Michel", "Anjou", "Rosemont"], 
    "characters": []
}, 



    "Lost Ladle's Kitchen": {
        "zone_name": "Lost Ladle's Kitchen", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Soup.png", 
                "description": "A soup kitchen owned and ran by a woman named *Lady* Maggie Apatos. The shop runs late into the night, it's soft neon lights offering respite for the city's lost.  ", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Saint Leonard"], 
        "characters": [], 
        "secret_entry_passwords": ["Soup"], 
        "accessible_from_zones": ["Saint Leonard"]
    }, 




"Ahuntsic-Cartierville": {
    "zone_name": "Ahuntsic-Cartierville", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Ahuntsic-Cartierville.png", 
            "description": "Ahuntsic-Cartierville moves like the old north of the island forgot how to change. The factories near Chabanel still breathe behind thick doors, while the river slides past warehouses and brick duplexes gone soft at the edges. Families live above dépanneurs where the bell barely rings, and the parks near Sault-au-Récollet hold on to rituals no one admits to practicing. Hôpital Fleury watches from its corner like a bureaucrat in a white coat, always lit, never blinking. Planes pass overhead, low and constant, but never seem to land. This isn’t the end of the city. It’s where the static settles.", 
            "sound_path": "res://sound/description/Ahuntsic-Cartierville.mp3"
        }
    }, 
    "connected_zones": ["Fleury Hospital: Exterior", "Saint-Michel", "Montréal-Nord", "Parc-Extension", "Villeray", "Saint-Laurent", "Côte-des-Neiges"], 
    "characters": []
}, 

"Fleury Hospital: Exterior": {
    "zone_name": "Fleury Hospital: Exterior", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/FleuryHospitalExteriorMain.png", 
            "description": "Fleury Hospital is where people go to die. Towering over the district, it looms like a magnifying glass over an anthill, sterilizing the otherwise dingy surroundings. This is not a place of healing, but of waiting for the inevitable to come to a population most would rather ignore.\n\nThe smell of bleach and coffee assaults the nostrils when entering. The presence of death makes this place seem older than it really is. Everyone seems so solem, everything so unclean. A semi-circlular desk and a hanging sign above it reading, ACCUEIL welcomes guests with a red courtesy phone a few meters after walking in."\
\
, 
            "sound_path": "[ambulance siren, city sounds]"
        }, 
        "Emergency Entry": {
            "image_path": "res://Image/ViewpointImage/FleuryHospitalExteriorEmergencyEntry.png", 
            "description": "The emergency entry is always busy - ambulances come in and out, and gurneys rattle over the pavement as sliding doors whoosh open and closed behind sleep deprived paramedics. The crying cacophony of the waiting room sings out with every whoosh of the door. With it, you can feel the hope of those inside escape into the evening air.", 
            "sound_path": "[groans of pain, wheeled gurney sounds]"
        }
    }, 
    "connected_zones": ["Ahuntsic-Cartierville", "Fleury Hospital: Triage"], 
    "characters": []
}, 

"Fleury Hospital: Triage": {
    "zone_name": "Fleury Hospital: Triage", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/FleuryHospitalTriage.png", 
            "description": "The triage is loud, crowded and miserable. The flourescent lights add a level of jaundice to the cramped collective of ill and infirm.  Even the orderly who went breezing by smelling suspiciously like weed and alcohol seemed afflicted. The patients stare up at one TV with sagging eyes, and open mouths, watching a silent news anchor read the news with French Captions. A crackling voice goes out over the intercom, paging some member of the medical team to the ER.\n\nThere's an aging, burly nurse working the check-in and triage desk who's gossiping with another. You have the feeling she is the kind of no-nonsense nurse that knows how to pin you down, and give you a cavity search while enjoying it a little too much on her end. \n\nThere is a sliding, automatic door leading outside to where a couple of unlit ambulances are parked."\
\
\
\
, 
            "sound_path": "[someone coughing, baby crying, people arguing]"
        }
    }, 
    "connected_zones": ["Fleury Hospital: Exterior", "Fleury Hospital: Medical Ward", "Fleury Hospital: Hospital Room", "Fleury Hospital: Elevator"], 
    "characters": []
}, 

"Fleury Hospital: Medical Ward": {
    "zone_name": "Fleury Hospital: Hallway", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/FleuryHospitalHallway.png", 
            "description": "The halls of the hospital are boring and liminal - confusing and maze like. How long have you been stuck here? The smell of sterile medical plastic stings the nostrils when the lift doors open. There is a low rumble coming from the Nurses' Station as they take calls and prepare the next round of vitals, medication and getting yelled at by Doctors. The sounds of dozens of EKG machines bleep through the ward, accompanied by the the low rumble of the TVs in patients' rooms. In the distance, someone is crying.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Fleury Hospital: Triage", "Fleury Hospital: Labs", "Fleury Hospital: Hospital Room", "Fleury Hospital: Elevator"], 
    "characters": []
}, 

"Fleury Hospital: Labs": {
    "zone_name": "Fleury Hospital: Labs", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/FleuryHospitalLabs.png", 
            "description": "The smell of sterile medical plastic is strong here. This floor is brightly lit up, almost excessively so. This floor is entirely equipped to take all patient samples and give a full analysis with their microscopes and slides, test tubes, centrifuges, and auto-klaives. A couple of younger post-grad types are usually found in here at night. They quietly do their work with headphones covering their ears. The walls are adorned with charts and diagrams of science and human anatomy. There's a picture of some older gent in a white coat mounted to a dart board looking out at the room with a painfully paternalist expression.", 
            "sound_path": "[beep of hospital equipment, air conditioning, heavy breathing?]"
        }
    }, 
    "connected_zones": ["Fleury Hospital: Medical Ward", "Fleury Hospital: Elevator"], 
    "characters": []
}, 


"Fleury Hospital: Hospital Room": {
    "zone_name": "Fleury Hospital: Hospital Room", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/FleuryHospitalHospitalRoom.png", 
            "description": "Though the room is private, you still feel exposed. Machines beep and hum, with medical implements and supplies carefully arranged in cupboards, bins, and glass containers. There is an attempt made at cleanliness here that escapes the more public areas of the hospital, but it is only surface deep. Looking closer, the trash bin is overflowing, the sharps container has used needles sticking out of it, and there is a stink in the exam table that just won't leave, filling your nose as you shift in your seat.", 
            "sound_path": "[beeps, rolling chair noises, curtains opening, bed rustling, door closing]"
        }
    }, 
    "connected_zones": ["Fleury Hospital: Medical Ward", "Fleury Hospital: Triage"], 
    "characters": []
}, 



    "Fleury Hospital: Elevator": {
        "zone_name": "Fleury Hospital: Elevator", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/hospital-elevator-interior.png", 
                "description": "The dingy light flickers as you enter the elevator, barely large enough to fit a gurney. The Muzak sofly emits from the small speaker coming somewhere from above your heads. The vertical panel of buttons, which look half rubbed off after years of use, show the available floors.Your arrival at a given floor is heralded by a chime, and a canned, static-filled voice calling out something unintelligible.", 
                "sound_path": ""
            }
        }, 
        "connected_zones": ["Fleury Hospital: Medical Ward", "Fleury Hospital: Triage", "Fleury Hospital: Morgue", "Fleury Hospital: B1", "Fleury Hospital: Labs"], 
        "characters": []
    }, 

    "Fleury Hospital: B1": {
        "zone_name": "Fleury Hospital: B1", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/hospital-basement1.png", 
                "description": "It's quiet, short of the hum of something, maybe a furnace or heating system operating. There are a series of large exposed pipes and conduits running along the ceiling. Most of what is seen here are doors with various signs denying entry to those Not Authorized. One of them says, 'Security Personnel Only.'\nThe idling janitor carts in the hallways lead you believe maintenance and janitorial services begin, and end their shifts on this floor."\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Fleury Hospital: Elevator"], 
        "characters": [], 
    }, 


    "Fleury Hospital: Morgue": {
        "zone_name": "Fleury Hospital: Morgue", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/hospital-morgue.png", 
                "description": "You immediately feel the cold when the doors to the lift open. It's quiet here too, dead quiet. It makes the sound of your footsteps louder than they probably should. The smell of water, sanitzing chemicals and humors gently waft through this floor.\n \nThe morgue is at the end of a long hallway that is dimly lit. One of the light ballasts house faulty bulbs that eerily flicker off and on. Passed a small desk, and through a door marked, 'Morgue' lies the whole operation; autopsies, post-morts, and freezers to preserve them until moved to their final resting places. A single, blanket covered corpse drains its fluid from a tube in its leg that sticks out from under the covers, into a large drain in the floor. The whole place is tiled in some dingy white and sea green hue like it was built in Florida during the 1960s"\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Fleury Hospital: Elevator"], 
        "characters": [], 
    }, 


    "Fleury Hospital: Pharmacy": {
        "zone_name": "Fleury Hospital: Pharmacy", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/hospital-pharmacy.png", 
                "description": "The stench of the world's largest jar of daily vitamins strikes when the lift doors open. The hallway leading from the elevator to the tiny waiting room is very short. On the opposite side of this waiting room is a wall with a single, solid-looking security door made of metal, and a small 'drive-thru' window for the Pharmacists and Techs to take and fulfill prescriptions. There is a security camera for the door, the window and the sitting area with it's total of three uncomfortable looking chairs. It's very dark here. If anyone is working over night, they are way behind that solid, metal door.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Fleury Hospital: Labs"], 
        "characters": [], 
    }, 






    "Mercier": {
        "zone_name": "Mercier", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Mercier_neighborhood.png", 
                "description": "This is where the island shows its bruises. Mercier was once a city unto itself, stretched thin along the river like a prayer that never got answered. Then it was annexed. Then it was forgotten. The factories and industry are mostly dead now. What remains is rust and routine, with the spaces that once held industry blooming with new growth - parks, gardens. The churches here echo too much. The schools look more like fortresses. And the alleys never stop steaming, even in winter. Poor but proud, French here is the mother-tongue, spoken raw and fast. Violence here does not sneak in; it stomps through the front door. Demonstrations against new industrial projects, fights in the metro, fires in the night. The local government throws up murals and food banks like wards against collapse. Something is growing in the cracks between these concrete slabs. Not a movement. Not a miracle. Just pressure. Roots buckling pavement, trying to tear off the modern facades and return to something greener.", 
                "sound_path": "res://sound/description/Mercier.mp3"
            }, 
        }, 
        "connected_zones": ["Anjou", "Hochelaga-Maisonneuve", "Rosemont", "Montréal-Est"], 
        "characters": []
    }, 


    "Hochelaga-Maisonneuve": {
        "zone_name": "Hochelaga-Maisonneuve", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/hochelaga-Maisonneuve_neighborhood.png", 
                "description": "This is where the island shows its bruises. Hochelaga was once a city unto itself, full of smokestacks and sweat, proud and ugly and loud. Like Mercier, it followed a similar fate. The factories are mostly dead now. Old unions. Old grudges. The backfiring of cars and the roar of biker gangs have replaced the clangs and shouts of industry. Saint Catherine Street East cuts through it like a vein that s been opened too many times. Here, it is the people who keep what little order there is, not the government. Eyes shift pass as groups meet in carefully selected restaurants. They look away as items change hands in an alley. The women on the corners are pretty and eager, waving at the cars and bikers passing by as they strut and show off the merchandise.\n\nNobody trusts each other much. Not the cops, not the landlords, not the neighbors. But they all know when to keep their heads down. Everyone knows someone who got jumped last week. Everyone knows which stairwells to avoid. Kids walk to school past boarded-up storefronts and act like they don t see the needles. It is a place that functions, barely, on muscle memory and spite.\n\nSomething builds beneath the worn-down exteriors and tired faces. You feel it in the way people glance over their shoulders. In the way they speak faster and listen less. The city marks this place as up-and-coming, but no one here believes in upward anymore. Just coming. Whatever it is, it is already on its way."\
\
\
\
, 
                "sound_path": "res://sound/description/Hochelaga-Maisonneuve.mp3"
            }, 
        }, 
        "connected_zones": ["Mercier", "Rosemont", "Plateau Mont Royal", "Centre-Sud", "La Petite Patrie"], 
        "characters": []
    }, 


"Montréal-Est": {
    "zone_name": "MontrealEst", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/MontrealEst.png", 
            "description": "Montréal-Est sits by the oil tanks, where the river bends wide and chemical lights stain the night sky. The factories breathe steady, their chimneys spilling smoke that drifts like scripture across the dark. Streets here run flat and functional, lined with warehouses and small brick houses pressed close against chain-link fences. The smell of gasoline lingers in every doorway, and puddles catch neon from trucks rolling past like restless sermons.\n\nIt is an industrial parish, lit not by stained glass but by refinery flames that never die. The silence between shifts feels heavier than prayer, broken only by the hiss of valves and the groan of metal. In Montréal-Est, the city’s hunger is not romantic. It is mechanical, chemical, a machine that keeps running even when no one is watching.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Pointe-aux-Trembles", "Mercier", "Anjou"], 
    "characters": []
}, 

"Côte Saint-Luc": {
    "zone_name": "CoteSaintLuc", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/CoteSaintLuc.png", 
            "description": "Côte Saint-Luc sits like a city within the city, bordered by rail yards and highways that close it off from the rest of the island. Apartment towers rise over brick duplexes and tidy lawns, anchored by the shopping centre where groceries and banks keep the pulse steady. It is a Jewish enclave, its synagogues and community halls setting the rhythm of life, the windows going dark early while bakeries and family shops stand as old guardians against the pull of downtown.\n\nAt night the neighborhood holds its breath. The streetlamps hum along Cavendish but their glow falters in the hedges and the alleys, leaving the silence thick. To the north, the rail yards stretch out like an open wound, cars resting in endless rows under the stars. The calm feels heavy here, not protective but suffocating, as if the stillness itself has weight. The quiet listens back, and something in it waits.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Lachine", "Côte-des-Neiges", "Saint-Laurent", "Dorval", "Notre-Dame-de-Grâce"], 
    "characters": []
}, 



"Plateau Mont Royal": {
    "zone_name": "PlateauMontRoyal", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/PlateauMontRoyal.png", 
            "description": "The Plateau is the city’s painted smile. Rows of spiral staircases and murals peeling like sunburn. It was once working class, then artistic, now both and neither. Everything here is façade. Painters drink with lawyers. Poets rent from hedge funds. The corner cafés smell like burnt espresso and rising rent. Meanwhile, Centre-Sud squats just beneath it, quieter and colder. A place where the bones of Old Montreal still show through the cracks.\n\nThey built this part of the city early, and they built it wrong. The sewers breathe at night. The air smells like old bread and forgotten blood.\n\nThe Plateau is already changing. Young francophones from the suburbs are moving in with stolen furniture and big ideas. English still lingers in Mile End and Saint-Louis Square, but it is the language of grandparents and landlords now. Immigrants are priced out one block at a time. The city loves to show off the Plateau, a “cultural beacon”...but those who live here know the beauty only goes skin deep.\n"\
\
\
\
\
, 
            "sound_path": "res://sound/description/PlateauMontRoyal.mp3"
        }
    }, 
    "connected_zones": ["Parc-Extension", "Mont-Royal West", "Quartier des Spectacles", "La Petite-Patrie", "Hochelaga-Maisonneuve", "Centre-Sud", "McGill – Downtown Campus"], 
    "characters": []
}, 



"Mont-Royal West": {
    "zone_name": "Mont-Royal West", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/mont-royal-west.png", 
            "description": "It wears its past like a coat gone thin at the elbows. Once it was parades and bakeries, now it is pawnshops, cheap bars, and apartments that groan through the night. You catch the languages still layered in the brick, French laughter, Yiddish prayers, Irish curses, all pressed together into the same tired mortar. The street never stopped changing, it only collected scars. \n\nWhat was once promenade turned into corridor, each doorway a palimpsest. Priests smoked where students now drink, brass bands dissolved into synth beats, and the ghosts of corner cafés still linger behind the neon. Mont-Royal West does not tell its history. It forces you to walk through it, step by cracked step.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Jailhouse Rock Cafe Deck", "Plateau Mont Royal"], 
    "characters": []
}, 




    "JRC Venue": {
        "zone_name": "JRC Venue", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/jailhouse-venue.png", 
                "description": "The narrow store front betrays the reality of the space available inside the venue. The length of the venue was 30 meters long, making plenty of space for people on the inside.The walls are adorned with fliers of shows coming. Iconic shows that had already come were bound in a frame to be adored for all time. \n\nThe  Wall of Elvi , a wall painted with Elvis in the Jailhouse, and all around him are pictures of world-renowned Elvis impersonators, including Pol Parsley THE Thai Elvis.\n\nBartenders worked behind a wooden, L-shaped bartop. They keep their cool while passing out dozens of drinks to the demanding public, scrambling for tips to make rent in the big city. \n\nBehind them are shelves of booze that flicker with the lights flashing, and strobing from the ceiling and stage. \n\nOn the opposite side of the venue is the stage, and what seems like some sort of small hallway with a double hinged door swinging in and out as people regularly pass through. There is a homemade, wooden sign that says  Restrooms nailed to the front of the door. "\
\
\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Jailhouse Rock Cafe Deck", "JRC Hallway"], 
        "characters": []
    }, 


    "JRC Hallway": {
        "zone_name": "JRC Hallway", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/jailhouse-hallway.png", 
                "description": "This hallway is narrow, and much shorter than the rest of the venue s high ceiling. Tthere is a right turn leading to the Gents and the Ladies. A few feet further down leads to another room that is guarded by another bouncer when there is a show that night. When the way is clear, it leads to the Green Room for the big acts that came that way. It was also for the few people who were  cool enough  to know about it, and loiter there with some privacy.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["JRC Venue", "JRC Green Room"], 
        "characters": []
    }, 


    "JRC Green Room": {
        "zone_name": "JRC Green Room", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/jailhouse-greenroom.png", 
                "description": "The Green Room (with red walls) is small, but adequate to comfortably hold the big acts and their various dalliances with a series of old, but clean and comfortable looking couches and chairs. A warm, dull light emits from a couple of lava lamps, and some white icicle Christmas lights draped all around at the tops of the walls.\n\nThere is a very old floor tom sitting on a small pillar. The hardware on it is a bit rusty, and the glitter finish drum wrap was losing its luster. But sticking out the side, near the bottom, was a spout. The pillar had a small plaque in front of it.\n\nThe plaque refers to how this was once a hidden room in a Canadian  speakeasy  when Montreal was one of the few safe havens for booze during Canadian prohibition. \n"\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["JRC Hallway", "JRC Stage"], 
        "characters": []
    }, 


    "JRC Stage": {
        "zone_name": "JRC Stage", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/jailhouse-stage.png", 
                "description": "The stage stands 1.5 meters above the venue floor. It s made entirely of long planks of wood like an old theater stage. There were old, red curtains with dingy gold trim, drawstrings and tassels draped at the front. They strangely smelled of popcorn, beer and fire. There is an array of black cables, and input boxes for the bands to plug into before sound checks. \nThere is a rack of stage lights running across the front just behind the curtains that light up when a band is playing. A stage hand in the back controls it all with a few light and smoke contraptions they've got jury rigged together.\n\nThere is a trap door, but it doesn't seem to open from this side. No one knows how to open it, and get down under the stage. The stagehands figure the access under the stage was sealed off with a wall years before, and that it probably came out to the Green Room. "\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["JRC Green Room"], 
        "characters": []
    }, 


    "Jailhouse Rock Cafe Deck": {
        "zone_name": "Jailhouse Rock Cafe Deck", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/jailhouse-cafe-deck.png", 
                "description": "The nearby sounds of downtown Montreal began to fall to the wayside as the sound of the crowd, and loud music of the Jailhouse Rock Cafe grew louder. \nThe noise picks up the scent of booze, cigarettes, and cloves along with trace amounts of patchouli, sandalwood and pomade. A car passes by, and honks their horn at the people outside, raising their glasses and sending a  Wooo!  back to the passerby.\n\nThe front of this joint is an elevated deck standing a few feet above the sidewalk adjacent. It is loaded with tables, and people having a drink. A veritable French cafe for the greaser, the beatnik, the biker, the hippie and the head. All united under the banner of Rock and its last 40 years of life and evolution. \nThere are fliers in the windows behind the tables to showcase plays there next.\n\nWhen there was someone playing, the deck would be packed. So many came out to experience  the vibe  together, using booze and live Rock n Roll to forget about how horrible a place the real world is by listening to the music its oppressive atmosphere had created. Sometimes there would be a Burlesque show, or Rocky Horror night, but Rock n Roll was King at the Jailhouse Rock Cafe."\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Mont-Royal West", "JRC Venue"], 
        "characters": []
    }, 






    "Centre-Sud": {
        "zone_name": "Centre-Sud", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Centre-Sud_neighborhood.png", 
                "description": "Centre-Sud squats beneath the Plateau, waiting. Waiting for someone to notice. Centre-Sud remains what it was; bruised and patient. Home to the invisible, the addicted, the alone. There are community kitchens and punk shows and shelters with broken locks. Saint-Denis is all smoke and shouting on Friday nights. The alleys behind Ontario Street feel hungover before the sun even sets. \n\nLike the Plateau, this district is built on art, on culture - on the vibrance the people desperately infuse this place with, hoping that someone will see them and react with love instead of fear. It is a place of the deviant and the outcast, those who do not fit the mold of traditional society. It is the Gay Village - a quarantine from the rest of the city, where its residents are invited to a qualified freedom encased by careful walls.\n\n\nNo one talks about the overdoses in the Centre-Sud shelters. Or the nights when the power flickers and dogs will not stop barking. There are more fights lately. Not drunk, not petty. Just fast and final. A woman vanishes from her third-floor apartment. A man burns alive in an alley and no one hears a scream. It is as if the lights got too bright and started attracting the wrong kind of attention. "\
\
\
\
\
, 
                "sound_path": "res://sound/description/Centre-Sud.mp3"
            }, 
        }, 
        "connected_zones": ["Quartier des Spectacles", "Plateau Mont Royal", "Downtown Montreal", "Hochelaga-Maisonneuve", "Old Montreal"], 
        "characters": []
    }, 


    "Théâtre de l'Aube: Upper Loft": {
        "zone_name": "Théâtre de l'Aube: Upper Loft", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Kaina_UpperLoft.png", 
                "description": "As you enter, the floorboards groan beneath your feet, but it's the air that greets you first — It's stuffy in here. The scent of incense and lantern oil fighting to mask the unpleasant undertones of moss, rot and decaying velvet. The light is low but warm, cast by dozens of mismatched lanterns and candles tucked into alcoves, their glow pooling on faded murals. The shadows seem to squirm restlessly between the lanterns in the corner of your eyes, as though the excess lighting could only push rather than banish them.\n\nYour steps echo, a reminder of the run-down and abandoned grand theatre below. Strewn about the floor are threadbare carpets, whose once vibrant colors and intricate patterns have turned dull and dusted. They mute your steps when you step on them — but they're not meant to be stepped on with shoes.\n\nExposed walls and maintenance what-nots are mostly-hidden behind shelves, furniture, most of it wood and most of it old. Nothing quite matches, yet it's clear someone tried to make do with what they got to craft at least an illusion of a cozy space. A stage is strewn in the middle of the loft, but it's seemingly made into a bedroom of carpet and pillows, with chairs carefully arranged. A platter of lit candles sits below the arch, illuminating it prettily – yet writhing shadows linger below. One curtain is folded, seemingly fixed and sewn halfway through with another that doesn't quite match. Another curtain, smaller, not meant for the stage, was left to cascade dramatically. The loft is moreso magnetic than welcoming. It demands attention. "\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Théâtre de l'Aube: Attic", "Théâtre de l'Aube: Side Stairwell", "Théâtre de l'Aube: Bathing Room"], 
        "characters": []
    }, 


    "Théâtre de l'Aube: Entrance": {
        "zone_name": "Théâtre de l'Aube: Entrance", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Kaina_Entrance.png", 
                "description": "\nWelcome to the ironically named Theatre of Dawn.\n\nThe ticket booth stands empty but bright as ever, despite the dusty must that lingers about the foyer. Old posters are still hung up above it, and below a mock-stained glass decoration. Someone must be keeping the chandeliers and lanterns lit.\n\nThe waiting room seats are practically crumbling where they sit, the line of seats and lanterns above leading up to into a stairwell, and a locked door besides, with a long lost key. To the side of the booth stands the entrance into the grand theatre, just a short hallway walk away."\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Centre-Sud", "Théâtre de l'Aube: Side Stairwell", "Théâtre de l'Aube: Grand Hall"], 
        "characters": [], 
        "secret_entry_passwords": ["Eclipse"], 
        "accessible_from_zones": ["Centre-Sud"]
    }, 


    "Théâtre de l'Aube: Grand Hall": {
        "zone_name": "Théâtre de l'Aube: Grand Hall", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Kaina_GrandHall.png", 
                "description": "The former glory of this hall still runs strong, despite the loose debris on the floor and the torn, decaying curtains. \n\nEmpty seats o’ plenty stand in rows, so unused and aged that a gentle touch threatens to tear the red fabric that holds the cushioning. Before them, a stage where once talents told stories and wowed crowds, now sits empty and unused. \n\nAbove, more floors, more seats, with how dilapidated the building itself stands, one may lose themselves trying to find the way to the upper seats. Perhaps even when it bustled, this was an architectural issue with this theatre. Maybe a contributor to its inevitable abandonment in the future."\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Théâtre de l'Aube: Backstage", "Théâtre de l'Aube: Entrance"], 
        "characters": []
    }, 


    "Théâtre de l'Aube: Backstage": {
        "zone_name": "Théâtre de l'Aube: Backstage", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Kaina_Backstage.png", 
                "description": "Behind the heavy curtains and stage sits this room, where actors and other talents used to prepare for their entrance. Now it’s a makeshift meeting room, lit with lantern and candle light, decorated with mirrors and various old furniture, mismatched chairs and stools. Expertly cluttered to look cozy despite the water damaged flooring. Another curtain, not the stage curtain one behind had been hung up to make the illusion of pretty and theatrical below a naked, skeletal ceiling.\n\nOne a small table sits a small box, in it, some well-rolled cigarettes and candies for those who can still relish the sweetness mortal teeth crave. In another corner, a hookah, an authentic one, too. \n\nThe strong smell of incense over moss and rotting fabric sits in the musty, old building air."\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Théâtre de l'Aube: Grand Hall"], 
        "characters": []
    }, 


    "Théâtre de l'Aube: Side Stairwell": {
        "zone_name": "Théâtre de l'Aube: Side Stairwell", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Kaina_SideStairwell.png", 
                "description": "Have you been told to follow the lanterns? Perhaps you were, perhaps not. Perhaps you’re expected, or maybe you are an unwanted guest.\n\nThe stairwell is cramped, and yet it is clear someone put time and care to try and clean it and make it feel half cozy. It’s carpeted, but this is a carpet you can forget about, with one of those patterns so busy, they’re purposely made to hold dust and grime. \n\nLanterns are strewn about along with small basins filled with scented oils. There’s a certain ritualistic air to the arrangement - but a personal ritual, rather than something inherently meaningful for a crowd of individuals.\n\nThe walls are half deteriorating - they are long past renovation, yet decorated with mirrors parallel to one another, causing some glances to make the space feel bigger and endless, quite purposely so."\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Théâtre de l'Aube: Entrance", "Théâtre de l'Aube: Upper Loft", "Théâtre de l'Aube: Rooftop"], 
        "characters": []
    }, 


    "Théâtre de l'Aube: Attic": {
        "zone_name": "Théâtre de l'Aube: Attic", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Kaina_AtticRoom.png", 
                "description": "This rundown attic smells like dust and old paper. The woodboards groan violently at your feet on the first step, and grant you mercy on the next. Papers are in disarray, but somehow meticulously so.\n\nA single lantern hangs at the ceiling, gently swaying with draft wind. Packed boxes, likely holding miscellaneous items from last century, gather dust in corners and shelves of the cramped attic room. The sloped feeling only serves to add to the claustrophobic feel.\n\nOn the table sits a jar of dirt, most notably, among all the paperworks and books. Despite everything else, the room looks lived-in. Whoever does live here is unbothered by the cramped space and musty, dusty air."\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Théâtre de l'Aube: Upper Loft"], 
        "characters": []
    }, 


    "Théâtre de l'Aube: Bathing Room": {
        "zone_name": "Théâtre de l'Aube: Bathing Room", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Kaina_BathingRoom.png", 
                "description": "Someone worked tirelessly to make this even possible. There are basins strewn about, the largest one playing the role of a sink atop a shelf, with a small stool standing lonely besides. A mirror hangs in front, and above it, towels are seeming hung with the skeletons of the ceiling.\n\nThis was once a chemical room, but now, pipes have been exposed and bent and just one of them has a valve that actually runs water, albeit cold. For that, a heater stands in the corner - quite small, the type made for tea, but it seems to hold the metal basins strewn about quite well. Something between a small bathtub and a large basin sits against the wall, with a faucet that doesn’t actually work besides it and a mirror hung up on the wall above. \n\nCandles decorate the entire room, which smells sweetly of all the little metal and glass bottles of hair and body products, as well as other aromatics, some handmade, others squeezed out of their commercial bottles and into personalized ones."\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Théâtre de l'Aube: Upper Loft"], 
        "characters": []
    }, 


    "Théâtre de l'Aube: Rooftop": {
        "zone_name": "Théâtre de l'Aube: Rooftop", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Kaina_Rooftop.png", 
                "description": "A sort of cozy, half balcony half bare rooftop overlooking the city of Montreal.\n\nCarpets are strewn about, along with a book shelf and many loose piles of books only waiting to be picked up. Most in french, some in English. A small coffee table sits in the middle for use, but seems to usually be too cluttered. \n\nThe skeleton of a canopy stands at the rails, and used to hang up various lanterns, adding to the cozy feel of this chill view of the city and night sky, and death trap for a cainite by day."\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Théâtre de l'Aube: Side Stairwell"], 
        "characters": []
    }, 






    "Rosemont": {
        "zone_name": "Rosemont", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/rosemont_neighborhood.png", 
                "description": "This district was built by hands that knew brick and mortar better than names. Rosemont came from the east, steady and working. You can still see the Catholic past in the rooflines and cross-streets. But that past has faded into smoke and discount signage. It was never rich, but it was solid. The kind of place that felt permanent. That permanence is starting to crack now. Paint peels. Foundations shift. The old families move out. Something colder moves in.\n\nThe streets are full of French. Real French. Blue-collar and loud. Mechanics, bakers, civil servants. Their kids drift between punk bars and Cégeps. The old Italian men still play cards behind the Jean-Talon Market. There is money here, but it does not show itself. It hides in toolboxes and pension plans. Rosemont is stubborn. La Petite-Patrie is watchful. Together, they are a district that knows how to wait. The kind of place that knows a storm is coming and puts plastic over the windows without being told.\n\nIt is getting worse. Slowly. Quietly. Fights that used to end with black eyes now end with hospital visits. Police cars idle longer than they used to. There are more broken bottles on the sidewalks. More glances that linger too long. A woman falls from a third-floor balcony and the neighbors agree not to mention it. A kid starts screaming in class and no one can calm him down. The city says this is a district in transition. That word hangs in the air like mold. This place was built by workers. But it is being unbuilt by something else. Something no one is naming yet."\
\
\
\
, 
                "sound_path": "res://sound/description/Rosemont.mp3"
            }, 
        }, 
        "connected_zones": ["Anjou", "La Petite-Patrie", "Saint Leonard", "Saint-Michel", "Mercier", "Hochelaga-Maisonneuve"], 
        "characters": []
    }, 


    "La Petite-Patrie": {
        "zone_name": "La Petite-Patrie", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/la_petite_neighborhood.png", 
                "description": "Like Rosemont, this district was built by the working class. La Petite-Patrie sprouted behind it, row houses and corner shops in close formation. You can still see the shared Catholic past in the rooflines and cross-streets, the solidarity of first-wave immigrants beside the native Quebecois ever watchful.\n\nThe streets are full of French, Italians, and Vietnamese groceries that blink neon between barber shops, patisséries beside pizzarias. The money here is quiet, winding around the residential streets like the overgrowths of ivy. \n\nIt waits for the storm to hit, bracing itself with hunched shoulders and firm backs against a rising tide. Slowly. Quietly. Fights overstay their welcome. Anger lingers and simmers, waiting for a moment to explode out. There is more broken glass on the sidewalks. Like Rosemont, the word 'transition' lingers in the air like mold, creeping into lungs already taxed and straining. La Petite-Patrie's immigrants wonder if this new tide will be the one to force them out, but they refuse to go without a fight."\
\
\
\
, 
                "sound_path": "res://sound/description/LaPetitePatrie.mp3"
            }, 
        }, 
        "connected_zones": ["Villeray", "Hochelaga-Maisonneuve", "Parc-Extension", "Rosemont", "Plateau Mont Royal", "Saint-Michel"], 
        "characters": []
    }, 


    "Villeray": {
        "zone_name": "Villeray", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/villeray_neighborhood.png", 
                "description": "These are worker streets. Narrow, lined with triplexes and concrete yards, hung with laundry in summer and cigarette smoke in winter. Villeray sits quiet and tense, built on factory time and stubbornness.\n\nSomething is pressing in.\n\n Out of the entire island, this is where people crowd up the most. French and English are spoken, but neither leads. Greek, Urdu, Tamil, Bengali, Punjabi, Arabic, Creole, Italian. The families here live tight. Some whole buildings speak the same language. Others shift from floor to floor.\n\nThe rent is cheap. The jobs are scarce. There are playgrounds with broken swings and community centres with flickering lights. No one here believes in help. Only endurance.\n\n Lately, even that feels strained. The police do not come quickly. When they do, they ask the wrong questions. Old men walk here at night with knives in their pockets, waiting for the other shoe to drop."\
\
\
\
\
\
\
\
, 
                "sound_path": "res://sound/description/Villeray.mp3"
            }, 
        }, 
        "connected_zones": ["Ahuntsic-Cartierville", "Saint-Michel", "La Petite-Patrie", "Parc-Extension"], 
        "characters": []
    }, 


    "Parc-Extension": {
        "zone_name": "Parc-Extension", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/parc-extension_neighborhood.png", 
                "description": "Parc-Extension pulses like a fever, crammed with storefronts and stories in twenty languages. None of these neighborhoods were designed for grace. They were designed for function. Now that function has started to slip. The sidewalks crack. The windows fog. Something is pressing in. This side of the city always belonged to the newly arrived. Villeray and Saint-Michel are a few years ahead on the curve, but not by much. French, English, Italian and Greek, are all less spoken here than Hindu, Tamul, Bangla, Spanish, and Creole.\n\nThere are fights in the metro. Screams behind closed doors. A teenager dragged into a side alley and never seen again. People vanish between job shifts. This part of the city does not ask for safety. It asks only that the danger keeps moving."\
\
, 
                "sound_path": "res://sound/description/Parc-Extension.mp3"
            }, 
        }, 
        "connected_zones": ["Villeray", "Saint-Laurent", "La Petite-Patrie", "Plateau Mont Royal", "Ahuntsic-Cartierville", "Côte-des-Neiges"], 
        "characters": []
    }, 


    "Sud-Ouest": {
        "zone_name": "Sud-Ouest", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/sud-ouest_neighborhood.png", 
                "description": "This is where the city did its labor. Saint-Henri, Pointe-Saint-Charles, Little Burgundy, Ville- mard, Côte-Saint-Paul. Every name is a scar. The Lachine Canal carved through it like a wound that never closed. They built factories here. Textiles, metal, slaughter. The men died early, the women died quiet, and the city took their labor without gratitude. When the canal died, the silence was immediate. Trains stopped. Doors locked. Rats came back. No one cleaned up. They just painted over the brick and hoped no one would ask questions.\n\nThese nights, the Sud-Ouest holds on with white knuckles. Some houses are still owned by the families that built them. Others rot behind chain-link fences and foreclosure notices. French, mostly. Old stock, stubborn. But Haitian families have started to fill the cracks. So have Vietnamese and Irish remnants. Black youth keep to Little Burgundy, out of habit more than hope. English lingers here, but it feels apologetic. These streets do not belong to optimism. They belong to routine. People go to work. People get drunk. People survive. Sometimes that is all.\n\nThe violence is not new here. It just changed tone. It used to be shouted. Now it whispers. A stabbing on Charlevoix. A house fire that leaves no one accounted for. A fight in a park that ends too quietly. The police come slower. They ask fewer questions. No one wants to know why the canal smells different after midnight. No one investigates the shoes found tied together on the abandoned bridge. The city has plans. Murals, condos, bike paths. But the ground refuses to heal. Something old still walks here. It remembers the machines. It remembers the blood."\
\
\
\
, 
                "sound_path": "res://sound/description/Sud-Ouest.mp3"
            }, 
        }, 
        "connected_zones": ["Lachine Canal", "Montreal West", "Westmount", "Notre-Dame-de-Grâce", "Downtown Montreal", "Old Montreal", "Pointe-du-Moulin", "Verdun", "LaSalle"], 
        "characters": []
    }, 


    "Anjou": {
        "zone_name": "Anjou", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Anjou.png", 
                "description": "Anjou sits at the far edge of Montreal like a half-forgotten outpost, caught between the remnants of farmland and the tightening sprawl of highways. Its streets carry the weight of suburban ambition turned brittle: rows of low-rise apartment blocks with their paint sun-bleached and peeling, modest bungalows pressed shoulder to shoulder, and concrete shopping plazas where neon signs buzz faintly, letters missing or flickering out one by one.\n\nIn the quiet corners an abandoned lot where weeds push up through fractured pavement, the underpass where lights always flicker out too quickly there is a sense that something else has taken root. Not openly, not visibly, but as a whisper threaded through the hum of fluorescent lights and the endless drone of highway traffic. People rarely linger in these places without reason. The neighborhood seems to breathe in its own uneasy rhythm, as if hiding something beneath its surface, something that had been buried but never stayed still."\
\
, 
                "sound_path": "res://sound/description/Anjou.mp3"
            }, 
        }, 
        "connected_zones": ["Mercier", "Saint Leonard", "Rivière-des-Prairies", "Montréal-Est", "Rosemont"], 
        "characters": []
    }, 


    "Pointe-aux-Trembles": {
        "zone_name": "Pointe-aux-Trembles", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/pointe-aux-trembles_neighboorhood.png", 
                "description": "Point-aux-Trembles breathes like a place on the fringe, pressed against the St. Lawrence, where the river wind carries both salt and rot. The streets stretch long and uneven, lined with squat duplexes and tired apartment blocks whose bricks have darkened with soot and years of weather. Paint peels from wooden balconies; laundry flaps on sagging lines even in the winter air, stiff and grey.\n\nFactories loom close to the water, their chimneys coughing smoke into the sky, shadows falling across rows of chain-link fences where the grass grows in tufts through cracked pavement. At night, the yards are seas of sodium light, orange halos spilling over pallets, rusted drums, and puddles of oily rainwater that ripple though nothing moves nearby. The hum of machinery is constant, though it shifts in pitch without warning, as if responding to something unseen.\n\nOn the main streets, corner dépanneurs glow with buzzing fluorescents, casting sharp light onto faces that linger outside too long, half-hidden in the smoke of cheap cigarettes. Stray dogs bark in the distance, then fall silent all at once, as though commanded. Kids trade whispered dares about the abandoned houses near the riverbank, where windows gape like missing teeth and the wind rattles doors that should not be able to move.\n\nThe sense of decay is not just in the rusting metal and crumbling stone but in the air itself, heavy with a kind of expectancy. You can feel it when you step beneath the flickering lamps of an underpass or pause at the mouth of an alley where the asphalt splits into darkness. It is the hush before something stirs, the uneasy awareness that the neighborhood is watching that behind the broken facades and empty lots, Point-aux-Trembles keeps its own secrets, and they are not all of this world."\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Rivière-des-Prairies", "Montréal-Est"], 
        "characters": []
    }, 


    "Rivière-des-Prairies": {
        "zone_name": "Rivi re-des-Prairies", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/riviere_des_prairies_neighborhood.png", 
                "description": "Rivière-des-Prairies feels like a boundary more than a neighborhood, caught between the suburban sprawl of Montreal and the wide, black breath of the river itself. The streets stretch long and quiet, dotted with duplexes and modest brick homes, their lawns patchy with crabgrass and oil stains from cars that sit idle too long. The air is thick with humidity in summer, carrying the smell of cut grass mixed with diesel from passing buses. In winter, the snow turns grey within days, piled high against chain-link fences and littered with cigarette butts.\n\nThe blocks near the industrial edge echo with silence once the workday ends warehouses shuttered, loading bays left in shadow, only the occasional rattle of a loose sheet of tin breaking the stillness. Stray cats slip through broken windows, and in the evenings, kids dare each other to climb the fences and peek inside. They swear the buildings hum even after the machines shut down, a low vibration felt more in the chest than the ears.\n\nCloser to the river, the atmosphere thickens. The water moves slowly, reflecting dull streaks of light from factories upriver, and the reeds at the shoreline rustle even when the wind is still. Abandoned docks sag into the current, their planks slick with algae, their iron bolts corroded like rotting teeth. Locals say you can sometimes hear voices carried over the water at night faint, disjointed, never close enough to understand.\n\nThe neighborhood carries a strange hush after dark. Streetlights flicker, casting uneven pools of light onto sidewalks where weeds force their way up through cracks. The silence is fragile, always on the verge of breaking: the distant slam of a dumpster lid, the squeal of rusted brakes, the sound of footsteps that don t quite match your own. Rivière-des-Prairies feels like it is waiting, holding something just out of sight. Its decay is ordinary enough to ignore by day, but at night, it sharpens into something else a sense that beneath the concrete, the water, the long streets leading nowhere, something old and restless has not been forgotten."\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Pointe-aux-Trembles", "Anjou", "Montréal-Nord", "Montréal-Est"], 
        "characters": []
    }, 













"LaSalle": {
    "zone_name": "LaSalle", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/LaSalle.png", 
            "description": "The river doesn’t slow for LaSalle. It rushes past in white curls and deep channels, shaping the land long before streets were drawn across it. The Lachine Rapids churn just beyond the parks, loud and constant, a reminder that this place was once the end of the line for canoes and cargo. The old canal still cuts through the landscape, half-forgotten but never erased. You can walk its length and feel where the city once stopped.\n\nLaSalle grew in pieces. Farmland gave way to industry, then to neighborhoods built for workers who wanted something stable, something theirs. Rows of brick duplexes stretch toward the horizon, their balconies stacked with chairs, flags, and flowerpots. Churches rise beside depanneurs. Schools hum with French, but the voices inside speak Italian, Haitian Creole, and Arabic after the bell rings. The land here holds stories, not landmarks. The rapids keep moving, the wind carries grit off the water, and people learn early how to plant their feet. This town does not wait for the city to notice it. It never needed to.", 
            "sound_path": "res://sound/description/LaSalle.mp3"
        }
    }, 
    "connected_zones": ["Lachine Canal", "Lachine", "Montreal West", "Verdun", "Sud-Ouest"], 
    "characters": []
}, 


"Verdun": {
    "zone_name": "Verdun", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Verdun.png", 
            "description": "Verdun breathes in smoke and river mist, a quarter that never quite dries. Neon lingers on wet asphalt, caught in puddles that ripple when the metro rumbles beneath. The balconies lean close, iron railings rusted, laundry left to stiffen in the damp air. You can hear the Saint-Lawrence at night, low and endless, carrying the weight of everything dumped into it. Bars spill their glow out onto cracked sidewalks, tired jukebox songs leaking into the street, as if the river itself had learned to hum along.\n\nThe churches stand tired, their colored glass washed pale by fluorescent glare. Graffiti scrawls climb their walls like unanswered prayers, while bridges murmur with traffic above. In Verdun, nothing is hidden. Every scar is shown in light, every sin painted in color. It feels like the city watching itself in a mirror too long, seeing the cracks, and deciding to keep them.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["LaSalle", "Sud-Ouest"], 
    "characters": []
}, 



"Saint-Laurent": {
    "zone_name": "SaintLaurent", 
    "default_viewpoint": "main", 
    "category": "montreal_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/SaintLaurent.png", 
            "description": "Saint-Laurent sits in the shadow of the mountain, not beneath it but behind it, just far enough that the weight of it feels muted. The old roads tilt east toward downtown, toward the spires and glass, but here the skyline breaks into smokestacks and satellite dishes. The factories still operate. The streets are built for trucks. Diesel clings to the air like a second language.\n\nBehind the wide boulevards, the town folds into itself. Armenian bakeries next to corner mosques. Casseroles cooling on balcony railings. French is spoken first, but no one expects it to be the last word. Saint-Laurent is protected by distance, by zoning, by memory. The mountain looms, yes, but it does not reach this far. Out here, the city feels imagined. Something told in stories. What is real are the loading docks, the church basements, the voices that slip between languages without pausing. The work begins early. The silence lasts longer. No one looks back unless they have to.", 
            "sound_path": "res://sound/description/SaintLaurent.mp3"
        }
    }, 
    "connected_zones": ["Ahuntsic-Cartierville", "Côte-des-Neiges", "Côte Saint-Luc", "Parc-Extension", "Pierrefonds", "Dollard-des-Ormeaux", "Dorval", "Lachine"], 
    "characters": []
}, 




"Dorval": {
    "zone_name": "Dorval", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Dorval.png", 
            "description": "You hear it before anything else. The drone of engines, constant and shifting, leaking through drywall and window frames. In Dorval, flight is not spectacle. It is weather. Planes cut the sky in tight descent, low enough to read the logos on their bellies. The air smells faintly of kerosene, especially near the highway, where hotels cluster like tired ideas.\n\nThis is not suburb or city. It is a threshold. The houses are older than they look, built before the island filled out. There are stretches near the lake where the grass grows long and the mailboxes still bear the names of families who arrived before Expo. People here are used to noise, used to being mistaken for something else. French and English pass without friction, often in the same breath. Dorval moves with a particular kind of patience, shaped by departure, but never in a rush to go anywhere.", 
            "sound_path": "res://sound/description/Dorval.mp3"
        }
    }, 
    "connected_zones": ["Pointe-Claire", "Dollard-des-Ormeaux", "Lachine", "Côte Saint-Luc", "Saint-Laurent"], 
    "characters": []
}, 



"Roxboro": {
    "zone_name": "Roxboro", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Roxboro.png", 
            "description": "Rust clings to the railings by the tracks. Gravel shifts underfoot where the platform ends near a graffitied fence. Roxboro was laid down around the rail line, a town shaped more by schedule than plan. Bungalows lean into each other along narrow lots, their paint faded, their hedges trimmed low enough to see who still lives there. The river sits behind it all, screened off by brush, wires, and forgotten footpaths.\n\nThis is a place that never pretended to be polished. Roxboro holds onto its renters, its lifers, its names scrawled into wet cement behind the dépanneur. French and English mingle without effort, not because of tolerance but because there is no room for distance. Flags hang in front windows, not for pride, but to remember where someone came from. Children play in gravel lots with cracked plastic toys. The train passes through on time. No one waits for it, but everyone knows when it’s late.", 
            "sound_path": "res://sound/description/Roxboro.mp3"
        }
    }, 
    "connected_zones": ["Sainte-Geneviève", "Dollard-des-Ormeaux", "Pierrefonds"], 
    "characters": []
}, 


"Dollard-des-Ormeaux": {
    "zone_name": "DollardDesOrmeaux", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/DollardDesOrmeaux.png", 
            "description": "The streets are wide and freshly paved, curving through rows of low brick homes and clipped front lawns. Street signs are clean, intersections marked by stop signs that everyone obeys. Sprinklers tick in unison at dusk. Nothing looks old here, and nothing looks like it plans to change. Dollard-des-Ormeaux was built for comfort, and it holds that shape carefully.\n\nFamilies came for order and stayed for insulation. Jews from Côte-Saint-Luc, Italians from the east end, Anglos who wanted nothing to do with referendum or downtown noise. French is there, but softened, more bureaucratic than cultural. Strip malls hold kosher butchers beside dollar stores and tailor shops, all under the hum of sodium lights. There are no landmarks, no nightclubs, no reason to visit unless you belong. And for those who do, that is exactly the point.", 
            "sound_path": "res://sound/description/DollardDesOrmeaux.mp3"
        }
    }, 
    "connected_zones": ["Sainte-Geneviève", "Pointe-Claire", "Kirkland", "Roxboro", "Dorval", "Saint-Laurent"], 
    "characters": []
}, 



"Sainte-Geneviève": {
    "zone_name": "SainteGenevieve", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/SainteGenevieve.png", 
            "description": "The stone church looks too large for the neighborhood. Built in the 1840s, its bell tower rises above the rooftops, watching the river like it remembers something the houses forgot. Sainte-Geneviève holds close to the shoreline, its streets laid along the routes oxen once dragged wheat to the old watermill. The bones of the parish run deep. Some of them are still in the crypt, beneath the church floor, where the founder was entombed after his body was brought back and buried again.\n\nFrench is spoken here without hesitation. Not out of pride, but because it always has been. The houses are modest, stone and wood, quiet behind hedges. Rain sticks to the pavement longer than it should. The river glows faintly at night, not from the city, but from something older... Nothing about Sainte-Geneviève feels abandoned, but it feels remembered in a way that most places are not.", 
            "sound_path": "res://sound/description/SainteGenevieve.mp3"
        }
    }, 
    "connected_zones": ["Pierrefonds", "Kirkland", "Dollard-des-Ormeaux", "Roxboro"], 
    "characters": []
}, 


"Pointe-Claire": {
    "zone_name": "PointeClaire", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/PointeClaire.png", 
            "description": "Old stone still clings to the shoreline where the mission once stood, its church tower watching the lake with the same silence it always has. Just uphill, the streets begin to twist into something else. Split-level homes with aluminum siding, old trees boxed in by sidewalks, a tired shopping centre that still smells like carpet and popcorn. Pointe-Claire grew outward from the lake like a memory trying to modernize, layer by layer, decade by decade.\n\nIn the bars near the train tracks, accents blur together over cheap pints and jukebox hum. Teenagers drift between arcades and depanneurs, pockets full of change and nowhere in particular to be. French and English trade places without warning, depending on who is speaking and who is listening. The lake is always near, even when you cannot see it, pulling at the edge of things. Not a threat. Just a reminder.", 
            "sound_path": "res://sound/description/PointeClaire.mp3"
        }
    }, 
    "connected_zones": ["Kirkland", "Beaconsfield", "Dollard-des-Ormeaux", "Dorval"], 
    "characters": []
}, 

"Pierrefonds": {
    "zone_name": "Pierrefonds", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Pierrefonds.png", 
            "description": "The lawns are wide in Pierrefonds, and the streets curve just enough to feel planned. Split-level homes line the blocks like teeth, all brown brick and vinyl siding, with porches big enough for folding chairs but not conversation. Kids ride battered BMX bikes in lazy circles, cutting through backyards and construction lots that never seem to finish what they started.\n\nIt’s a family place, mostly. Francophone and immigrant, with schoolyards that echo in four languages and Catholic churches that still fill on Sundays. There’s no nightlife worth naming. Just basements with wood paneling, pool tables, and cassette decks that never left the eighties. You might see the river from the end of your street, but most don’t bother. The city is far enough away to ignore, and close enough to blame when things don’t work. Pierrefonds keeps its head down and stays where it is.", 
            "sound_path": "res://sound/description/Pierrefonds.mp3"
        }
    }, 
    "connected_zones": ["Sainte-Geneviève", "Kirkland", "Senneville", "Sainte-Anne-de-Bellevue", "Saint-Laurent"], 
    "characters": []
}, 

"Beaconsfield": {
    "zone_name": "Beaconsfield", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Beaconsfield.png", 
            "description": "Something about the air feels thinner here. Not colder, just distant. Beaconsfield runs along the water, all quiet streets and careful wealth, where the houses sit back from the road as if uninterested in being seen. Trees are older than most of the homes, and the wind off Lake Saint-Louis moves through them like a habit. You can walk for blocks without hearing anything but your own footsteps and the low buzz of a streetlamp struggling to stay lit.\n\nEnglish dominates, but softly. This is old West Island money, not flashy, not loud. The kind that votes, keeps records, and teaches its children to speak properly. The train still stops here, though fewer people take it. Teenagers gather in parks lit just enough to see each other’s faces, drinking quietly, pretending not to belong. The shoreline is always close, dark and flat, reflecting little. Some nights it feels like the whole town is listening to the water, waiting for something to rise out of it.", 
            "sound_path": "res://sound/description/Beaconsfield.mp3"
        }
    }, 
    "connected_zones": ["Baie-D'Urfé", "Kirkland", "Pointe-Claire", "Sainte-Anne-de-Bellevue"], 
    "characters": []
}, 


"Kirkland": {
    "zone_name": "Kirkland", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Kirkland.png", 
            "description": "The streets were carved out in the 60s, laid over farmland and windbreak forests that once split the West Island into long forgotten concessions. By the 80s, the fields had vanished beneath cul-de-sacs and carports, filled with engineers, bureaucrats, and oil company men who wanted distance without disconnection. The roads are broad and clean, the lawns watched over. Nothing out of place, but the silence lasts too long after dark.\n\nEnglish is spoken without apology here. The churches are Anglican or United, the high school mascots are in English, and the community centres still serve coffee from chipped mugs with Union Jacks printed on the side. French is present, but only where it has been required. Behind the symmetry and suburban calm, there is an unease that lingers. Not loud, but constant. Porch lights flicker on at the same time every evening. No one answers the door if you knock too late. This is Kirkland. It behaves itself. It expects you to do the same.", 
            "sound_path": "res://sound/description/Kirkland.mp3"
        }
    }, 
    "connected_zones": ["Sainte-Geneviève", "Sainte-Anne-de-Bellevue", "Pierrefonds", "Beaconsfield", "Pointe-Claire", "Dollard-des-Ormeaux"], 
    "characters": []
}, 


"Sainte-Anne-de-Bellevue": {
    "zone_name": "SainteAnneDeBellevue", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/SainteAnneDeBellevue.png", 
            "description": "The locks move first. Slow, deliberate, louder than you expect. Then the canal breathes, and the street picks up again. Sainte Anne de Bellevue is built around that rhythm. Stone underfoot, water to the left, cafés and brick storefronts to the right. Trains pass above without stopping. Boats pass below without hurrying. Everything here continues at the pace of conversation.\n\nMornings begin with brooms on doorsteps and gulls overhead. By noon the students have taken over the patios, and by night the lights reflect in the canal like they always have. Locals nod to each other without words. Strangers are noticed, not judged. The town holds a little warmth in its walls, the kind that doesn’t need to announce itself. The kind that stays after the last boat pulls away.", 
            "sound_path": "res://sound/description/SainteAnneDeBellevue.mp3"
        }
    }, 
    "connected_zones": ["Kirkland", "Senneville", "Pierrefonds", "Baie-D'Urfé"], 
    "characters": []
}, 

"Baie-D'Urfé": {
    "zone_name": "BaieDUrfe", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/BaieDUrfe.png", 
            "description": "Wind moves freely in Baie-D’Urfé. It rolls in off the lake and settles in the trees, rustling through quiet streets that follow the curve of the water. The roads are narrow, the houses spaced out, and the lawns kept with a kind of careful modesty. There are no corner stores or glowing signs. Just mailboxes, fences, and the long sound of tires moving slow over wet asphalt.\n\nFounded as a farming parish in the early 1700s, the town still carries a sense of distance from the city it borders. Most residents have been here for decades. They know the shape of the shoreline and the timing of the train that cuts behind the marina. Children ride their bikes past trimmed hedges. Dogs bark from behind gates. Down by the docks, sails are lowered with practiced hands. It is the kind of place where very little changes, and the things that do are noticed immediately.", 
            "sound_path": "res://sound/description/BaieDUrfe.mp3"
        }
    }, 
    "connected_zones": ["Sainte-Anne-de-Bellevue", "Beaconsfield"], 
    "characters": []
}, 


"Senneville": {
    "zone_name": "Senneville", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Senneville.png", 
            "description": "Senneville holds the western tip of the island where the French first built their palisades in the seventeenth century. The fort has vanished, but the pattern of retreat endures. Wealth gathered here in the twentieth century, poured into large estates and careful gardens, then thinned and left behind mansions with hollow windows staring out across the water. The Saint Lawrence presses against the shoreline, steady and cold, gnawing at what inheritance once tried to preserve.\n\nThe people who remain live behind hedges and gates, professors from the city, heirs clinging to their parents’ property, families that wanted distance more than neighbors. Their streets are wide and still, patrolled only by the occasional car, each engine echoing in the silence. At the shore the docks sag into the current, boathouses marked by moss and fading paint. Senneville is not empty, but it feels rehearsed, as if everyone here is performing wealth long after the audience has gone home.", 
            "sound_path": "res://sound/description/Senneville.mp3"
        }
    }, 
    "connected_zones": ["Sainte-Anne-de-Bellevue", "Pierrefonds"], 
    "characters": []
}, 







    "Ottawa Downtown": {
        "id": "OttawaDowntown", 
        "default_viewpoint": "Main", 
        "category": "ottawa_high_outside", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/ottawadowntown.png", 
                "description": "The streets stretch out in orderly rows, their lamps casting warm pools of light against the mist. Parliament stands steady above it all, its tower a familiar silhouette against the deepening sky. Flags stir dutifully in the damp air, and the old stones hum with the comfort of rituals well-kept. Every step echoes with the assurance that the city endures, unchanged and unwavering.\n\n\tYet behind the glow of the windows and the tidy facades, something quieter moves — a slow settling of walls, a faint ache in the iron bones of monuments. The ceremonies continue without fault, the stones recite their oaths without pause, and no one speaks of the hairline cracks spidering just beneath the surface."\
, 
                "sound_path": "res://sound/description/ottawadowntown.mp3"
            }
        }, 
        "connected_zones": ["Parliament Hill", "National War Memorial", "Lyon Street - Downtown", "Lowertown", "Centretown West", "Centretown", "Sandy Hills", "The Crimson Pulse"], 
        "characters": []
    }, 

    "Parliament Hill": {
        "id": "ParliamentHill", 
        "default_viewpoint": "Parliament Building", 
        "category": "ottawa_high_outside", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Parliament Building": {
                "image_path": "res://Image/ViewpointImage/parliamentbuildingzone.png", 
                "description": "Parliament holds itself with care. The tower rises through the mist with the posture of something aware of being watched. Its copper crown is bruised, its windows emptied of light, but the silhouette remains firm. A gesture of continuity more than authority. Nothing has fallen. That is what matters.\n\n\tThere are guards, of course. A few in plain view, jackets buttoned, boots clean. Others blend into the marble and shadow, lingering in alcoves you might not have seen until too late. They do not speak. They do not shift. But if you hesitate near the wrong threshold, someone always steps out. Not abruptly. Just on time. The city does not like questions."\
, 
                "sound_path": "res://sound/description/parliamentbuilding.mp3"
            }, 
            "Centennial Flame": {
                "image_path": "res://Image/ViewpointImage/centennialflame.png", 
                "description": "Lit in 1967 for Canada’s centennial, the flame has never gone out. It sits openly at Parliament’s feet, encircled by quiet fountains and forgotten heraldry. By day it is photographed, maintained, respected. No one questions it. Not the tourists. Not the guards. Not even the Kindred, though many avoid it entirely. Some simply walk wider circles. Others tremble without knowing why.\n\n\tMore than a few have succumbed to Rötschreck near its edge, overtaken by a terror that surges without warning. Still, the flame remains. Even the Prince has never proposed extinguishing it. Perhaps it is too visible. Perhaps too old. Or perhaps it is simply easier this way. The city endures many things it no longer understands, and the flame has learned how to be one of them."\
, 
                "sound_path": "res://sound/description/centennialflame.mp3"
            }, 
            "Eyeing West Block": {
                "image_path": "res://Image/ViewpointImage/ottawawestblock.png", 
                "description": "The West Block does not call attention to itself. Its towers wear age convincingly. The stones are dark in the right places, the windows recessed just enough to suggest old depth. Everything about it has been maintained with care. Too much care. It is the most heavily renovated of the triplet, and the most heavily trusted. That trust has never been questioned.\n\n\tOf the three, it is the most sinister. Not because of anything visible, but because nothing is. The air inside is muffled, as if the building prefers to keep voices soft. Corridors run longer than they should. Rooms appear on no floor plan but are never locked. Its silence is not reverent. It is deliberate. If something listens from inside the stone, it does not hide. It simply waits."\
, 
                "sound_path": "res://sound/description/ottawawestblock.mp3"
            }, 
            "Eyeing East Block": {
                "image_path": "res://Image/ViewpointImage/ottawaeastblock.png", 
                "description": "The East Block wears its history like a uniform. Stone gables, arched windows, iron flourishes at the roofline. Everything cut to the silhouette of Victorian memory. Of the three buildings, it is the one that wants to be seen. Guides call it the oldest, the most authentic, the true anchor of the Hill. Its halls are dimly lit, lined with reconstructed offices meant to preserve the image of a government that once knew exactly what it was doing.\n\n\tOut front stands the 1812 memorial, cold and clean, flanked by chain posts and quietly ignored. No one visits it for long. It casts no shadow on the façade behind it. The building remains pristine in photographs, but those who walk by at night often feel watched. Not with hostility. With expectation. Like a stagehand behind the curtain, waiting for a cue that never comes."\
, 
                "sound_path": "res://sound/description/ottawaeastblock.mp3"
            }
        }, 
        "connected_zones": ["Library of Parliament", "Parliament Building – Entrance Hall Zone", "National War Memorial", "Ottawa Downtown"], 
        "characters": []
    }, 


    "Library of Parliament": {
        "zone_name": "LibraryOfParliamentMainHall", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/libraryofparliament.png", 
                "description": "The library stands behind Parliament like a reliquary, braced with flying buttresses and carved with the confidence of a nation that believes its own myth. No one questions its placement. Few enter without permission. Its dome rises like a crown of spires, steep and sharp, surrounded by walls that once suggested sanctuary. Now they suggest containment.\n\n\tThis is not where knowledge is stored. This is where it is performed. The books are real, the archives vast, but the power lies in what is not indexed. Even Kindred tread lightly here, for it is Elysium. The city does not flaunt the building’s authority. It simply allows the illusion of scholarship to do the work. A masquerade of heritage, perfectly preserved. The only thing older than the records is the need to control them."\
, 
                "sound_path": "res://sound/description/libraryofparliament.mp3"
            }
        }, 
        "connected_zones": ["Library of Parliament – Main Chamber Room", "Parliament Hill"], 
        "characters": []
    }, 

"Library of Parliament – Main Chamber Room": {
    "zone_name": "LibraryOfParliamentMainChamberRoom", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/libraryofparliamentmain.png", 
            "description": "The main chamber is a circle, but not a perfect one. Every architect’s drawing claims otherwise, and every visitor swears it feels off. The bookshelves rise in tiers along the curved wall, their spines uniform in height, untouched by time, like rows of waiting eyes. Desks are arranged in precise order across the floor, none of them facing each other, none quite aligned. Globes sit on some, unmoving. Others are covered in documents that have not been opened in decades, but are replaced exactly when one is removed.\n\nThe statue in the center does not point, gesture, or look. It simply exists, still and immense, standing where the acoustics collapse. Voices die at its feet. Lights hang far overhead, swaying slightly even when the air is still. The room smells faintly of heat and copper, like a place that used to house something alive. Every sound here happens a second too late. Footsteps echo before they land. Papers flutter without motion. No one reports these things. No one has to. The room is a safe haven. You are not in danger. You are only being watched by the shape of memory, wrapped in stone, waiting to see which thought you were about to have next."\
, 
            "sound_path": "res://sound/description/libraryofparliamentmain.mp3"
        }
    }, 
    "connected_zones": ["Library of Parliament"], 
    "characters": []
}, 


"Parliament Building – Entrance Hall Zone": {
    "zone_name": "ParliamentBuildingEntranceHallZone", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/parliamantentrance.png", 
            "description": "The entrance hall is taller than it needs to be. The ceilings arch upward like a question held too long. The marble is cold underfoot, polished smooth but never reflective. At night, the chandeliers do not flicker. They hum softly instead, like something mechanical trying not to be noticed. The walls hold no clocks, no signs, no sense of direction. Just corridors, unfolding in angles that should return but never quite do.\n\nThe silence is not heavy. It is precise. Every footstep confirms you are somewhere you were not supposed to find on your own. The doors are too far apart. The arches are too similar. You keep moving, just further in. The stillness of the empty halls do not contain you, do not pull you back."\
, 
            "sound_path": "res://sound/description/parliamantentrance.mp3"
        }
    }, 
    "connected_zones": ["Parliament Hill"], 
    "characters": []
}, 


    "National War Memorial": {
        "zone_name": "NationalWarMemorial", 
        "default_viewpoint": "main", 
        "category": "ottawa_high_outside", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/warmemorialzone.png", 
                "description": "The National War Memorial rises with deliberate weight, too large for the square that holds it. Bronze soldiers march forward beneath the stone arch, locked in motion toward something long gone. The eagle above looks down, wings outstretched like a verdict. This is not a monument to the fallen. It is a structure meant to be obeyed.\n\n\tThe buildings around it lean back slightly, as if pretending not to listen. Lights stay on too late. Traffic softens without cause. Just beneath the arch lies the Tomb of the Unknown Soldier, perfect in its placement, nameless by design. It marks nothing. It secures everything. The city wraps around it with careful choreography, rehearsing a silence it no longer questions."\
, 
                "sound_path": "res://sound/description/warmemorialzone.mp3"
            }
        }, 
        "connected_zones": ["Parliament Hill", "National Arts Centre", "Ottawa Downtown"], 
        "characters": []
    }, 


    "National Arts Centre": {
        "zone_name": "NationalArtsCentre", 
        "default_viewpoint": "main", 
        "category": "ottawa_high_outside", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/nationalartscentre.png", 
                "description": "The National Arts Centre is not like the others. It follows the rules of civic architecture only loosely, as if designed by someone who read the manual and chose to interpret it. Concrete spreads out in deliberate planes, severe and low, but inside there are moments of softness, strange warmths of wood and light, staircases that seem to curve without instruction. It is a bureaucratic structure, but it dreams. And somehow, the city allows it.\n\n\tThere is no clear reason for this permission. The building is too large for its surroundings and too quiet for its size. It does not welcome, yet it does not repel. People enter it for music and theatre, but they leave with the sense that something else is being rehearsed behind the walls. The lights are carefully controlled. The acoustics are perfect. It behaves itself. But beneath the concrete skin, something thoughtful is moving, and no one has asked it to stop."\
, 
                "sound_path": "res://sound/description/nationalartscentre.mp3"
            }
        }, 
        "connected_zones": ["National War Memorial", "National Arts Centre – Interior"], 
        "characters": []
    }, 

    "National Arts Centre – Interior": {
        "zone_name": "NationalArtsCentreInterior", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/nationalartscentreinterior.png", 
                "description": "The interior is quieter than expected, even when full. Sound moves strangely here. Footsteps are softened, voices do not echo. The light is amber and indirect, filtered through layers of intention that no one remembers authoring. The ceiling folds in repeating geometries that suggest order but offer no comfort. The stairs rise slowly, not as an invitation, but as a condition. It is not dark, but it is never bright. The shadows feel installed. Hallways extend in directions that seem deliberate but unmarked. Doors remain closed longer than they should. Somewhere nearby, music is being tuned, but you will not hear it until the building is ready.\n\n\tThis is not only a theatre. It is a space made entirely of in-betweens. Every room feels like the threshold to another room that may not exist. There is no single place to rest your attention. You move through it with the sense that someone else is waiting for your arrival, though they have not called you forward. There is no enchantment here. Only precision, and the feeling that it has been allowed to go too far."\
, 
                "sound_path": "res://sound/description/nationalartscentreinterior.mp3"
            }
        }, 
        "connected_zones": ["National Arts Centre", "National Arts Centre – Spectacle Room"], 
        "characters": []
    }, 

    "National Arts Centre – Spectacle Room": {
        "zone_name": "SpectacleRoom", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/spectacleroom.png", 
                "description": "Shh, the show will start soon.", 
                "sound_path": "res://sound/description/spectacleroom.mp3"
            }
        }, 
        "connected_zones": ["National Arts Centre – Interior"], 
        "characters": []
    }, 



    "Lyon Street - Downtown": {
        "zone_name": "Lyon Street", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/LionStreetDowntownOttawa.png", 
                "description": "Lyon street is lined with fresh high rise condominiums and businesses, all creating thick shadows over the street. Here at night, things are far more subdued, but it's clear that this is a hub of activity when daylight strikes.\n\nThat's not to say that it's bereft of nightlife. A couple bars are open at this hour, not to mention the thumping of bass from a club down the way. People meander down the road, all looking to spice up their nightlives, and a few cars cut shapes through the road itself.\n\nIt's inviting in its strange, sleepy way. Perhaps you should explore; see what the night on Lyon Street has to offer."\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Ottawa Downtown", "The Crimson Pulse"], 
        "characters": []
    }, 


    "The Crimson Pulse": {
        "zone_name": "The Crimson Pulse", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/CrimsonPulse.png", 
                "description": "The Crimson Pulse is settled in Downtown Ottawa, its scarlet neon sign is simple, yet flourished. Seemingly once an art deco theatre, now the black marble facade and smoked glass hide what await within, only the thumping of bass in your chest preparing you for what may lie within. Fervorous mortals line the sidewalk, appearing ready to claw each other apart for the chance at getting past the red-suited bouncers guarding the velvet rope. Getting past them for Kindred, though? Easy. You just steps up and they let you past, despite the protests of the kine in line.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Ottawa Downtown", "The Crimson Pulse - Main Floor"], 
        "characters": []
    }, 


    "The Crimson Pulse - Main Floor": {
        "zone_name": "The Crimson Pulse - Main Floor", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/CrimsonPulseInterior.png", 
                "description": "Inside is.. a lot, to say the least. The first thing one notices are the heavy scents of sweat, smoke, and perfume paired with the crimson strobe lights that bounce off of large shattered pieces of mirror hanging at various heights. It's a fever dream of industrial, goth, and techno beats while the facsimile of an anatomically-accurate heart hangs in lieu of a disco ball, pulsing with faint magenta light to the beat of whatever's playing. On one end of the space is a large stage that wraps in a crescent shape, currently occupied by barely dressed men and women twisting and writhing to the music in what appears to be interpretive dance.\n\nSpeaking of the crowd: it's an interesting mix here. Club kids, goths, and models make up the majority here, but there seem to be some more adrenal types: junkies and thrill-seekers posted up near the bar. The staff here are all pale and eerily calm, always smiling pleasantly and eager to please as people make their requests. Except at the velveted curtains on either side of said bar. Occasionally, you can glimpse the mirrored stairs behind them, leading up to assumedly the wrought-iron railed balcony that edges this entire experience. The mystery of what is behind the smoky curtains above just tantalizingly close. Yet.. almost every person that tries to go up is turned away. Though, a very select few have been ushered past. And you? The red-suited bouncer just gives you a single glance before stepping aside and allowing you up above, should you be so inclined."\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["The Crimson Pulse", "The Crimson Pulse - Upper Level"], 
        "characters": []
    }, 


    "The Crimson Pulse - Upper Level": {
        "zone_name": "The Crimson Pulse - Upper Level", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/CrimsonPulseInterior.png", 
                "description": "The outermost ring of the balcony has various open lush leather booths, everything lit extraordinarily dimly with pale red light. In many places, however, these break off into velvet-curtained private rooms, some of which are open with silk-lined couches visible within. Each one is permeated with soft incense that seems to warp your own senses, dulling them the longer you're exposed, but not to a point of detriment for you. To a mortal, though? They'd probably be completely lost in it. It's dark, dangerous luxury: if you wanted to meet someone important or feed on one of the flock below, this somehow felt perfectly right for both in equal measure.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["The Crimson Pulse - Main Floor", "Private Room One", "Private Room Two"], 
        "characters": []
    }, 


    "Private Room One": {
        "zone_name": "Private Room One", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/CrimsonPulseInterior.png", 
                "description": "A dimly lit room cordoned off by a red velvet curtain. Inside is a lush silk-lined couch that circles the space and leaves a large opening in the center. Incense burns in here, seemingly entering through the vent, that dulls the senses, though not enough to be a detriment. At least, not for Kindred.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["The Crimson Pulse - Upper Level"], 
        "characters": []
    }, 


    "Private Room Two": {
        "zone_name": "Private Room Two", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/CrimsonPulseInterior.png", 
                "description": "A dimly lit room cordoned off by a red velvet curtain. Inside is a lush silk-lined couch that circles the space and leaves a large opening in the center. Incense burns in here, seemingly entering through the vent, that dulls the senses, though not enough to be a detriment. At least, not for Kindred.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["The Crimson Pulse - Upper Level"], 
        "characters": []
    }, 


    "Crimson Pulse - The Antechamber": {
        "zone_name": "Crimson Pulse - The Antechamber", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/CPAntechamber.png", 
                "description": "Down a hidden elevator in one of the private rooms, what lays below is the true heart of the Crimson Pulse. The walls here are polished concrete with mirrored columns and black lacquer furniture. Everything gleams down here with damp heat and too much perfume. The lighting is subtle and dim, led by crimson and amber strip lights in recessed groves in the walls. But it's just so much.. more. What scents above were down here exacerbated with the heavy stenches of opium and marijuana now permeating beneath the numbing undercurrent of perfumes.\n\nHere in the antechamber, long black leather couches and low glass tables are scattered with half-empty syringes, gold-rimmed goblets, and small trays filled with the ashes of incense. There are several small rooms off of the sides in here, each with beds covered in dark silk sheets, distorting mirrors, and humming with a strangely trance-like frequency. These? Probably meant to steal a moment for feeding. Or whatever else strikes the patrons' fancies."\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Private Room One", "Crimson Pulse - The Core"], 
        "characters": [], 
        "secret_entry_passwords": ["duval"], 
        "accessible_from_zones": ["Private Room One"]
    }, 


    "Crimson Pulse - The Core": {
        "zone_name": "Crimson Pulse - The Core", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/CPCore.png", 
                "description": "Where the Antechamber gave an appetizer, here is the main course. In the center of the room is a wide circular bed with black silk sheets, overhung by translucent fabric that gives the illusion of smoke. All along the walls of this room are couches, kept pristine despite the mess of the previous area, and always occupied by one or two pale figures locked in an embrace -- or more.\n\nBehind the bed is a single, large, antique mirror. Its surface is black as oil. Just the presence of it raises the hairs on the back of your neck in animalistic discomfort. In front of it is a table with a figurine of a coiled serpent around a large red pillar candle."\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Crimson Pulse - The Antechamber"], 
        "characters": []
    }, 




"Centretown": {
    "zone_name": "Centretown", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/centretown.png", 
            "description": "Centretown is where Ottawa pretends to be real. Glass offices and civic banners declare relevance, but the ground underneath is soft with erasure. Every building has had five names. Every plaque contradicts the last. The streets are wide and gridded like a failed utopia, but their corners still fold in on themselves, pooling with sirens and shredded pamphlets. Somewhere under Metcalfe, an escalator hums without a staircase. People hear it in their sleep.\n\nThis is where the city dreams in policy. You can feel it in the libraries, the union halls, the way rain seems to fall slower near Somerset. Fluorescent-lit diners flicker with the guilt of a thousand unkept appointments. Tenants change, landlords vanish, but the leases renew themselves. Something here wants you to fill out forms until you forget what you were proving. The lights stay on because someone, somewhere, is still counting.", 
            "sound_path": "res://sound/description/centretown.mp3"
        }
    }, 
    "connected_zones": ["Bank Street", "Sparks Street", "Armory Drive", "Centretown West", "The Glebe", "Golden Triangle"], 
    "characters": []
}, 

    "Armory Drive": {
        "zone_name": "Armory Drive", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/ArmoryDrive.png", 
                "description": "The avenue ran like a seam through the darkened fabric of the city. The low amber glow of the streetlights seemed less like illumination and more like a hesitant stain, unsure if it should fully commit to the dark. Storefronts along the block included the heavy stone facade of a hotel, a restaurant with condensation blurring its glass, and a store whose display window showed only shadow. They looked less like places of business and more like quiet, waiting faces.\n\nAbove them, power lines stretched and swayed, a tangled script written against the indifferent blackness. Everything felt held in a state of indefinite pause, even the heavy brick that should suggest permanence. The few cars that moved seemed to glide, their engines muffled, as if the air itself were too thick for sound. Traffic signals changed with a strange, lingering slowness, the shift from one color to the next a moment that stretched past its natural duration. The sidewalks held no footsteps, only a suggestion of recent movement, a chill that lingered in the space where people should have been."\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Centretown"], 
        "characters": []
    }, 


    "The Armory Hotel": {
        "zone_name": "The Armory Hotel", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/ArmoryHotel.png", 
                "description": "The double doors of The Armory Hotel closed with a pneumatic sigh, sealing off the street's humid silence. The lobby opened up, a deep, rectangular space that felt too grand for its actual size. The air hung still and cool, a temperature that suggested disuse rather than comfortable climate control. Overhead, the chandeliers, heavy brass and clouded glass, cast a light that seemed to merely acknowledge the corners of the room, rather than truly illuminate them. Their glow picked out the textured wallpaper, a faded tapestry of pattern, and the dark wood paneling that climbed halfway up the walls, giving the room a sense of being perpetually submerged.\n\nThe reception desk, a fortress of polished oak, stood empty. Its pigeonholes, meant to hold keys, were vacant, each dark square a tiny, unblinking eye. A brass clock above it marked time with an oppressive stillness; its soft ticking was a sound almost imagined, like a memory of a sound. In the sitting area, deep red velvet armchairs and a matching sofa sat arranged around a low table, their cushions plump and undisturbed. They looked less like furniture meant for guests and more like an exhibit, waiting patiently for a pose that would never come. The quiet was thick here, a presence that settled over everything, pushing against the ears, making one aware of the sudden, startling beat of one's own heart."\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Armory Drive", "Room 307"], 
        "characters": []
    }, 


    "Room 307": {
        "zone_name": "Room 307", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Room307.png", 
                "description": "The heavy door to the room eased open, revealing a space that felt both formally appointed and subtly lived-in. The air hung cool, but not sterile, carrying a faint, pleasant scent of old paper and something metallic, like polished brass. The floral patterns on the curtains and the bedspread, rich with deep greens and muted reds, were clearly the hotel's choice, a flourish that was functional, if not quite personal.\n\nTo the right, the double bed, a grand affair of dark wood and plump pillows, looked invitingly soft, as if waiting to absorb one's weariness. And then, to the left, the desk. Upon it there is a laptop; a sturdy, pale grey machine sat open, its screen a dark mirror. Beside it, a book lay splayed open, spine broken from frequent reading�a treatise on physics, perhaps, or advanced technology given the glimpse of diagrams on the visible page. Nearby, a small stack of other volumes, some thick with academic heft, others worn with the casualness of a well-loved paperback: physics, more technology, and a collection on comparative religion. A comfortable armchair, upholstered in deep crimson, was tucked neatly beneath the desk, as though its occupant had only just risen. The closet door, slightly ajar, revealed a quiet regiment of dark clothing, hinting at a wardrobe of both practicalities and a touch of formality. This wasn't merely a hotel room; it was a quiet, temporary world, carefully arranged, and bearing the clear imprint of someone fully at ease in their own company."\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["The Armory Hotel"], 
        "characters": [], 
        "secret_entry_passwords": ["Gnosis"], 
        "accessible_from_zones": ["The Armory Hotel"]
    }, 

"Bank Street": {
    "zone_name": "BankStreet", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/ottawa_bank_street_centretown.png", 
            "description": "Bank Street stretches through Centretown like a bulging, flickering. It is too wide to feel old, too narrow to feel new. Lampposts flicker in the afternoon like they are unsure they should be on yet. The storefronts try their best: diners from the 1950s, mini-marts from last week, a bank that looks like it was born tired. Above, utility lines sag like exhausted syntax, trailing down the corridor in tangled punctuation. Everything feels temporary, even the buildings that have been here since Diefenbaker. Cars idle under red lights that seem to last longer than memory. On weekends, the sidewalks fill with people pretending they are not from here. Behind them, office towers from the downtown core loom like supervisors on break. This is Centretown’s pulse, but the rhythm is syncopated. It is too slow for ambition, too fast for comfort.", 
            "sound_path": "res://sound/description/ottawa_bank_street_centretown.mp3"
        }
    }, 
    "connected_zones": ["The Afterlife – Entrance", "Centretown"], 
    "characters": []
}, 


"The Afterlife – Entrance": {
    "zone_name": "TheAfterlifeEntrance", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/TheAfterlifeEntrance.png", 
            "description": "Sat on Bank Street, The Afterlife is a hub of activity for the alternative and punk scenes of the city, hosting new, up-and-coming underground bands each night and even the occasional big name. At it's double doors, 2 bouncers stand - One checking the IDs of those waiting in a small queue along the front of the building, the other stands with a clipboard with a list of pre-approved regulars and guests who can skip the line and monitoring the smoking area outside the building.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["The Afterlife", "Bank Street (Centretown)"], 
    "characters": []
}, 


"The Afterlife": {
    "zone_name": "TheAfterlife", 
    "default_viewpoint": "Main", 
    "category": "Club001", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/TheAfterlifeGroundFloor.png", 
            "description": "The ground floor of The Afterlife pulses with gritty energy; neon-soaked walls, industrial metal accents, and a stage where underground and up-and-coming bands showcase their talents, surrounded by a crowd clad in leather, spikes, and avant-garde fashion. Above it stands a mezzanine that seems more quiet, likely a private area, overlooking the chaos below through wrought iron railings and smoked glass panels. At the far end of the room stands a door with a guard posted outside it — clearly some sort of VIP or employee-only area.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["The Afterlife – Entrance"], 
    "characters": []
}, 

"The Afterlife – VIP": {
    "zone_name": "AfterlifeVIP", 
    "default_viewpoint": "Main", 
    "category": "Club001", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/TheAfterlifeVIP.png", 
            "description": "Through the backdoor leads a staircase to the VIP basement. Walking through the stairwell, the sound and chaos of the club above dies down somewhat, though can still be heard through the brick and concrete. The VIP area is significantly more expensive than the club above; smooth comfortable leather booths — all with ample room to sit, even for the largest of Kindred — and dimly lit chandeliers contrast the industrial metal accents and exposed brickwork. Across the far wall is a private bar, tended by the same bartender each night.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["The Afterlife"], 
    "characters": [], 
    "secret_entry_passwords": ["ChipIn"], 
    "accessible_from_zones": ["The Afterlife"]
}, 

"Sparks Street": {
    "zone_name": "Sparks Street", 
    "default_viewpoint": "main", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Assets/UI/SparksSt.png", 
            "description": "Once a main street in Centretown, Sparks Street was converted to a pedestrian-only area some 20 years ago in an effort to improve commerce. Initial success brought in new businesses alongside some of the city’s oldest and most important structures, creating a clash of eras and aesthetics that survived even as that initial success faded. Now, it’s an ideal tourist destination, featuring food, nightlife and the arts right alongside historical landmarks.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Nourrir", "Centretown"], 
    "characters": []
}, 

"Nourrir": {
    "zone_name": "Nourrir", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Assets/UI/Nourrir.png", 
            "description": "By all appearances, the restaurant Nourrir fits in with the rather expensive, tourist-centric area where it's located, with trendy neon signage over a faux-vintage storefront of carved wood and colorful glass. Inside, it's all dark wood and velvet under low lighting. Walls without windows are decorated with a variety of impressionist paintings, including cards with the artists' statements. Plush seats surround the tables, which are each filled with sparkling glassware and, if someone is eating, a rotating collection of plates featuring a variety of small and intricate dishes. The jazz music is soft but ever-present and may be provided by a live band on special nights. From the main dining area, kitchen doors are visible as is the entrance to a room reserved for special events.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Sparks Street"], 
    "characters": []
}, 

"Nourrir - Private Dining Room": {
    "zone_name": "Nourrir - Private Dining Room", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Assets/UI/NourrirPrivate.png", 
            "description": "Nourrir's private dining room looks much like the rest of the restaurant, but is a smaller space with one larger table. It has a separate entrance to the kitchen, keeping it completely separated from the public dining room so long as the doors are closed.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Nourrir"], 
    "characters": [], 
    "secret_entry_passwords": ["le sang"], 
    "accessible_from_zones": ["Nourrir"]
}, 







    "Centretown West": {
        "zone_name": "CentretownWest", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/centretownwest.png", 
                "description": "Centretown West is a district of layered tenancy and slow erosion. The houses were not built to last, but they have. Their endurance is not deliberate, only the result of habit and weather. Walls bow outward from pressure no one speaks of. Gardens take root in paint buckets. Wires cross the sky in tangled lines. The wind moves unevenly here and turns corners it should not know.\n\n\tThe people do not gather, but they remain. They cook quiet meals in narrow kitchens and speak in borrowed tongues. They pass one another like shadows exchanged between doorframes. Each address has belonged to someone else and will again. The neighborhood is not beautiful, but it is remembered. Not cherished, but fed."\
, 
                "sound_path": "res://sound/description/centretownwest.mp3"
            }
        }, 
        "connected_zones": ["190 Lisgar St, Ottawa", "Centretown West Northern Fringes", "Ottawa Downtown", "Centretown", "Lebreton Flats", "Little Italy", "Chinatown"], 
        "characters": []
    }, 


"190 Lisgar St, Ottawa": {
    "zone_name": "*190 Lisgar St, Ottawa*", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/Quinnoutside.png", 
            "description": "190 Lisgar St, Ottawa. To those with a keen eye, the small residential presents a singular sign with a white on black *Quinn, Private Investigatiors* on the front lawn. A small window shows the interior, a mix of an office and a detectives work station. The building itself has two floors and is made from red bricks. Rarely, someone comes in during the day. To those who have heard of it, it is an adress usually given when mysteries need to be unfolded, internal investigations need to be carried out or when certain facts need to be concealed from public knowledge", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Centretown West", "Office Quinn"], 
    "characters": []
}, 

"Office Quinn": {
    "zone_name": "*Office Quinn&K*", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/OfficeQuinnK.png", 
            "description": "*The modern office in front of this floor consists of three white desks, a personal computer, several cabinets, drawers, and the like. The walls are plastered with posters with very little commonality; a map of Ottawa next to a detailed description of human anatomy, from print-outs of Canada's Top 100 charts to an organogram of Ottawa's political and executive institutions — little wallpaper is left unoccupied. A small seating opportunity indicates a waiting area. The back of the floor is separated by a wooden frame, where a noir-esque detective bureau is located. Next to the bureau is a small closet, on the door it says \\\"KEEP CLOSED, PHOTOGRAPHIC DEVELOPMENT\\\" in big, green letters. Two wooden desks face each other, one plaque says \\\"Quinn\\\" the other \\\"Mr.K\\\". Here the walls too are occupied, but the content seems more esoteric in nature, with a Qabalistic Tree of Life next to a map titled \\\"SIGHTINGS\\\" standing out. A small bookshelf contains various legal documents and law books.*", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["190 Lisgar St, Ottawa", "Quinn Room"], 
    "characters": [], 
    "secret_entry_passwords": ["Antistius"], 
    "accessible_from_zones": ["190 Lisgar St, Ottawa"]
}, 

"Quinn Room": {
    "zone_name": "*Quinn Room*", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/QuinnRoom.png", 
            "description": "It's a little cramped. The walls are lined with various kinds of bookcases and shelves filled with all sorts of documentation, alongside the occasional occult-looking object. One long side features a magnetic chalkboard, a small plastic box filled with colored chalk, animal magnets, and black yarn. A small computer sits beside a messy desk — neither has been cleaned recently. The only thing in order is a small shelf full of case files. Some boxes are marked with strange notations.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Office Quinn"], 
    "characters": [], 
    "secret_entry_passwords": ["Klaatu"], 
    "accessible_from_zones": ["Office Quinn"]
}, 

"Centretown West Northern Fringes": {
    "zone_name": "Centretown West Northern Fringes", 
    "default_viewpoint": "main", 
    "category": "ottawa_low_outside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/ottawa_centretown_west_fringe.png", 
            "description": "This is the northern fringe of Centretown West, where the city forgets to sweep and the streets lose their names. The tents cluster here, just before the land buckles into Lebreton Flats. Canvas, tarp, stolen signage, all stitched into shelter. Smoke drifts from garbage fires, curling between rusted poles and silent trees. The skyline is still visible, blurred by grime and weather, but it feels like another world. Nobody patrols this edge. Nobody counts the souls who sleep here. The stroller has no child, only plastic bags. The silence is broken by coughing, or the sound of a tin can being kicked out of the way. This is not poverty. It is the city’s discarded memory, gathered into makeshift homes before the emptiness swallows it whole.\n\nLebreton Flats begins just beyond those last sagging wires. The camp holds on like rot at the edge of a scar, too stubborn to die, too forgotten to matter. The people here do not look toward downtown. They look down, or not at all. Somewhere behind them, the street signs still say Ottawa, but it means nothing. The city ends here, not with a border but with a shrug.", 
            "sound_path": "res://sound/description/ottawa_centretown_west_fringe.mp3"
        }
    }, 
    "connected_zones": ["Lebreton Flats", "Centretown West"], 
    "characters": []
}, 




"Lebreton Flats": {
    "zone_name": "OttawaLebretonFlats", 
    "default_viewpoint": "main", 
    "category": "Creepy001", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/ottawa_lebreton_flats.png", 
            "description": "Lebreton Flats is not a neighborhood. It is a refusal. The city cut it out like rot and never closed the wound. From Booth Street to the riverbank, there is only municipal silence. Broken pavement, dead grass, rusted lampposts that hum without light. After the demolitions of the 1960s, the Flats were promised rebirth. What came instead was entropy. Concrete bones protrude from the dirt like accusations. Chain-link fences sag where footpaths run between collapsed foundations. The homeless gather in the shell of a burned-out depot, lighting fires in cracked barrels. Some are mad. Some are sick. All are invisible. The air smells of wet insulation and mold. There is no rhythm here, no sirens, no footsteps. The land has turned against its owners.\n\nThe Flats do not belong to anyone. They are city land, yes, but only on paper. The police never come here. Not from fear, but because there is nothing to protect. It is a zone the city would rather not only ignore but see erased entirely. Bureaucrats speak of cultural renewal but forget the soil still remembers fire. Children are warned away from the fences, though few need the warning. The silence is enough. No residents. No voters. No use. And yet the place endures, like a secret waiting to be misremembered. Every year brings another proposal, another sketch for museums or parks or something that glows. The Flats reject it all. They have chosen stillness. Not because they failed, but because they were never meant to remain.", 
            "sound_path": "res://sound/description/ottawa_lebreton_flats.mp3"
        }
    }, 
    "connected_zones": ["Centretown West Northern Fringes", "Centretown West", "Little Italy"], 
    "characters": []
}, 





"Lowertown": {
    "zone_name": "Lowertown", 
    "default_viewpoint": "Main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "Main": {
            "image_path": "res://Image/ViewpointImage/lowertown.png", 
            "description": "Lowertown breathes through its teeth. The streets are too narrow for comfort, too old for order, and too alive to be quiet. Stone and brick lean inward, holding the heat in summer and the cold in winter, never quite letting go. Church towers and corner stores share corners like cousins who do not speak anymore. The air smells like bread and incense and cigarettes. Some windows are open when they shouldn’t be. Others have been shut for years.\n\nYou feel it in the soles of your shoes. The slant of the sidewalk, the way light bends around the laundromat at dusk, the sound of a conversation continuing just after you’ve passed. Murals fade under layers of new paint. Bicycles rust in place. At a glance, it looks forgotten. But nothing is ever truly lost here. The neighborhood keeps everything. Every broken latch, every accent, every quiet song that spilled from a window in the middle of the night. It doesn’t ask who you are. It already knows."\
, 
            "sound_path": "res://sound/description/lowertown.mp3"
        }
    }, 
    "connected_zones": ["Byward Market - Clarence Street", "Byward Market - Rideau Street", "Ottawa Downtown", "New Edinburgh", "Hull Downtown", "Sandy Hills"], 
    "characters": []
}, 





    "Byward Market - Rideau Street": {
        "zone_name": "RideauStreet", 
        "default_viewpoint": "main", 
        "category": "ottawa_high_outside", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/rideaustreet.png", 
                "description": "Rideau Street stretches across the city like a line someone drew too confidently and never corrected. It is wide, uneven, always active. The buses arrive in long chains, red-lit and patient, idling beside storefronts that never truly close. Pedestrians move quickly, heads down, as if following instructions no one remembers giving. The Rideau Centre pulses behind glass, humming with escalators and recycled air. Across from it, the Château Laurier watches without comment, heavy with windows and unbroken protocol. The pavement gleams at night whether it rained or not. Streetlights flicker in rhythm with nothing. Screens flash, signals change, but the city does not seem to progress. It circulates, loops, corrects. Rideau does not speak to you. It holds you in place until you understand how long it has been awake.", 
                "sound_path": "res://sound/description/rideaustreet.mp3"
            }
        }, 
        "connected_zones": ["McDonald's – 99 Rideau", "Lowertown", "The Electric Carousel"], 
        "characters": []
    }, 

    "The Electric Carousel": {
        "zone_name": "The Electric Carousel", 
        "default_viewpoint": "Main", 
        "category": "ottowa_high_outside", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/arcade_1.png", 
                "description": "As soon as you push through the grimy door from the fast-paced street, time freezes.\nThe Electric Carousel Arcade beams its neon glow on the faces of the people dragging themselves on Rideau Street, a pulsing yet hidden shelter for nerds, misfits and lonely people. \n\nInside, a thick fog of cigarette smoke permeates the place, giving it an eerie lighting with the pulsing colors from Galaga and Dragon's Lair. \nThe air hums with 8-bit sounds, creating an hypnotizing melody, lulling the patrons alongside the stupor from the beer and the hashish they seek as they drop another quarter in search for the next high score.\nThe sound of tapping fingers echoes in the hall, where your feet sticks to days of stale drinks poured near the machines.\nPeople come and go, reaching for the nearby McDonald's for a fast meal, losing quarter after quarter to beat the next dragon.\nA coin drop, an asteroid explode. Rinse. Repeat. The perfect web."\
\
\
\
\
\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Byward Market - Rideau Street"], 
        "characters": []
    }, 

    "McDonald's – 99 Rideau": {
        "zone_name": "McDonalds99Rideau", 
        "default_viewpoint": "main", 
        "category": "ottawa_high_outside", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/mcdonalds99rideau.png", 
                "description": "The McDonald’s at 99 Rideau is a hole in the city’s mouth, always open, always swallowing. The lights flicker but never go out. The floor sticks. The bathrooms are locked or flooded or both. People don’t eat here so much as wait for something worse to happen. Dealers lean by the exit. Fights start over nothing. A man screams at the soda machine and wins. The air tastes like salt, bleach, and breath held too long. Security pretends not to see. Staff serve with eyes that do not blink. At three in the morning it feels like the only place still alive in Ottawa, and it should not be.", 
                "sound_path": "res://sound/description/mcdonalds99rideau.mp3"
            }
        }, 
        "connected_zones": ["McDonald's – 99 Rideau : Interior", "Byward Market - Rideau Street"], 
        "characters": []
    }, 

    "McDonald's – 99 Rideau : Interior": {
        "zone_name": "McDonalds99RideauInterior", 
        "default_viewpoint": "main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/mcdonalds99rideauinterior.png", 
                "description": "Inside, it feels like a punishment no one remembers handing down. The ceiling is too low, the lighting too loud, the heat uneven and sour. Tables wobble. Chairs are bolted down and still manage to move. The floor is wet for reasons no one explains. Conversations happen in mutters, in arguments, in languages you almost recognize. Someone is always sleeping with their head on the tray. Someone else is pacing the same tile over and over like it owes them money. The fryers scream in the back, but the food comes out cold. Security stands near the door and does not intervene. Everything smells like old ketchup and failure. You cannot tell how long you’ve been here, and by the time you leave, the building has taken something small from you. It never says what.", 
                "sound_path": "res://sound/description/mcdonalds99rideauinterior.mp3"
            }
        }, 
        "connected_zones": ["McDonald's – 99 Rideau"], 
        "characters": []
    }, 


    "Byward Market - Clarence Street": {
        "zone_name": "ClarenceStreet", 
        "default_viewpoint": "main", 
        "category": "ottawa_high_outside", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/clarencestreet.png", 
                "description": "Clarence Street does not sleep so much as it pauses, waiting for someone to realize it never wanted to be a street. The lamps are too yellow, too dim, spaced just far enough apart to leave questions between them. Storefronts line the road like teeth after a long night, all signage faded, all doors closed but not locked. There is movement behind the glass, but only the kind you sense, never see. The pavement glistens without rain. A car is parked without a driver. The Parliament silhouette looms in the distance, indifferent and still. Everything here feels like the end of something that has not happened yet.", 
                "sound_path": "res://sound/description/clarencestreet.mp3"
            }
        }, 
        "connected_zones": ["ByWard Garage", "Lowertown"], 
        "characters": []
    }, 

    "ByWard Garage": {
        "zone_name": "ByWardGarage", 
        "default_viewpoint": "main", 
        "category": "ottawa_high_outside", 
        "is_neighborhood": false, 
        "viewpoints": {
            "main": {
                "image_path": "res://Image/ViewpointImage/bywardgarage.png", 
                "description": "The ByWard garage crouches behind the market like it was put there to keep something in, not store anything. Its lights are too few and too dim, humming just enough to remind you they are failing. The concrete is warm in summer, sweating in winter, never fully dry. Cars come and go, but the place itself does not move. The signs point nowhere. The air smells like rubber, coin metal, and something faintly sweet, like fruit gone soft in the dark. You can walk through it without being stopped. No one will say anything. But the sound of your footsteps will follow you longer than they should.", 
                "sound_path": "res://sound/description/bywardgarage.mp3"
            }
        }, 
        "connected_zones": ["Byward Market - Clarence Street"], 
        "characters": []
    }, 

"Byward Market - York Street": {
    "zone_name": "YorkStreet", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/yorkstreet.png", 
            "description": "York Street carries the bones of Bytown beneath its pavement. Once a line for timber carts and laborers, it still feels more like a passage than a place. The bricks on either side are survivors of the city’s early fires, their edges chipped and darkened, as if remembering smoke. The lamps do not brighten so much as mark territory, leaving wide shadows where silence gathers. The market shuts down, yet the air lingers with bruised fruit and stale beer, the kind of smell that does not wash out. Cars idle without drivers. Windows stare without light. The street waits, not for traffic, but for someone to notice how long it has been waiting.", 
            "sound_path": "res://sound/description/yorkstreet.mp3"
        }
    }, 
    "connected_zones": ["Zaphod Beeblebrox Entrance", "Byward Market - Clarence Street", "Lowertown"], 
    "characters": []
}, 

"Zaphod Beeblebrox Entrance": {
    "zone_name": "ZaphodBeeblebroxEntrance", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/zaphodbeeblebrox.png", 
            "description": "The doorway to Zaphod Beeblebrox pretends at starlight but never leaves Ottawa. Its sign hums in uneven blue against brickwork older than the club’s ideas, framed by green-painted pillars that lean like they were never measured. The glass door wears layers of tape and torn posters, fingerprints pressed so long they have become part of the pane. A locked service door beside it stays the same shade of moss every season. The sidewalk shows scars from utilities long since removed, square cuts that never healed. Steam crawls from the alley vents, curling into the sign’s glow. The place wants to be cosmic, but it feels more like a bar drafted into a ledger.", 
            "sound_path": "res://sound/description/zaphodbeeblebrox.mp3"
        }
    }, 
    "connected_zones": ["Zaphod Beeblebrox", "Byward Market - York Street"], 
    "characters": []
}, 

"Zaphod Beeblebrox": {
    "zone_name": "ZaphodBeeblebrox", 
    "default_viewpoint": "stage", 
    "category": "Club001", 
    "is_neighborhood": false, 
    "viewpoints": {
        "stage": {
            "image_path": "res://Image/ViewpointImage/zaphodbeeblebrox_stage.png", 
            "description": "The stage at Zaphod Beeblebrox is not elevated. It just happens to be where the lights are pointed. Inspired by basement venues and B-side bootlegs, it is a shallow platform barely separated from the crowd, framed by cables that crawl across the ceiling like exposed nerves. The walls are black-painted cinderblock, chipped and recoated so many times they feel soft to the touch. A single fan turns overhead, not to cool the room but to keep the sweat moving. The audience is packed tight, shoulder to shoulder, their boots stuck to the floor and their faces lit in bursts of red and green. The sound doesn’t echo. It just stays.", 
            "sound_path": "res://sound/description/zaphodbeeblebrox_stage.mp3"
        }, 
        "bar": {
            "image_path": "res://Image/ViewpointImage/zaphodbeeblebrox_bar.png", 
            "description": "The bar at Zaphod Beeblebrox is a long stretch of scuffed wood that drinks as much as it serves. Its surface is carved with initials, ticket stubs pressed into its cracks, and rings left by glasses that never dried. Behind it, the shelves glow with cheap bottles lit from below, labels curling from the damp. The bartenders move fast but without ceremony, their motions rehearsed like factory work. The air is thick with the mix of stale hops, spilled spirits, and the tang of wet coats drying too slowly. Every stool wobbles. Every glass feels borrowed. The bar is less a place to rest than another part of the noise.", 
            "sound_path": "res://sound/description/zaphodbeeblebrox_bar.mp3"
        }
    }, 
    "connected_zones": ["Zaphod Beeblebrox Entrance"], 
    "characters": []
}, 




"New Edinburgh": {
    "zone_name": "NewEdinburgh", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/NewEdinburgh.png", 
            "description": "Brick houses gather close along narrow streets, their walls darkened by damp and age, their windows glowing faintly like eyes that do not sleep. Beyond the fences, embassy gardens linger under trimmed hedges, but the air feels staged, too neat, too careful. The roar of the Rideau Falls seeps in from the edge of the neighborhood, constant and heavy, a sound that drowns out whatever else might be moving in the dark. Lamps stretch their light thin across the cobblestones, leaving more shadow than glow.\n\nThis is New Edinburgh, a corner of Ottawa where diplomacy and secrecy hardened into brick and iron. The streets do not invite, they observe. After sundown the silence sharpens, broken only by the water’s endless crash, a reminder that the city’s veins end here in noise and mist. It is less a place to live than a precinct of vigilance, a neighborhood that remembers its purpose and does not let you forget it.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Lowertown", "Lindenlea"], 
    "characters": []
}, 



"Lindenlea": {
    "zone_name": "Lindenlea", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Lindenlea.png", 
            "description": "Tucked north of Beechwood, the houses stand small but deliberate, with steep roofs and narrow porches pressed along winding streets. Trees grow thick overhead, their branches locking together until the lamps struggle to break through, leaving sidewalks in uneven pools of shadow. The air carries the smell of damp soil and stone, a weight that clings to basements and stairwells. At night the streets twist back on themselves, each corner sharper than it should be, each turn uncertain.\n\nLindenlea was born from the garden city dream, but the dream feels uneasy. The planned lanes curl inward, looping into patterns that trap as much as they guide, until the neighborhood feels like it is folding in on itself. Windows shut early, porches sit vacant, and the quiet lengthens into something more deliberate than rest. The design whispers order, yet the mood suggests surveillance, as though the very plan was drawn not to free its residents, but to keep them accounted for.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["New Edinburgh"], 
    "characters": []
}, 



"Sandy Hills": {
    "zone_name": "SandyHill", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/SandyHill.png", 
            "description": "East of downtown the ground slopes, and the houses lean with it, brick shells marked by chipped plaster and stairways that groan under their own weight. Trees crowd overhead in broken lines, their branches weaving over lamps that stutter out halos of sickly yellow. The air tastes of chalk dust and wet wood, with a faint bitterness of plaster crumbling in the rain. Every few blocks an embassy crouches behind wrought iron, too quiet, while the gaps between them are filled by student houses where the laughter sounds manic even before it cuts off.\n\nSandy Hill is the city’s split personality left in plain sight. Old mansions crumble into rooming houses, embassies shine with empty windows, and the apartments cough up tenants who move in and out like a revolving cast. It is polite by day, but at night the silence takes a paranoid edge, heavy and unblinking. Footsteps echo longer than they should, doors slam without faces, and the street seems to double back on itself. The neighborhood does not feel lived in so much as haunted by Ottawa’s need to remember and forget at the same time.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Ottawa Downtown", "Lowertown", "Golden Triangle", "Overbrook", "Old Ottawa East"], 
    "characters": []
}, 



"Overbrook": {
    "zone_name": "Overbrook", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Overbrook.png", 
            "description": "The houses sit low to the ground, their siding patched in mismatched colors, roofs marked by stains that never washed out. Chain-link fences lean at odd angles, gates swinging loose on rusted hinges. The streets are cracked and uneven, pools of dirty water swallowing what little glow the lamps can give. Down by the river the air is sour with algae and rust, seeping into basements that already smell of mildew. Even at night the highway above never quiets, its roar pressing down like a weight.\n\nOverbrook carries the look of neglect, a neighborhood patched over just enough to keep moving but never enough to feel whole. Shops along Coventry shutter early, leaving only dim reflections in their glass. The alleys run tight and strewn with bottles, corners marked by graffiti that looks older than it is. The silence here is uneasy, the kind that makes you check behind you even when no one is near. It feels less like a place to live than a place the city left behind, waiting to see how long it will hold together.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Sandy Hills", "Forbes"], 
    "characters": []
}, 



"Forbes": {
    "zone_name": "Forbes", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Forbes.png", 
            "description": "Tucked off St. Laurent, the streets of Forbes run short and uneven, a tangle of low houses and tired walk-ups pressed against the industrial yards. The asphalt is cracked and buckled, lined with ditches that stink of oil and rainwater. Streetlamps give off a pale orange haze that seems to fade before it hits the ground, leaving corners where the dark gathers thick. The air carries the sharp tang of metal, a reminder of the garages and warehouses that sit just past the houses, their lots littered with rusted scraps.\n\nForbes feels like the edge of something, a neighborhood that lives under the shadow of workyards and traffic. The homes are small, patched over, curtains drawn early. Stray dogs move between the fences, their shapes quick and silent, and the only sound after nightfall is the low hum of machinery that never really stops. It has the air of a place nobody chose, where people end up rather than arrive. Walk too long through its streets and it feels less like you are crossing a neighborhood and more like you are being pushed out of the city itself.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Overbrook"], 
    "characters": []
}, 




"Hull Downtown": {
    "zone_name": "HullDowntown", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/hulldowntown.png", 
            "description": "The towers in downtown Hull reflect each other like liars trading stories, all glass and repetition, their surfaces too clean to trust. Walkways stretch between buildings like veins no one remembers stitching, each step echoing against concrete that never fully dried. Inside, the offices hum with low voltage and bad intentions, paper shuffled just to prove someone is listening. Outside, the sidewalks curve around bars that never close, never brighten, their windows filmed with the breath of men who speak in smoke. Nothing here points north. The signs contradict each other, and the streets pretend they’re part of something bigger across the river. But the river does not believe them. And when the sun sets, the light does not fall. It gets pulled down, slowly, like a body sinking.", 
            "sound_path": "res://sound/description/hulldowntown.mp3"
        }
    }, 
    "connected_zones": ["Wrightville", "Lowertown"], 
    "characters": []
}, 

  "Wrightville": {
    "zone_name": "Wrightville", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
      "main": {
        "image_path": "res://Image/ViewpointImage/wrightville.png", 
        "description": "Wrightville sits low against the river, crouched in its own reflection. Houses press together with the posture of people who have waited too long in line, their paint cracked, their porches slanted just enough to whisper about weight. Power lines cross overhead in loose grids that buzz in the rain. There are too many backyards here, and most no longer know who owns them. At night, televisions flicker through curtains and cast strange liturgies onto plastic siding. The silence is slow and adhesive, like syrup left on a counter. Even the wind sounds reluctant.", 
        "sound_path": "res://sound/description/wrightville.mp3"
      }
    }, 
    "connected_zones": ["Gatineau Park", "Hull Downtown"], 
    "characters": []
  }, 

  "Gatineau Park": {
    "zone_name": "GatineauPark", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
      "main": {
        "image_path": "res://Image/ViewpointImage/gatineaupark.png", 
        "description": "Gatineau Park begins where the city forgets itself. The pavement gives way to gravel, then to quiet, then to something older. Trees rise in patient formations, spaced like columns in a forgotten temple, their bark etched by wind and the slow discipline of time. The trails don’t lead; they suggest. Lakes sit like held breath between hills that never quite relax. In the underbrush, everything moves like it has permission. The park is not wild, but it is not tamed either. It watches. It remembers. And in the stillness between footsteps, the dark feels deliberate.", 
        "sound_path": "res://sound/description/gatineaupark.mp3"
      }
    }, 
    "connected_zones": ["Gatineau Parkway", "Wrightville"], 
    "characters": []
  }, 

"Gatineau Parkway": {
    "zone_name": "Gatineau Parkway", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
      "Main": {
        "image_path": "res://Image/ViewpointImage/GatineauParkway.png", 
        "description": "Gatineau Parkway coils like a forgotten, frozen serpent through the heart of the park. Towering pines lean inward while the brooding cliffs gaze down like sentinels carved from sorrow at the trodden white path below. Snow weighs down the branches beside and above, making them bow to those souls who pass through this long path. Only the ambient heat of the asphalt and the dedication of the city's snowplows keeps it somewhat visible, lined by walls of discarded snow that could bury a man alive. Many paths branch off the sides, some drawn with the tracks of skis and others with the heavy dragging of snowshoes. The only thing stirring is the swirl of flakes in the biting air. Each step forward is another toward the maw of a hungering winter beast.", 
        "sound_path": "res://Assets/Sound/*YOURSOUNDFILENAME*.ogg"
      }
    }, 
    "connected_zones": ["Gatineau Park", "Lusk Cave - Entrance", "Phillipe Lake Campground"], 
    "characters": []
  }, 

  "Lusk Cave - Entrance": {
    "zone_name": "Lusk Cave - Entrance", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
      "Main": {
        "image_path": "res://Image/ViewpointImage/LuskCaveMouth.png", 
        "description": "At the end of a half-frozen stream, peeking just above the snowline, a dark abyss waits to swallow the next who stumbles into it. The damp cavern air drifts over the white banks with a ravenous bite, leaving trails of ice over the skin of any who approach. Just inside, the ice breaks open to allow the stream to run through, thin and starving in these winter months. Forced to crouch down to half a man's height, once inside you're forced shin-deep into icy water. Each step inside is slick and deadly as if the cave itself desired the blood of its delvers. From deeper in, the wind moans mournfully. Nothing here is at a peaceful rest.", 
        "sound_path": "res://Assets/Sound/*YOURSOUNDFILENAME*.ogg"
      }
    }, 
    "connected_zones": ["Gatineau Parkway", "Lusk Cave - Main Chamber"], 
    "characters": []
  }, 

  "Lusk Cave - Main Chamber": {
    "zone_name": "Lusk Cave - Main Chamber", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
      "Main": {
        "image_path": "res://Image/ViewpointImage/LuskChamber.png", 
        "description": "Finally, you can stand upright without rock scraping flesh from your skull. Pitch darkness surrounds you, even the air seeming to hold its breath. Here, the cave has opened up into a large chamber with several ledges and smaller crevices branching off into other sections of the cavern. One path has the faintest scent of fresh air. The others? Musky and damp. Forgotten. Whatever ancient things were once here, nothing remains. And yet, you feel unwelcome. The stone here whispers of blood and violence. Of trespassing. The urge to turn back wells in your chest. A primal instinct of flight.", 
        "sound_path": "res://Assets/Sound/*YOURSOUNDFILENAME*.ogg"
      }
    }, 
    "connected_zones": ["Lusk Cave - Entrance"], 
    "characters": []
  }, 

  "Lusk Cave - Hidden Path": {
    "zone_name": "Lusk Cave - Hidden Path", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
      "Main": {
        "image_path": "res://Image/ViewpointImage/LuskCaveHiddenPath.png", 
        "description": "Braving through the oppressive atmosphere of the cave, you press yourself through a narrow fissure near the stone floor. The ancient marble digs into your flesh while you move, inch by inch. Here, you're a sitting duck. You can hardly move. The walls compress so tightly around your chest that you're certain that kine would suffocate before they made it to.. wherever this goes. Yet still, you inch onward through this claustrophobic nightmare. Or do you turn back? You're free range for anything ahead or behind and the animal stench here is only growing stronger..", 
        "sound_path": "res://sound/description/*SOUNDFILENAME*.mp3"
      }
    }, 
    "connected_zones": ["Sera's Hideaway", "Lusk Cave - Main Chamber"], 
    "characters": [], 
    "secret_entry_passwords": ["sinclair"], 
    "accessible_from_zones": ["Lusk Cave - Main Chamber"]
  }, 


  "Sera's Hideaway": {
    "zone_name": "Sera's Hideaway", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
      "Main": {
        "image_path": "res://Image/ViewpointImage/SeraCave.png", 
        "description": "The suffocating passage winds, expands, and contracts before finally opening up into a reasonably large chamber. Pelts are strewn around the place, a few knives and a handgun have been haphazardly thrown in a corner. Beside the pelts is a well-polished recurve bow and a quiver of arrows as well as a stack of papers -- newspapers, it looks like, from the last five years. Some are the Ottawa Citizen. Others? The Boston Globe. The New York Times. Beyond that, very little personal effects seem to dot the space.\n\nHowever, the other side of the cavern tells a new tale. Here, the bones of animals and humans alike have begun to pile. Old blood flakes from even more ancient marble. Claw marks mar the wall. But not all of the bones sit forgotten. Some have been carved. Others pierced with cord and wrapped. Tools and jewelry both. No part of the prey left to waste. All of nature had its purpose.", 
        "sound_path": "res://Assets/Sound/*YOURSOUNDFILENAME*.ogg"
      }
    }, 
    "connected_zones": ["Lusk Cave - Hidden Path"], 
    "characters": []
  }, 

  "Phillipe Lake Campground": {
    "zone_name": "Phillipe Lake Campground", 
    "default_viewpoint": "Main", 
    "category": "", 
    "is_neighborhood": false, 
    "viewpoints": {
      "Main": {
        "image_path": "res://Image/ViewpointImage/PhillipeLakeCampground.png", 
        "description": "A biting winter wind howls through the dark campground by Phillipe Lake, where a few dying campfires flicker weakly against the cold. Mist coils through the frost-covered trees and clings to the shore, veiling the landscape in a ghostly hush. The lake lies black and motionless, a mirror to nothing, its surface exhaling silence like breath from the grave. Shadows stretch long and unnatural, cast by the firelight, as if something unseen watches from the treeline. Once a place of warmth and stories, the campground now feels suspended between worlds—where time forgets to move, and the dead may still wander.\n\nWho knows what might become of these souls beneath the heavy boughs of winter?", 
        "sound_path": "res://Assets/Sound/*YOURSOUNDFILENAME*.ogg"
      }
    }, 
    "connected_zones": ["Gatineau Parkway"], 
    "characters": []
  }, 



"Golden Triangle": {
    "zone_name": "GoldenTriangle", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/GoldenTriangle.png", 
            "description": "The Golden Triangle lies before you, a slender wedge of city hemmed by the silent glide of the Rideau Canal and the restless pulse of Elgin Street. By day, its streets are filled with the warm hum of cafés, boutiques, and murmuring crowds, but as dusk falls, the energy subtly shifts.\n\nElgin Street, the western edge, wears its modern bustle like a mask. Under its glow of neon signs and laughter lie whispered bargains, fleeting alliances, and the soft shadow of predators choosing their moment.\n\nTo the east, the Rideau Canal mirrors the sky, its surface reflecting the glow of lampposts and the hush of drifting leaf shadows. In winter, it transforms into a vast expanse of ice, a pale stage where breath crystallizes and echoes seem too loud, where the world’s largest skating rink becomes a frozen altar, gleaming in the moonlight.\n\nAt night the streets darken, lanterns flicker, and the architecture breathes stories the living have long forgotten. This is not just a neighborhood. It is a vein through the city, where history and hunger swirl together beneath polished surfaces.", 
            "sound_path": "res://sound/description/GoldenTriangle.mp3"
        }
    }, 
    "connected_zones": ["Elgin Street (Golden Triangle)", "Centretown", "Sandy Hills"], 
    "characters": []
}, 


"Elgin Street (Golden Triangle)": {
    "zone_name": "ElginStreetGoldenTriangle", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/ElginStreetGoldenTriangle.png", 
            "description": "Elgin Street runs like a vein through the Golden Triangle, pulsing with the lifeblood of Ottawa’s nocturnal elite. By day, the avenue wears the mask of respectability. Polished storefronts, boutiques displaying their high society luxuries, and cafés that whisper with the idle chatter of the well kept. As the sun surrenders, the street shifts. The air thickens with music, smoke, and temptation, and the Golden Triangle bares its fangs.\n\nAt its heart stands Ember Moon, a rock nightclub whose crimson neon sign glows like a wound in the night. The bass reverberates through the pavement, a siren’s pulse that draws mortals and Kindred alike. Inside, shadows writhe in rhythm, sweat and desire mingling beneath the burn of stage lights. Ember Moon is more than a club. It is a crucible of hunger, where whispers of backroom dealings vanish beneath the thunder of guitars.\n\nScattered along the street, other clubs pulse in counterpoint. Velvet draped lounges for the decadent, electronic temples where the music blurs into something mechanical and near bestial. Between them, the cold facades of art galleries rise like sanctuaries to beauty, their walls hung with visions that speak more of obsession than genius. Toreador prowl these halls as priests at their altars, their courtly games dressed in the guise of curation.\n\nNot far from the glow of indulgence lie old libraries, their spines cracked and pages heavy with dust. A few Kindred favor these quiet sanctums, their pale fingers turning the parchment of forgotten truths while the city outside roars with noise. Above, the skyline bristles with ornate apartments, homes of Ottawa’s gilded aristocracy. Their balconies overlook Elgin like watchtowers, where society’s chosen sip their wine and pretend not to notice the shadows sliding beneath them.\n\nThe Golden Triangle is more than a neighborhood. It is a stage for contrasts. Elegance and decay. Indulgence and secrecy. The pulse of the living and the silence of the dead. To mortals, it is a district of culture and pleasure. To the Kindred, it is contested ground, a hunting preserve wrapped in the trappings of sophistication, where every gallery, every bar, every chandelier lit apartment conceals a predator’s smile.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Château de Ahn Driveway", "Golden Triangle"], 
    "characters": []
}, 


"Château de Ahn Driveway": {
    "zone_name": "ChateauDeAhnDriveway", 
    "default_viewpoint": "main", 
    "category": "ottawa_private_outside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/ChateauDeAhnDriveway.png", 
            "description": "Along Queen Elizabeth Drive is a lone driveway locked behind heavy gates of older times. The wrought iron gate creaks faintly as the wind stirs it, its intricate patterns blackened by age and neglect. The stone pillars that flank it bear the weight of centuries, their weathered surfaces veined with moss and shadow. Beyond lies a path strewn with fallen leaves, a carpet of autumnal reds and golds that whisper underfoot with every step.\n\nThe forest beyond the threshold is quiet, too quiet. The kind of silence that feels heavy and expectant, as though the trees themselves are holding their breath. The narrowing path vanishes into the embrace of ancient trunks, where the last light of dusk struggles to penetrate the canopy.\n\nThis gate is not merely an entrance. It is a boundary. To cross it is to leave the world of the living behind, to step willingly into the domain of the unseen. Whatever waits beyond does not welcome the uninvited, yet it calls to those attuned to the secrets of the night.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Château de Ahn", "Golden Triangle", "Elgin Street (Golden Triangle)"], 
    "characters": []
}, 


"Château de Ahn": {
    "zone_name": "ChateauDeAhn", 
    "default_viewpoint": "main", 
    "category": "ottawa_private_outside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/ChateauDeAhn.png", 
            "description": "Before you rises a monumental mansion, a relic of bygone centuries, its walls entwined with ivy and scarred by time itself. Rounded towers, capped with slate tiled spires, loom like grim sentinels against the sky, while the tall windows are dark mirrors that make it hard to shake the feeling of being watched.\n\nThe façade blends opulent elegance with oppressive weight. Stone, ornament, and shadow. Half hidden stairways wind toward massive entrance portals that make even the bold hesitate before crossing the threshold.\n\nThe garden, immaculately kept and yet eerily still, feels more like a stage set than a living place. The flowers are too perfect and the grass too even, as if arranged by an unseen hand. At night, mist often shrouds the estate, and the crunch of gravel along the paths echoes too loudly between the arcades.\n\nThis is no ordinary house. It is a haven for the Undying. A refuge where ancient intrigues are woven and masks of humanity are carefully maintained. Behind the heavy doors, the whispers of centuries linger, and in every shadow, the gaze of an elder may lie in wait.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Château de Ahn Driveway", "Château de Ahn - Inside", "Château de Ahn - Garden"], 
    "characters": []
}, 


"Château de Ahn - Inside": {
    "zone_name": "ChateauDeAhnInside", 
    "default_viewpoint": "main", 
    "category": "ottawa_private_inside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/ChateauDeAhnInside.png", 
            "description": "The library is a cathedral of silence, dressed in velvet shadows and fractured light. Tall, gothic windows spill a dim glow across the chamber, painting the air with the melancholy hues of dusk. Every shelf groans beneath the weight of ancient tomes, their cracked spines whispering of forbidden truths, their presence a promise and a warning alike.\n\nThe air is heavy with dust, wax, and faint traces of incense long burned out. Statues and carved columns watch like stone sentinels, their expressions unreadable in the flicker of lamplight. The ornate balcony above seems less a gallery for readers and more a vantage for unseen eyes.\n\nThe arrangement of furniture feels deliberate and almost ritualistic. Two opposing sofas like seats at a council of shadows, and a circular table at the center as if it were an altar to knowledge or power. Rich carpets dull every step, swallowing sound until even the smallest movement feels intrusive and sacrilegious.\n\nIt is a place for confidences and conspiracies, where the illusion of hospitality cannot mask the undertow of danger. Here, every book may be a weapon, every silence a trap, and every word the beginning of a pact sealed in blood.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Château de Ahn", "Château de Ahn - Garden", "Château de Ahn - Atelier", "Château de Ahn - Great Hall"], 
    "characters": []
}, 


"Château de Ahn - Great Hall": {
    "zone_name": "ChateauDeAhnGreatHall", 
    "default_viewpoint": "main", 
    "category": "ottawa_private_inside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/ChateauDeAhnGreatHall.png", 
            "description": "The great hall hums with the weight of history and the subtle dread of secrets best left unspoken. Gothic arches stretch upward like the ribs of an ancient beast, while the soft lighting does little to chase away the shadows clinging to every corner. Polished floors gleam faintly, reflecting the cold glow from tall windows that spill in more moonlight than day. The air feels curated. Elegant, but not welcoming. Here, power is measured in silence and glances, as though the hall itself listens. It bridges centuries. Medieval stone bones dressed in modern upkeep, a place where masquerade and predation meet under the guise of civility.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Château de Ahn - Inside"], 
    "characters": []
}, 

"Château de Ahn - Garden": {
    "zone_name": "ChateauDeAhnGarden", 
    "default_viewpoint": "main", 
    "category": "ottawa_private_outside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/ChateauDeAhnGarden.png", 
            "description": "The garden unfolds like a carefully composed requiem. Orderly, elegant, and faintly unsettling in its perfection. The stone path winds with deliberate grace along the grounds, its pale surface whispering beneath each step. Overhead, wooden trellises form a vaulted canopy, from which lavender drapes in languid strands, the fragrance cloying in the night air. Sweet, with a suggestion of decay.\n\nLanterns hang from the beams, their glow subdued, casting long and skeletal shadows across the path. Their light is not warm, but pale and uncertain, illuminating only fragments of the way forward and leaving the rest to the velvet silence of the dark.\n\nFurther in the distance, a greenhouse rises, its glass panes gleaming faintly under the moonlight. Once a sanctuary for cultivation, it now serves as a secluded tea house. An oasis for clandestine meetings, whispered bargains, and conversations veiled in civility. Its walls of glass shimmer like the surface of a dream, offering the illusion of transparency while concealing truths far more dangerous.\n\nThis is no mere garden. It is a stage set for intrigue, where nature is tamed into elegance, and every detail reminds the visitor that beauty here is never without peril.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Château de Ahn", "Château de Ahn - Inside", "Château de Ahn - Tea house"], 
    "characters": []
}, 


"Château de Ahn - Tea house": {
    "zone_name": "ChateauDeAhnTeaHouse", 
    "default_viewpoint": "main", 
    "category": "ottawa_private_inside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/ChateauDeAhnTeaHouse.png", 
            "description": "The tea house stands like a glass cathedral in the garden, its iron frame overgrown with roses and ivy, illuminated by the glow of a crystal chandelier. Inside, the air is thick with the sweetness of blossoms, heavy and intoxicating, as though beauty itself were a trap.\n\nA long table dominates the space, set not only for tea but for whispered salons where Kindred weave intrigues as carefully as garlands. Velvet chairs, porcelain cups, and fragrant blooms create an atmosphere both divine and suffocating. Eden reimagined as a stage for politics and seduction.\n\nHere, elegance is weapon, and every gesture is calculated. The tea may be exquisite, but it is never what truly quenches the thirst of its masters.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Château de Ahn - Garden"], 
    "characters": []
}, 


"Château de Ahn - Atelier": {
    "zone_name": "ChateauDeAhnAtelier", 
    "default_viewpoint": "main", 
    "category": "ottawa_private_inside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/ChateauDeAhnAtelier.png", 
            "description": "The studio breathes with the silence of stone, a cathedral of dust and artistry where every chisel mark is both violence and devotion. Blocks of marble and limestone stand like mute sentinels in various stages of becoming. Some still crude and unshaped, others caught forever in the fragile moment between perfection and ruin.\n\nThe air is thick with the scent of powdered stone, mingling with faint traces of oil and wax. Shafts of pale light filter through high and narrow windows, illuminating the suspended haze like a holy veil, making every particle dance as if in reverence to the artist’s touch. Tools lie scattered across heavy oak tables. Chisels worn to familiarity, hammers balanced with surgical precision. Each instrument as much a weapon as it is a brushstroke.\n\nHalf finished statues linger in the corners. Faces too beautiful to be mortal, bodies sculpted with an intimacy that borders on obsession. Some smile in serenity, others twist in agony, yet all bear the mark of their creator’s hunger for beauty, meaning, and permanence in a world of decay.\n\nCandles burn low among the stones, their light caressing surfaces that seem to breathe in the dark. To step into this place is to feel the presence of its master even in absence. A Toreador who does not simply carve, but seduces the very marrow of the earth into immortal form.\n\nThis is not a workshop. It is a sanctuary, a shrine, and a mausoleum for the Toreador’s desires, where every echo of hammer against stone sounds like a heartbeat that should not exist.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Château de Ahn - Inside", "Château de Ahn - Stone Vault"], 
    "characters": []
}, 


"Château de Ahn - Stone Vault": {
    "zone_name": "ChateauDeAhnStoneVault", 
    "default_viewpoint": "main", 
    "category": "ottawa_private_inside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/ChateauDeAhnStoneVault.png", 
            "description": "The chamber rests behind a sturdy wooden door, its frame scarred by years of quiet use. Within, the air is cool and clean, touched by the mineral breath of stone and the faint perfume of wood shavings.\n\nPedestals and shelves line the space, carrying half shaped blocks, unfinished busts, and figures caught mid gesture, waiting for the sculptor’s hand to return. Some forms are rough outlines, others nearly complete, their silence heavy with potential rather than ruin.\n\nThis is not a crypt, but a workshop paused in time. A sanctuary of intention where beauty lingers unfinished, each piece a promise still unfulfilled.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Château de Ahn - Atelier", "Crystal Haven"], 
    "characters": []
}, 


"Crystal Haven": {
    "zone_name": "CrystalHaven", 
    "default_viewpoint": "main", 
    "category": "ottawa_private_inside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/CrystalHaven.png", 
            "description": "The haven opens like the heart of a gemstone split by divine hands. Walls shimmer with the fractured brilliance of sapphire crystal, each surface catching and bending the faintest light into a thousand shades of midnight blue. The air is cool, tinged with the mineral scent of stone, as though the room itself has been carved from the bones of the earth.\n\nLamps fashioned from crystal shards burn with subdued glow, their light refracted into glistening patterns that crawl along the walls like living veins of frost. Couches and tables are sculpted from the same glacial essence. The counters gleam with a predatory polish, their edges sharp as fangs, glowing faintly in the light.\n\nHere, time feels suspended. Every angle and every reflection is curated and orchestrated. The interplay of light and shadow becomes a living artwork that shifts with each flicker of the lamps. It is not merely a refuge, but a shrine to beauty itself, a Toreador’s cathedral carved from the secret heart of the earth.\n\nHere, surrounded by the illusion of eternal ice and cosmic silence, one can almost forget the heat of the hunt and the burden of eternity. Almost.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Château de Ahn - Stone Vault", "Château de Ahn - Atelier", "Château de Ahn - Inside"], 
    "characters": [], 
    "secret_entry_passwords": ["Crystal"], 
    "accessible_from_zones": ["Château de Ahn - Stone Vault", "Château de Ahn - Atelier", "Château de Ahn - Inside", "Château de Ahn", "Château de Ahn - Garden", "Château de Ahn - Tea house", "Château de Ahn Driveway", "Château de Ahn - Great Hall"]
}, 


"Crystal Haven - Bedroom": {
    "zone_name": "CrystalHavenBedroom", 
    "default_viewpoint": "main", 
    "category": "ottawa_private_inside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/CrystalHavenBedroom.png", 
            "description": "A side chamber opens from the crystalline lounge, its icy brilliance softened into something more personal. The walls still glimmer with the frozen light of the main hall, but the atmosphere here is warmer and more human. Less a shrine, more a retreat. The bed at the center of the room blends comfort with design, echoing the crystalline elegance around it. The frame is pale and smooth as sculpted frost, and it glimmers faintly in the ambient light.\n\nLarge enough for two, the bed is built for comfort above all else, a high quality resting place where true ease is valued more than display. Silk sheets shimmer in a shade reminiscent of a pristine lake, their blue so clear and luminous it feels as though one could see straight through to endless depths. Against the crystalline chamber, they blend seamlessly, echoing the serene clarity of water captured in eternal stillness.\n\nAround it, small details anchor the room in memory. Plush figures, carefully placed. Photographs of family, including a young boy with black hair and vivid blue eyes, his gaze bright with the vitality that faded after the Embrace. Collars from pets passed only a few years ago. A few books rest on a side table, their pages worn from reading yet cared for with gentle hands.\n\nAgainst one wall rests a statue of a small dog and cat entwined in an embrace, a masterwork of stone whose tender detail softens the ice and radiates a living warmth.\n\nThis room is not a gallery and not a performance. It is a sanctuary of memory. Fragile, private, sacred, and achingly human.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Crystal Haven"], 
    "characters": [], 
    "secret_entry_passwords": ["Haven"], 
    "accessible_from_zones": ["Crystal Haven"]
}, 


"Crystal Haven - Jail": {
    "zone_name": "CrystalHavenJail", 
    "default_viewpoint": "main", 
    "category": "ottawa_private_inside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/CrystalHavenJail.png", 
            "description": "A narrow passage leads to a chamber stripped of dignity. The ice like walls gleam faintly, casting back a pale and pitiless light that spares nothing from view. There are no windows and no shadows to hide in. Only the raw, crystalline cold.\n\nInside, the barest elements of survival are laid out with clinical indifference. A cot thin as regret, a basin of stagnant water, and a toilet that reeks of utility. Nothing more. No softness and no comfort. Only existence prolonged until it is taken.\n\nThis is not a room, but a cage. A larder for the damned. The humans kept here are not chosen, but discarded by their own kind. Killers, predators, and wretches whose absence stirs no mourning. To the Kindred, they are nothing but vessels, blood held in skin, waiting for the kiss that will drain them dry.\n\nThe ice itself becomes a cruel irony. Beautiful, eternal, and utterly indifferent, it watches every moment of their captivity. In this place, humanity is reduced to stock, and death is not tragedy, but convenience.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Crystal Haven"], 
    "characters": [], 
    "secret_entry_passwords": ["Jail"], 
    "accessible_from_zones": ["Crystal Haven"]
}, 


"Ember Moon": {
    "zone_name": "EmberMoon", 
    "default_viewpoint": "main", 
    "category": "ottawa_private_inside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/EmberMoon.png", 
            "description": "The Ember Moon burns with 90s rock defiance, a neon crescent glowing blood red above its door. Inside, guitars scream, bodies writhe, and the air tastes of smoke, sweat, and hunger. Velvet draped booths cling to the edges of the chaos, where whispers of power and promises cut deeper than the music.\n\nAbove the bar, bottles glitter like stained glass in hellfire, every drink poured with a smile sharp enough to wound. Mortals think they have found rebellion, but the Kindred know better. The Ember Moon is their stage, their sanctuary, and their hunting ground.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Ember Moon - Outside"], 
    "characters": []
}, 



"Ember Moon - Outside": {
    "zone_name": "EmberMoonOutside", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": false, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/EmberMoonOutside.png", 
            "description": "Outside, the Ember Moon radiates a dangerous allure. A cracked brick facade looms under the sickly glow of a towering blood red neon crescent, the light buzzing like a heartbeat in the night. The sign’s letters read EMBER MOON in defiant scarlet, throwing jagged reflections across rain slick pavement.\n\nThe alley leading to the entrance feels alive with shadow. Graffiti sprawls in chaotic color, cigarette smoke curls from clustered figures, and the low thrum of bass rattles the street like a pulse calling to the lost and the hungry. A rusted steel door, framed in velvet black drapes, is watched by a bouncer whose eyes linger too long, sharp enough to peel back the soul.\n\nFrom the outside, the Ember Moon glows like a secret whispered into the night. A promise of hidden pleasures and forbidden freedom, its neon fire luring the curious into its embrace.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Elgin Street (Golden Triangle)", "Ember Moon"], 
    "characters": []
}, 



    "Old Ottawa East": {
        "zone_name": "Old Ottawa East", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/OldOttawaEast.png", 
                "description": "Its spine, Main Street, curves like someone gave up on drawing it straight. Houses sit slightly askew. Drainage patterns make no sense. Sidewalks disappear, then reappear two blocks later. This is not a planned neighbourhood. It is a contradiction mapped in inches. Saint Paul University anchors the south end. Convenience stores outnumber caf s. A halfway house and a massage clinic share the same block. ", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Old Ottawa South", "The Glebe", "Sandy Hills"], 
        "characters": []
    }, 



"Old Ottawa South": {
    "zone_name": "OldOttawaSouth", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/OldOttawaSouth.png", 
            "description": "Between the canal and the river, the streets knot themselves into Old Ottawa South, a strip that pretends to be cozy while something older breathes beneath it. Wooden porches lean over sidewalks that crack like broken teeth, and the lamps along Bank Street flicker over shops that feel more like holding cells than storefronts. The Mayfair Theatre glows in weak neon, its sign humming into the dark like a beacon for ghosts. The air clings heavy, a mix of damp brick and river silt that makes every corner taste stale.\n\nThis neighborhood is Ottawa’s conscience turned sour. It is the part of the city that remembers too much and hides it behind thrift stores, coffee counters, and long-standing pubs. The canal cuts one border, the river another, locking the streets into a pocket that has nowhere to go. After nightfall the silence has a pulse to it, steady and accusing, as though the houses themselves are keeping tally. Old Ottawa South is not about safety or tradition. It is about being watched, and about the city admitting, just here, that it never really trusted itself.", 
            "sound_path": "res://sound/description/OldOttawaSouth.mp3"
        }
    }, 
    "connected_zones": ["The Glebe", "Carleton University Campus", "Billings Bridge", "Old Ottawa East"], 
    "characters": []
}, 


"The Glebe": {
    "zone_name": "TheGlebe", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/TheGlebe.png", 
            "description": "The neighborhood rests just south of downtown, wrapped tight against the canal like it was meant to be set apart. Its houses are old brick, wide porches and tall windows, built by families who wanted permanence and got it. Shops along Bank Street still bear their old bones under new paint, storefronts changing hands but never quite shaking the weight of history behind the glass. The trees along the avenues grow thick, their roots splitting the walks as though reminding the pavement which came first. In the daytime it looks like stability, but the quiet after dark feels closer to watchfulness than comfort.\n\nThe Glebe represents Ottawa’s craving for order dressed up as charm. It is the city’s mirror of middle-class certainty, where heritage and respectability sit on every corner, but that same polish hides a nervous edge. The canal marks it like a moat, a line drawn between itself and the city it claims to be above. To walk its streets at night is to feel that mask slip, the houses leaning too close, the silence pressing harder than it should. The neighborhood is not just old or settled; it is a reminder that Ottawa’s heart beats slow, steady, and always under someone else’s gaze.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Centretown", "Old Ottawa South", "Old Ottawa East"], 
    "characters": []
}, 



"Billings Bridge": {
    "zone_name": "BillingsBridge", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/BillingsBridge.png", 
            "description": "Concrete hums at Billings Bridge, the weight of the span pressing into the river like a hand holding something down. The water churns black beneath it, catching faint scraps of light that break apart before they can form a reflection. Beside it the mall squats heavy, glass doors and tiled corridors that glow even after closing, a hive that refuses to sleep. The parking lots are wide and exposed, their painted lines stretching out like veins across empty ground.\n\nHere the city feels restless, as though it cannot sit still on its own foundations. The underpasses drip steadily, pools spreading across concrete that smells of iron and wet stone. Traffic shakes the span overhead, each passing car like a pulse too fast to be steady. Billings Bridge does not offer passage or arrival so much as pressure, the sense of being pinned between river and road, forced to listen as the current below whispers in a language you almost recognize.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Brookfield Gardens", "Old Ottawa South", "Faircrest Heights", "Applewood Acres"], 
    "characters": []
}, 


"Brookfield Gardens": {
    "zone_name": "BrookfieldGardens", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/BrookfieldGardens.png", 
            "description": "Low apartment blocks line the bend near Heron Road, their brick walls dulled by soot and streaks of damp. The courtyards between them are narrow, grass clipped too flat, the benches slick with condensation even before night settles. Lamps stutter against the dark, halos broken by the branches that reach in close, and the air carries the taste of exhaust from the parkway mixed with the sharp bite of concrete dust. The stairwells murmur with echoes, footsteps doubling back like the sound is reluctant to let go.\n\nBrookfield Gardens carries an unease that is sharper than silence. The hallways smell of meals you never see served, doors shut tight with locks scarred from too much use. Windows glow in scattered rhythms across the blocks, sudden rectangles of light that blink out as quickly as they appeared. Past midnight the streets run empty, but the buildings watch with their rows of blank eyes, steady and unblinking, as if the whole place is counting down to something it will not say aloud.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Mooney's Bay", "Rideau View", "Billings Bridge"], 
    "characters": []
}, 


"Mooney's Bay": {
    "zone_name": "MooneysBay", 
    "default_viewpoint": "main", 
    "category": "", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/MooneysBay.png", 
            "description": "The shoreline stretches wide, sand pale under the weak lamps that line the park. Water lies black and still, rippling only when the wind cuts sharp across its surface, carrying the smell of algae and gasoline from passing boats. The playground structures stand empty, their shapes crooked against the dark, while the steps of the old pavilion echo faintly even when no one moves. Beyond the beach, the trees close in thick, and their shadows spill long across the paths, bending where the light fails.\n\nMooney’s Bay has the feel of something waiting just out of sight. The water reflects almost nothing, swallowing light as if it were never there. Benches face the river like silent witnesses, their backs slick with dew, their seats cold no matter the season. Past midnight the place feels hollowed out, the laughter of summer crowds replaced by a pressure that tightens the air. The wide bay that looks welcoming by day becomes a black mouth at night, open and patient.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Rideau View", "Brookfield Gardens"], 
    "characters": []
}, 


"Carleton University Campus": {
    "zone_name": "CarletonUniversity", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/CarletonUniversityCampus.png", 
            "description": "The river bends around the campus like a moat, dark water pressing against the edges of clipped lawns and walkways that stretch too far beneath weak lamps. Buildings rise in blunt shapes of glass and brick, their windows blank after sundown, as if they have been watching too long. The tunnels below hum with stale air, their echoes doubling each step until it feels like someone is following. Even the benches scattered across the quads seem occupied in their stillness, waiting with a patience that does not belong to wood or stone.\n\nCarleton University carries an unease that settles deepest at night. The library looms like a bunker, humming with fluorescent breath, while the residence towers tilt above the river like worn sentries. The wind scrapes at the flagpoles, hollow and metallic, and doors in the underground walkways shut when no one is near. The campus feels staged, a collection of facades too neat to be empty, as though the lecture halls and stairwells are rehearsing for something that never arrives.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Rideau View", "Civic Hospital", "Old Ottawa South"], 
    "characters": []
}, 


"Rideau View": {
    "zone_name": "RideauView", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/RideauView.png", 
            "description": "Concrete towers rise like tired teeth against the river, their faces mottled with mildew and half-covered tags that no one remembers painting. The courtyards between them feel hollow, swings and benches scattered like discarded props, lit only by lamps that crackle in uneven bursts. The stairwells reek of damp and smoke, and when you climb them the echoes carry too long, repeating your steps as though someone else is following just a few paces behind. The smell of the river drifts in, iron-black, thick as oil, and it feels close enough to flood the whole place with a single turn.\n\nThis is Rideau View, carved from old farmland and left standing like a draft of the city that was never corrected. At night it feels temporary and unstable, a place where the air thickens with silence until even breathing sounds suspicious. The windows blink in uneven codes, turning on and off in patterns that suggest a message only the buildings understand. The neighborhood seems to wait with a patience that is not human, as though the streets themselves are counting down toward something you cannot quite see.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Carleton Heights", "Courtland Park", "Carleton University Campus", "Mooney's Bay", "Brookfield Gardens"], 
    "characters": []
}, 


"Chinatown": {
    "zone_name": "Chinatown", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/ChinatownOttawa.png", 
            "description": "Lantern signs hang crooked over Somerset, their colors dimmed by grime and years of smoke. Restaurants spill steam into the street, clouds that rise and vanish before they touch the lamps, leaving the sidewalks wet and strange. The shops feel too narrow, stacked with goods that smell of dust and oil, and above them the apartments press low, their windows shut tight against the night. Somewhere past the arches, traffic hums like a restless engine, carrying a weight that does not leave.\n\nChinatown in Ottawa feels like it holds its breath after dark. The signs flicker weakly, reds and greens bleeding out before they touch the pavement, and the alleys fold into deeper dark than they should. The air tastes faintly of soy and metal, like a kitchen left burning with no one inside. Stray cats slip across the street without sound, their eyes catching the glow like mirrors. Past midnight, the silence is thick enough to feel, and every shadow looks like it could step forward if given the chance.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Little Italy", "Centretown West"], 
    "characters": []
}, 



"Little Italy": {
    "zone_name": "LittleItaly", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/LittleItalyOttawa.png", 
            "description": "Along Preston Street the restaurants and cafés glow with neon, their signs humming in colors that bleed onto the wet pavement. The air is thick with garlic, oil, and smoke, but under it lingers the iron tang of the train tracks that cut across the neighborhood. Brick façades lean heavy over narrow sidewalks, their upper windows dark, blinds pulled tight as though the families above have retreated from the night. Even the murals seem to fade under the lamps, painted saints and flags peeling into shapes that do not quite stay still.\n\nLittle Italy carries a strange stillness once the kitchens close. The music dies but the echo clings to the alleys, a bassline you feel in your ribs though nothing plays. The benches along the street wait empty, damp beneath the sodium glow, and the intersections stretch too wide, as if holding their breath. Walk long enough and the smell of food gives way to something colder, metallic and sour, the kind of scent that clings to steel. By midnight the neighborhood feels less like a celebration and more like a memory that refuses to sleep.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Civic Hospital", "Hintonburg", "Centretown West", "Lebreton Flats", "Chinatown"], 
    "characters": []
}, 


"Hintonburg": {
    "zone_name": "Hintonburg", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Hintonburg.png", 
            "description": "The streets run narrow here, old brick shops pressed close against the road, their painted signs peeling into unreadable ghosts. Factories long since shuttered still breathe rust into the air, their chimneys blackened stubs pointing toward a sky that feels too low. Railway tracks slice through the blocks like scars, the sound of trains gone but their vibration lingering in the ground. Even the taverns spill less light than they should, their doors opening to rooms where laughter always sounds a little too far away.\n\nHintonburg is not dead, but it feels like it is rehearsing the end. The lamps flicker weakly against graffiti-stained walls, and the alleys seem to bend back on themselves, as if trapping whatever wanders in. Dogs bark in languages you almost understand, and sometimes the silence between houses feels like it is counting down. It is a neighborhood caught between what it was and what it will never be again, a place where you wonder if the city is rotting quietly from this very point outward, and whether the world notices or not.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Wellington Village", "Civic Hospital", "Little Italy"], 
    "characters": []
}, 


"Civic Hospital": {
    "zone_name": "CivicHospital", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/CivicHospital.png", 
            "description": "The streets rise gently toward the ridge, brick houses standing in neat rows with porches pulled close to the sidewalk. Trees arch overhead, their branches weaving shadows that smother the weak shine of the lamps. The air is heavy with the smell of stone and damp brick, as if the neighborhood itself sweats after sundown. Sirens stretch too long in the night, echoing between the houses until they dissolve into something less like a warning and more like a voice that refuses to fade.\n\nThe Civic Hospital looms at the heart of it, its windows stacked in rigid lines of light that spill coldly across the streets. Around it, the homes feel watchful and withdrawn, curtains sealed against the night, driveways empty even when the cars are still there. Few linger outside once dark settles in. The neighborhood holds quiet in a way that feels deliberate, as though the silence itself is standing guard, and the glow from the wards makes the streets look more like a wake than a place to rest.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Courtland Park", "Carlington", "Hintonburg", "Little Italy", "Carleton University Campus"], 
    "characters": []
}, 


"Courtland Park": {
    "zone_name": "CourtlandPark", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/CourtlandPark.png", 
            "description": "Tucked between the rail line and the curling edge of the Experimental Farm, Courtland Park feels more like a pocket than a neighborhood. The bungalows here are low and plain, set against hedges that have gone shaggy with age, their curtains drawn long before the lamps outside stutter to life. The air carries the flat stench of asphalt from the nearby roads, a taste that clings to the tongue and makes the silence heavier. Even the streetlamps seem reluctant, their glow collapsing just short of the hedgerows, leaving the sidewalks veiled in shadow.\n\nThis is the ground where the Merivale Road once carried cattle north toward the old slaughterhouses near the river, a history buried but not erased. Courtland Park seems to breathe that memory, the empty lots and overgrown fields marked by a quiet that feels more like withholding than peace. After nightfall, the spaces between houses seem to lengthen, as if the neighborhood itself is pulling apart. The air grows close and watchful, and the dark presses in with the sense that every step is tallied by something patient and unseen.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Carleton Heights", "Civic Hospital", "Rideau View"], 
    "characters": []
}, 


"Carleton Heights": {
    "zone_name": "CarletonHeights", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/CarletonHeights.png", 
            "description": "South of the river the streets stretch wide, broken by sagging lawns and driveways split like old scars. Duplexes lean into one another, their bricks damp with the night air, their curtains pulled as if the houses themselves were keeping secrets. Power lines whistle when the wind cuts through, a thin note that lingers longer than it should, and the lamps overhead buzz faintly like they are holding back the dark. The smell of wet asphalt mixes with cut grass and something sour that clings to the ditches along Prince of Wales.\n\nCarleton Heights feels unfinished, a neighborhood sketched too quickly and left to fade at the edges. The space here does not breathe like freedom, it gapes like vacancy, echoing when you walk alone. Dogs bark at nothing, and sometimes the silence that follows seems louder than their warning. The schoolyards grow heavy after sundown, playgrounds watching with more patience than their shape should allow. The quiet scratches at the nerves, a soundless pressure that feels like someone trying to speak.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Carlington", "Courtland Park", "Rideau View"], 
    "characters": []
}, 


"Wellington Village": {
    "zone_name": "WellingtonVillage", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/WellingtonVillage.png", 
            "description": "Shops line Wellington like teeth in a crooked grin, their painted signs faded, their windows clouded by dust and old light. Above them, narrow apartments squeeze against one another, brick walls scarred by smoke and the scrape of wires. The side streets feel tighter than they should, rows of homes crouched close, their porches sunken into shadow beneath thick maples. Even in daylight there is a hush to the air, as if conversation belongs behind doors, not on the pavement.\n\nThis is Wellington Village, where the lamps burn with a dull glow and the alleys seem to bend into darker turns than the maps remember. At night the storefront glass reflects more than it should, passing shapes that no one steps out to follow. The hum of the streetcars is gone, but sometimes the rails sing anyway, a metallic shiver under the asphalt. By midnight the neighborhood feels sealed, its silence too careful, its sleep too thin.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Westboro", "Hintonburg"], 
    "characters": []
}, 


"Carlington": {
    "zone_name": "Carlington", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Carlington.png", 
            "description": "On the western slope of Ottawa, rows of bungalows climb around a scarred hill where an old quarry pond sits stagnant and dark, its edges littered with weeds and glass. The wind twists strangely over the ridge, carrying whistles that sometimes sharpen into voices too close to human.\n\nThis is Carlington, a neighborhood that feels watchful even when nothing stirs. Streetlights along Kirkwood and Fisher hum weakly, while the alleys run deeper into shadow than they should. Garages rust at the margins, the churches close their doors early, and by midnight the hill glows faintly under city light, circled by houses that never seem to rest.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Westboro", "McKellar Heights", "Carleton Heights", "Civic Hospital"], 
    "characters": []
}, 

"Westboro": {
    "zone_name": "Westboro", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Westboro.png", 
            "description": "The homes along Richmond Road pretend to be modest, but the street carries memory like a watermark. Once a lumber town, then a village of rail-men and river work, Westboro was annexed into Ottawa as if absorbed into a greater body. Yet the lines of ownership still twitch. Warehouses stand among boutiques, and the old factories have not fully surrendered to renovation. The Ottawa River lies just beyond the rise, a reminder that the neighborhood owes its existence to current and commerce more than to civic design.\n\nIn the alleys behind the storefronts, brick walls lean under the weight of signs in both languages, though neither fully convinces. Churches with tired steps look down on quiet cafés, as if waiting for judgment. Every door carries a history, but none of them are fully open. The neighborhood is observed, recorded, and kept, like a file stored in the wrong cabinet but never thrown away.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Highland Park", "Carlington", "Wellington Village"], 
    "characters": []
}, 



"McKellar Heights": {
    "zone_name": "McKellarHeights", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/McKellarHeights.png", 
            "description": "A quiet grid between traffic veins, bordered by routine and clipped cedar. McKellar Heights doesn’t announce itself. It begins. One bungalow at a time. Lawns at regulation height. Driveways with two cars, both idling through retirement. The houses are close but not curious. Curtains drawn just enough to signal occupancy.\n\nThere is no center here. No plaza. No café with regulars. Just a church with a gravel lot and a park shaped like an afterthought. The signs are bilingual, the conversations are not. Even the birds seem to know when to stop singing. Somewhere behind one of the garages, a tool was left out and rusted into memory. No one touches it. Nothing is wasted. Nothing is explained.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Highland Park", "Woodroffe North"], 
    "characters": []
}, 



"Highland Park": {
    "zone_name": "HighlandPark", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/HighlandPark.png", 
            "description": "The homes were first laid out in the 1920s, back when Highland Park marked the western edge of Ottawa’s ambition. Built for professionals and government men who didn’t want to live downtown, the neighborhood took its shape from the streetcar line that once ran down Byron. Some of those rails still surface after heavy rain, pushing through the asphalt like reminders. The houses are large but quiet. Brick, wood, and old money.\n\nWalk the side streets and you’ll notice it. The same cars parked in the same places. The same dog walked at the same hour. Conversations are brief, polite, and never repeated. The library gets quiet visits. The cafés serve one drink well. Along the edge of the neighborhood, facing the parkway, there’s an abandoned tennis court no one tears up. The net is gone, but the lines are still visible. Everyone sees them. No one steps on them.", 
            "sound_path": "res://sound/description/HighlandPark.mp3"
        }
    }, 
    "connected_zones": ["Carlingwood", "McKellar Heights", "Westboro"], 
    "characters": []
}, 



"Woodroffe North": {
    "zone_name": "WoodroffeNorth", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/WoodroffeNorth.png", 
            "description": "The houses in Woodroffe North are older than they look. Set between the river and the transitway, their brickwork hides additions, retrofits, decades of quiet reshaping. Trees line the streets like they were planted with ceremony, now tall enough to cast shade over everything that followed. The roads here don’t connect so much as parallel. A layout made to be respected, not understood.\n\nDown near Richmond Road, the storefronts still hold their original signs, the kind with hand-painted letters and aging neon. Schools and churches are never far apart. At night, the sound of traffic from the Parkway blends with the wind through the trees, never quite fading, never quite loud. People who live here tend to stay. Not because of loyalty, but because the place is already calibrated to them. It remembers how they move. How they speak. What they prefer to keep private.", 
            "sound_path": "res://sound/description/WoodroffeNorth.mp3"
        }
    }, 
    "connected_zones": ["Lincoln Heights", "Carlingwood", "McKellar Heights"], 
    "characters": []
}, 



"Carlingwood": {
    "zone_name": "Carlingwood", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Carlingwood.png", 
            "description": "Carlingwood does not change quickly. Built around the shopping centre that gave it a name, the neighborhood settled early into its patterns. Bungalows with carports and hedge-lined yards. Seniors walking the same loop each morning. A library that still smells like the 1970s. The streets are wide and soft-spoken, curving gently between the mall, the churches, and the long shadow of the Queensway.\n\nThe mall itself is still clean, still humming. Escalators run smooth. Muzak plays without irony. People shop here because they always have. Most of them remember when it opened. Carlingwood was never meant to be a destination. It was a solution. A place for widows and former bookkeepers. A place where people nod to each other without speaking, and where nothing is urgent except the bus schedule. The city surrounds it now, but doesn’t enter.", 
            "sound_path": "res://sound/description/Carlingwood.mp3"
        }
    }, 
    "connected_zones": ["Lincoln Heights", "Woodroffe North", "Highland Park"], 
    "characters": []
}, 




"Eastway Gardens": {
    "zone_name": "Eastway Gardens", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/EastwayGardens.png", 
            "description": "Tucked into a hard corner of Alta Vista’s northern edge, it sits between Industrial Avenue, Russell Road, Belfast Road, and St. Laurent Boulevard, forming a square of housing boxed in by movement, noise, and freight. Rail lines run beside it. Trucks idle just beyond the tree line. There are no soft edges here. The houses are close, the lots small. Backyards back into chain-link fences or warehouse lots. At night, the sound of metal on metal from the freight lines can shake picture frames. Some families claim their children sleep better that way.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Elmvale Acres", "Riverview"], 
    "characters": []
}, 


"Riverview": {
    "zone_name": "Riverview", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/Riverview.png", 
            "description": "The Ottawa General Hospital, the CHEO campus, the National Defence Medical Centre. Massive, sterile facilities that pull gravity toward them like stars. Around them rose the apartment blocks: Alta Vista Towers, cooperative housing, seniors’ residences, low-income towers meant to solve problems that were never defined clearly in the first place. Squeezed between arterial roads, industrial boundaries, and the surgical hum of its medical core, the neighborhood stretches from Smyth to Heron, from Riverside to Industrial Avenue.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Eastway Gardens", "Elmvale Acres", "Alta Vista", "Applewood Acres"], 
    "characters": []
}, 

"Faircrest Heights": {
    "zone_name": "Faircrest Heights", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/FaircrestHeights.png", 
            "description": "Faircrest Heights is a fortress without walls. Bounded by Smyth Road, the Rideau River, and the skeletal reach of the Ottawa General Hospital, the neighborhood exists in a state of perfected seclusion. It remains one of the only zones in Alta Vista where zoning has never been meaningfully contested. There are no businesses here. No towers. No renters. Just silence, clipped hedges, and generational property lines marked in paperwork. The homes are large but not showy, intentionally neutral. Two-storey houses with narrow sightlines, low bungalows flanked by old maples. Driveways curve like questions no one wants to answer.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Alta Vista", "Applewood Acres", "Billings Bridge"], 
    "characters": []
}, 

"Applewood Acres": {
    "zone_name": "Applewood Acres", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/ApplewoodAcres.png", 
            "description": "The houses are modest, almost shy. Bounded by Kilborn Avenue, Heron Road, Bank Street, and the CN rail line, the neighborhood was one of Ottawa’s earliest experiments in total suburban design. It was shaped into a perfect little grid designed to absorb the postwar boom like a sponge. Campeau Corporation laid it out in the 1950s with military precision: rows of nearly identical bungalows, short walking distances, no commercial agitation. Commercial activity was zoned out. The only shops are just beyond reach. Everything here directs you outward for needs and inward for behavior. Schools like Ridgemont High taught structure, not ambition. Parks were placed like pressure valves.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Faircrest Heights", "Billings Bridge", "Alta Vista", "Riverview"], 
    "characters": []
}, 

"Alta Vista": {
    "zone_name": "Alta Vista", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/AltaVista.png", 
            "description": "To the north, the hospital complex looms. Ottawa General. CHEO. The National Defence Medical Centre. The community is a satellite array: civil servants, military clerks, radiology technicians. Parks like Featherston and Orlando exist mostly to soak up sound. Some nights, porch lights across three blocks all go out at the exact same minute. The layout is textbook: curving roads designed to reduce speed and thought, bungalows dropped like rubber stamps, zoning locked tight. Not one laundromat. Not one bar. Nothing unapproved.", 
            "sound_path": ""
        }
    }, 
    "connected_zones": ["Riverview", "Faircrest Heights", "Applewood Acres"], 
    "characters": []
}, 


"Lincoln Heights": {
    "zone_name": "LincolnHeights", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/LincolnHeights.png", 
            "description": "Lincoln Heights was carved out in the postwar swell, part of the city’s quiet push westward. It was never meant to dazzle. It was meant to function. Modest bungalows for public servants, walk-up apartments for clerks and telephonists, all placed with bureaucratic precision near the new transit loop and federal offices. The roads curve gently, not to follow the land but to manage it. The green spaces are wide, but no one sits in them for long.\n\nThe shopping centre opened in the 1960s with fanfare. There was a fountain once. Now the tiles are cracked, and the lights buzz even when it’s empty. The transit station across the boulevard feeds the city its workers and retrieves them after dark, quiet and unbroken. Inside the towers, blinds are always drawn. Conversations take place at kitchen tables under fluorescent light. There are no festivals here. No corner stores open past nine. Just routine, and the sound of the next bus arriving on schedule.", 
            "sound_path": "res://sound/description/LincolnHeights.mp3"
        }
    }, 
    "connected_zones": ["Britannia Heights", "Carlingwood", "Woodroffe North"], 
    "characters": []
}, 


"Britannia Heights": {
    "zone_name": "BritanniaHeights", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/BritanniaHeights.png", 
            "description": "The houses climb gently uphill, set back from the water but still within its reach. Britannia Heights grew as the streetcars did, one block at a time, grafted onto farmland by planners who believed order could be drawn with a ruler. Bungalows with trimmed hedges, Catholic schools with tall fences, and churches that watch from corners without blinking. Everything here is measured. Even the cracks in the sidewalk follow a pattern.\n\nThe families are older now. Some never left. Most work in departments no one talks about outside the office. There is a silence to the streets after dinner, a pause that stretches longer than it should. The streetlights flicker, but only once. Lawn ornaments shift slightly between seasons, always facing the same way. Behind the community centre, someone has been mowing a field that no one remembers using. Not out of care. Out of instruction.", 
            "sound_path": "res://sound/description/BritanniaHeights.mp3"
        }
    }, 
    "connected_zones": ["Lincoln Heights", "Britannia Village"], 
    "characters": []
}, 

"Britannia Village": {
    "zone_name": "BritanniaVillage", 
    "default_viewpoint": "main", 
    "category": "ottawa_high_outside", 
    "is_neighborhood": true, 
    "viewpoints": {
        "main": {
            "image_path": "res://Image/ViewpointImage/BritanniaVillage.png", 
            "description": "The street grid bends here, forced to accommodate what came before it. Britannia Village was a lakeside resort once, long before the capital swallowed it. Old foundations still surface in the soil after rain. Stone steps lead to nowhere. Brick outlines of vanished cottages emerge like quiet admissions. The tram used to stop near the water. It doesn’t anymore. The tracks were pulled up, but some nights you can still hear it. Metal on metal, just under the wind.\n\nPorches sag toward the Ottawa River, screened in and watching. Retired civil servants keep long memories and short conversations. The hydro station hums at all hours, its red warning lights blinking across the reeds like a signal no one speaks of. Every house has a locked drawer. The Dominion Observatory sits not far from here, blind and silent, still fenced off like it remembers what it once saw. Britannia waits at the western edge of the city, behind hedge and policy, perfectly still. It was archived, not abandoned. The filing cabinet just never closed.", 
            "sound_path": "res://sound/description/BritanniaVillage.mp3"
        }
    }, 
    "connected_zones": ["Rowatt St", "Britannia Heights"], 
    "characters": []
}, 


    "Rowatt St": {
        "zone_name": "Rowatt St", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/article-top-tips-to-secure-your-neighborhood-1-3934714195.png", 
                "description": "Rowatt Street isn't much in the way of interesting. Simple houses line a simple street, and for the most part? It's quiet here. People mind their business and keep opinions to themselves. \n\nAt the end of the street, a right turn will take you to a large home, older but still well maintained (at least externally). Rumor has it the lady of the house rarely leaves, and no one sees her doing so if she does."\
\
, 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Britannia Village"], 
        "characters": []
    }, 



    "Hunt Club Park": {
        "zone_name": "Hunt Club Park", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/HuntClubPark.png", 
                "description": "South of Walkley, east of Conroy, the fields have only just stopped being fields. The air still carries the smell of cut trees and disturbed soil. A handful of homes are finished. Some have families in them. There are fewer than fifteen hundred residents here. The streetlights work, but not all of them.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Urbandale"], 
        "characters": []
    }, 


    "Urbandale": {
        "zone_name": "Urbandale", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/Urbandale.png", 
                "description": "A branded enclosure stamped across southeastern Ottawa by Urbandale Construction, like the signature of a civil engineer who feared chaos.Three to four thousand residents lived in Urbandale by 1990. Most were Anglophone, most paid their property taxes on time. The parks were maintained. The lawns were edged. Urbandale is holding up patterns, the streets are clean. The people are good. And the silence under the topsoil is growing louder", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Hunt Club Park", "Elmvale Acres", "Hawthorne Meadows"], 
        "characters": []
    }, 


    "Hawthorne Meadows": {
        "zone_name": "Hawthorne Meadows", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/HawthorneMeadows.png", 
                "description": "Built during the second wave of Ottawa s expansion, its shape was drawn with a kind of doctrinal certainty: looping roads to create false safety, pocket parks like planned sacraments, rows of homes identical in posture but not in soul. Bordered by Walkley, St. Laurent, Russell, and the CN line, it sits like a quietly humming machine, neither hidden nor truly visible. Nothing looks broken. Nothing shines. There are no monuments here, only compliance.", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Urbandale", "Elmvale Acres", "Sheffield Glen"], 
        "characters": []
    }, 


    "Sheffield Glen": {
        "zone_name": "Sheffield Glen", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/SheffieldGlen.png", 
                "description": "A self-contained tract of low-rise housing tucked between Russell and Belfast like an afterthought, laid out in the curving grid of Southvale Crescent where roads loop endlessly back to themselves.Townhouses, garden homes, and rental blocks planted in quiet density, engineered for moderate income and manageable unrest. There are no local businesses.In 1990, two to three thousand people lived in Sheffield Glen. No parks. No schools. Just housing and the roads to take you somewhere else. Most were Anglophone, many were new arrivals from Lebanon, Romania, and El Salvador, moved here by circumstance more than choice", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Elmvale Acres", "Hawthorne Meadows"], 
        "characters": []
    }, 


    "Elmvale Acres": {
        "zone_name": "Elmvale Acres", 
        "default_viewpoint": "Main", 
        "category": "", 
        "is_neighborhood": true, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/ElmvaleAcres.png", 
                "description": "Mid-1950s, Campeau Corporation, a vision of modest utopia laid out in cul-de-sacs and quiet loops. Bungalows repeated like standardized answers. No room for ambition. No space for rot. South of Alta Vista, east of the General Hospital. The Elmvale Acres Shopping Centre served as the local heart, beating in fluorescent pulses. No frills, no flash. A pharmacy, a grocer, a dry cleaner with one broken press and three active service requests. Ottawa s hospital belt lay to the west, meaning half the residents worked shift schedules and spoke in clinical terms even at PTA meetings. Transit routes fed into the neighborhood like arteries from elsewhere, but few took the bus out unless they had to. ", 
                "sound_path": ""
            }, 
        }, 
        "connected_zones": ["Urbandale", "Eastway Gardens"], 
        "characters": []
    }, 

}
