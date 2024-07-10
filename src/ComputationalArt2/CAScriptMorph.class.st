Class {
	#name : #CAScriptMorph,
	#superclass : #PluggableTextMorphPlus,
	#instVars : [
		'contentTabs',
		'currentTabname'
	],
	#category : #'ComputationalArt2-UI'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 12:17'
}
CAScriptMorph class >> create: aTabMapping defaultTab: aTabname [

	| scriptMorph |
	scriptMorph := CAScriptMorph on: nil text: nil accept: nil.
	scriptMorph contentTabs: aTabMapping defaultTab: aTabname.
	^ scriptMorph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 12:04'
}
CAScriptMorph >> content [
	^ contentTabs at: self currentTabname.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 11:35'
}
CAScriptMorph >> contentTabs [
	^ contentTabs
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 11:37'
}
CAScriptMorph >> contentTabs: aContentMapping defaultTab: aTabname [
	contentTabs := aContentMapping.
	self switchToTab: aTabname.
	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 12:04'
}
CAScriptMorph >> currentTabname [
	^ currentTabname
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 11:29'
}
CAScriptMorph >> initialize [
	contentTabs := Dictionary new.
	super initialize.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 12:49'
}
CAScriptMorph >> switchToTab: aTabname [
	contentTabs at: currentTabname put: (self text deepCopy).
	currentTabname := aTabname.
	self update.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 12:21'
}
CAScriptMorph >> update [
	self setText: self content.
]
