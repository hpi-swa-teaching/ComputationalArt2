"
CAIntegerTextMorph is used to handle integer input within a text morph.
"
Class {
	#name : #CAIntegerTextMorph,
	#superclass : #CATextMorph,
	#instVars : [
		'actionBlock',
		'minValue',
		'maxValue'
	],
	#category : #'ComputationalArt2-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 00:55'
}
CAIntegerTextMorph >> actionBlock: aBlock [
	actionBlock := aBlock.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 13:12'
}
CAIntegerTextMorph >> initialize [
	super initialize.
	self contents: '1'.
	minValue := 0.
	maxValue := 99999.
	actionBlock := [:num| ].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 02:06'
}
CAIntegerTextMorph >> keyStroke: anEvent [
	"I handle key strokes to allow only digits, backspace, delete, and arrow keys."
	| key string number |
	key := anEvent keyCharacter.
	(key isDigit or:
	key = Character backspace or:
	key = Character delete or:
	key = Character arrowRight or:
	key = Character arrowLeft) ifTrue: [super keyStroke: anEvent.].
	
	(key = Character cr) ifTrue: [
		super keyStroke: anEvent.
		string := self contents asString.
		[number := string asNumber] on: Error do:[number:=0.].
		number := number min: maxValue max: minValue.
		self contents: number asString.
		actionBlock value: number.].
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 00:46'
}
CAIntegerTextMorph >> maxValue [
	^maxValue.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 00:46'
}
CAIntegerTextMorph >> maxValue: aNumber [
	maxValue := aNumber.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 00:46'
}
CAIntegerTextMorph >> minValue [
	^minValue.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 00:46'
}
CAIntegerTextMorph >> minValue: aNumber [
	minValue := aNumber.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 00:40'
}
CAIntegerTextMorph >> number: aNumber [
	"I set the contents to the given number, ensuring it is within the min and max values."
	| num |
	num := aNumber min: maxValue max: minValue.
	self contents: num asString.
]
