extends Node
class_name HuntingScenarioManager


var scenarios: = {
    "Social": {
        "LonelyHeartAtTheBar": {
            "hunt_type": "Social", 
            "scenario_name": "Lonely Heart at the Bar", 
            "description": "You're out on the town, looking for someone lonely enough to take home.", 

            "contact_phase": [
                {
                    "title": "Scan the bar quietly", 
                    "description": "You sit back and observe. Who's drinking alone? Who looks desperate?", 
                    "roll": ["Perception", "Empathy"], 
                    "difficulty": 6, 
                    "success_text": "You clock a pair of lonely eyes at the end of the rail; their gaze slides off every group and lands on the door.", 
                    "failure_text": "Everyone is clustered or loud. The few loners studiously avoid eye contact, including yours."
                }, 
                {
                    "title": "Chat up the bartender", 
                    "description": "The bartender knows everyone. You slide over and start small talk.", 
                    "roll": ["Charisma", "Streetwise"], 
                    "difficulty": 7, 
                    "success_text": "A half-smile and a nod left; the bartender tilts their chin toward a regular nursing something cheap.", 
                    "failure_text": "The bartender is slammed and unimpressed. You get a mandatory chuckle and a suggestion to order or move."
                }, 
                {
                    "title": "Flirt from across the room", 
                    "description": "All eye contact and faint smiles. Let them come to you.", 
                    "roll": ["Manipulation", "Expression"], 
                    "difficulty": 6, 
                    "success_text": "They meet your gaze twice, then a third time longer than they should. Their shoulder angles your way.", 
                    "failure_text": "They glance once and fold back into their drink. A friend steps between you and the moment dies."
                }, 
                {
                    "title": "Claim the empty stool", 
                    "description": "You take the seat beside the loner like it was always meant to be yours, posture open, no rush.", 
                    "roll": ["Charisma", "Etiquette"], 
                    "difficulty": 6, 
                    "success_text": "They do not guard the space. A small smile flickers and they angle to include you.", 
                    "failure_text": "They slide a coat onto the stool or pivot to the TV. The bubble stays intact."
                }, 
                {
                    "title": "Pretend to cry at the bar", 
                    "description": "Tears are bait. You play the broken-hearted victim.", 
                    "roll": ["Appearance", "Subterfuge"], 
                    "difficulty": 8, 
                    "success_text": "A gentle hand lands on your shoulder. They offer a napkin and the kind of attention that lingers.", 
                    "failure_text": "Staff asks if you need a cab. Your would-be mark pivots away to avoid the scene."
                }
            ], 

            "hunt_phase": [
                {
                    "title": "Isolate them with flattery", 
                    "description": "You compliment them just right and suggest some privacy.", 
                    "roll": ["Manipulation", "Empathy"], 
                    "difficulty": 6, 
                    "success_text": "They lean in and mirror your smile. When you suggest fresh air, they nod without thinking.", 
                    "failure_text": "Your line lands like a script. They laugh it off and check the time."
                }, 
                {
                    "title": "Offer a smoke outside", 
                    "description": "Classic move. Just you and them by the dumpsters.", 
                    "roll": ["Charisma", "Subterfuge"], 
                    "difficulty": 6, 
                    "success_text": "They take the cigarette or the walk anyway. The door swings shut and the noise drops.", 
                    "failure_text": "They wave the offer away; they do not smoke or they just quit. The spell breaks."
                }, 
                {
                    "title": "Buy them a strong drink", 
                    "description": "Lowering their guard through old-fashioned poisoning.", 
                    "roll": ["Intelligence", "Streetwise"], 
                    "difficulty": 7, 
                    "success_text": "They accept and sip deep. Their shoulders loosen and the laugh comes easier.", 
                    "failure_text": "They set the glass aside after one taste. Water only, they say, with a smile that closes the door."
                }, 
                {
                    "title": "Convince them to dance", 
                    "description": "Close contact on the dance floor. You learn their rhythms.", 
                    "roll": ["Charisma", "Performance"], 
                    "difficulty": 6, 
                    "success_text": "They take your hand and the crowd swallows you both. Distance dissolves in the beat.", 
                    "failure_text": "They shake their head and point at their shoes. A tide of bodies surges between you."
                }, 
                {
                    "title": "Mirror their body language", 
                    "description": "You subtly copy their behavior; they don't even notice the connection growing.", 
                    "roll": ["Wits", "Empathy"], 
                    "difficulty": 8, 
                    "success_text": "Breathing syncs. Their voice drops to match yours and trust follows.", 
                    "failure_text": "They catch the pattern and stiffen. The spell snaps with an awkward laugh."
                }
            ], 

            "defeat_phase": [
                {
                    "title": "Lead them into the alley", 
                    "description": "A whisper, a kiss, a darkened door. No one watches.", 
                    "roll": ["Manipulation", "Subterfuge"], 
                    "difficulty": 6, 
                    "success_text": "The door thumps shut. Music becomes a dull pulse and the night belongs to you.", 
                    "failure_text": "A couple barges out laughing. Your mark hesitates, then drifts back toward the bar."
                }, 
                {
                    "title": "Feed mid-kiss", 
                    "description": "You don't ask. You take.", 
                    "roll": ["Dexterity", "Brawl"], 
                    "difficulty": 7, 
                    "success_text": "They melt against you and the bite lands clean behind the ear.", 
                    "failure_text": "Your teeth brush skin and they flinch hard. The moment shatters into apologies and distance."
                }, 
                {
                    "title": "Stroke their neck", 
                    "description": "Gentle, slow, preparing the vessel. Then bite.", 
                    "roll": ["Charisma", "Empathy"], 
                    "difficulty": 6, 
                    "success_text": "Pulse quickens under your fingers. They tilt without being asked.", 
                    "failure_text": "They tense and laugh to break the tension. The opening closes."
                }, 
                {
                    "title": "Feign passing out", 
                    "description": "You make them carry you to safety. They don't realize until it's too late.", 
                    "roll": ["Manipulation", "Acting"], 
                    "difficulty": 8, 
                    "success_text": "They shoulder your weight into a quiet nook. When they call your name, your mouth finds the answer.", 
                    "failure_text": "They flag staff and a cab instead. Too many eyes, too much light."
                }, 
                {
                    "title": "Just grab and bite", 
                    "description": "No subtlety. Just instinct.", 
                    "roll": ["Strength", "Brawl"], 
                    "difficulty": 7, 
                    "success_text": "You pin and feed before a sound escapes. The alley swallows it whole.", 
                    "failure_text": "They buck and shout, and a window above scrapes open."
                }
            ]

        }, 

        "AllNightAisle": {
            "hunt_type": "Social", 
            "scenario_name": "All-Night Aisle", 
            "description": "Fluorescent hum. A coffee machine that wheezes. A cooler door that sticks. The kind of convenience store that exists on every corner of the world after midnight. You look like a person running an errand. You are not.", 

            "contact_phase": [
                {
                    "title": "Scan the fluorescent room", 
                    "description": "You linger by the magazines and read the crowd without reading a word.", 
                    "roll": ["Perception", "Empathy"], 
                    "difficulty": 6, 
                    "success_text": "One customer studies labels without seeing them. Their basket holds a single item they do not need tonight.", 
                    "failure_text": "Couples drift in twos and the loners wear headphones like armor. No eyes to catch."
                }, 
                {
                    "title": "Ask about a missing item", 
                    "description": "You ask the clerk for batteries or the good lids. Your voice invites a bystander to answer first.", 
                    "roll": ["Charisma", "Etiquette"], 
                    "difficulty": 6, 
                    "success_text": "Your mark points you to the right shelf and smiles like a small rescue just happened.", 
                    "failure_text": "The clerk shrugs and the bystanders pretend to be invisible."
                }, 
                {
                    "title": "Share a small kindness", 
                    "description": "You pick up a dropped receipt, offer a napkin, or hold the door without ceremony.", 
                    "roll": ["Appearance", "Empathy"], 
                    "difficulty": 6, 
                    "success_text": "They thank you twice. The second time is softer and aimed only at you.", 
                    "failure_text": "They nod, pocket the moment, and fold back into themselves."
                }, 
                {
                    "title": "Coffee machine banter", 
                    "description": "You make a quiet joke about burnt beans and midnight habits while the machine spits.", 
                    "roll": ["Manipulation", "Expression"], 
                    "difficulty": 7, 
                    "success_text": "They answer with a tired laugh that belongs to strangers who want to be known.", 
                    "failure_text": "Your line lands flat. They step aside and stir silence into the cup."
                }, 
                {
                    "title": "Hold the cooler door", 
                    "description": "You catch the heavy glass and wait with an easy smile.", 
                    "roll": ["Appearance", "Subterfuge"], 
                    "difficulty": 8, 
                    "success_text": "They stay close instead of retreating. Cold air and eye contact do the work.", 
                    "failure_text": "They step back and let the door thump shut between you."
                }
            ], 

            "hunt_phase": [
                {
                    "title": "Offer to walk them to the lot", 
                    "description": "You frame it as safety. Two people look less like a target.", 
                    "roll": ["Manipulation", "Empathy"], 
                    "difficulty": 6, 
                    "success_text": "They match your pace without deciding to. Conversation starts to carry itself.", 
                    "failure_text": "They gesture to a ride arriving soon and thank you from a distance."
                }, 
                {
                    "title": "Pick up their small tab", 
                    "description": "You pay for their coffee or gum with an unbothered nod.", 
                    "roll": ["Charisma", "Streetwise"], 
                    "difficulty": 6, 
                    "success_text": "The barrier drops a notch. They linger by the receipt and find another sentence.", 
                    "failure_text": "They refuse with a polite smile that closes the door."
                }, 
                {
                    "title": "Let the hour confess", 
                    "description": "You talk about the late shift, the weather, the kind of nothing that leads to something true.", 
                    "roll": ["Intelligence", "Subterfuge"], 
                    "difficulty": 7, 
                    "success_text": "Their story drifts out in pieces. A problem, a name, a need for a little kindness.", 
                    "failure_text": "They answer in single words and watch the clock above the counter."
                }, 
                {
                    "title": "Mirror their browsing", 
                    "description": "You take interest in the same shelf and match their rhythm without copying a single choice.", 
                    "roll": ["Wits", "Empathy"], 
                    "difficulty": 8, 
                    "success_text": "Breathing syncs. Your hands move at the same speed. Trust arrives quietly.", 
                    "failure_text": "They catch the pattern and step away like they remembered an appointment."
                }, 
                {
                    "title": "Trade names at the threshold", 
                    "description": "At the door you offer a first name and a soft handshake.", 
                    "roll": ["Charisma", "Performance"], 
                    "difficulty": 6, 
                    "success_text": "They give you theirs and the grip lingers. The night opens.", 
                    "failure_text": "They pocket their hands and nod. The moment cools."
                }
            ], 

            "defeat_phase": [
                {
                    "title": "Step into the shadow of the loading bay", 
                    "description": "A quiet corner where the security light hums and the dumpsters smell like oranges and bleach.", 
                    "roll": ["Manipulation", "Subterfuge"], 
                    "difficulty": 6, 
                    "success_text": "The world narrows to your voices and the soft thud of a distant door. No one is looking.", 
                    "failure_text": "A delivery van noses in and the spell breaks with headlights."
                }, 
                {
                    "title": "Feed mid-embrace", 
                    "description": "You thank them with a hug that turns the angle you need.", 
                    "roll": ["Dexterity", "Brawl"], 
                    "difficulty": 7, 
                    "success_text": "Your mouth finds the line behind the ear. They soften and the bite lands clean.", 
                    "failure_text": "They tense at your breath and pull back. You let it become a laugh and lose the window."
                }, 
                {
                    "title": "Stroke the pulse", 
                    "description": "Your fingers trace wrist to throat while your voice stays calm.", 
                    "roll": ["Charisma", "Empathy"], 
                    "difficulty": 6, 
                    "success_text": "Their chin tilts without being asked. Heat gathers where you want it.", 
                    "failure_text": "They make a joke to cut the tension and step into the light."
                }, 
                {
                    "title": "Feign a faint", 
                    "description": "You sway and let them guide you to the quiet edge of the lot.", 
                    "roll": ["Manipulation", "Acting"], 
                    "difficulty": 8, 
                    "success_text": "They shoulder your weight behind stacked crates. When they say your name, your mouth provides the answer.", 
                    "failure_text": "The clerk notices and offers a chair inside. Too many eyes."
                }, 
                {
                    "title": "Just grab and bite", 
                    "description": "Instinct without ceremony.", 
                    "roll": ["Strength", "Brawl"], 
                    "difficulty": 7, 
                    "success_text": "You pin and feed before a sound escapes. The hum of the light covers everything.", 
                    "failure_text": "They buck and shout. A window opens somewhere above you."
                }
            ]
        }, 

        "SpinCycleSanctuary": {
            "hunt_type": "Social", 
            "scenario_name": "Spin-Cycle Sanctuary", 
            "description": "A late-night laundromat where the machines sing and the plastic chairs judge no one. The air smells like warm cotton and cheap citrus. People wait, stare, and try not to think. You arrive as if you, too, have a load to finish.", 

            "contact_phase": [
                {
                    "title": "Audit the room", 
                    "description": "You track who watches machines instead of people. The solitary ones blink slow.", 
                    "roll": ["Perception", "Alertness"], 
                    "difficulty": 6, 
                    "success_text": "You spot a pair of eyes that belong to no cluster. Their basket sits alone and their gaze keeps returning to the door.", 
                    "failure_text": "Everyone is paired or preoccupied. The few loners angle away the moment you look."
                }, 
                {
                    "title": "Change for a five", 
                    "description": "You offer quarters with an easy smile. The clang of coins starts a conversation.", 
                    "roll": ["Charisma", "Streetwise"], 
                    "difficulty": 6, 
                    "success_text": "They accept the roll and thumb the edges with relief. A grateful grin opens the door to talk.", 
                    "failure_text": "They tap a prepaid card and wave you off with a thanks. The moment slides by."
                }, 
                {
                    "title": "Rescue the runaway sock", 
                    "description": "A sock skates across tile. You catch it and deliver it like a small miracle.", 
                    "roll": ["Dexterity", "Athletics"], 
                    "difficulty": 6, 
                    "success_text": "You snag it mid glide and earn a real laugh. Their basket inches closer to your table.", 
                    "failure_text": "It slips under a machine with a wet slap. You both pretend not to care and the chance cools."
                }, 
                {
                    "title": "Read the bulletin board", 
                    "description": "You scan posted hours and maintenance notes to spot who is stranded by timing.", 
                    "roll": ["Intelligence", "Investigation"], 
                    "difficulty": 7, 
                    "success_text": "A scribbled note about Dryer 4 lines up with their stalled stare at a blinking light.", 
                    "failure_text": "Coupons, lost-cat flyers, and old notices. Nothing points to anyone in need."
                }, 
                {
                    "title": "Confess a stain story", 
                    "description": "You share a harmless laundry mishap that invites a laugh and a reply.", 
                    "roll": ["Manipulation", "Expression"], 
                    "difficulty": 7, 
                    "success_text": "They answer with a coffee disaster of their own. The ice is gone.", 
                    "failure_text": "They give you a polite smile and return to their magazine. No hook today."
                }
            ], 

            "hunt_phase": [
                {
                    "title": "Share the far folding table", 
                    "description": "You claim space beside them like it is the most natural choice in the world.", 
                    "roll": ["Charisma", "Leadership"], 
                    "difficulty": 6, 
                    "success_text": "They make room and mirror your neat corners. Rhythm becomes conversation.", 
                    "failure_text": "They pack up and drift to the other end. Your piece of table stays yours alone."
                }, 
                {
                    "title": "Offer to watch their load", 
                    "description": "You make yourself useful so trust can arrive without fuss.", 
                    "roll": ["Manipulation", "Subterfuge"], 
                    "difficulty": 6, 
                    "success_text": "They nod and step away for water. Trust settles like warm air.", 
                    "failure_text": "They hover and decline with a smile that closes the door."
                }, 
                {
                    "title": "Trade detergent tips", 
                    "description": "You talk fabric care like a secret handshake. The tone is friendly and soft.", 
                    "roll": ["Intelligence", "Etiquette"], 
                    "difficulty": 5, 
                    "success_text": "They lean in at your whisper about softeners. A brand name turns into a shared joke.", 
                    "failure_text": "They hold up a pod with a shrug. The topic dies on contact."
                }, 
                {
                    "title": "Set the fold rhythm", 
                    "description": "You start a slow, tidy fold with unhurried confidence, leaving space beside you like an invitation.", 
                    "roll": ["Charisma", "Performance"], 
                    "difficulty": 6, 
                    "success_text": "They drift into your tempo, sleeves and seams lining with yours.", 
                    "failure_text": "They fold fast and messy to avoid syncing. The distance returns."
                }, 
                {
                    "title": "Stretch the cycle", 
                    "description": "A quiet nudge to a knob or timer buys privacy and time.", 
                    "roll": ["Wits", "Larceny"], 
                    "difficulty": 8, 
                    "success_text": "One extra minute blinks on and the room forgets you both.", 
                    "failure_text": "The machine chirps an error and the attendant looks over."
                }
            ], 

            "defeat_phase": [
                {
                    "title": "Guide to the utility alcove", 
                    "description": "You drift toward the service sink where the hum gets louder and eyes get fewer.", 
                    "roll": ["Manipulation", "Subterfuge"], 
                    "difficulty": 6, 
                    "success_text": "The hum cancels footsteps. Tile and steel swallow the scene.", 
                    "failure_text": "A delivery cart rattles through and breaks your angle."
                }, 
                {
                    "title": "Bite during a lean", 
                    "description": "They rest against the cinderblock wall. You step in close and take the throat.", 
                    "roll": ["Dexterity", "Brawl"], 
                    "difficulty": 7, 
                    "success_text": "Their shoulders sink into concrete and the bite lands where breath begins.", 
                    "failure_text": "They push off the wall and your mouth meets air."
                }, 
                {
                    "title": "Warm hands, easy voice", 
                    "description": "Your palm settles on the shoulder. Your mouth finds the pulse.", 
                    "roll": ["Charisma", "Empathy"], 
                    "difficulty": 6, 
                    "success_text": "Tension drains under your touch. The throat offers itself.", 
                    "failure_text": "They flinch from contact and laugh to reset. The opening closes."
                }, 
                {
                    "title": "The harmless spill", 
                    "description": "A splash from a bottle draws focus down. You move when they look.", 
                    "roll": ["Wits", "Subterfuge"], 
                    "difficulty": 8, 
                    "success_text": "They follow the suds with their eyes and you move cleanly into the gap.", 
                    "failure_text": "The bottle clatters and the attendant calls out. Heads turn."
                }, 
                {
                    "title": "Finish if it turns rough", 
                    "description": "You seize, silence, and feed with clean efficiency.", 
                    "roll": ["Strength", "Brawl"], 
                    "difficulty": 7, 
                    "success_text": "You pin, feed, and ghost away before the spin cycle ends.", 
                    "failure_text": "They thrash into a metal chair with a sharp scrape that draws stares."
                }
            ]
        }, 


        "BusTerminalLull": {
            "hunt_type": "Social", 
            "scenario_name": "Bus Terminal Lull", 
            "description": "In a city bus terminal, fluorescent lights hum above rows of cracked plastic seats. Strangers drift in and out, waiting for departures, connections, or nowhere in particular. The air smells of coffee and exhaust. You move among tired travelers, watching for someone adrift.", 


            "contact_phase": [
                {
                    "title": "Survey the waiting room", 
                    "description": "You watch the scattered travelers. Who is alone, anxious, or glued to the arrival board?", 
                    "roll": ["Perception", "Empathy"], 
                    "difficulty": 6, 
                    "success_text": "You spot a solitary figure tapping their foot, checking the same bus number for the third time.", 
                    "failure_text": "Everyone's posture is closed, faces hidden behind books or arms."
                }, 
                {
                    "title": "Ask for a light or the time", 
                    "description": "You approach and ask for a cigarette light, the time, or directions to a vending machine.", 
                    "roll": ["Charisma", "Etiquette"], 
                    "difficulty": 6, 
                    "success_text": "They answer with a tired but open smile, happy for small interaction.", 
                    "failure_text": "You get a blank stare and a muttered answer. No invitation to linger."
                }, 
                {
                    "title": "Offer spare change for a snack", 
                    "description": "You offer some coins for the vending machines or ask to borrow a dollar.", 
                    "roll": ["Charisma", "Subterfuge"], 
                    "difficulty": 6, 
                    "success_text": "They accept with a grateful nod, or hand you a snack from their own bag.", 
                    "failure_text": "They shake their head and pull their belongings closer."
                }, 
                {
                    "title": "Comment on delays", 
                    "description": "You sigh and make a wry remark about late buses and long waits.", 
                    "roll": ["Manipulation", "Expression"], 
                    "difficulty": 7, 
                    "success_text": "They laugh softly and share their own frustration with the wait.", 
                    "failure_text": "They nod and stare back at the clock without engaging."
                }, 
                {
                    "title": "Pretend to be lost", 
                    "description": "You fumble with a ticket or ask which platform to use, playing confused.", 
                    "roll": ["Appearance", "Acting"], 
                    "difficulty": 8, 
                    "success_text": "They step up to help and walk you to the right platform or map.", 
                    "failure_text": "An attendant interrupts and offers professional help instead."
                }
            ], 


            "hunt_phase": [
                {
                    "title": "Ask about destinations", 
                    "description": "You ask where they are headed and why. Travelers like to share stories.", 
                    "roll": ["Manipulation", "Empathy"], 
                    "difficulty": 6, 
                    "success_text": "They share their destination and a piece of their life, glad to have company.", 
                    "failure_text": "They shrug and keep their reasons to themselves."
                }, 
                {
                    "title": "Share a coffee or snack", 
                    "description": "You buy two coffees and offer one without making a big deal.", 
                    "roll": ["Charisma", "Streetwise"], 
                    "difficulty": 6, 
                    "success_text": "They accept. Warmth in hand eases the tension.", 
                    "failure_text": "They refuse politely and say they are fine."
                }, 
                {
                    "title": "Offer travel tips", 
                    "description": "You give simple advice about routes or platforms to avoid.", 
                    "roll": ["Charisma", "Leadership"], 
                    "difficulty": 6, 
                    "success_text": "They listen and ask a follow up, trusting your authority.", 
                    "failure_text": "They frown, wary of advice from a stranger."
                }, 
                {
                    "title": "Talk about a headline", 
                    "description": "You mention a recent local story or the weather to open neutral ground.", 
                    "roll": ["Intelligence", "Expression"], 
                    "difficulty": 7, 
                    "success_text": "They engage, grateful for a distraction from the tedium.", 
                    "failure_text": "They wave it off and seem uninterested."
                }, 
                {
                    "title": "Mirror their posture", 
                    "description": "You subtly mimic their position or gestures to build silent rapport.", 
                    "roll": ["Wits", "Empathy"], 
                    "difficulty": 8, 
                    "success_text": "They relax and unconsciously sync to your presence.", 
                    "failure_text": "They notice and shift away as suspicion creeps in."
                }
            ], 


            "defeat_phase": [
                {
                    "title": "Suggest stepping out for air", 
                    "description": "You propose a brief break outside to escape the stale waiting room.", 
                    "roll": ["Manipulation", "Subterfuge"], 
                    "difficulty": 6, 
                    "success_text": "They agree and welcome a change of scenery and company.", 
                    "failure_text": "They decline and do not want to risk missing their bus."
                }, 
                {
                    "title": "Offer a cigarette", 
                    "description": "You offer a smoke at the curb and a sympathetic ear.", 
                    "roll": ["Charisma", "Subterfuge"], 
                    "difficulty": 6, 
                    "success_text": "They join you and the terminal fades into the background.", 
                    "failure_text": "They wave it off or a passerby intrudes."
                }, 
                {
                    "title": "Lean in to comfort", 
                    "description": "You offer a gentle word or a reassuring touch that invites closeness.", 
                    "roll": ["Charisma", "Empathy"], 
                    "difficulty": 6, 
                    "success_text": "They let their guard down and allow you into their space.", 
                    "failure_text": "They tense and move away from contact."
                }, 
                {
                    "title": "Move during boarding", 
                    "description": "As their bus is called, you position yourself to guide them away from the group.", 
                    "roll": ["Dexterity", "Brawl"], 
                    "difficulty": 7, 
                    "success_text": "You catch them in the shuffle and draw them aside without notice.", 
                    "failure_text": "There are too many eyes and too much noise. The moment slips away."
                }, 
                {
                    "title": "Feign dizziness", 
                    "description": "You pretend to feel faint and draw them close or toward the door.", 
                    "roll": ["Appearance", "Acting"], 
                    "difficulty": 8, 
                    "success_text": "They steady you and guide you toward a quiet corner or fresh air.", 
                    "failure_text": "The clerk notices and intervenes with help."
                }
            ]
        }
    }, 

    "Prowl": {
        "AlleywayLurker": {
            "hunt_type": "Prowl", 
            "scenario_name": "Alleyway Lurker", 
            "description": "You wait in the alleys and service corridors behind clubs, diners, and strip malls - places where stragglers pass through, too distracted or drunk to notice they're being watched.", 

            "contact_phase": [
                {
                    "title": "Watch the rear exits", 
                    "description": "You post up near the staff doors of a noisy bar and wait.", 
                    "roll": ["Perception", "Alertness"], 
                    "difficulty": 6, 
                    "success_text": "A lone figure stumbles out for a smoke break, rubbing their eyes.", 
                    "failure_text": "Delivery workers, bouncers, and groups come and go - no one's alone."
                }, 
                {
                    "title": "Follow the heavy footfalls", 
                    "description": "You hear a lone person stumbling through gravel and trash bags.", 
                    "roll": ["Wits", "Survival"], 
                    "difficulty": 7, 
                    "success_text": "You trail the sound to a drunk slumped against a dumpster.", 
                    "failure_text": "It was just an old man yelling at rats in a pile of recycling."
                }, 
                {
                    "title": "Sniff out blood or sweat", 
                    "description": "You rely on scent and instinct to find vulnerability.", 
                    "roll": ["Perception", "Survival"], 
                    "difficulty": 7, 
                    "success_text": "You catch the scent of stale fear. Someone's alone, and they know it.", 
                    "failure_text": "All you smell is old fry grease and wet cardboard."
                }, 
                {
                    "title": "Mark territory with rats", 
                    "description": "You notice where the vermin gather; they flee from stronger predators.", 
                    "roll": ["Intelligence", "Animal Ken"], 
                    "difficulty": 8, 
                    "success_text": "The rats part around a figure passed out near a trash bin - easy pickings.", 
                    "failure_text": "Tonight even the rats are cautious. You learn nothing."
                }, 
                {
                    "title": "Climb up and observe", 
                    "description": "You take to the rooftop ledge, watching the alley below like a gargoyle.", 
                    "roll": ["Dexterity", "Athletics"], 
                    "difficulty": 6, 
                    "success_text": "From above, you spot someone lost in thoughts as they pace alone through the alley.", 
                    "failure_text": "From up here, everything looks like shadows. No clear target."
                }
            ], 

            "hunt_phase": [
                {
                    "title": "Drop down from above", 
                    "description": "As they pass beneath you, you descend in silence.", 
                    "roll": ["Dexterity", "Stealth"], 
                    "difficulty": 6, 
                    "success_text": "You land without a sound. They're yours now.", 
                    "failure_text": "Your boot scuffs the edge; they hear and bolt."
                }, 
                {
                    "title": "Mimic a junkie", 
                    "description": "You stagger, mutter, and slump. They don't even look twice.", 
                    "roll": ["Manipulation", "Acting"], 
                    "difficulty": 7, 
                    "success_text": "They step around you, thinking you're harmless. Big mistake.", 
                    "failure_text": "They cross the street, muttering about crazy people."
                }, 
                {
                    "title": "Match their pace from behind", 
                    "description": "Your steps are quiet and steady. They never notice the echo.", 
                    "roll": ["Dexterity", "Stealth"], 
                    "difficulty": 6, 
                    "success_text": "You're behind them for ten steps before they realize - and by then it's too late.", 
                    "failure_text": "They stop abruptly and look back. You fade into the dark."
                }, 
                {
                    "title": "Rattle the bins", 
                    "description": "You make a noise to lure them deeper into the alley.", 
                    "roll": ["Wits", "Subterfuge"], 
                    "difficulty": 7, 
                    "success_text": "They creep forward, curious and nervous. Right where you want them.", 
                    "failure_text": "They hear the noise and immediately turn around and leave."
                }, 
                {
                    "title": "Distract with a stray animal", 
                    "description": "You send a feral cat or rat across their path. They follow it - or shy from it.", 
                    "roll": ["Charisma", "Animal Ken"], 
                    "difficulty": 8, 
                    "success_text": "They pause to watch the cat dart past - and don't see you closing in.", 
                    "failure_text": "They ignore the creature and keep walking with purpose."
                }
            ], 

            "defeat_phase": [
                {
                    "title": "Pull them into a doorway", 
                    "description": "You wait until they pass close, then vanish with them into shadow.", 
                    "roll": ["Dexterity", "Brawl"], 
                    "difficulty": 6, 
                    "success_text": "One quick yank - they vanish from view and into your arms.", 
                    "failure_text": "They shrug you off with a startled yell and run for the light."
                }, 
                {
                    "title": "Cover their mouth and bite", 
                    "description": "A hand on the jaw, an arm around the chest, and fangs at the neck.", 
                    "roll": ["Strength", "Brawl"], 
                    "difficulty": 7, 
                    "success_text": "You silence them mid-gasp, and the blood begins to flow.", 
                    "failure_text": "They thrash violently and knock you off balance. No time now."
                }, 
                {
                    "title": "Strike from behind", 
                    "description": "You don't hesitate. You grab and sink your fangs in before they can react.", 
                    "roll": ["Dexterity", "Brawl"], 
                    "difficulty": 6, 
                    "success_text": "They gasp and stiffen, but it's too late.", 
                    "failure_text": "They duck at the last second and your grip misses."
                }, 
                {
                    "title": "Cause them to faint", 
                    "description": "You hit a pressure point just right. No struggle, no noise.", 
                    "roll": ["Dexterity", "Medicine"], 
                    "difficulty": 8, 
                    "success_text": "They collapse in your arms like a puppet with its strings cut.", 
                    "failure_text": "You miss the nerve cluster. They cry out in pain and start running."
                }, 
                {
                  "title": "Wall press and drink", 
                  "description": "You pin them to brick with your forearm, turn the head to bare the throat, and feed cleanly.", 
                  "roll": ["Strength", "Athletics"], 
                  "difficulty": 7, 
                  "success_text": "Concrete takes the slack from their legs. Your mouth finds the pulse before a sound can form.", 
                  "failure_text": "They slip sideways off the wall and your grip breaks. The moment is gone."
                }
            ]
        }, 

    "ParkingGarageStalker": {
        "hunt_type": "Prowl", 
        "scenario_name": "Parking Garage Stalker", 
        "description": "Concrete spiral, low ceilings, lights that buzz and blink. Footsteps echo and engines tick as they cool. You move between pillars and shadows where cameras miss and nerves fray.", 
        "contact_phase": [
            {
                "title": "Catch the heel-echo", 
                "description": "You listen for solitary footfalls on concrete and the nervous jingle of keys.", 
                "roll": ["Wits", "Alertness"], 
                "difficulty": 6, 
                "success_text": "A single cadence carries from the stairwell. One person, unhurried but alone.", 
                "failure_text": "Tires squeal, doors slam, echoes overlap. You cannot separate one target from the noise."
            }, 
            {
                "title": "Glass and reflections", 
                "description": "You use windows and side mirrors to watch without showing your face.", 
                "roll": ["Perception", "Investigation"], 
                "difficulty": 7, 
                "success_text": "In a van's dark glass you catch the shape of someone reading a booklet by the elevator lobby.", 
                "failure_text": "Your angles are bad and the reflections lie. Nothing resolves into a clear mark."
            }, 
            {
                "title": "Top deck check", 
                "description": "You climb to the wind-scraped upper level where the lighting is worst and cars sit far apart.", 
                "roll": ["Dexterity", "Athletics"], 
                "difficulty": 6, 
                "success_text": "Near the railing a driver fumbles for a dropped card, back turned and shoulders tight.", 
                "failure_text": "The deck is empty and exposed. You feel seen by no one and everyone."
            }, 
            {
                "title": "Map the blind spots", 
                "description": "You track the sweep of each camera and the dead zones between pillars.", 
                "roll": ["Intelligence", "Security"], 
                "difficulty": 7, 
                "success_text": "You mark a clean corridor between two SUVs that the cameras never touch.", 
                "failure_text": "The coverage is better than you hoped. Every safe lane turns into open ground."
            }, 
            {
                "title": "Read the engine heat", 
                "description": "You pass palms near hoods and grilles. Fresh arrivals are warm and distracted.", 
                "roll": ["Perception", "Survival"], 
                "difficulty": 8, 
                "success_text": "A small sedan still radiates. Its owner steps out and checks a trunk latch.", 
                "failure_text": "Cold steel and dust. Whoever parked here did so long ago."
            }
        ], 
        "hunt_phase": [
            {
                "title": "Pillars and pace", 
                "description": "You move pillar to pillar, matching their speed while staying off their sightline.", 
                "roll": ["Dexterity", "Stealth"], 
                "difficulty": 6, 
                "success_text": "Your shadow never overlaps theirs. Ten steps and you are in striking distance.", 
                "failure_text": "A scuffed shoe betrays you. They glance back and quicken toward the elevator."
            }, 
            {
                "title": "Elevator feint", 
                "description": "You arrive at the lobby as the doors open, then drift away to let them step out alone.", 
                "roll": ["Manipulation", "Subterfuge"], 
                "difficulty": 7, 
                "success_text": "They relax when you turn aside and walk into your chosen lane.", 
                "failure_text": "They hold the door and ride it back down with two strangers."
            }, 
            {
                "title": "Use the cars as cover", 
                "description": "You move along door seams, mirrors, and rooflines like a ripple in paint.", 
                "roll": ["Wits", "Stealth"], 
                "difficulty": 6, 
                "success_text": "They never see more than a hint of motion in a window's edge.", 
                "failure_text": "A motion sensor floods the aisle with light. They look up and change direction."
            }, 
            {
                "title": "Split the herd", 
                "description": "You trigger a short chirp from a nearby alarm to separate them from passing company.", 
                "roll": ["Wits", "Larceny"], 
                "difficulty": 8, 
                "success_text": "Two pedestrians detour to investigate the noise. Your mark keeps walking, alone now.", 
                "failure_text": "The chirp becomes a full blast. Doors open and eyes appear from all sides."
            }, 
            {
                "title": "Stairwell squeeze", 
                "description": "You guide them toward the service stairs where the air smells of dust and paint.", 
                "roll": ["Manipulation", "Intimidation"], 
                "difficulty": 7, 
                "success_text": "They choose the stairs over the elevator without knowing why.", 
                "failure_text": "They step back into the elevator and a couple piles in behind them."
            }
        ], 
        "defeat_phase": [
            {
                "title": "Pillar pin", 
                "description": "You press them to concrete with one forearm and turn the head to bare the throat.", 
                "roll": ["Strength", "Brawl"], 
                "difficulty": 6, 
                "success_text": "The breath leaves their chest in a soft grunt. You drink before they can shape a word.", 
                "failure_text": "They twist and slip free, keys raking your wrist as they shove away."
            }, 
            {
                "title": "Hand over mouth", 
                "description": "Your palm seals the lips as your other arm locks the shoulders.", 
                "roll": ["Dexterity", "Brawl"], 
                "difficulty": 7, 
                "success_text": "A strangled sound dies in your hand. Their pulse is clean and close.", 
                "failure_text": "They bite your palm and jerk their head hard. The moment is lost."
            }, 
            {
                "title": "Backseat eclipse", 
                "description": "You open a rear door with a practiced pull and fold them into the dark.", 
                "roll": ["Dexterity", "Larceny"], 
                "difficulty": 8, 
                "success_text": "The car swallows the scene. You feed with the dome light dead.", 
                "failure_text": "The child lock snags and a chime pings. They thrash and spill back out."
            }, 
            {
                "title": "Sweep and settle", 
                "description": "You hook an ankle, guide the fall, and cradle the head to keep it quiet.", 
                "roll": ["Dexterity", "Athletics"], 
                "difficulty": 6, 
                "success_text": "They drop softly behind an SUV. Your fangs find home.", 
                "failure_text": "Their heel bounces off a hubcap with a bright ring that carries."
            }, 
            {
                "title": "Abort clean if seen", 
                "description": "You take a mouthful, wipe the mark, and vanish down the ramp.", 
                "roll": ["Wits", "Athletics"], 
                "difficulty": 8, 
                "success_text": "You are gone before the curious turn the corner. Only a damp patch remains.", 
"failure_text": "You hesitate and the moment hardens into shouts and footsteps."
                    }
                ]
            }, 


            "ConcreteVeins": {
                "hunt_type": "Prowl", 
                "scenario_name": "Concrete Veins", 
                "description": "A fenced-off construction site after hours. Floodlights stutter, heavy machinery looms, and plastic tarps snap in the wind. The ground is uneven, and pools of rainwater reflect the half-built skeleton above. You slip through gaps in the fence and hunt among the shadows and scaffolding.", 

                "contact_phase": [
                    {
                        "title": "Watch the time clock shed", 
                        "description": "You watch the entry booth where night workers and security check in and out.", 
                        "roll": ["Perception", "Investigation"], 
                        "difficulty": 6, 
                        "success_text": "You see a lone figure lingering at the punch clock, anxious to leave.", 
                        "failure_text": "The booth is empty and the log book is closed. No one lingers here."
                    }, 
                    {
                        "title": "Eavesdrop on radio chatter", 
                        "description": "You listen for security or workers on their radios.", 
                        "roll": ["Wits", "Technology"], 
                        "difficulty": 6, 
                        "success_text": "You overhear a bored guard mention a worker finishing late and heading out alone.", 
                        "failure_text": "The only static is the hum of machinery and traffic."
                    }, 
                    {
                        "title": "Smell for cigarette smoke", 
                        "description": "You follow the scent of tobacco drifting between stacks of lumber.", 
                        "roll": ["Perception", "Survival"], 
                        "difficulty": 7, 
                        "success_text": "You trace it to someone taking a break alone behind a pile of pipes.", 
                        "failure_text": "The wind shifts, the smoke disperses, and you lose the trail."
                    }, 
                    {
                        "title": "Spot a squatter's camp", 
                        "description": "You scan for a makeshift bedroll, backpack, or lantern in the shadows.", 
                        "roll": ["Intelligence", "Awareness"], 
                        "difficulty": 7, 
                        "success_text": "You find signs of a hidden nest. Its owner will return soon.", 
                        "failure_text": "Nothing but debris and old wrappers in the corners."
                    }, 
                    {
                        "title": "Scan the scaffolding", 
                        "description": "You move along steel walkways above for a bird's-eye view.", 
                        "roll": ["Dexterity", "Athletics"], 
                        "difficulty": 8, 
                        "success_text": "From above, you spot someone lagging behind the departing crew.", 
                        "failure_text": "Your foot slips and a metal bar clatters. No one lingers below now."
                    }
                ], 

                "hunt_phase": [
                    {
                        "title": "Slip between tarps", 
                        "description": "You move through hanging tarps, hiding your approach.", 
                        "roll": ["Dexterity", "Stealth"], 
                        "difficulty": 6, 
                        "success_text": "You ghost through the plastic. Your mark is unaware you are near.", 
                        "failure_text": "The tarp rustles loudly and a flashlight beam sweeps your way."
                    }, 
                    {
                        "title": "Distract with falling tools", 
                        "description": "You nudge a tool from above or behind a stack, drawing them closer.", 
                        "roll": ["Wits", "Subterfuge"], 
                        "difficulty": 7, 
                        "success_text": "Curious, they come to investigate the clang in the darkness.", 
                        "failure_text": "They call out for backup and move away quickly."
                    }, 
                    {
                        "title": "Flash a badge", 
                        "description": "You flash an old worker's badge or hard hat to put them at ease.", 
                        "roll": ["Manipulation", "Performance"], 
                        "difficulty": 7, 
                        "success_text": "They assume you belong and do not question your presence.", 
                        "failure_text": "They squint, unconvinced, and back away."
                    }, 
                    {
                        "title": "Shadow behind a shipping container", 
                        "description": "You move silently, keeping the container between you and your mark.", 
                        "roll": ["Dexterity", "Larceny"], 
                        "difficulty": 8, 
                        "success_text": "You keep out of sight until you are within arm's reach.", 
                        "failure_text": "A loose chain clatters and gives you away."
                    }, 
                    {
                        "title": "Intimidate as foreman", 
                        "description": "You bark a quiet command in a voice of authority, herding your mark away from lights.", 
                        "roll": ["Manipulation", "Intimidation"], 
                        "difficulty": 8, 
                        "success_text": "They hesitate, confused, and do not think to run.", 
                        "failure_text": "They know the real boss and turn wary."
                    }
                ], 

                "defeat_phase": [
                    {
                        "title": "Pull them behind the rebar", 
                        "description": "You seize your mark in the shadows behind stacked steel rods.", 
                        "roll": ["Strength", "Brawl"], 
                        "difficulty": 6, 
                        "success_text": "They are lost from sight and in your grasp before they can shout.", 
                        "failure_text": "They wrench free, sending rods crashing everywhere."
                    }, 
                    {
                        "title": "Choke with cable", 
                        "description": "You wrap a heavy cable around their chest, silencing the struggle as you feed.", 
                        "roll": ["Dexterity", "Brawl"], 
                        "difficulty": 7, 
                        "success_text": "The cable tightens and the sound is muffled. No one sees.", 
                        "failure_text": "They buck and the cable whips away, drawing attention."
                    }, 
                    {
                        "title": "Drop from above", 
                        "description": "You drop from scaffolding or a half-built floor onto their shoulders, fangs bared.", 
                        "roll": ["Dexterity", "Athletics"], 
                        "difficulty": 7, 
                        "success_text": "You land cleanly and bite before they can react.", 
                        "failure_text": "You miss your mark and crash to the ground."
                    }, 
                    {
                        "title": "Drag behind porta-potties", 
                        "description": "You pull them behind the temporary toilets where no one lingers and feed.", 
                        "roll": ["Wits", "Stealth"], 
                        "difficulty": 8, 
                        "success_text": "They are too shocked to fight. No eyes here.", 
                        "failure_text": "A security guard rounds the corner and spots you both."
                    }, 
                    {
                        "title": "Bite through a mask", 
                        "description": "You catch your mark as they slip on a dust mask or respirator, disguising the act as an accident.", 
                        "roll": ["Manipulation", "Subterfuge"], 
                        "difficulty": 8, 
                        "success_text": "They slump and no one notices beneath the noise and their gear.", 
                        "failure_text": "They panic and tear off the mask, shouting for help before you can feed."
                    }
                ]
            }
        }
    }






