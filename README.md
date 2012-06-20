#VarVars - Variable Variables
----

VarVars allow to quickly set up "Variable Variables", that is, variables with internal behaviors that define how its value changes in time.

While working on various AS3 projects, I grew tired of setting individual tweens when I needed a gameplay variable to vary according to some input. Coding cooldowns, player activity "heat" , multipliers and other dynamic numerical values was getting a little cumbersome, so I decided to create a library to make those behaviors easier to implement.

##Creating a VarVar

###AS3

Instantiate your VarVar object and then call the add() method to add behaviors to it.

Example:
````
var myVarVar:VarVar = new VarVar();
myVarVar.add(new Attack(1000)).add(new Sustain(300)).add(new Decay(200));
````
You can omit any of the three Behaviors and have just Attack and Decay, or Sustain then Decay, or just Decay or Attack. Just having a Sustain is missing the point of the whole lib :)

##Using a VarVar

###AS3

To use a VarVar, you just read or write its ````value```` property.

When you write to ````value````, the VarVar configures itself, but no value is changed yet. New values are calculated when you read the ````value```` property.

Optionally, you can configure a ````cacheDelay```` if you worry about performance.