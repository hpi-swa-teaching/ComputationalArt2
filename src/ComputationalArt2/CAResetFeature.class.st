"
CAResetFeature resets a process or simulation on the canvas.
"
Class {
	#name : #CAResetFeature,
	#superclass : #CAClickableFeature,
	#category : #ComputationalArt2,
	#'squeak_changestamp' : 'iss 6/7/2024 11:52'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 19:23'
}
CAResetFeature class >> executeFeature: aCAWindow [
	|  canvasContainer |
	canvasContainer := aCAWindow canvasContainer.
	canvasContainer canvas reset.
	canvasContainer updateForm.
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:33'
}
CAResetFeature class >> featureName [
	^'Reset'.
]
