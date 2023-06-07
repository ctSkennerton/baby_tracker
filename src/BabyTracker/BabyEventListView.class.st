"
I am a Seaside Component that renders a unordered list of `BabyEvent`.

I need a block to be given in `BabyEventListView>>#events` that returns a collection of `BabyEvent`.
For example, to get a list of 10 baby events I could be initialized like so:
```
list := BabyEventListView new events: [BabyEvent storedInstances first: 10]
```
"
Class {
	#name : #BabyEventListView,
	#superclass : #WAComponent,
	#instVars : [
		'babyEvent',
		'baby',
		'eventBlock',
		'minimumDate',
		'maximumDate'
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

{ #category : #'as yet unclassified' }
BabyEventListView >> defaultMaximumDate [

	^ Date today
]

{ #category : #'as yet unclassified' }
BabyEventListView >> defaultMinimumDate [

	^ (Date tomorrow - 7 days) asDate
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

{ #category : #accessing }
BabyEventListView >> maximumDate [

	^ maximumDate ifNil: [ maximumDate := self defaultMaximumDate  ]
]

{ #category : #accessing }
BabyEventListView >> maximumDate: aDate [

	maximumDate := aDate
]

{ #category : #accessing }
BabyEventListView >> minimumDate [

	^ minimumDate ifNil: [ minimumDate := self defaultMinimumDate  ]
]

{ #category : #accessing }
BabyEventListView >> minimumDate: aDate [

	minimumDate := aDate
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
	filteredEvents := self events select: [ :each | 
		                  each startTime >= self minimumDate
		                  & (each startTime <= ((self maximumDate + 1 days) asDate)) ]. "first: self maxNumberOfEvents."
	"babyEvents := BabyEvent storedInstances
		              sortBlock: [ :first :second | 
			              first startTime > second startTime ];
		              satisfying: [ :each | 
			              each baby = self session currentBaby ]."
	filteredEvents size >= 1
		ifTrue: [ 
			html div
				class: 'row';
				with: [ self renderTimeRangeFormOn: html ].

			prevDate := filteredEvents first startTime asDate.


			(filteredEvents groupedBy: [ :each | each startTime asDate ]) 
				keysAndValuesDo: [ :date :events | 
					html heading
						level: 3;
						with: date.
					html unorderedList: [ 
						events do: [ :event | 
							html listItem: [ self renderEvent: event on: html ] ] ] ] ]
		ifFalse: [ 
			html heading
				level: 3;
				with: 'No events yet' ]
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

{ #category : #rendering }
BabyEventListView >> renderTimeRangeFormOn: html [

	html form
		class: 'row row-cols-lg-auto g-2 align-items-center';
		with: [ 
			html div
				class: 'col-12';
				with: [ 
					html label
						class: 'visually-hidden';
						for: 'start-date';
						with: 'Start: '.
					html dateInput5
						id: 'start-date';
						class: 'form-control form-control-sm';
						attributeAt: 'step' put: '1';
						callback: [ :value | self minimumDate: value asDate ];
						value: self minimumDate yyyymmdd ].
			html div
				class: 'col-12';
				with: [ 
					html label
						class: 'visually-hidden';
						for: 'end-date';
						with: 'End: '.
					html dateInput5
						id: 'end-date';
						class: 'form-control form-control-sm';
						attributeAt: 'step' put: '1';
						callback: [ :value | self maximumDate: value asDate ];
						value: self maximumDate yyyymmdd ].
			html div
				class: 'col-12';
				with: [ "class: self defaultFormDivCssClass;"
					html submitButton
						class: 'btn btn-success btn-sm';
						"callback: [ self answer: self babyEvent ];"text: 'Show'.
					html space.
					html cancelButton
						class: 'btn btn-secondary btn-sm';
						callback: [ 
							self minimumDate: self defaultMinimumDate.
							self maximumDate: self defaultMaximumDate ];
						text: 'Reset' ] ]
]
