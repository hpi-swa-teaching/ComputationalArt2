Class {
	#name : #CATextMorph,
	#superclass : #TextMorph,
	#instVars : [
		'cachedUiScale'
	],
	#category : #'ComputationalArt2-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 01:54'
}
CATextMorph >> drawKeyboardFocusIndicationOn: aCanvas [

	self wantsRoundedCorners
		ifTrue: [aCanvas frameRoundRect: self bounds radius: self cornerRadius width: self keyboardFocusWidth + self borderWidth color: self keyboardFocusColor]
		ifFalse: [aCanvas fillRectangle: self bounds color: CAWindow uiDarkerBackground].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 00:41'
}
CATextMorph >> drawOn: aCanvas [
	cachedUiScale = Display uiScaleFactor ifFalse:[
		cachedUiScale := Display uiScaleFactor.
		self font: TextStyle defaultFont.].
	super drawOn: aCanvas.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:26'
}
CATextMorph >> initialize [
	super initialize.
	self minimumWidth: 10.
	self backgroundColor: CAWindow uiDarkerBackground.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 02:06'
}
CATextMorph >> keyStroke: anEvent [
	| hand |
	super keyStroke: anEvent.
	(anEvent keyCharacter = Character cr) ifTrue: [
		hand := ActiveHand ifNil: [HandMorph activeHand].
		hand releaseKeyboardFocus: self.].
	
]
