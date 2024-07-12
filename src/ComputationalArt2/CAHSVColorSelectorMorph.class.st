"
CAHSVColorSelectorMorph is a Morph used to select an HSV color value.
"
Class {
	#name : #CAHSVColorSelectorMorph,
	#superclass : #HSVColorSelectorMorph,
	#instVars : [
		'window'
	],
	#category : #'ComputationalArt2-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 12:08'
}
CAHSVColorSelectorMorph >> colorSelected:  aColor [
	super colorSelected: aColor.
	window = nil ifFalse: [window colorSelected: aColor.].
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 12:07'
}
CAHSVColorSelectorMorph >> window [
	^window.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 12:06'
}
CAHSVColorSelectorMorph >> window: aCAColorPickerWindow [
	window :=aCAColorPickerWindow.
]
