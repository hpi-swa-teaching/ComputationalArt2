Class {
	#name : #CAToolContainer,
	#superclass : #Morph,
	#instVars : [
		'caWindow',
		'contextRow',
		'primaryColorButton',
		'previousToolClass',
		'secondaryColorButton',
		'activeButton',
		'toolRow'
	],
	#category : #ComputationalArt2
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/29/2024 19:36'
}
CAToolContainer class >> create: aCAWindow [
	
	| toolContainer contextRow toolRow secondaryColorButton primaryColorButton primaryColorForm secondaryColorForm |
	toolContainer := CAToolContainer new.
	toolContainer caWindow: aCAWindow.
	
	toolRow := CAWindow createHBox.
	toolRow color: CAWindow uiDarkerBackground.
	
	contextRow := CAWindow createHBox.
	contextRow color: CAWindow uiDarkerBackground.
	
	{CARedoFeature. CAUndoFeature.} do: [:Tool | | b |
		b := Tool createFeatureButton: aCAWindow.
		b name: Tool featureName.
		contextRow addMorph: b.].
	contextRow addMorph: CAWindow createHSpaceFiller.
	
	toolContainer contextRow: contextRow.
	toolContainer addMorph: (CAVSpace new dpiHeight: CAWindow uiSpacing).
	toolContainer toolRow: toolRow.
	
	secondaryColorForm := Form extent: 1@1 depth: 32.
	secondaryColorForm fillColor: aCAWindow secondaryColor morphicColor.
	secondaryColorButton := CAIconButton newFrom: secondaryColorForm onClick: [ | colorPicker |
		colorPicker := CAColorPickerWindow create.
		colorPicker startColor: aCAWindow secondaryColor.
		colorPicker onAccept: [:aCARGB |
			aCAWindow secondaryColor: aCARGB.].] ballonText: 'Secondary Color'.
	toolContainer secondaryColorButton: secondaryColorButton.
	toolRow addMorph: secondaryColorButton.
	
	primaryColorForm := Form extent: 1@1 depth: 32.
	primaryColorForm fillColor: aCAWindow primaryColor morphicColor.
	primaryColorButton := CAIconButton newFrom: primaryColorForm onClick: [ | colorPicker |
		colorPicker := CAColorPickerWindow create.
		colorPicker startColor: aCAWindow primaryColor.
		colorPicker onAccept: [:aCARGB |
			aCAWindow primaryColor: aCARGB.].] ballonText: 'Primary Color'.
	toolContainer primaryColorButton: primaryColorButton.
	toolRow addMorph: primaryColorButton.
	
	toolRow addMorph: CAWindow createHSpaceFiller.
	
	{CAResetCanvasTool. CAFloodFillTool. CACircleTool. CARectangleTool. CALineTool. CAPenTool. CAMoveTool.} do: [:Tool | | b |
		b := Tool createToolButton: toolContainer.
		b name: Tool toolName.
		toolRow addMorph: b.].
	
	toolContainer setActiveClass: CAMoveTool.
	^toolContainer.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/11/2024 23:39'
}
CAToolContainer >> caWindow: aCAWindow [
	caWindow := aCAWindow.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/11/2024 23:39'
}
CAToolContainer >> contextRow: aMorph [
	contextRow := aMorph.
	self addMorph: aMorph.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/5/2024 17:35'
}
CAToolContainer >> initialize [
	super initialize.
	self extent: 0@0;
		color: Color transparent;
		layoutPolicy: TableLayout new;
		vResizing: #shrinkWrap;
		hResizing: #spaceFill;
		listDirection: #topToBottom;
		wrapCentering: #center;
		layoutInset: 0;
		cellInset: 0;
		borderWidth: 0.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/11/2024 23:39'
}
CAToolContainer >> primaryColorButton: aCAImageButton [
	primaryColorButton := aCAImageButton.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/29/2024 19:33'
}
CAToolContainer >> primaryRGB: aCARGB [
	primaryColorButton baseForm fillColor: aCARGB morphicColor.
	primaryColorButton updateDisplayIcon.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/11/2024 23:39'
}
CAToolContainer >> revertToPreviousActiveClass [
	self setActiveClass: previousToolClass.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/11/2024 23:40'
}
CAToolContainer >> secondaryColorButton: aCAImageButton [
	secondaryColorButton := aCAImageButton.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/29/2024 19:34'
}
CAToolContainer >> secondaryRGB: aCARGB [
	secondaryColorButton baseForm fillColor: aCARGB morphicColor.
	secondaryColorButton updateDisplayIcon.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/11/2024 23:40'
}
CAToolContainer >> setActiveButton: aCAToolButton [
	activeButton isNil ifFalse: [activeButton active: false].
	activeButton := aCAToolButton.
	activeButton active: true.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/11/2024 23:40'
}
CAToolContainer >> setActiveClass: aCACanvasToolClass [
	| contextBox newContextBox |
	self setActiveButton: (toolRow submorphNamed: aCACanvasToolClass toolName).
	caWindow activeTool: aCACanvasToolClass new.
	contextBox := contextRow submorphNamed: 'contextBox'.
	newContextBox := aCACanvasToolClass createContextBox: caWindow.
	newContextBox name: 'contextBox'.
	contextBox isNil ifTrue: [contextRow addMorph: newContextBox.]
		ifFalse: [contextRow replaceSubmorph: contextBox by: newContextBox.].

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/27/2024 17:41'
}
CAToolContainer >> setActiveClassTemporary: aCAToolClass [
	previousToolClass := caWindow activeTool class.
	self setActiveClass: aCAToolClass.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 14:05'
}
CAToolContainer >> toolRow: aMorph [
	toolRow := aMorph.
	self addMorph: aMorph.
]
