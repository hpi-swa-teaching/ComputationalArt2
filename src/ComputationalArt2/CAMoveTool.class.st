"
CAMoveTool allows moving and zooming the canvas content.
"
Class {
	#name : #CAMoveTool,
	#superclass : #CACanvasTool,
	#category : #ComputationalArt2,
	#'squeak_changestamp' : 'iss 6/7/2024 11:51'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/8/2024 22:49'
}
CAMoveTool class >> createContextBox: aCAWindow [
	| hBox |
	hBox := CAWindow createHBox.
	hBox addMorph: (CAStringMorph new contents: 'Move').
	^hBox.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:34'
}
CAMoveTool class >> toolName [
	^'Move'.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 16:03'
}
CAMoveTool >> handleMouseMove: anEvent on: aCACanvasContainer [
	| delta |
	anEvent anyButtonPressed ifTrue: [
		delta := anEvent position - anEvent startPoint.
		aCACanvasContainer canvasOffset: (aCACanvasContainer canvasOffset + delta).].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:17'
}
CAMoveTool >> handleMouseWheel: anEvent on: aCACanvasContainer [
	| deltaY currentScale newScale mousePosition currentMouseCanvasOffset newMouseCanvasOffset currentCanvasOffset newCanvasOffset |
	
	currentScale := aCACanvasContainer canvasScale asFloat.
	deltaY := anEvent wheelDelta y / 400.0 * currentScale.
	newScale := aCACanvasContainer clampScale: (currentScale + deltaY).
	mousePosition := anEvent position - aCACanvasContainer position.
	currentCanvasOffset := aCACanvasContainer canvasOffset.
	currentMouseCanvasOffset := currentCanvasOffset - mousePosition.
	newMouseCanvasOffset := currentMouseCanvasOffset * (newScale / currentScale).
	newCanvasOffset := mousePosition + newMouseCanvasOffset.
	
	aCACanvasContainer canvasOffset: newCanvasOffset scale: newScale.
]
