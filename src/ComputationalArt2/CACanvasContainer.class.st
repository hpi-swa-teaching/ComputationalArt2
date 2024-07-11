Class {
	#name : #CACanvasContainer,
	#superclass : #PasteUpMorph,
	#instVars : [
		'caWindow',
		'caCanvas',
		'canvasOffset',
		'imageMorph',
		'canvasScale'
	],
	#category : #ComputationalArt2
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 12:58'
}
CACanvasContainer class >> newWith: aCAWindow [
	^CACanvasContainer new caWindow: aCAWindow.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:13'
}
CACanvasContainer >> caWindow [
	^caWindow.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 12:55'
}
CACanvasContainer >> caWindow: aCAWindow [
	caWindow := aCAWindow.
]

{
	#category : #'project state',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:14'
}
CACanvasContainer >> canvas [
	^caCanvas.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/11/2024 23:42'
}
CACanvasContainer >> canvasOffset [
	^canvasOffset.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/11/2024 23:42'
}
CACanvasContainer >> canvasOffset: aPoint [
	canvasOffset := aPoint.
	imageMorph position: self position + canvasOffset.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:14'
}
CACanvasContainer >> canvasOffset: aPoint scale: aNumber [
	self canvasScale: aNumber;
		canvasOffset: aPoint.
	
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:14'
}
CACanvasContainer >> canvasScale [
	^canvasScale.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 16:09'
}
CACanvasContainer >> canvasScale: aNumber [
	canvasScale := self clampScale: aNumber.
	self updateForm.
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:14'
}
CACanvasContainer >> clampScale: aNumber [
	^aNumber min: 16.0 max: 0.125.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 16:03'
}
CACanvasContainer >> getPixelPosition: aPoint [
	^(((aPoint - self position) - canvasOffset) / canvasScale) floor.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:14'
}
CACanvasContainer >> handlesKeyboard: anEvent [
	^anEvent keyCode = 16.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 11:48'
}
CACanvasContainer >> handlesMouseDown: anEvent [
	^true.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 13:14'
}
CACanvasContainer >> handlesMouseMove: anEvent [
	^true.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 14:43'
}
CACanvasContainer >> handlesMouseWheel: anEvent [
	^true.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:15'
}
CACanvasContainer >> initialize [
	super initialize.
	self color: Color transparent;
		borderWidth: 1;
		minimumExtent: 128@128;
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	canvasOffset := 0@0.
	canvasScale := 1.0.
	
	caCanvas := CACanvas new: 100 height: 100 depth: 32.
	caCanvas create.
	
	imageMorph := ImageMorph new image: caCanvas form.
	imageMorph position: canvasOffset.
	self addMorph: imageMorph.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/27/2024 17:42'
}
CACanvasContainer >> keyDown: anEvent [
	caWindow toolContainer setActiveClassTemporary: CAMoveTool.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/27/2024 17:40'
}
CACanvasContainer >> keyUp: anEvent [
	caWindow toolContainer revertToPreviousActiveClass.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/27/2024 17:02'
}
CACanvasContainer >> mouseDown: anEvent [
    caWindow activeTool handleMouseDown: anEvent on: self.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 13:35'
}
CACanvasContainer >> mouseMove: anEvent [
	caWindow activeTool handleMouseMove: anEvent on: self.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/27/2024 17:04'
}
CACanvasContainer >> mouseUp: anEvent [
	caWindow activeTool handleMouseUp: anEvent on: self.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 14:44'
}
CACanvasContainer >> mouseWheel: anEvent [
	caWindow activeTool handleMouseWheel: anEvent on: self.
]

{
	#category : #'stepping and presenter',
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 14:22'
}
CACanvasContainer >> step [
	caWindow isSimulating ifTrue: [
		CAStepFeature executeFeature: caWindow.].
	super step.
	
]

{
	#category : #'stepping and presenter',
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 21:49'
}
CACanvasContainer >> stepTime [
	^35.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/5/2024 01:02'
}
CACanvasContainer >> updateForm [
	| scaledForm |
	scaledForm := caCanvas form magnifyBy: canvasScale.
	imageMorph image: scaledForm.
]
