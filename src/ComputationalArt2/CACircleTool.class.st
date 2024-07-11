"
CACircleTool used to draw circles on the canvas.
"
Class {
	#name : #CACircleTool,
	#superclass : #CACanvasTool,
	#instVars : [
		'startPoint'
	],
	#category : #ComputationalArt2,
	#'squeak_changestamp' : 'iss 6/7/2024 11:48'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 02:24'
}
CACircleTool class >> createContextBox: aCAWindow [
	| hBox |
	hBox := CAWindow createHBox.
	hBox addMorph: (CAWindow createToolFillContextMorph: aCAWindow);
	addMorph: (CAHSpace new dpiWidth: CAWindow uiContextBoxSpacing);
		addMorph: (CAWindow createToolStrokeContextMorph: aCAWindow);
		addMorph: (CAHSpace new dpiWidth: CAWindow uiContextBoxSpacing);
		addMorph: (CAWindow createToolStrokeWidthContextMorph: aCAWindow).
	^hBox.
	

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:33'
}
CACircleTool class >> toolName [
	^'Circle'.
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'iss 6/26/2024 13:37'
}
CACircleTool >> drawCircleFrom: startPoint to: endPoint on: aCACanvasContainer [
	| center radius caWindow |
	center := (startPoint + endPoint) // 2.
	radius := (startPoint dist: endPoint) // 2.
	
	caWindow := aCACanvasContainer caWindow.
	caWindow toolFill ifTrue: [
		aCACanvasContainer canvas fillCircleAt: center radius: radius color: caWindow secondaryColor.].
	caWindow toolStroke ifTrue: [
		aCACanvasContainer canvas drawCircleOutlineAt: center radius: radius color: caWindow primaryColor width: caWindow toolStrokeWidth.
		].
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:16'
}
CACircleTool >> handleMouseDown: anEvent on: aCACanvasContainer [
	aCACanvasContainer canvas saveState;
		commit.
	startPoint := aCACanvasContainer getPixelPosition: anEvent position.

]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 01:36'
}
CACircleTool >> handleMouseMove: anEvent on: aCACanvasContainer [
	startPoint ifNotNil: [ 
		aCACanvasContainer canvas reset.
		self drawCircleFrom: startPoint to: 
			(aCACanvasContainer getPixelPosition: anEvent position) on: aCACanvasContainer.
		aCACanvasContainer updateForm.
		].
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'Tyron Franzke 6/13/2024 10:38'
}
CACircleTool >> handleMouseUp: anEvent on: aCACanvasContainer [
	self drawCircleFrom: startPoint to: (aCACanvasContainer getPixelPosition: anEvent position) on: aCACanvasContainer.
	startPoint := nil.
	
	aCACanvasContainer canvas commit.
	aCACanvasContainer updateForm.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'iss 6/7/2024 11:15'
}
CACircleTool >> initialize [
	super initialize.
	startPoint := nil.
]

{
	#category : #private,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:16'
}
CACircleTool >> numberOfSteps [
	^100.
]
