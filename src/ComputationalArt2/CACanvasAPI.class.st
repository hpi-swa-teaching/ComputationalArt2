Class {
	#name : #CACanvasAPI,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'strokeWidth',
		'strokeRGB',
		'fillRGB',
		'backbuffer'
	],
	#category : #ComputationalArt2
}

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 19:16'
}
CACanvasAPI >> fillCircle: aPoint radius: aNumber [
	canvas fillCircleAt: aPoint radius: aNumber color: fillRGB.
	
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 14:39'
}
CACanvasAPI >> fillR:r G: g B: b [
	self fillRGB: (CARGB r: r g: g b: b).
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 14:00'
}
CACanvasAPI >> fillRGB [
	^fillRGB.
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:24'
}
CACanvasAPI >> fillRGB: aCARGB [
	fillRGB := aCARGB.
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:34'
}
CACanvasAPI >> fillRect: start extent: size [
	canvas drawRect: start to: (start + size) color: fillRGB.
	
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:34'
}
CACanvasAPI >> fillRect: start to: end [
	canvas drawRect: start to: end color: fillRGB.
	
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 10:00'
}
CACanvasAPI >> fold: a2DArray [
	| w h |
	w := a2DArray size.
	w = 0 ifTrue:[^nil].
	h := a2DArray at: 1.
	h = 0 ifTrue:[^nil].
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 10:41'
}
CACanvasAPI >> fold: a2DArray at: aPoint [
	| hm wm b g r |
	hm := (a2DArray size / 2) floor.
	wm := (((a2DArray at: 1) size / 2) floor).
	r := 0.0.
	g := 0.0.
	b := 0.0.
	(hm * -1) to: hm do: [ :yOffset |
		(wm * -1) to: wm do: [ :xOffset | | color factor |
			color := self rgbBackAt: aPoint + (xOffset@yOffset).
			factor := (a2DArray at: (yOffset + hm + 1)) at: (xOffset + wm + 1).
			r := r + (color red * factor).
			g := g + (color green * factor).
			b := b + (color blue * factor).].].
	self rgbAt: aPoint put: (CARGB r: r g: g b: b).
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:54'
}
CACanvasAPI >> height [
	^canvas height.
]

{
	#category : #private,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:34'
}
CACanvasAPI >> initialize [
	self strokeRGB: (CARGB black).
	self fillRGB: (CARGB black).
	self strokeWidth: 1.
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:55'
}
CACanvasAPI >> pixelsDo: aBlock [
	0 to: (self width - 1) do: [:y|
		0 to: (self height - 1) do: [:x|
			aBlock value: x value: y.].].
]

{
	#category : #private,
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 10:42'
}
CACanvasAPI >> privateCanvas: aCACanvas [
	canvas := aCACanvas.
	backbuffer := aCACanvas form deepCopy.
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:59'
}
CACanvasAPI >> rgbAt: aPoint [
	| p |
	p := (aPoint x min: (self width) max: 0)@(aPoint y min: (self height) max: 0).
	^canvas colorAt: aPoint.
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 19:34'
}
CACanvasAPI >> rgbAt: aPoint put: aCARGB [
	^canvas drawPoint: aPoint color: aCARGB.
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 10:43'
}
CACanvasAPI >> rgbBackAt: aPoint [
	| p |
	p := (aPoint x min: (self width - 1) max: 0)@(aPoint y min: (self height - 1) max: 0).
	^CARGB newFrom: (backbuffer colorAt: p).
]

{
	#category : #API,
	#'squeak_changestamp' : 'iss 6/26/2024 12:56'
}
CACanvasAPI >> strokeCircle: aPoint radius: aNumber [
	canvas drawCircleOutlineAt: aPoint radius: aNumber color: strokeRGB width: strokeWidth.
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 19:28'
}
CACanvasAPI >> strokeLine: start to: end [
	^canvas drawLine: start to: end width: strokeWidth color: strokeRGB.
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 14:39'
}
CACanvasAPI >> strokeR:r G: g B: b [
	self strokeRGB: (CARGB r: r g: g b: b).
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 14:00'
}
CACanvasAPI >> strokeRGB [
	^strokeRGB.
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:24'
}
CACanvasAPI >> strokeRGB: aCARGB [
	strokeRGB := aCARGB.
]

{
	#category : #API,
	#'squeak_changestamp' : 'iss 6/26/2024 12:57'
}
CACanvasAPI >> strokeRect: start extent: size [
	canvas drawOutlineOfRect: (start extent: size) withColor: strokeRGB width: strokeWidth.
]

{
	#category : #API,
	#'squeak_changestamp' : 'iss 6/26/2024 12:57'
}
CACanvasAPI >> strokeRect: start to: end [
	canvas drawOutlineOfRect: (start corner: end) withColor: strokeRGB width: strokeWidth.
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 13:56'
}
CACanvasAPI >> strokeWidth [
	^strokeWidth.
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 13:55'
}
CACanvasAPI >> strokeWidth: aNumber [
	strokeWidth := aNumber.
]

{
	#category : #API,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 18:40'
}
CACanvasAPI >> width [
	^canvas width.
]
