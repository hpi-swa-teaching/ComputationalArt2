"
CAStepFeature performs a single step in a process or simulation on the canvas.
"
Class {
	#name : #CAStepFeature,
	#superclass : #CAClickableFeature,
	#category : #ComputationalArt2,
	#'squeak_changestamp' : 'iss 6/7/2024 11:52'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 21:11'
}
CAStepFeature class >> executeFeature: aCAWindow [
	| block canvasAPI canvas code |
	
	canvas := aCAWindow canvasContainer canvas.
	
	(aCAWindow simulationStep = 0) ifTrue: [
		code := aCAWindow scriptField contentOfTab: CATabInitalizeFeature tabName.
		Transcript showln: code.
		block := Compiler evaluate: ('[:canvas | ', code ,']').
		canvasAPI := CACanvasAPI new.
		canvasAPI privateCanvas: canvas.
		block value: canvasAPI.
		aCAWindow canvasContainer updateForm.].
	
	code := aCAWindow scriptField contentOfTab: (CATabCanvasFeature tabName).
	block := Compiler evaluate: ('[:canvas | ', code ,']').
	canvasAPI := CACanvasAPI new.
	canvasAPI privateCanvas: canvas.
	block value: canvasAPI.
	aCAWindow canvasContainer updateForm.
	
	aCAWindow simulationStep: aCAWindow simulationStep + 1.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:33'
}
CAStepFeature class >> featureName [
	^'Step'.
]
