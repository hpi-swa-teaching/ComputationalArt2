Class {
	#name : #CAColorPickerWindow,
	#superclass : #SystemWindow,
	#instVars : [
		'redTextMorph',
		'greenTextMorph',
		'blueTextMorph',
		'hueTextMorph',
		'saturationTextMorph',
		'valueTextMorph',
		'hsv',
		'onAcceptBlock'
	],
	#category : #'ComputationalArt2-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 11:48'
}
CAColorPickerWindow class >> create [
	| window |
	window := CAColorPickerWindow labelled: 'Color Picker'.
	window openInWorld.
	^window.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 21:09'
}
CAColorPickerWindow >> accept [
	onAcceptBlock value: (CARGB newFrom: hsv selectedColor).
	self delete.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 19:26'
}
CAColorPickerWindow >> colorSelected: aColor [
	redTextMorph contents: (CARGB chanelTo8Bit: aColor red) asString.
	greenTextMorph contents: (CARGB chanelTo8Bit: aColor green) asString.
	blueTextMorph contents: (CARGB chanelTo8Bit: aColor blue) asString.
	hueTextMorph contents: (CARGB chanelTo8Bit: aColor hue / 360.0) asString.
	saturationTextMorph contents: (CARGB chanelTo8Bit: aColor saturation) asString.
	valueTextMorph contents: (CARGB chanelTo8Bit: aColor brightness) asString.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 19:50'
}
CAColorPickerWindow >> initialize [
	| vBox hBox hBoxRed hBoxGreen hBoxBlue hBoxHue hBoxSaturation hBoxValue cancelButton hBoxButtons acceptButton |
	super initialize.
	self clipSubmorphs: true;
		minimumExtent: 400@400.
		
	hsv := CAHSVColorSelectorMorph new.
	hsv vResizing: #spaceFill;
		hResizing: #spaceFill;
		window: self.	
	
	redTextMorph := CAIntegerTextMorph new minValue: 0; maxValue: 255.
	redTextMorph hResizing: #spaceFill.
	redTextMorph actionBlock: [:num | hsv selectedColor: (Color r: num / 255.0 g: hsv selectedColor green b: hsv selectedColor blue).].
	
	greenTextMorph := CAIntegerTextMorph new minValue: 0; maxValue: 255.
	greenTextMorph hResizing: #spaceFill.
	greenTextMorph actionBlock: [:num | hsv selectedColor: (Color r: hsv selectedColor red g: num / 255.0 b: hsv selectedColor blue).].
	
	blueTextMorph := CAIntegerTextMorph new minValue: 0; maxValue: 255.
	blueTextMorph hResizing: #spaceFill.
	blueTextMorph actionBlock: [:num | hsv selectedColor: (Color r: hsv selectedColor red g: hsv selectedColor green b: num / 255.0).].
	
	hueTextMorph := CAIntegerTextMorph new minValue: 0; maxValue: 255.
	hueTextMorph hResizing: #spaceFill.
	hueTextMorph actionBlock: [:num | hsv selectedColor: (Color h: (num / 255.0 * 360) s: hsv selectedColor saturation v: hsv selectedColor brightness).].
	
	saturationTextMorph := CAIntegerTextMorph new minValue: 0; maxValue: 255.
	saturationTextMorph hResizing: #spaceFill.
	saturationTextMorph actionBlock: [:num | hsv selectedColor: (Color h: hsv selectedColor hue s: (num / 255.0) v: hsv selectedColor brightness).].
	
	valueTextMorph := CAIntegerTextMorph new minValue: 0; maxValue: 255.
	valueTextMorph hResizing: #spaceFill.
	valueTextMorph actionBlock: [:num | hsv selectedColor: (Color h: hsv selectedColor hue s: hsv selectedColor saturation v: (num / 255.0)).].
	
	hBoxRed := CAWindow createHBox.
	hBoxRed addMorph: redTextMorph;
		addMorph: (CAStringMorph new contents: 'Red'; hResizing: #spaceFill).
	
	hBoxGreen := CAWindow createHBox.
	hBoxGreen addMorph: greenTextMorph;
		addMorph: (CAStringMorph new contents: 'Green'; hResizing: #spaceFill).
		
	hBoxBlue := CAWindow createHBox.
	hBoxBlue addMorph: blueTextMorph;
		addMorph: (CAStringMorph new contents: 'Blue'; hResizing: #spaceFill).
	
	hBoxHue := CAWindow createHBox.
	hBoxHue addMorph: hueTextMorph;
		addMorph: (CAStringMorph new contents: 'Hue'; hResizing: #spaceFill).
	
	hBoxSaturation := CAWindow createHBox.
	hBoxSaturation addMorph: saturationTextMorph;
		addMorph: (CAStringMorph new contents: 'Saturation'; hResizing: #spaceFill).
		
	hBoxValue := CAWindow createHBox.
	hBoxValue addMorph: valueTextMorph;
		addMorph: (CAStringMorph new contents: 'Value'; hResizing: #spaceFill).
	
	cancelButton := PluggableButtonMorphPlus new.
	cancelButton label: 'Cancel';
		target: self;
		actionSelector: #delete;
		hResizing: #spaceFill.
	
	acceptButton := PluggableButtonMorphPlus new.
	acceptButton label: 'Accept';
		target: self;
		actionSelector: #accept;
		hResizing: #spaceFill.
	
	hBoxButtons := CAWindow createHBox.
	hBoxButtons addMorph: acceptButton;
		addMorph: cancelButton.
	
	vBox  := CAWindow createVBox.
	vBox hResizing: #spaceFill;
		vResizing: #spaceFill.
	vBox addMorph: hBoxButtons;
		addMorph: CAWindow createVSpaceFiller;
		addMorph: hBoxValue;
		addMorph: hBoxSaturation;
		addMorph: hBoxHue;
		addMorph: (CAStringMorph new contents: 'HSV');
		addMorph: (CAVSpace new dpiHeight: 16);
		addMorph: hBoxBlue;
		addMorph: hBoxGreen;
		addMorph: hBoxRed;
		addMorph: (CAStringMorph new contents: 'RGB').
	
	hBox := CAWindow createHBox.
	hBox addMorph: vBox;
		addMorph: (CAHSpace new dpiWidth: CAWindow uiSpacing);
		addMorph: hsv.
	
	self colorSelected: hsv selectedColor.
	self addMorph: hBox fullFrame:
		(LayoutFrame fractions: (0.0@0.0 corner: 1@1)).
		
	onAcceptBlock := [:aCARGB|].
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 20:50'
}
CAColorPickerWindow >> onAccept: aBlock [
	onAcceptBlock := aBlock.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 11:18'
}
CAColorPickerWindow >> paneColor [
	^self defaultColor.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/23/2024 19:43'
}
CAColorPickerWindow >> startColor: aCARGB [
	| morpicColor |
	morpicColor := aCARGB morphicColor.
	self colorSelected: morpicColor.
	hsv selectedColor: morpicColor.
]
