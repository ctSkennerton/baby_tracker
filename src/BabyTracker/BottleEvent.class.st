Class {
	#name : #BottleEvent,
	#superclass : #PointInTimeBabyEvent,
	#instVars : [
		'bottleAmount',
		'bottleUnit',
		'bottleType'
	],
	#category : #BabyTracker
}

{ #category : #public }
BottleEvent class >> reStoreDefinition [

	^ super reStoreDefinition
		  define: #bottleAmount as: Float;
		define: #bottleType as: String;
		define: #bottleUnit as: String;
		  yourself
]

{ #category : #displaying }
BottleEvent class >> startLabel [

	^ 'Bottle'
]

{ #category : #accessing }
BottleEvent >> bottleAmount [

	^ bottleAmount
]

{ #category : #accessing }
BottleEvent >> bottleAmount: anObject [

	bottleAmount := anObject
]

{ #category : #accessing }
BottleEvent >> bottleType [

	^ bottleType
]

{ #category : #accessing }
BottleEvent >> bottleType: anObject [

	bottleType := anObject
]

{ #category : #'as yet unclassified' }
BottleEvent >> bottleTypes [

^ #('Formula' 'Expressed')
]

{ #category : #accessing }
BottleEvent >> bottleUnit [

	^ bottleUnit
]

{ #category : #accessing }
BottleEvent >> bottleUnit: anObject [

	bottleUnit := anObject
]

{ #category : #accessing }
BottleEvent >> editView [

	"comment stating purpose of instance-side method"

	^ BottleEventView 
]

{ #category : #initialization }
BottleEvent >> initialize [ 

	"comment stating purpose of instance-side method"

	type := 'Bottle'.
	bottleType := ''.
	bottleUnit := 'fl oz'.
	bottleAmount := 0.0.
]
