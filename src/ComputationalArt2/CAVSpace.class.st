"
CAVSpace is a Morph subclass that represents a vertical space with a specific height in DPI.
"
Class {
	#name : #CAVSpace,
	#superclass : #Morph,
	#instVars : [
		'dpiHeight'
	],
	#category : #'ComputationalArt2-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/5/2024 15:39'
}
CAVSpace >> dpiHeight: aNumber [
	dpiHeight := aNumber.
	self changed.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/5/2024 16:58'
}
CAVSpace >> drawOn: aCanvas [
	"I draw draw myselfe on the canvas and calculate the height in pixels
	based on DPI and scale factor."
	| h |
	h := (dpiHeight * Display uiScaleFactor) rounded.
	h = self extent y ifFalse: [
		self extent: 0@h.].
	super drawOn: aCanvas.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/5/2024 15:38'
}
CAVSpace >> initialize [
	super initialize.
	dpiHeight := 1.
	self color: Color transparent.
]
