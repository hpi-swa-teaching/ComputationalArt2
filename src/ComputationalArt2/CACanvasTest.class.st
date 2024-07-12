Class {
	#name : #CACanvasTest,
	#superclass : #TestCase,
	#instVars : [
		'window',
		'canvas'
	],
	#category : #'ComputationalArt2-Tests'
}

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 01:57'
}
CACanvasTest >> setUp [
	canvas := CACanvas new: 100 height: 100 depth: 32.
	canvas create.
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:10'
}
CACanvasTest >> testClearColor [
	| color |
	color := CARGB red.
	canvas clearColor: color.
	self assert: (canvas colorAt: 50@50) = color.
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 03:04'
}
CACanvasTest >> testCommit [
	| color |
	color := CARGB magenta.
	canvas drawPoint: 1@1 color: color;
		commit.
	self assert: (CARGB newFrom: (canvas stableCanvas form colorAt: 1@1)) = color.
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:10'
}
CACanvasTest >> testDrawLine [
	| color startPoint endPoint |
	color := CARGB green.
	startPoint := 0@0.
	endPoint := 10@10.
	canvas drawLine: startPoint to: endPoint width: 1 color: color.
	self assert: (canvas colorAt: 5@5) = color.
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:57'
}
CACanvasTest >> testDrawPoint [
	| color point |
	color := CARGB blue.
	point := 10@10.
	canvas drawPoint: point color: color.
	self assert: (canvas colorAt: point) = color.
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:01'
}
CACanvasTest >> testInitialization [
	"Test that the canvas initializes correctly"
	self assert: canvas width = 100;
		assert: canvas height = 100;
		assert: canvas depth = 32;
		assert: canvas undoStack isEmpty;
		assert: canvas redoStack isEmpty;
		assert: (canvas colorAt: 0@0) = canvas defaultColor.
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 03:03'
}
CACanvasTest >> testIsInBounds [
	self assert: (canvas isInBounds: 50@50);
		deny: (canvas isInBounds: 150@150).
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 03:04'
}
CACanvasTest >> testResize [
	canvas resize: 200 height: 200.
	self assert: canvas width = 200;
		assert: canvas height = 200.
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 03:04'
}
CACanvasTest >> testUndoRedo [
	| color1 color2 |
	color1 := CARGB yellow.
	color2 := CARGB black.
	canvas clearColor: color1;
		saveState;
		clearColor: color2.
	self assert: (canvas colorAt: 50@50) = color2.
	
	"Undo"
	canvas undo.
	self assert: (canvas colorAt: 50@50) = color1.
	
	"Redo"
	canvas redo.
	self assert: (canvas colorAt: 50@50) = color2.
]
