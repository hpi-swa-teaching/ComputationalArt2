"
CACanvasTool is an abstract class that serves as the base for all canvas tools.
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
	"I am an abstract method and should be overridden by subclasses to create and return a context box for the tool."
	^self subclassResponsibility.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/7/2024 00:05'
}
CACanvasTool class >> createToolButton: aCAToolContainer [
	"I create and return a new tool button for the tool."
	^CAIconButton newToolButton: self conainer: aCAToolContainer.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:15'
}
CACanvasTool class >> toolName [
	"I return the name of the tool and should be overwritten."
	^'Tool'.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 15:56'
}
CACanvasTool >> handleMouseClick: anEven on: aCACanvasContainer [
	"I am a abstract method to handle mouse click events on the canvas."
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 12:54'
}
CACanvasTool >> handleMouseDown: anEven on: aCACanvasContainer [
	"I am a abstract method to handle mouse down events on the canvas."
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 12:55'
}
CACanvasTool >> handleMouseMove: anEven on: aCACanvasContainer [
	"I am a abstract method to handle mouse move events on the canvas."
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 12:55'
}
CACanvasTool >> handleMouseUp: anEven on: aCACanvasContainer [
	"I am a abstract method to handle mouse up events on the canvas."
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 12:55'
}
CACanvasTool >> handleMouseWheel: anEven on: aCACanvasContainer [
	"I am a abstract method to handle mouse wheel events on the canvas."
]
