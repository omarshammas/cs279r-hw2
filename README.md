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

Each task begins by clicking a "next" button in the center of the screen (difficult to center exactly because we don't know the dimensions of the turks computer, but we have ideas to be implemented in the next iteration). Timer starts when the subject is presented with the name and icon for a target (it may be presented as part of the doc, or in a sidebar). Incorrect selections will produce an audible beeping sound.

2 blocks of tasks: Familiarization (to build spatial memory) and Performance
2 sets of commands (1 for each block): 6 commands spread across 3 different tabs. 3 in home, 2 in insert, 1 in view. 

The same set will be used for familiarization and performance with Ribbons/CommandMaps. Then the other set will be used for familiarization and performance with Ribbons/CommandMaps. The ordering of the set and interface will be counterbalanced using a Latin square, but currently isn't.

Familiarization block consists of 30 tasks (1 command set of 6 commands * 5 trials). Performance block consists of 90 tasks using the same command set as the previous familiarization round (1 command set of 6 commands * 15 trials). The ordering of commands will be randomized. In the case of the ribbons, we tried to ensure that 50% of the commands would ensure a parent switch but the system would be stuck in an infinite loop. For now, we removed it but we plan on using a tolerance instead such 50% + or - 5%. 

After each performance section, participants must complete a simple question 'Which method did you perfer?'.

We store each completed action in our database. Each models describe what task was given to the user, the time it took the user to complete the task, the number of incorrect clicks the user made before he selected completed the task and a flag showing whether or not the user was in the familiarization block or the performance block.

List of variables:
Control variables – the interface used and the order of commands that we present to the participants
Independent variables – the number of trials used, the set of commands used and the button to launch the CommandMaps interface
Random variables – time of day, participant's screen size, participant's location)
Dependent variables – the average time to complete each task, the average error rate and the choice of which interface they preferred better

Possible threats to the internal validity of the experiment are participants' different browsers dimensions, moving their mice before the page loads in order to get closer to the menu. The original experiment is tightly controlled and does not take into account many factors of real world user interface use, this experiment lacks in external validity. 

We hope to mitigate the internal validity threats by optimizing our code to run the same across all browsers that we allow to be used in the experiment requirements. We would also like to lock the position of a users mouse until the page has loaded, but we have not found a way to accomplish this yet.