func get_all_hunt_types() -> Array:
    return scenarios.keys()

func get_scenarios_for_type(hunt_type: String) -> Array:
    var formatted: = hunt_type.capitalize()
    if scenarios.has(formatted):
        return scenarios[formatted].keys()
    return []


func has_scenario(hunt_type: String, scenario_id: String) -> bool:
    return scenarios.has(hunt_type) and scenarios[hunt_type].has(scenario_id)

func get_scenario(hunt_type: String, scenario_id: String) -> Dictionary:
    if has_scenario(hunt_type, scenario_id):
        return scenarios[hunt_type][scenario_id]
    return {}

func has_phase(hunt_type: String, scenario_id: String, phase: String) -> bool:
    var scenario: = get_scenario(hunt_type, scenario_id)
    return scenario.has(phase)

func get_phase_options(hunt_type: String, scenario_id: String, phase: String) -> Array:
    if has_phase(hunt_type, scenario_id, phase):
        return get_scenario(hunt_type, scenario_id)[phase]
    return []

func get_roll_data(phase_entry: Dictionary) -> Dictionary:
    return {
        "roll": phase_entry.get("roll", []), 
        "difficulty": phase_entry.get("difficulty", 6)
    }

func get_result_text(phase_entry: Dictionary, success: bool) -> String:
    if success:
        return phase_entry.get("success_text", "You succeed.")
    else:
        return phase_entry.get("failure_text", "You fail.")
