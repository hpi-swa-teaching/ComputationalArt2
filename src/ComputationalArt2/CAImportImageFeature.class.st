"
CAImportImageFeature imports an image onto the canvas.
"
Class {
	#name : #CAImportImageFeature,
	#superclass : #CAClickableFeature,
	#category : #ComputationalArt2,
	#'squeak_changestamp' : 'iss 6/7/2024 11:54'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:21'
}
CAImportImageFeature class >> executeFeature: aCAWindow [
	| fc stream |
	fc := FileChooser new.
	"fc initializeAsSystemWindowWithCaptionPane."
	fc initializeAsSystemWindowWithCaptionPane;
		setCaption: 'Select an image file. (.png .gif .bmp .jpg .jpeg)' translated;
		setSuffixes: {'png' . 'gif' . 'bmp' . 'jpg' . 'jpeg' }.
	stream := fc open.
	stream ifNotNil: [ | form |
		form := (Form fromBinaryStream: stream).
		
		aCAWindow canvasContainer canvas
			resize: (form width) height: (form height);
			clearImage: form;
			commit.
			aCAWindow canvasContainer updateForm.
		].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:33'
}
CAImportImageFeature class >> featureName [
	^'Import Image'.
]
