Class {
	#name : #CACanvasAPITest,
	#superclass : #TestCase,
	#instVars : [
		'canvas',
		'api'
	],
	#category : #'ComputationalArt2-Tests'
}

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:28'
}
CACanvasAPITest >> setUp [
	canvas := CACanvas new: 10 height: 10 depth: 32.
	canvas create.
	api := CACanvasAPI new.
	api privateCanvas: canvas.
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 03:04'
}
CACanvasAPITest >> testFillCircle [
	| center color radius radiusPoint outsideCirclePoint |
	center := 5@5.
	radius := 3.
	radiusPoint := 5@(5+radius).
	outsideCirclePoint := 5@(5+radius+1).
	color := CARGB green.
	api fillRGB: color;
		fillCircle: center radius: radius.
	self assert: (canvas colorAt: center) = color;
		assert: (canvas colorAt: radiusPoint) = color;
		deny: (canvas colorAt: outsideCirclePoint) = color.
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:49'
}
CACanvasAPITest >> testFillRGB [
	| color |
	color := CARGB red.
	api fillRGB: color.
	self assert: api fillRGB = color.
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 03:05'
}
CACanvasAPITest >> testFillRect [
	| color end start |
	start := 1@1.
	end := 8@8.
	color := CARGB blue.
	api fillRGB: color;
		fillRect: start to: end.
	self assert: (canvas colorAt: 4@4) = color;
		deny: (canvas colorAt: 9@9) = color.
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 03:05'
}
CACanvasAPITest >> testFold [
	| array expectedColor |
	array := #( (0 0 0) (0.1 0.4 1) (0.4 0 0) ).
	expectedColor := CARGB r: 241 g: 241 b: 241.
	api fillRGB: CARGB red;
		rgbAt: 5@5 put: CARGB yellow;
		fillRect: 0@0 extent: 10@10;
		fold: array at: 5@5.
	self assert: (canvas colorAt: 5@5) = (expectedColor).
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:21'
}
CACanvasAPITest >> testPixelsDo [
	| counter |
	counter := 0.
	api pixelsDo: [ :x :y | counter := counter + 1. ].
	self assert: counter = (canvas width * canvas height).
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 03:05'
}
CACanvasAPITest >> testStrokeCircle [
	api strokeWidth: 1;
		strokeR: 0 G: 0 B: 255;
		strokeCircle: 5@5 radius: 2.
	self assert: (canvas colorAt: 5@3) = (CARGB blue);
		deny: (canvas colorAt: 5@0) = (CARGB blue).
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 03:06'
}
CACanvasAPITest >> testStrokeLine [
	| start end color |
	start := 0@0.
	end := 9@9.
	color := CARGB black.
	api strokeRGB: color;
		strokeWidth: 1;
		strokeLine: start to: end.
	self assert: (canvas colorAt: start) = color;
		assert: (canvas colorAt: end) = color;
		assert: (canvas colorAt: 4@4) = color;
		deny: (canvas colorAt: 4@5) = color.
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 03:06'
}
CACanvasAPITest >> testStrokeRect [
	api strokeR: 255 G: 255 B: 0;
		strokeRect: 2@2 to: 6@6.
	self assert: (canvas colorAt: 2@2) = (CARGB yellow).
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:41'
}
CACanvasAPITest >> testStrokeWidth [
	| width |
	width := 2.
	api strokeWidth: width.
	self assert: api strokeWidth = width.
]
