"
CACheckbox is a UI element that represents a checkbox with an icon.
"
Class {
	#name : #CACheckbox,
	#superclass : #CAIconButton,
	#category : #'ComputationalArt2-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/8/2024 22:24'
}
CACheckbox >> initialize [
	super initialize.
	self color: self class defaultColor;
		displayImageMorph:ImageMorph new;
		iconWidth: CAWindow uiIconCheckboxWidth;
		padding: CAWindow uiIconCheckboxPadding;
		baseForm: ((GitAssetLoader for: 'ComputationalArt2') loadImageMorph: 'assets\img\tools\Check.png') form;
		borderWidth: 1;
		borderColor: Color black;
		updateSize.
	displayIcon visible: false.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/7/2024 00:33'
}
CACheckbox >> isChecked [
	^active.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/7/2024 01:15'
}
CACheckbox >> mouseUp: anEvent [
	pressed := false.
	anEvent position = mouseDownPosition ifTrue: [
		active := active not.
		onClickBlock value.].
	self updateColor.
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/7/2024 00:31'
}
CACheckbox >> updateColor [
	super updateColor.
	displayIcon visible: active.
]
