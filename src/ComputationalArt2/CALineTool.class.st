"
CALineTool used to draw lines on the canvas.
"
Class {
	#name : #CALineTool,
	#superclass : #CACanvasTool,
	#instVars : [
		'startPoint'
	],
	#category : #ComputationalArt2,
	#'squeak_changestamp' : 'iss 6/7/2024 11:47'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 02:17'
}
CALineTool class >> createContextBox: aCAWindow [
	| hBox |
	hBox := CAWindow createHBox.
	hBox addMorph: (CAWindow createToolStrokeWidthContextMorph: aCAWindow).
	^hBox.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:34'
}
CALineTool class >> toolName [
	^'Line'.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 13:19'
}
CALineTool >> handleMouseDown: anEvent on: aCACanvasContainer [
	"I handle the mouse down event by saving the start point of the line."
	startPoint := aCACanvasContainer getPixelPosition: anEvent position.
	aCACanvasContainer canvas saveState.
	aCACanvasContainer canvas commit.
	aCACanvasContainer updateForm.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 01:37'
}
CALineTool >> handleMouseMove: anEvent on: aCACanvasContainer [
	"I handle the mouse move event by drawing a temporary line from the start point to the current mouse position."
	startPoint ifNotNil: [ | endPoint caWindow |
		caWindow := aCACanvasContainer caWindow.
		aCACanvasContainer canvas reset.
		endPoint := aCACanvasContainer getPixelPosition: anEvent position.
		aCACanvasContainer canvas drawLine: startPoint to: endPoint width: caWindow toolStrokeWidth color: caWindow primaryColor.
		aCACanvasContainer updateForm.].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:26'
}
CALineTool >> handleMouseUp: anEvent on: aCACanvasContainer [
	"I handle the mouse up event by drawing the final line from the start point to the end point."
	| endPoint caWindow |
	endPoint := aCACanvasContainer getPixelPosition: anEvent position.
	caWindow := aCACanvasContainer caWindow.
	aCACanvasContainer canvas drawLine: startPoint to: endPoint width: caWindow toolStrokeWidth color: caWindow primaryColor.
	startPoint := nil.
	aCACanvasContainer canvas commit.
	aCACanvasContainer updateForm.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'iss 6/7/2024 10:58'
}
CALineTool >> initialize [
	super initialize.
	startPoint := nil.
]
