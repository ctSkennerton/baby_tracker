Class {
	#name : #BabyEventListView,
	#superclass : #WAComponent,
	#instVars : [
		'babyEvent',
		'baby',
		'eventBlock'
	],
	#category : #BabyTracker
}

{ #category : #initialization }
BabyEventListView >> baby [ 

	^ self session currentBaby
]

{ #category : #initialization }
BabyEventListView >> baby: aBaby [

	baby:= aBaby
]

{ #category : #removing }
BabyEventListView >> editEvent: aBabyEvent [

	| edited |
	edited := self call: aBabyEvent edit.

	edited ifNotNil: [ edited store ]
]

{ #category : #accessing }
BabyEventListView >> events [

	^ eventBlock value
]

{ #category : #accessing }
BabyEventListView >> events: aBlock [
	"Specify a block that returns a collection of baby events."
	eventBlock := aBlock
]

{ #category : #initialization }
BabyEventListView >> initialize [

	super initialize.

]

{ #category : #accessing }
BabyEventListView >> maxNumberOfEvents [

	"comment stating purpose of instance-side method"

	^ 60
]

{ #category : #removing }
BabyEventListView >> removeEvent: aBabyEvent [
	(self confirm: 'Are you sure that you want to remove this event?')
        ifTrue: [ aBabyEvent unstore.
	self session currentBaby refresh ]
	
]

{ #category : #rendering }
BabyEventListView >> renderContentOn: html [

	| prevDate filteredEvents |
	filteredEvents := self events first: self maxNumberOfEvents.
	"babyEvents := BabyEvent storedInstances
		              sortBlock: [ :first :second | 
			              first startTime > second startTime ];
		              satisfying: [ :each | 
			              each baby = self session currentBaby ]."

	prevDate := filteredEvents first startTime asDate.


	(filteredEvents groupedBy: [ :each | each startTime asDate ]) 
		keysAndValuesDo: [ :date :events | 
			html heading
				level: 3;
				with: date.
			html unorderedList: [ 
				events do: [ :event | 
					html listItem: [ self renderEvent: event on: html ] ] ] ]
]

{ #category : #rendering }
BabyEventListView >> renderEvent: aBabyEvent on: html [

	html render: aBabyEvent.
	html text: ' ('.
	html anchor
		callback: [ self editEvent: aBabyEvent ];
		with: 'edit'.
	html space.
	html anchor
		callback: [ self removeEvent: aBabyEvent ];
		with: 'remove'.
	html text: ')'
]
