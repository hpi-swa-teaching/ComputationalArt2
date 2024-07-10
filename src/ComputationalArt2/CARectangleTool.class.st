"
CARectangleTool is used to draw rectangles on the canvas.
"
Class {
	#name : #CARectangleTool,
	#superclass : #CACanvasTool,
	#instVars : [
		'startPoint'
	],
	#category : #ComputationalArt2,
	#'squeak_changestamp' : 'iss 6/7/2024 11:53'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 02:24'
}
CARectangleTool class >> createContextBox: aCAWindow [
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
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:34'
}
CARectangleTool class >> toolName [
	^'Rectangle'.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'iss 6/26/2024 13:39'
}
CARectangleTool >> drawRectangleFrom: startPoint to: endPoint on: aCACanvasContainer [
	| topLeft bottomRight width height rect caWindow |
	topLeft := startPoint min: endPoint.
	bottomRight := startPoint max: endPoint.
	width := bottomRight x - topLeft x.
	height := bottomRight y - topLeft y.
	caWindow := aCACanvasContainer caWindow.
	rect := Rectangle origin: topLeft extent: width @ height.

	caWindow toolFill ifTrue: [
		aCACanvasContainer canvas drawRect: rect color: caWindow secondaryColor.].

	caWindow toolStroke ifTrue: [
		aCACanvasContainer canvas drawOutlineOfRect: rect withColor: caWindow primaryColor width: caWindow toolStrokeWidth.].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 13:19'
}
CARectangleTool >> handleMouseDown: anEvent on: aCACanvasContainer [
	aCACanvasContainer canvas saveState.
	aCACanvasContainer canvas commit.
	startPoint := aCACanvasContainer getPixelPosition: anEvent position.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/13/2024 10:47'
}
CARectangleTool >> handleMouseMove: anEvent on: aCACanvasContainer [
	
	startPoint ifNotNil: [ | endPoint |
		aCACanvasContainer canvas reset.
		endPoint := aCACanvasContainer getPixelPosition: anEvent position.
		self drawRectangleFrom: startPoint to: endPoint on: aCACanvasContainer.
		aCACanvasContainer updateForm.
		].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/13/2024 10:48'
}
CARectangleTool >> handleMouseUp: anEvent on: aCACanvasContainer [
    
	| endPoint |
	endPoint := aCACanvasContainer getPixelPosition: anEvent position.
	self drawRectangleFrom: startPoint to: endPoint on: aCACanvasContainer.
	startPoint := nil.
	aCACanvasContainer canvas commit.
	aCACanvasContainer updateForm.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Halfil 6/12/2024 21:41'
}
CARectangleTool >> initialize [
    super initialize.
    startPoint := nil.

]
