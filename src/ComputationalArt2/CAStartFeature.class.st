"
CAStartFeature starts a process or simulation on the canvas.
"
Class {
	#name : #CAStartFeature,
	#superclass : #CAClickableFeature,
	#category : #ComputationalArt2,
	#'squeak_changestamp' : 'iss 6/7/2024 11:53'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 14:32'
}
CAStartFeature class >> executeFeature: aCAWindow [
	aCAWindow isSimulating: true.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:33'
}
CAStartFeature class >> featureName [
	^'Start'.
]
