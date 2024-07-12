"
CAIconButton is a UI element that represents a clickable button with an form icon.
"
Class {
	#name : #CAIconButton,
	#superclass : #Morph,
	#instVars : [
		'baseForm',
		'iconWidth',
		'paddingTop',
		'paddingRight',
		'paddingBottom',
		'paddingLeft',
		'displayIcon',
		'pressed',
		'hover',
		'active',
		'mouseDownPosition',
		'onClickBlock'
	],
	#category : #'ComputationalArt2-UI'
}

{
	#category : #Color,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 16:15'
}
CAIconButton class >> activeColor [
	^Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.2.
]

{
	#category : #Color,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 14:39'
}
CAIconButton class >> defaultColor [
	^Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.0.
]

{
	#category : #Color,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 16:21'
}
CAIconButton class >> hoverColor [
	^Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.05.
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 21:23'
}
CAIconButton class >> newFeatureButton: aFeatureClass onClick: aBlock [
	| button |
	button := self newFrom: aFeatureClass buttonForm
		onClick: aBlock
		ballonText: aFeatureClass featureName.
	^button.
		
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 21:22'
}
CAIconButton class >> newFrom: aForm onClick: aBlock ballonText: aString [
	"I create a new button with the given form, click action, and balloon text."
	| button |
	button := CAIconButton new.
	button color: self defaultColor.
	button displayImageMorph:ImageMorph new.
	button iconWidth: CAWindow uiIconButtonWidth.
	button padding: CAWindow uiIconButtonPadding.
	button baseForm: aForm.
	button onClick: aBlock.
	button balloonText: aString.
	button updateSize.
	^button.
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/7/2024 00:10'
}
CAIconButton class >> newToolButton: aCAToolClass conainer: aCAToolContainer [
	^self newFrom: aCAToolClass buttonForm
		onClick: [aCAToolContainer setActiveClass: aCAToolClass.]
		ballonText: aCAToolClass toolName.
]

{
	#category : #Color,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 14:40'
}
CAIconButton class >> pressedColor [
	^Color r: 0.0 g: 0.0 b: 0.0 alpha: 0.2.
]

{
	#category : #click,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 14:21'
}
CAIconButton >> active: aBoolean [
	active := aBoolean.
	self updateColor.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/29/2024 19:33'
}
CAIconButton >> baseForm [
	^baseForm.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 13:10'
}
CAIconButton >> baseForm: aForm [
	baseForm := aForm.
	self updateDisplayIcon.
]

{
	#category : #click,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 13:25'
}
CAIconButton >> beforeOnClick [
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 13:34'
}
CAIconButton >> displayImageMorph: anImageMorph [
	displayIcon := anImageMorph.
	self addMorph: displayIcon.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 13:25'
}
CAIconButton >> drawOn: aCanvas [
	super drawOn: aCanvas.
	(self iconWidthPixel = displayIcon extent x) ifFalse: [
		self updateSize.
		self updateDisplayIcon.].
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 16:24'
}
CAIconButton >> handlesMouseDown: anEvent [
	^true.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 16:07'
}
CAIconButton >> handlesMouseOver: anEvent [
	^true.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 12:14'
}
CAIconButton >> iconHeightPixel [
	"I calculate and return the height of the icon in pixels."
	| size |
	size := baseForm extent.
	^(iconWidth / ((size x asFloat) / (size y asFloat)) * Display uiScaleFactor) ceiling.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 11:41'
}
CAIconButton >> iconWidth: aNumber [
	iconWidth := aNumber.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:27'
}
CAIconButton >> iconWidthPixel [
	"I calculate and return the width of the icon in pixels."
	^(iconWidth * Display uiScaleFactor) ceiling.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 16:20'
}
CAIconButton >> initialize [
	super initialize.
	active := false.
	pressed := false.
	hover := false.
	onClickBlock := [].
]

{
	#category : #click,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 14:24'
}
CAIconButton >> mouseDown: anEvent [
	pressed := true.
	self updateColor.
	mouseDownPosition := anEvent position.
]

{
	#category : #click,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 14:19'
}
CAIconButton >> mouseEnter: anEvent [
	hover := true.
	self updateColor.
]

{
	#category : #click,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 14:19'
}
CAIconButton >> mouseLeave: anEvent [
	hover := false.
	pressed := false.
	self updateColor.
]

{
	#category : #click,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:39'
}
CAIconButton >> mouseUp: anEvent [
	pressed := false.
	self updateColor.
	anEvent position = mouseDownPosition ifTrue: [
		onClickBlock value.]
	
]

{
	#category : #click,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 15:16'
}
CAIconButton >> onClick: aBlock [
	onClickBlock := aBlock.
	
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 11:13'
}
CAIconButton >> padding: pad [
	"I set the padding of the button for all sides at the same time."
	self paddingTop: pad right: pad bottom: pad left: pad.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 11:48'
}
CAIconButton >> paddingBottomPixels [
	"I calculate and return the bottom padding in pixels."
	^(paddingBottom * Display uiScaleFactor) ceiling.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 11:48'
}
CAIconButton >> paddingLeftPixels [
	"I calculate and return the left padding in pixels."
	^(paddingLeft * Display uiScaleFactor) ceiling.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 11:49'
}
CAIconButton >> paddingRightPixels [
	"I calculate and return the right padding in pixels."
	^(paddingRight * Display uiScaleFactor) ceiling.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 10:23'
}
CAIconButton >> paddingTop: top right: right bottom: bottom left: left [
	paddingTop := top.
	paddingRight := right.
	paddingBottom := bottom.
	paddingLeft := left.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 11:49'
}
CAIconButton >> paddingTopPixels [
	"I calculate and return the top padding in pixels"
	^(paddingTop * Display uiScaleFactor) ceiling.
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 14:23'
}
CAIconButton >> updateColor [
	"I update the color of the button based on its state."
	| class |
	class := self class.
	pressed ifTrue: [
		self color: class pressedColor.]
	ifFalse: [
		active ifTrue: [
			self color: class activeColor.]
		ifFalse: [
			hover ifTrue: [self color: class hoverColor.]
			ifFalse: [self color: class defaultColor.].
			].
		].
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 13:19'
}
CAIconButton >> updateDisplayIcon [
	"I update the displayed icon based on the base form and icon width."
	displayIcon image: (baseForm magnifyBy:
		((self iconWidthPixel asFloat) / (baseForm extent x asFloat))).
]

{
	#category : #ui,
	#'squeak_changestamp' : 'Yoan Tchorenev 6/4/2024 13:35'
}
CAIconButton >> updateSize [
	"Update the size and position of the button and its icon."
	self extent: (self paddingRightPixels + self iconWidthPixel + self paddingLeftPixels)@(self paddingTopPixels + self iconHeightPixel + self paddingBottomPixels).
	displayIcon position: self position + (self paddingLeftPixels@self paddingTopPixels).
]
