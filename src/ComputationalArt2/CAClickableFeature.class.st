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
	^((GitAssetLoader for: 'ComputationalArt2') loadImageMorph: 'assets\img\tools\',self featureName,'.png') form.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/7/2024 00:13'
}
CAClickableFeature class >> createFeatureButton: aCAWindow [
	^CAIconButton newFeatureButton: self onClick: [self executeFeature: aCAWindow.].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:28'
}
CAClickableFeature class >> executeFeature: aCAWindow [
	^self subclassResponsibility.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/12/2024 00:18'
}
CAClickableFeature class >> featureName [
	^'Tool'.
]
