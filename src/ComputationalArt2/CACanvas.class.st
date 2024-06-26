Class {
	#name : #CACanvas,
	#superclass : #Object,
	#instVars : [
		'width',
		'height',
		'depth',
		'stagedCanvas',
		'stableCanvas',
		'defaultColor',
		'undoStack',
		'redoStack'
	],
	#category : #ComputationalArt2
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/5/2024 00:58'
}
CACanvas class >> new: aWidth height: aHeight [
	^ self new: aWidth height: aHeight depth: Display depth.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/5/2024 00:57'
}
CACanvas class >> new: aWidth height: aHeight depth: aDepth [
	^ CACanvas new width: aWidth; height: aHeight; depth: aDepth.
]

{
	#category : #api,
	#'squeak_changestamp' : 'iss 6/13/2024 16:39'
}
CACanvas >> clearColor: aColor [

	self saveState.
	stagedCanvas form fillWithColor: aColor.
]

{
	#category : #api,
	#'squeak_changestamp' : 'iss 6/13/2024 16:13'
}
CACanvas >> clearImage: aForm [
	
	self saveState.
	stagedCanvas image: aForm at: 0@0.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 17:01'
}
CACanvas >> colorAt: aPosition [
	^ CARGB newFrom: (self form colorAt: aPosition).
]

{
	#category : #api,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 17:05'
}
CACanvas >> commit [
	stableCanvas setForm: stagedCanvas form deepCopy.
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'Tyron Franzke 6/5/2024 13:49'
}
CACanvas >> create [
	
	stableCanvas := FormCanvas extent:
	(self width)@(self height)depth: (self depth).
	stagedCanvas := FormCanvas extent:
	(self width)@(self height) depth: (self depth).
	
	self clearColor: defaultColor.
	self commit.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 6/5/2024 00:55'
}
CACanvas >> depth [
	^ depth
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 6/5/2024 13:25'
}
CACanvas >> depth: aDepth [
	depth := aDepth.
]

{
	#category : #api,
	#'squeak_changestamp' : 'iss 6/26/2024 12:52'
}
CACanvas >> drawCircleOutlineAt: center radius: radius color: aCARGB width: aLineWidth [

	| angle stepAngle x y points |
	
	points := OrderedCollection new.
	stepAngle := (2 * Float pi) / 100.
	
	0 to: 99 do: [:i | 
		angle := i * stepAngle.
		x := (center x + (radius * (angle cos))) rounded.
		y := (center y + (radius * (angle sin))) rounded.
		points add: (x @ y).
		].
	
	points withIndexDo: [:point :i |
		self drawLine: point to: (points atWrap: i + 1) width: aLineWidth color: aCARGB.
		].
]

{
	#category : #api,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 17:06'
}
CACanvas >> drawLine: aStartPoint to: anEndPoint width: aLineWidth color: aCARGB [

	stagedCanvas line: aStartPoint to: anEndPoint
		width: aLineWidth color: aCARGB.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'iss 6/26/2024 12:55'
}
CACanvas >> drawOutlineOfRect: rect withColor: aCARGB width: aLineWidth [

	| topEdge bottomEdge leftEdge rightEdge |
	
	topEdge := Rectangle origin: rect topLeft extent: rect width @ aLineWidth.
	bottomEdge := Rectangle origin: rect bottomLeft - (0 @ aLineWidth) extent: rect width @ aLineWidth.
	leftEdge := Rectangle origin: rect topLeft extent: aLineWidth @ rect height.
	rightEdge := Rectangle origin: rect topRight - (aLineWidth @ 0) extent: aLineWidth @ rect height.
	
	self drawRect: topEdge color: aCARGB.
	self drawRect: bottomEdge color: aCARGB.
	self drawRect: leftEdge color: aCARGB.
	self drawRect: rightEdge color: aCARGB.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 17:06'
}
CACanvas >> drawPoint: aPoint color: aCARGB [
	stagedCanvas point: aPoint color: aCARGB.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 17:06'
}
CACanvas >> drawRect: aRectangle color: aCARGB [

	stagedCanvas fillRectangle: aRectangle color: aCARGB.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 17:06'
}
CACanvas >> drawRect: aStartPoint to: anEndPoint color: aCARGB [

	stagedCanvas fillRectangle:
		(Rectangle origin: aStartPoint corner: anEndPoint) color: aCARGB.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 17:07'
}
CACanvas >> fillCircleAt: center radius: radius color: aCARGB [
	| dx dy |
	(center x - radius to: center x + radius) do: [:x |
		(center y - radius to: center y + radius) do: [:y |
			dx := x - center x.
			dy := y - center y.
			((dx * dx) + (dy * dy) <= (radius * radius)) ifTrue: [
				self drawPoint: (x @ y) color: aCARGB.
				].
			].
		].
]

