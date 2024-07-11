"
This abstract class serves as the base for all canvas tools in the Computational Art application.
"
Class {
	#name : #CACanvasTool,
	#superclass : #Object,
	#category : #ComputationalArt2,
	#'squeak_changestamp' : 'iss 6/7/2024 11:49'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:36'
}
CACanvasTool class >> buttonForm [
	^((GitAssetLoader for: 'ComputationalArt2') loadImageMorph: 'assets\img\tools\',self toolName,'.png') form.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/8/2024 22:33'
}
CACanvasTool class >> createContextBox: aCAWindow [
	^self subclassResponsibility.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/7/2024 00:05'
}
CACanvasTool class >> createToolButton: aCAToolContainer [
	^CAIconButton newToolButton: self conainer: aCAToolContainer.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:15'
}
CACanvasTool class >> toolName [
	^'Tool'.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 15:56'
}
CACanvasTool >> handleMouseClick: anEven on: aCACanvasContainer [
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 12:54'
}
CACanvasTool >> handleMouseDown: anEven on: aCACanvasContainer [
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 12:55'
}
CACanvasTool >> handleMouseMove: anEven on: aCACanvasContainer [
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 12:55'
}
CACanvasTool >> handleMouseUp: anEven on: aCACanvasContainer [
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 12:55'
}
CACanvasTool >> handleMouseWheel: anEven on: aCACanvasContainer [
	
]
