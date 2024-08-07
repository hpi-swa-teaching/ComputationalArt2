"
CAExportFeature provides functionality to export canvas properties and content to a .compArt file.
"
Class {
	#name : #CAExportFeature,
	#superclass : #CAClickableFeature,
	#category : #ComputationalArt2
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/27/2024 02:07'
}
CAExportFeature class >> executeFeature: aCAWindow [
	"I prompt the user for a filename and directory, validate the input, and then save the canvas properties to the specified file."
	| fileName directory validFileName |
	fileName := UIManager default request: 'Enter a filename (.compArt)'.
	fileName isEmpty ifTrue: [^ self].
   
	validFileName := self validateFileName: fileName.
	directory := FileList2 modalFolderSelector.
	directory ifNotNil: [
		self saveCanvasPropertiesToFile: directory fileName: validFileName window: aCAWindow.
	].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:33'
}
CAExportFeature class >> featureName [
	^'Export'.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 12:12'
}
CAExportFeature class >> saveCanvasPropertiesToFile: aDirectory fileName: aFileName window: aCAWindow [
	"I save the canvas properties and content to the specified file."
	| out container properties canvasForm |
	out := FileStream forceNewFileNamed: (aDirectory pathName, '/', aFileName).
	container := aCAWindow canvasContainer.
	properties := {
		'script_content_tabs'->aCAWindow scriptField contentTabs.
		'script_last_active_tab'->aCAWindow scriptField currentTabname.
		'canvas_scale'->container canvasScale.
		'canvas_offset'->container canvasOffset.
		'primary_color'->aCAWindow primaryColor.
		'secondary_color'->aCAWindow secondaryColor.
	} asDictionary.
    
	canvasForm := aCAWindow canvasContainer canvas form.
	properties storeOn: out.
	out nextPutAll: '---spacer---'.
	canvasForm storeOn: out.
	out close.

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/27/2024 02:06'
}
CAExportFeature class >> validateFileName: aFileName [
	"I ensure the filename ends with '.compArt'"
	^ (aFileName endsWith: '.compArt')
		ifTrue: [aFileName]
		ifFalse: [aFileName, '.compArt'].
]
