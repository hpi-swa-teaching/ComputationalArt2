"
CAPenTool is used to draw freehand lines on the canvas.
"
Class {
	#name : #CAPenTool,
	#superclass : #CACanvasTool,
	#instVars : [
		'isDrawing'
	],
	#category : #ComputationalArt2,
	#'squeak_changestamp' : 'iss 6/7/2024 11:50'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/8/2024 23:04'
}
CAPenTool class >> createContextBox: aCAWindow [
	| hBox |
	hBox := CAWindow createHBox.
	hBox addMorph: (CAWindow createToolStrokeWidthContextMorph: aCAWindow).
	^hBox.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:34'
}
CAPenTool class >> toolName [
	^'Pen'.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 16:50'
}
CAPenTool >> drawAt: aPoint on: aCACanvasContainer [
	aCACanvasContainer canvas drawPoint: aPoint color: aCACanvasContainer caWindow primaryColor.

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 13:19'
}
CAPenTool >> handleMouseDown: anEvent on: aCACanvasContainer [
	aCACanvasContainer canvas saveState.
	aCACanvasContainer canvas commit.
	isDrawing := true.
	self drawAt: (aCACanvasContainer getPixelPosition: anEvent position) on: aCACanvasContainer.

]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'iss 6/12/2024 17:40'
}
CAPenTool >> handleMouseMove: anEvent on: aCACanvasContainer [
	isDrawing ifTrue: [
		self drawAt: (aCACanvasContainer getPixelPosition: anEvent position) on: aCACanvasContainer.
		].
	aCACanvasContainer updateForm.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 19:06'
}
CAPenTool >> handleMouseUp: anEvent on: aCACanvasContainer [
	isDrawing := false.
	aCACanvasContainer canvas commit.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'iss 6/7/2024 10:36'
}
CAPenTool >> initialize [
	super initialize.
	isDrawing := false.
]
