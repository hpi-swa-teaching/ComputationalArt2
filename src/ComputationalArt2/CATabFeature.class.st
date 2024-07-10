Class {
	#name : #CATabFeature,
	#superclass : #CAClickableFeature,
	#category : #ComputationalArt2
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'Tyron Franzke 7/10/2024 12:54'
}
CATabFeature class >> executeFeature: aCAWindow [
	aCAWindow scriptField switchToTab: self tabName.
]
