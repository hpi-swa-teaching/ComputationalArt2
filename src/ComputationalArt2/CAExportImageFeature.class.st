"
CAExportImageFeature exports the canvas as an image.
"
Class {
	#name : #CAExportImageFeature,
	#superclass : #CAClickableFeature,
	#category : #ComputationalArt2,
	#'squeak_changestamp' : 'iss 6/7/2024 11:54'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/12/2024 18:53'
}
CAExportImageFeature class >> executeFeature: aCAWindow [
	"I ask the user for a filename and export the canvas of the given CAWindow as a bmp image."
	| fileName |
	fileName := UIManager default request: 'Enter a filename (.bmp)'.
	fileName size == 0 ifFalse: [ | directory validFileName |
	validFileName := (fileName endsWith: '.bmp')
		ifTrue: [ fileName ]
		ifFalse: [ fileName, '.bmp' ].
	
		directory := FileList2 modalFolderSelector.
		directory ifNotNil: [
			aCAWindow canvasContainer canvas form
				writeBMPfileNamed: directory pathName,'/',validFileName.
		]
	].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:33'
}
CAExportImageFeature class >> featureName [
	^'Export Image'.
]
