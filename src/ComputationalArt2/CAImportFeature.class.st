Class {
	#name : #CAImportFeature,
	#superclass : #CAClickableFeature,
	#category : #ComputationalArt2
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/27/2024 02:14'
}
CAImportFeature class >> applyDictionaryToWindow: aWindow from: aDictString [
	"Applies dictionary values to the specified window"
	| d container |
	d := Compiler evaluate: aDictString.
	container := aWindow canvasContainer.
	aWindow scriptField setText: (d at: 'script_text').
	aWindow primaryColor: (d at: 'primary_color');
		secondaryColor: (d at: 'secondary_color').
	
	container canvasScale: (d at: 'canvas_scale');
		canvasOffset: (d at: 'canvas_offset').
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/27/2024 02:12'
}
CAImportFeature class >> deserializeFormFromString: aFormString [
	"Deserializes the Form from the string"
	^ Compiler evaluate: aFormString.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/27/2024 02:00'
}
CAImportFeature class >> executeFeature: aCAWindow [
	| stream dictString formString loadedForm fileContents separatorIndex |
	
	stream := self openImageFileChooser.
	
	stream ifNotNil: [
		fileContents := stream upToEnd.
    		separatorIndex := fileContents indexOfSubCollection: '---spacer---'.
		
		dictString := self extractDictionaryStringFrom: fileContents separatorIndex: separatorIndex.
		formString := self extractFormStringFrom: fileContents separatorIndex: separatorIndex.
 	       
		self applyDictionaryToWindow: aCAWindow from: dictString.
		loadedForm := self deserializeFormFromString: formString.
		self updateCanvasWithLoadedForm: loadedForm in: aCAWindow.
	].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/27/2024 01:58'
}
CAImportFeature class >> extractDictionaryStringFrom: fileContents separatorIndex: separatorIndex [
	"Extracts the form string from the stream"
	^ fileContents copyFrom: 1 to: separatorIndex - 1.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/27/2024 01:56'
}
CAImportFeature class >> extractFormStringFrom: fileContents separatorIndex: separatorIndex [
	"Extracts the form string from the stream"
	^ fileContents copyFrom: separatorIndex + 12 to: fileContents size.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:33'
}
CAImportFeature class >> featureName [
	^'Import'.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/27/2024 01:52'
}
CAImportFeature class >> openImageFileChooser [
	"Opens a file chooser for selecting an image file"
	| fc |
	fc := FileChooser new.
	fc initializeAsSystemWindowWithCaptionPane.
	fc setCaption: 'Select an image file.' translated.
	^ fc open
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 6/27/2024 01:49'
}
CAImportFeature class >> updateCanvasWithLoadedForm: aForm in: aWindow [
    "Updates the canvas with the loaded Form"
    aWindow canvasContainer canvas
        resize: aForm width height: aForm height;
        clearImage: aForm;
        commit.
    aWindow canvasContainer updateForm.
]
