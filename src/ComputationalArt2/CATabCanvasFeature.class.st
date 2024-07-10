Class {
	#name : #CATabCanvasFeature,
	#superclass : #CATabFeature,
	#category : #ComputationalArt2
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 21:33'
}
CATabCanvasFeature class >> createFeatureButton: aCAWindow [
	button := CAIconButton newFeatureButton: self onClick: [self executeFeature: aCAWindow.
		(aCAWindow menuRow submorphNamed: CATabCanvasFeature featureName) active: true.
		(aCAWindow menuRow submorphNamed: CATabInitalizeFeature featureName) active: false. ].
	button name: self featureName.
	^button.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 13:34'
}
CATabCanvasFeature class >> featureName [
	^'Canvas Script'.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 12:55'
}
CATabCanvasFeature class >> tabName [
	^ 'canvas'.
]
