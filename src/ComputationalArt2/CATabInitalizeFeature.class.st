Class {
	#name : #CATabInitalizeFeature,
	#superclass : #CATabFeature,
	#category : #ComputationalArt2
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 21:34'
}
CATabInitalizeFeature class >> createFeatureButton: aCAWindow [
	button := CAIconButton newFeatureButton: self onClick: [self executeFeature: aCAWindow.
		(aCAWindow menuRow submorphNamed: CATabCanvasFeature featureName) active: false.
		(aCAWindow menuRow submorphNamed: CATabInitalizeFeature featureName) active: true.  ].
	button name: self featureName.
	^button.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 13:20'
}
CATabInitalizeFeature class >> featureName [
	^'Initialization Script'.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 12:57'
}
CATabInitalizeFeature class >> tabName [
	^'initialize'.
]
