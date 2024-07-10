"
CAPauseFeature pauses a process or simulation on the canvas.
"
Class {
	#name : #CAPauseFeature,
	#superclass : #CAClickableFeature,
	#category : #ComputationalArt2,
	#'squeak_changestamp' : 'iss 6/7/2024 11:52'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 7/10/2024 14:28'
}
CAPauseFeature class >> executeFeature: aCAWindow [
	aCAWindow isSimulating: false.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Yoan Tchorenev 6/6/2024 23:33'
}
CAPauseFeature class >> featureName [
	^'Pause'.
]
