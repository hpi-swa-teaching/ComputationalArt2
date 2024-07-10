"
CAStartFeature starts a process or simulation on the canvas.
"
Class {
	#name : #CAStartFeature,
	#superclass : #CAClickableFeature,
	#category : #ComputationalArt2,
	#'squeak_changestamp' : 'iss 6/7/2024 11:53'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 12:51'
}
CAStartFeature class >> executeFeature: aCAWindow [
	| block canvasAPI canvas |
	canvas := aCAWindow canvasContainer canvas.
	canvas reset.
	block := Compiler evaluate: '[:canvas | ', aCAWindow scriptField text,']'.
	canvasAPI := CACanvasAPI new.
	canvasAPI privateCanvas: canvas.
	block value: canvasAPI.
	
	aCAWindow canvasContainer updateForm.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:33'
}
CAStartFeature class >> featureName [
	^'Start'.
]
