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
	#'squeak_changestamp' : 'Tyron Franzke 6/27/2024 02:08'
}
CAExportFeature class >> saveCanvasPropertiesToFile: aDirectory fileName: aFileName window: aCAWindow [
	| out container properties canvasForm |
  
	out := FileStream forceNewFileNamed: (aDirectory pathName, '/', aFileName).
	container := aCAWindow canvasContainer.
	properties := {
		'script_text'->aCAWindow scriptField text.
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
	"Ensure the filename ends with '.compArt'"
	^ (aFileName endsWith: '.compArt')
		ifTrue: [aFileName]
		ifFalse: [aFileName, '.compArt'].
]
