Command Maps
============

###Authors:

* Omar Shammas
* Tunde Agboola

###Heroku:

This RoR app is deployed on heroku.

* Production - http://commandmaps.heroku.com
* Staging - http://commandmapsstaging.heroku.com

###Acknowledgements:

Office Ribbon - http://github.com/OkGoDoIt/Office-Ribbon-2010

###Experiment Design:

Each task begins by clicking a "next" button in the center of the screen. The timer starts when the subject is presented with the target icon and its name. Incorrect selections will produce an audible beeping sound.

2 blocks of tasks: Familiarization (to build spatial memory) and Performance
2 sets of commands (1 for each block): 6 commands spread across 3 different tabs. 3 in the home tab, 2 in the insert tab, and 1 in the view tab. 

The same set will be used for familiarization and performance with Ribbons/CommandMaps. Then the other set will be used for familiarization and performance with Ribbons/CommandMaps. The ordering of the set and interface will be counterbalanced using a Latin square, but currently isn't.

Familiarization block consists of 30 tasks (1 command set of 6 commands * 5 trials). Performance block consists of 90 tasks using the same command set as the previous familiarization round (1 command set of 6 commands * 15 trials). The ordering of commands will be randomized. In the case of the ribbons, we tried to ensure that 50% of the commands would ensure a parent switch but the system would be stuck in an infinite loop. For now, we removed it but we plan on using a tolerance instead such 50% + or - 5%. 

After completing all command selection tasks the participant is presented with a simple question, 'Which method did you perfer?'.

We store each completed task in our database. Each record contains the target icon, the time to completion, the number of incorrect clicks, the block (familiarization or performance), and the menu type.

### Internal and External Validity

* Control variables – the interface used and the order of commands that we present to the participants
* Independent variables – the number of trials used, the set of commands used and the button to launch the CommandMaps interface
* Random variables – time of day, participant's screen settings, participant's location
* Dependent variables – the average time to complete each task, the average error rate and the choice of which interface they preferred better

The biggest threat to internal validity is participants' different browser dimenstions, and "cheating" by moving their pointer closer to the menu as the page is loading. These first threat can be mitigated by ensuring the experiment remains in constant size no matter how large the participant's monitor as long as it is 940px wide. The second threat can be mitigated by ensuring that the page is fully loaded and by revealing the target icon once the user clicks a button in the center of the screen. This will guarantee that the participants' pointers will start from the same location. 

The experiment is tightly controlled and does not resemble a normal workflow where users are constantly switching back and forth between typing and selecting commands. This threat to external validity can be mitigated by building a more complete experiment where participants are given a series of tasks that invlove typing and editing a document.