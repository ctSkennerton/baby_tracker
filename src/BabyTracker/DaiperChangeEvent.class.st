Class {
	#name : #DaiperChangeEvent,
	#superclass : #PointInTimeBabyEvent,
	#instVars : [
		'daiperType'
	],
	#category : #BabyTracker
}

{ #category : #public }
DaiperChangeEvent class >> reStoreDefinition [ 

	^ super reStoreDefinition 
		define: #daiperType as: String;
		yourself
]

{ #category : #accessing }
DaiperChangeEvent >> daiperType [
	"Get the condition of the daiper"

	^ daiperType
]

{ #category : #accessing }
DaiperChangeEvent >> daiperType: aString [

	"Set the condition of the daiper: Mixed, Pee, Poop"

	daiperType := aString
]

{ #category : #initialization }
DaiperChangeEvent >> initialize [

	type := 'Daiper Change'.
	daiperType := ''
]
