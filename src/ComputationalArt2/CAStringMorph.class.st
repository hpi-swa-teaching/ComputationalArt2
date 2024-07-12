"
CAStringMorph represents a string.
"
Class {
	#name : #CAStringMorph,
	#superclass : #StringMorph,
	#instVars : [
		'dpiHeight',
		'cachedUIScaleFactor'
	],
	#category : #'ComputationalArt2-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 22:36'
}
CAStringMorph >> drawOn: aCanvas [
	super drawOn: aCanvas.
	cachedUIScaleFactor = Display uiScaleFactor ifFalse: [
		cachedUIScaleFactor := Display uiScaleFactor.
		self fitContents.].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 22:33'
}
CAStringMorph >> initialize [
	super initialize.
	cachedUIScaleFactor := Display uiScaleFactor.
]
