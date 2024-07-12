"
CAWindow is the main window of the application.
"
Class {
	#name : #CAWindow,
	#superclass : #SystemWindow,
	#instVars : [
		'activeTool',
		'canvasContainer',
		'toolFill',
		'toolStroke',
		'toolStrokeWidth',
		'primaryColor',
		'secondaryColor',
		'scriptField',
		'toolContainer',
		'simulationStep',
		'isSimulating',
		'menuRow'
	],
	#category : #ComputationalArt2
}

{
	#category : #creation,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:36'
}
CAWindow class >> create [
	^self create: true.
]

{
	#category : #creation,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:37'
}
CAWindow class >> create: aBoolean [
	"I create and return a new CAWindow instance.
	If aBoolean is true, I open the window in the world."
	| window menuHeight menuRow canvasToolVBox simButtons simVBox scriptField canvasContainer toolContainer |
	window := CAWindow labelled: 'Computational Art'.
	window activeTool: CAMoveTool new.
	window minimumExtent: 700@400.
	
	menuHeight := (self uiIconButtonPadding * 2 + self uiIconButtonWidth)  * Display uiScaleFactor.
	
	canvasContainer := CACanvasContainer newWith: window.
	window canvasContainer: canvasContainer.
	
	toolContainer := CAToolContainer create: window.
	window toolContainer: toolContainer.
	canvasToolVBox := self createVBox.
	canvasToolVBox addMorph: toolContainer.
	canvasToolVBox addMorph: (CAVSpace new dpiHeight: CAWindow uiSpacing).
	canvasToolVBox addMorph: canvasContainer.
	canvasToolVBox minimumExtent: 300@300.
	
	menuRow := self createMenu: window.
	window menuRow: menuRow.
	
	scriptField := CAScriptMorph create: {'initialize' -> '"Your initialization code"'. 'pixel'->'"Your pixel manipulation code"'. 'canvas'->'"Your canvas manipulation code"'.} asDictionary
		defaultTab: 'initialize'.
	scriptField vResizing: #spaceFill.
	scriptField hResizing: #spaceFill.
	scriptField wrapFlag: true.
	window scriptField: scriptField.
	
	simButtons := self createSimulationsButtons: window.
	simVBox := self createVBox.
	simVBox addMorph: simButtons.
	simVBox addMorph: (CAVSpace new dpiHeight: CAWindow uiSpacing).
	simVBox addMorph: scriptField.
	simVBox minimumExtent: 200@300.
	
	window addMorph: simVBox fullFrame:
		(LayoutFrame fractions: (0.6@0.0 corner: 1.0@1) offsets: (0@menuHeight extent: 0@(-1 * (menuHeight)))).
		
	window addMorph: menuRow fullFrame:
		(LayoutFrame fractions: (0.0@0.0 corner: 1.0@0.0) offsets: (0@0 extent: 0@menuHeight)).
		
 	window addMorph: canvasToolVBox fullFrame:
		(LayoutFrame fractions: (0.0@0.0 corner: 0.6@1) offsets: (0@menuHeight extent: 0@(-1 * (menuHeight)))).
	
	aBoolean ifTrue: [
		window openInWorld.
		World activeHand keyboardFocus: nil. ].
	^window.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 22:29'
}
CAWindow class >> createHBox [
	"I create and return a new horizontally aligned box."
	| hbox |
	hbox := Morph new.
	hbox extent: 0@0;
		layoutPolicy: TableLayout new;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		color: Color transparent;
		listDirection: #leftToRight;
		borderWidth: 0;
		layoutInset: 0;
		cellInset: 0.
	^hbox.
	
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/5/2024 14:18'
}
CAWindow class >> createHSpaceFiller [
	"I create and return a new horizontal space filler."
	| morph |
	morph := Morph new.
	morph color: Color transparent.
	morph extent: 0@0.
	morph hResizing: #spaceFill.
	morph vResizing: #rigid.
	^morph.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:23'
}
CAWindow class >> createMenu: aCAWindow [
	"I create and return the menu bar of the main window."
	| hBox simStepMorph |
	hBox := CAWindow createHBox.
	hBox color: CAWindow uiDarkerBackground.
	{CATabCanvasFeature. CATabInitalizeFeature.} do: [:Feature | | button |
		button := Feature createFeatureButton: aCAWindow.
		hBox addMorph: button.
		Feature = CATabInitalizeFeature ifTrue: [button active: true.].
		].

	hBox addMorph: CAWindow createHSpaceFiller.
	
	simStepMorph := CAStringMorph new contents: 'Sim Step: 0'.
	simStepMorph name: 'simStep'.
	hBox addMorph: simStepMorph.
	
	hBox addMorph: CAWindow createHSpaceFiller.
	
	{CAExportImageFeature. CAImportImageFeature. CAExportFeature. CAImportFeature. } do: [:Tool | | button |
		button := Tool createFeatureButton: aCAWindow.
		hBox addMorph: button.
		(Tool featureName = 'Reset' or: Tool featureName = 'Start') ifTrue:[
			hBox addMorph: CAWindow createHSpaceFiller.].].
		
	^hBox.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 02:23'
}
CAWindow class >> createSimulationsButtons: aCAWindow [
	"I create and return the simulation buttons."
	| hBox |
	hBox := CAWindow createHBox.
	hBox color: CAWindow uiDarkerBackground.
	{CAResetFeature. CAPauseFeature. CAStartFeature. CAStepFeature} do: [:Feature | | button |
		button := Feature createFeatureButton: aCAWindow.
		hBox addMorph: button.
		(Feature featureName = 'Reset' or: Feature featureName = 'Start') ifTrue:[
			hBox addMorph: CAWindow createHSpaceFiller.].].
	^hBox.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/7/2024 01:27'
}
CAWindow class >> createToolFillContextMorph: aCAWindow [
	"I create and return the UI element for the tool fill checkbox."
	| hBox checkBox text |
	checkBox := CACheckbox new.
	checkBox active: aCAWindow toolFill.
	checkBox onClick: [aCAWindow toolFill: checkBox isChecked.].
	
	text := CAStringMorph new.
	text contents: 'Fill:'.
	
	hBox := self createHBox.
	hBox hResizing: #shrinkWrap;
		addMorph: checkBox;
		addMorph: (CAHSpace new dpiWidth: CAWindow uiSpacing);
		addMorph: text.
	^hBox.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/8/2024 23:02'
}
CAWindow class >> createToolStrokeContextMorph: aCAWindow [
	"I create and return the UI element for the tool stroke checkbox."
	| hBox checkBox text |
	checkBox := CACheckbox new.
	checkBox active: aCAWindow toolStroke.
	checkBox onClick: [aCAWindow toolStroke: checkBox isChecked.].
	
	text := CAStringMorph new.
	text contents: 'Stroke:'.
	
	hBox := self createHBox.
	hBox hResizing: #shrinkWrap;
		addMorph: checkBox;
		addMorph: (CAHSpace new dpiWidth: CAWindow uiSpacing);
		addMorph: text.
	^hBox.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/18/2024 21:18'
}
CAWindow class >> createToolStrokeWidthContextMorph: aCAWindow [
	"I create and return the UI element for the tool stroke width input field."
	| hBox text |	
	text := CAStringMorph new.
	text contents: 'Stroke Width:'.
	
	hBox := self createHBox.
	hBox hResizing: #shrinkWrap;
		addMorph: (CAIntegerTextMorph new number: aCAWindow toolStrokeWidth;
			minValue: 1;
			maxValue: 16;
			actionBlock: [:num|aCAWindow toolStrokeWidth: num.]);
		addMorph: (CAHSpace new dpiWidth: CAWindow uiSpacing);
		addMorph: text.
	^hBox.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/5/2024 14:52'
}
CAWindow class >> createVBox [
	"I create and return a new vertically aligned box."
	| vbox |
	vbox := Morph new.
	vbox extent: 0@0;
		hResizing: #shrinkWrap;
		vResizing: #spaceFill;
		color: Color transparent;
		listDirection: #topToBottom;
		borderWidth: 0;
		layoutInset: 0;
		cellInset: 0;
		layoutPolicy: TableLayout new.
	^vbox.
	
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:23'
}
CAWindow class >> createVSpaceFiller [
	"I create and return a new vertical space filler."
	| morph |
	morph := Morph new.
	morph color: Color transparent;
		extent: 0@0;
		vResizing: #spaceFill;
		hResizing: #rigid.
	^morph.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 01:36'
}
CAWindow class >> uiBrighterBackground [
	^Color r: 1.0 g: 1.0 b: 1.0 alpha: 0.1.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/8/2024 22:56'
}
CAWindow class >> uiContextBoxSpacing [
	^12.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/5/2024 17:30'
}
CAWindow class >> uiDarkerBackground [
	^Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.1.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/5/2024 18:55'
}
CAWindow class >> uiIconButtonPadding [
	^6.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/5/2024 18:55'
}
CAWindow class >> uiIconButtonWidth [
	^16.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/7/2024 00:51'
}
CAWindow class >> uiIconCheckboxPadding [
	^3.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/7/2024 00:51'
}
CAWindow class >> uiIconCheckboxWidth [
	^10.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 00:07'
}
CAWindow class >> uiNumberInputWidth [
	^100.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/5/2024 16:17'
}
CAWindow class >> uiSpacing [
	^4.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 13:33'
}
CAWindow >> activeTool [
	^activeTool.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/2/2024 13:39'
}
CAWindow >> activeTool: aTool [
	activeTool := aTool.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:25'
}
CAWindow >> canvasContainer [
	^canvasContainer.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/5/2024 12:38'
}
CAWindow >> canvasContainer: aCanvasContainer [
	canvasContainer := aCanvasContainer.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 13:42'
}
CAWindow >> initialize [
	super initialize.
	self clipSubmorphs: true.
	toolFill := false.
	toolStroke := true.
	toolStrokeWidth := 1.
	primaryColor := CARGB black.
	secondaryColor := CARGB white.
	simulationStep := 0.
	isSimulating := false.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:25'
}
CAWindow >> isSimulating [
	^isSimulating.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:25'
}
CAWindow >> isSimulating: aBoolean [
	isSimulating := aBoolean.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:24'
}
CAWindow >> menuRow [
	^menuRow.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:24'
}
CAWindow >> menuRow: anObject [
	menuRow := anObject.
]

