"
CAScriptMorph manages multiple code snippets in different tabs.
"
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
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 01:39'
}
CAScriptMorph class >> create: aTabMapping defaultTab: aTabname [
	| scriptMorph |
	scriptMorph := CAScriptMorph on: nil text: nil accept: nil.
	scriptMorph contentTabs: aTabMapping defaultTab: aTabname.
	^ scriptMorph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:26'
}
CAScriptMorph >> content [
	^contentTabs at: self currentTabname.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 01:39'
}
CAScriptMorph >> contentOfTab: aTabName [
	"I return the content of the specified tab."
	aTabName = self currentTabname ifTrue: [
		^self text deepCopy].
	^contentTabs at: aTabName.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:26'
}
CAScriptMorph >> contentTabs [
	^contentTabs.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 11:37'
}
CAScriptMorph >> contentTabs: aContentMapping defaultTab: aTabname [
	"I set the content of all tabs and switch to the specified default tab."
	contentTabs := aContentMapping.
	self switchToTab: aTabname.
	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:26'
}
CAScriptMorph >> currentTabname [
	^currentTabname.
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
	"I switch to the specified tab, saving the content of the current tab."
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
