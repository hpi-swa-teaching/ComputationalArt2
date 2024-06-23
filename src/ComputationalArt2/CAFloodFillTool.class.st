"
CAFloodFillTool fills an area with a selected color.
"
Class {
	#name : #CAFloodFillTool,
	#superclass : #CACanvasTool,
	#category : #ComputationalArt2,
	#'squeak_changestamp' : 'iss 6/7/2024 11:53'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 02:26'
}
CAFloodFillTool class >> createContextBox: aCAWindow [
	| hBox |
	hBox := CAWindow createHBox.
	hBox addMorph: (CAStringMorph new contents: 'Flood Fill').
	^hBox.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:33'
}
CAFloodFillTool class >> toolName [
	^'Flood Fill'.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 16:58'
}
CAFloodFillTool >> handleMouseDown: anEvent on: aCACanvasContainer [
	| startPoint |
	aCACanvasContainer canvas saveState.
	startPoint := aCACanvasContainer getPixelPosition: anEvent position.
	
	aCACanvasContainer canvas fillFrom: startPoint withColor: aCACanvasContainer caWindow primaryColor.
	aCACanvasContainer updateForm.
]
