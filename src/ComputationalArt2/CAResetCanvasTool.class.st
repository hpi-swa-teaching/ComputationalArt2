"
CAResetCanvasTool resets the canvas to its stable state.
"
Class {
	#name : #CAResetCanvasTool,
	#superclass : #CACanvasTool,
	#category : #ComputationalArt2,
	#'squeak_changestamp' : 'iss 6/7/2024 11:48'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 02:26'
}
CAResetCanvasTool class >> createContextBox: aCAWindow [
	| hBox |
	hBox := CAWindow createHBox.
	hBox addMorph: (CAStringMorph new contents: 'Reset Canvas').
	^hBox.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:34'
}
CAResetCanvasTool class >> toolName [
	^'Reset Canvas'.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 16:59'
}
CAResetCanvasTool >> handleMouseDown: anEvent on: aCACanvasContainer [
	aCACanvasContainer canvas clearColor: aCACanvasContainer caWindow primaryColor.
	aCACanvasContainer canvas commit.
	aCACanvasContainer updateForm.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'iss 6/7/2024 10:44'
}
CAResetCanvasTool >> initialize [
	super initialize.
]
