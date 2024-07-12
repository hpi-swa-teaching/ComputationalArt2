"
CACanvas holds the form component and wraps manipulation on it.
"
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
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:15'
}
CACanvas class >> new: aWidth height: aHeight [
	^self new: aWidth height: aHeight depth: Display depth.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:15'
}
CACanvas class >> new: aWidth height: aHeight depth: aDepth [
	^CACanvas new width: aWidth; height: aHeight; depth: aDepth.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:05'
}
CACanvas >> clearColor: aColor [
	"I clear the canvas with the given color."
	self saveState;
		commit.
	stagedCanvas form fillWithColor: aColor.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:05'
}
CACanvas >> clearImage: aForm [
	"I clear the canvas with the given form."
	self saveState;
		commit.
	stagedCanvas image: aForm at: 0@0.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:12'
}
CACanvas >> colorAt: aPosition [
	"I return the color at the given position."
	^CARGB newFrom: (self form colorAt: aPosition).
]

{
	#category : #api,
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 13:19'
}
CACanvas >> commit [
	"I commit the current state of the staged canvas to the stable canvas."
	stableCanvas setForm: stagedCanvas form deepCopy.
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:06'
}
CACanvas >> create [
	stableCanvas := FormCanvas extent:
	(self width)@(self height)depth: (self depth).
	stagedCanvas := FormCanvas extent:
	(self width)@(self height) depth: (self depth).
	
	self clearColor: defaultColor;
		resetUndoStack;
		commit.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:12'
}
CACanvas >> defaultColor [
	^defaultColor.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:12'
}
CACanvas >> depth [
	^depth.
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
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:10'
}
CACanvas >> drawCircleOutlineAt: center radius: radius color: aCARGB width: aLineWidth [
	"I draw the outline of a circle with the given parameters."
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
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:06'
}
CACanvas >> drawLine: aStartPoint to: anEndPoint width: aLineWidth color: aCARGB [
	"I draw a line on the canvas with the given parameters."
	stagedCanvas line: aStartPoint to: anEndPoint
		width: aLineWidth color: aCARGB.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:11'
}
CACanvas >> drawOutlineOfRect: rect withColor: aCARGB width: aLineWidth [
	"I draw the outline of a rectangle with the given parameters."
	| topEdge bottomEdge leftEdge rightEdge |
	topEdge := Rectangle origin: rect topLeft extent: rect width @ aLineWidth.
	bottomEdge := Rectangle origin: rect bottomLeft - (0 @ aLineWidth) extent: rect width @ aLineWidth.
	leftEdge := Rectangle origin: rect topLeft extent: aLineWidth @ rect height.
	rightEdge := Rectangle origin: rect topRight - (aLineWidth @ 0) extent: aLineWidth @ rect height.
	
	self drawRect: topEdge color: aCARGB;
		drawRect: bottomEdge color: aCARGB;
		drawRect: leftEdge color: aCARGB;
		drawRect: rightEdge color: aCARGB.
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
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:06'
}
CACanvas >> drawRect: aRectangle color: aCARGB [
	"I draw a filled rectangle on the canvas with the given parameters."
	stagedCanvas fillRectangle: aRectangle color: aCARGB.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:07'
}
CACanvas >> drawRect: aStartPoint to: anEndPoint color: aCARGB [
	"I draw a filled rectangle on the canvas with the given parameters."
	stagedCanvas fillRectangle:
		(Rectangle origin: aStartPoint corner: anEndPoint) color: aCARGB.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 17:07'
}
CACanvas >> fillCircleAt: center radius: radius color: aCARGB [
	"I fill a circle at the given center point with the given radius and color."
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
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:11'
}
CACanvas >> fillFrom: startPoint withColor: aCARGB [
	"I fill the area starting from the given point with the given color using a flood fill algorithm."
	| stack oldColor |
	oldColor  := self colorAt: startPoint.
	oldColor = aCARGB ifTrue: [ ^self. ].
	stack := OrderedCollection new.
	stack add: startPoint.
	[ stack isEmpty ] whileFalse: [
		| point neighbors |
		point := stack removeLast.
		(self colorAt: point) = oldColor ifTrue: [
			self drawPoint: point color: aCARGB.
			neighbors := { point + (1@0). point - (1@0). point + (0@1). point - (0@1) }.
			neighbors do: [ :neighbor |
				(self isInBounds: neighbor) ifTrue: [ stack add: neighbor. ].
			].
		].
	].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:12'
}
CACanvas >> form [
	^stagedCanvas form.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:12'
}
CACanvas >> height [
	^height.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:11'
}
CACanvas >> height: aHeight [
	height := aHeight.
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:14'
}
CACanvas >> initialize [
	defaultColor := CARGB gray.
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
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:11'
}
CACanvas >> maxStackSize [
	^50.
]

{
	#category : #'state management',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:07'
}
CACanvas >> redo [
	"I redo the last undone action."
	redoStack isEmpty ifTrue: [self inform: 'no more redo actions'
		] ifFalse: [undoStack add: (stagedCanvas form deepCopy).
		stagedCanvas setForm: redoStack removeLast.
		self commit.
		].
]

{
	#category : #api,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:01'
}
CACanvas >> redoStack [
	^ redoStack
]

{
	#category : #api,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:07'
}
CACanvas >> reset [
	stagedCanvas setForm: stableCanvas form deepCopy.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 13:21'
}
CACanvas >> resetUndoStack [
	undoStack := OrderedCollection new.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:12'
}
CACanvas >> resize [
	"I resize the canvas to the current width and height, preserving the existing content."
	| oldForm |
	oldForm := stableCanvas form.
	stableCanvas := FormCanvas extent:
		(self width)@(self height) depth: (self depth).
	stagedCanvas := FormCanvas extent:
		(self width)@(self height) depth: (self depth).
	self clearColor: defaultColor;
		clearImage: oldForm;
		commit.
]

{
	#category : #api,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:08'
}
CACanvas >> resize: aWidth height: aHeight [
	width := aWidth.
	height := aHeight.
	self resize.
]

{
	#category : #'state management',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:08'
}
CACanvas >> saveState [
	"I save the current state of the staged canvas to the undo stack."
	undoStack size >= self maxStackSize ifTrue: [undoStack removeFirst].
	undoStack add: (stagedCanvas form deepCopy).
	redoStack := OrderedCollection new.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:58'
}
CACanvas >> stableCanvas [
	^stableCanvas.
]

{
	#category : #'state management',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:08'
}
CACanvas >> undo [
	"I undo the last action performed on the canvas."
	undoStack isEmpty ifTrue: [self inform: 'no more undo actions'
		] ifFalse: [redoStack add: (stagedCanvas form deepCopy).
		stagedCanvas setForm: undoStack removeLast.
		self commit.
		].
]

{
	#category : #api,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:12'
}
CACanvas >> undoStack [
	^undoStack.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:12'
}
CACanvas >> width [
	^width.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:13'
}
CACanvas >> width: aWidth [
	width := aWidth.
]
