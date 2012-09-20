Command Maps
============

###Authors:

* Omar Shammas
* Tunde Agboola

###Heroku:

This RoR app is deployed on heroku.

* Production - commandmaps.heroku.com
* Staging - commandmapsstaging.heroku.com

###Experiment Design:

Each task begins by clicking a "next" button in the center of the screen (difficult to center exactly because we don't know the dimensions of the turks computer). Timer starts when the subject is presented with the name and icon for a target (it may be presented as part of the doc, or in a sidebar). Incorrect selections will produce some sort of feedback (maybe a beep, or some banner).

2 blocks of tasks: Familiarization (to build spatial memory) and Performance
2 sets of commands (1 for each block): 6 commands spread across 3 different tabs. 3 in home, 2 in insert, 1 in view. 

The same set will be used for familiarization and performance with Ribbons/CommandMaps. Then the other set will be used for familiarization and performance with Ribbons/CommandMaps. The ordering of the set and interface will be counterbalanced using a Latin square.

Familiarization block consists of 30 tasks (1 command set of 6 commands * 5 trials). Performance block consists of 90 tasks using the same command set as the previous familiarization round (1 command set of 6 commands * 15 trials). The ordering of commands will be randomized, but in the case of ribbons we will ensure that a given ordering of commands will cause a parent switch 50% of the time.

After each performance section, participants must complete an NASA-TLX worksheet, and at the end of the experiment they must select CommandMaps or Ribbons as their preference.

We store each completed action in our database. Each models describe what task was given to the user, the time it took the user to complete the task, the number of incorrect clicks the user made before he selected completed the task and a flag showing whether or not the user was in the familiarization block or the performance block.

List of variables:
Control variables – the interface used and the order of the block of commands that the user is presented with
Independent variables – the number of trials used, the set of commands used and the button to launch the CommandMaps interface.
Random variables – the subjects used and the time of day the experiment is performed
Dependent variables – the average time to complete each task, the average error rate and the choice of which interface they preferred better

Possible threats to the internal validity of the experiment are users using different browsers, users moving their mice before the page loads in order to get in a edge, and the fact that novice users can partake in the experiment. Because the original experiment is tightly controlled and does not take into account many factors of real world user interface use, this experiment as a whole does not provide much external validity
We hope to mitigate the internal validity threats by optimizing our code to run the same across all browsers that we allow to be used in the experiment requirements. We would also like to lock the position of a users mouse until the page has loaded, but we have not found a way to accomplish this yet.