{
	#category : #colors,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 00:25'
}
CAWindow >> paneColor [
	^self defaultColor.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:24'
}
CAWindow >> primaryColor [
	^primaryColor.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/29/2024 19:22'
}
CAWindow >> primaryColor: aCARGB [
	primaryColor := aCARGB.
	toolContainer primaryRGB: aCARGB.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KH 6/22/2024 16:08'
}
CAWindow >> scriptField [
	^scriptField.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KH 6/22/2024 16:10'
}
CAWindow >> scriptField: aTextField [
	scriptField := aTextField.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:24'
}
CAWindow >> secondaryColor [
	^secondaryColor.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/29/2024 19:22'
}
CAWindow >> secondaryColor: aCARGB [
	secondaryColor := aCARGB.
	toolContainer secondaryRGB: aCARGB.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'HAlfil 6/23/2024 17:21'
}
CAWindow >> setActiveTool: aTool [
    activeTool := aTool.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:24'
}
CAWindow >> simulationStep [
	^simulationStep.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 21:41'
}
CAWindow >> simulationStep: aNumber [
	simulationStep := aNumber.
	(menuRow submorphNamed: 'simStep') contents: 'Sim Step: ',aNumber.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:24'
}
CAWindow >> toolContainer [
	^toolContainer.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/27/2024 17:13'
}
CAWindow >> toolContainer: aCAToolContainer [
	toolContainer := aCAToolContainer. 
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/7/2024 01:12'
}
CAWindow >> toolFill [
	^toolFill.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/7/2024 01:13'
}
CAWindow >> toolFill: aBoolean [
	toolFill := aBoolean.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/7/2024 01:13'
}
CAWindow >> toolStroke [
	^toolStroke.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/7/2024 01:13'
}
CAWindow >> toolStroke: aBoolean [
	toolStroke := aBoolean.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:24'
}
CAWindow >> toolStrokeWidth [
	^toolStrokeWidth.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/9/2024 00:44'
}
CAWindow >> toolStrokeWidth: aNumber [
	toolStrokeWidth := aNumber.
]
