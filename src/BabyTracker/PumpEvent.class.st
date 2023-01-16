Class {
	#name : #PumpEvent,
	#superclass : #PointInTimeBabyEvent,
	#instVars : [
		'pumpAmount',
		'pumpUnit'
	],
	#category : #BabyTracker
}

{ #category : #public }
PumpEvent class >> reStoreDefinition [ 
^ super reStoreDefinition
		  define: #pumpAmount as: Float;
		  define: #pumpUnit as: String;
		  yourself
]

{ #category : #'as yet unclassified' }
PumpEvent class >> startLabel [

	^ 'Pump'
]

{ #category : #printing }
PumpEvent >> displayStringOn: aStream [

	aStream
		nextPutAll: self type;
		nextPutAll: ': ';
		nextPutAll: self pumpAmount asString;
		nextPutAll: ' ';
		nextPutAll: self pumpUnit;
		nextPutAll: ' @ '.
	self startTime bt_printShortOn: aStream
]

{ #category : #accessing }
PumpEvent >> editView [

	"comment stating purpose of instance-side method"

	^ PumpEventView
]

{ #category : #initialization }
PumpEvent >> initialize [

	"comment stating purpose of instance-side method"

	type := 'Pump'.

	pumpUnit := 'mL'.
	pumpAmount := 0.0
]

{ #category : #accessing }
PumpEvent >> pumpAmount [

	^ pumpAmount
]

{ #category : #accessing }
PumpEvent >> pumpAmount: anObject [

	pumpAmount := anObject
]

{ #category : #accessing }
PumpEvent >> pumpUnit [

	^ pumpUnit
]

{ #category : #accessing }
PumpEvent >> pumpUnit: anObject [

	pumpUnit := anObject
]
