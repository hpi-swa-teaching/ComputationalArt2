Class {
	#name : #CARGBTest,
	#superclass : #TestCase,
	#category : #'ComputationalArt2-Tests'
}

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 01:32'
}
CARGBTest >> testChanelTo8Bit [
	self assert: (CARGB chanelTo8Bit: 0) = 0;
		assert: (CARGB chanelTo8Bit: 1.0) = 255;
		assert: (CARGB chanelTo8Bit: 0.5) = 128;
		assert: (CARGB chanelTo8Bit: 0.75) = 192;
		assert: (CARGB chanelTo8Bit: 1.1) = 255.

]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 01:22'
}
CARGBTest >> testChannelManipulation [
	| color |
	color := CARGB r: 0 g: 0 b: 0.

	"Set green to a valid value within bounds"
	color green: 500.
	self assert: (color green = 255).
	
	"Set red to a value within bounds"
	color red: 128.
	self assert: (color red = 128).

	"Set blue to a value exceeding bounds"
	color blue: 300.
	self assert: (color blue = 255).

	"Set blue to a value below bounds"
	color blue: -50.
	self assert: (color blue = 0).
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 01:29'
}
CARGBTest >> testComparison [
	| color1 color2 color3 |
	color1 := CARGB r: 1 g: 1 b: 1.
	color2 := CARGB r: 1 g: 1 b: 1.
	color3 := CARGB r: 1 g: 1 b: 0.
	
	self assert: color1 equals: color2;
		deny: (color1 = color3).

]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 01:29'
}
CARGBTest >> testInstantiation [
	| color |
	color := CARGB r: 0 g: 0 b: 0.
	self assert: color notNil;
		assert: (color red = 0);
		assert: (color green = 0);
		assert: (color blue = 0).
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 01:29'
}
CARGBTest >> testMorphicColorExport [
	| cargbYellow cargbGreen cargbCyan cargbDifferent cargbNotGreen |
	cargbYellow := CARGB yellow.
	cargbGreen := CARGB r: 0 g: 255 b: 0.
	cargbCyan := CARGB r: 0 g: 255 b: 255.
	cargbDifferent := CARGB r: 1 g: 2 b: 3.
	cargbNotGreen := CARGB r: 255 g: 0 b: 0.
	
	self assert: cargbYellow morphicColor = Color yellow;
		assert: cargbGreen morphicColor = Color green;
		assert: cargbCyan morphicColor = Color cyan;
		deny: cargbNotGreen morphicColor = Color green;
		deny: cargbDifferent morphicColor = Color green.
]

{
	#category : #running,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 01:33'
}
CARGBTest >> testMorphicColorImport [
	| squeakColor cargbColor |
	squeakColor := Color r: 0.5 g: 0.75 b: 0.25.
	cargbColor := CARGB newFrom: squeakColor.
	
	self assert: (cargbColor red = (CARGB chanelTo8Bit: squeakColor red)).
	self assert: (cargbColor green = (CARGB chanelTo8Bit: squeakColor green));
		assert: (cargbColor blue = (CARGB chanelTo8Bit: squeakColor blue)).
	
	"Check edge cases"
	squeakColor := Color r: 0.0 g: 0.0 b: 0.0.
	cargbColor := CARGB newFrom: squeakColor.
	self assert: (cargbColor red = 0);
		assert: (cargbColor green = 0);
		assert: (cargbColor blue = 0).
	
	squeakColor := Color r: 1.0 g: 1.0 b: 1.0.
	cargbColor := CARGB newFrom: squeakColor.
	self assert: (cargbColor red = 255);
		assert: (cargbColor green = 255);
		assert: (cargbColor blue = 255).
]
