Class {
	#name : #CACanvasContainer,
	#superclass : #PasteUpMorph,
	#instVars : [
		'caCanvas',
		'imageMorph',
		'canvasOffset',
		'caWindow',
		'canvasScale',
		'form'
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
	#'squeak_changestamp' : 'iss 6/12/2024 18:06'
}
CACanvasContainer >> caWindow [
	^caWindow
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 12:55'
}
CACanvasContainer >> caWindow: aCAWindow [
	caWindow := aCAWindow.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/5/2024 12:43'
}
CACanvasContainer >> canvas [
	^ caCanvas
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 13:57'
}
CACanvasContainer >> canvasOffset [
	^canvasOffset.
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 14:23'
}
CACanvasContainer >> canvasOffset: aPoint [
	canvasOffset := aPoint.
	imageMorph position: self position + canvasOffset.
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 16:33'
}
CACanvasContainer >> canvasOffset: aPoint scale: aNumber [
	self canvasScale: aNumber.
	self canvasOffset: aPoint.
	
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 15:00'
}
CACanvasContainer >> canvasScale [
	^canvasScale
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
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 16:04'
}
CACanvasContainer >> clampScale: aNumber [
	^ aNumber min: 16.0 max: 0.125.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 16:03'
}
CACanvasContainer >> getPixelPosition: aPoint [
	^(((aPoint - self position) - canvasOffset) / canvasScale) floor.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 11:48'
}
CACanvasContainer >> handlesMouseDown: anEvent [
	^true.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 13:14'
}
CACanvasContainer >> handlesMouseMove: anEvent [
	^true.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 14:43'
}
CACanvasContainer >> handlesMouseWheel: anEvent [
	^true.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 16:40'
}
CACanvasContainer >> initialize [
	super initialize.
	self color: Color transparent.
	self borderWidth: 1.
	self minimumExtent: 128@128.
	self hResizing: #spaceFill.
	self vResizing: #spaceFill.
	canvasOffset := 0@0.
	canvasScale := 1.0.
	
	caCanvas := CACanvas new: 100 height: 100 depth: 32.
	caCanvas create.
	
	imageMorph := ImageMorph new image: caCanvas form.
	imageMorph position: canvasOffset.
	self addMorph: imageMorph.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/5/2024 01:21'
}
CACanvasContainer >> mouseDown: anEvent [
	caWindow activeTool handleMouseDown: anEvent on: self.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 13:35'
}
CACanvasContainer >> mouseMove: anEvent [
	caWindow activeTool handleMouseMove: anEvent on: self.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 13:32'
}
CACanvasContainer >> mouseUp: anEvent [
	caWindow activeTool handleMouseUp: anEvent on: self.	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 14:44'
}
CACanvasContainer >> mouseWheel: anEvent [
	caWindow activeTool handleMouseWheel: anEvent on: self.
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
