"
CAClickableFeature is an abstract class that defines the behavior of clickable features in the application.
"
Class {
	#name : #CAClickableFeature,
	#superclass : #Object,
	#category : #ComputationalArt2
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:33'
}
CAClickableFeature class >> buttonForm [
	"I return the form of the button for this feature."
	^((GitAssetLoader for: 'ComputationalArt2') loadImageMorph: 'assets\img\tools\',self featureName,'.png') form.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/7/2024 00:13'
}
CAClickableFeature class >> createFeatureButton: aCAWindow [
	"I create and return a button for this feature."
	^CAIconButton newFeatureButton: self onClick: [self executeFeature: aCAWindow.].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:28'
}
CAClickableFeature class >> executeFeature: aCAWindow [
	"This method should be overridden by subclasses to execute the feature."
	^self subclassResponsibility.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:18'
}
CAClickableFeature class >> featureName [
	"I return the name of the feature and should be overwritten."
	^'Tool'.
]