{
	#category : #api,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 17:01'
}
CACanvas >> fillFrom: startPoint withColor: aCARGB [

	| stack oldColor |
	oldColor  := self colorAt: startPoint.
	oldColor = aCARGB ifTrue: [ ^self ].
	stack := OrderedCollection new.
	stack add: startPoint.
	[ stack isEmpty ] whileFalse: [
		| point neighbors |
		point := stack removeLast.
		(self colorAt: point) = oldColor ifTrue: [
			self drawPoint: point color: aCARGB.
			neighbors := { point + (1@0). point - (1@0). point + (0@1). point - (0@1) }.
			neighbors do: [ :neighbor |
				(self isInBounds: neighbor) ifTrue: [ stack add: neighbor ].
			].
		].
	].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 6/5/2024 13:32'
}
CACanvas >> form [
	^ stagedCanvas form.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 6/5/2024 13:22'
}
CACanvas >> height [
	^ height
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 6/12/2024 18:52'
}
CACanvas >> height: aHeight [
	height := aHeight
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'iss 6/13/2024 16:03'
}
CACanvas >> initialize [

	defaultColor := Color gray.
	undoStack := OrderedCollection new.
	redoStack := OrderedCollection new.
]

{
	#category : #api,
	#'squeak_changestamp' : 'iss 6/11/2024 16:44'
}
CACanvas >> isInBounds: aPoint [
	^(aPoint x >= 0 and: [ aPoint x < self width ])
	and: [ aPoint y >= 0 and: [ aPoint y < self height ]].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'iss 6/13/2024 16:06'
}
CACanvas >> maxStackSize [
	^50
]

{
	#category : #'state management',
	#'squeak_changestamp' : 'iss 6/13/2024 16:40'
}
CACanvas >> redo [

	redoStack isEmpty ifTrue: [self inform: 'no more redo actions'
		] ifFalse: [undoStack add: (stagedCanvas form deepCopy).
		stagedCanvas setForm: redoStack removeLast.
		self commit.
		].
]

{
	#category : #api,
	#'squeak_changestamp' : 'Tyron Franzke 6/5/2024 13:32'
}
CACanvas >> reset [

	stagedCanvas setForm: stableCanvas form deepCopy.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Tyron Franzke 6/12/2024 18:52'
}
CACanvas >> resize [
	
	| oldForm |
	oldForm := stableCanvas form.
	
	stableCanvas := FormCanvas extent:
		(self width)@(self height) depth: (self depth).
	stagedCanvas := FormCanvas extent:
		(self width)@(self height) depth: (self depth).
	
	self clearColor: defaultColor.
	self clearImage: oldForm.
	self commit.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Tyron Franzke 6/12/2024 18:52'
}
CACanvas >> resize: aWidth height: aHeight [
	
	| oldForm |
	oldForm := stableCanvas form.
	
	width := aWidth.
	height := aHeight.
	self resize.
]

{
	#category : #'state management',
	#'squeak_changestamp' : 'iss 6/13/2024 16:41'
}
CACanvas >> saveState [

	undoStack size >= self maxStackSize ifTrue: [undoStack removeFirst].
	undoStack add: (stagedCanvas form deepCopy).
	redoStack := OrderedCollection new.
]

{
	#category : #'state management',
	#'squeak_changestamp' : 'iss 6/13/2024 16:39'
}
CACanvas >> undo [

	undoStack isEmpty ifTrue: [self inform: 'no more undo actions'
		] ifFalse: [redoStack add: (stagedCanvas form deepCopy).
		stagedCanvas setForm: undoStack removeLast.
		self commit.
		].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 6/5/2024 00:55'
}
CACanvas >> width [
	^ width
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 6/12/2024 18:52'
}
CACanvas >> width: aWidth [
	width := aWidth
]
