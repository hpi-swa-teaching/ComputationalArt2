Class {
	#name : #CARGB,
	#superclass : #Color,
	#instVars : [
		'red',
		'green',
		'blue'
	],
	#category : #ComputationalArt2
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:29'
}
CARGB class >> black [
	^CARGB r: 0 g: 0 b: 0.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:19'
}
CARGB class >> blue [
	^CARGB r: 0 g: 0 b: 255.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 19:25'
}
CARGB class >> chanelTo8Bit: aNumber [
	^(((aNumber * 256.0) floor) min: 255).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:19'
}
CARGB class >> cyan [
	^CARGB r: 0 g: 255 b: 255.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:21'
}
CARGB class >> gray [
	^CARGB r: 127 g: 127 b: 127.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:19'
}
CARGB class >> green [
	^CARGB r: 0 g: 255 b: 0.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:20'
}
CARGB class >> magenta [
	^CARGB r: 255 g: 0 b: 255.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 19:59'
}
CARGB class >> newFrom: aColor [
	| color |
	color := self new.
	color red: (self chanelTo8Bit: aColor red).
	color green: (self chanelTo8Bit: aColor green).
	color blue:  (self chanelTo8Bit: aColor blue).
	^color.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 16:56'
}
CARGB class >> r: r g: g b: b [
	| rgb |
	rgb := self basicNew.
	rgb red: r; green: g; blue: b.
	^rgb.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 19:18'
}
CARGB class >> random [
	^CARGB r: (255 random) g: (255 random) b: (255 random).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:19'
}
CARGB class >> red [
	^CARGB r: 255 g: 0 b: 0.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:20'
}
CARGB class >> white [
	^CARGB r: 255 g: 255 b: 255.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:20'
}
CARGB class >> yellow [
	^CARGB r: 255 g: 255 b: 0.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 15:30'
}
CARGB >> = aCARGB [
	^(red = aCARGB red) and: (green = aCARGB green) and: (blue = aCARGB blue).
	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 19:12'
}
CARGB >> blue [
	^ blue
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 19:36'
}
CARGB >> blue: aNumber [
	blue := (aNumber rounded) min: 255 max: 0.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 19:12'
}
CARGB >> green [
	^ green
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 19:36'
}
CARGB >> green: aNumber [
	green := (aNumber rounded) min: 255 max: 0.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 19:10'
}
CARGB >> initialize [
	red := 0.
	green := 0.
	blue := 0.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:27'
}
CARGB >> morphicColor [
	^Color r: red /255.0 g: green / 255.0 b: blue / 255.0.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 16:46'
}
CARGB >> pixelValueForDepth: d [
	| val |
	d = 32 ifTrue: [
		 val :=	((red bitShift: 16) bitAnd: 16rFF0000) bitOr:
				(((green bitShift: 8) bitAnd: 16rFF00) bitOr:
				((blue bitShift: 0) bitAnd: 16rFF)).
		^16rFF000000 + val.].
	self error: 'unknown pixel depth: ', d printString.

]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 19:12'
}
CARGB >> red [
	^ red
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 19:36'
}
CARGB >> red: aNumber [
	red  := (aNumber rounded) min: 255 max: 0.
]
