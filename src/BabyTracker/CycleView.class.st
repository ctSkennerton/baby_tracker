Class {
	#name : #CycleView,
	#superclass : #WAComponent,
	#instVars : [
		'cycles',
		'summary'
	],
	#category : #BabyTracker
}

{ #category : #'as yet unclassified' }
CycleView >> calculateCycles [

	| prev |
	prev := nil.
	cycles := OrderedCollection new.
	cycles add: OrderedCollection new.
	BabyEvent storedInstances do: [ :each | 
		prev ifNotNil: [ 
			(each isKindOf: SleepBabyEvent) ifTrue: [ "This could be the start of a new cycle"
				(prev isKindOf: SleepBabyEvent)
					ifTrue: [ 
						each startTime - prev endTime >= 15 minutes ifTrue: [ "start of a new cycle" 
							cycles add: OrderedCollection new ] ]
					ifFalse: [ "start of a new cycle" 
					cycles add: OrderedCollection new ] ] ].
		cycles last add: each.
		prev := each ]
]

{ #category : #'as yet unclassified' }
CycleView >> cyclesByCalendarDay [

	^ self groupedBy: [ :events | events first startTime asDate ]
]

{ #category : #enumerating }
CycleView >> groupedBy: aBlock [

	^ cycles groupedBy: aBlock
]

{ #category : #initialization }
CycleView >> initialize [

	super initialize.
	cycles := OrderedCollection new.
	summary := Dictionary new
]

{ #category : #rendering }
CycleView >> renderContentOn: html [

	| cyclesPerDay |
	self calculateCycles.

	cyclesPerDay := self cyclesByCalendarDay.

	(cyclesPerDay keys sort: [ :a :b | a > b ]) do: [ :day | 
		html div
		class: 'row';
		with: [ 
			html div
				class: 'column';
				with: [ self
			renderCycleOn: html
			ForDay: day
			WithCycles: (cyclesPerDay at: day)] ].
		 ]
]

{ #category : #rendering }
CycleView >> renderCycleOn: html ForDay: day WithCycles: dayCycles [

	| cycleCount |
	html heading
		level: 3;
		with: day.
	html div
		class: 'table-responsive';
		with: [ 
			html table
				class: 'table';
				with: [ 
					html tableHead: [ 
							html tableRow: [ 
									html tableData: 'Cycle'.
									html tableData: 'Start'.
									html tableData: 'End'.
									html tableData: 'Sleep'.
									html tableData: 'Formula'.
									html tableData: 'Breast Milk'.
									html tableData: 'Pee'.
									html tableData: 'Mixed'.
									html tableData: 'Poop' ] ].
					cycleCount := dayCycles size + 1.
					dayCycles reverseDo: [ :cycle | 
							| cycleSummary |
							cycleCount := cycleCount - 1.
							cycleSummary := self summarizeCycle: cycle.
							html tableRow: [ 
									html tableData: cycleCount.
									html tableData: (cycleSummary at: 'Start') bt_printShort.
									html tableData: (cycleSummary at: 'End') bt_printShort.
									html tableData:
											(cycleSummary at: 'Sleep') bt_printHoursMinutesString.
									html tableData: ((cycleSummary at: 'Formula') round: 2).
									html tableData: ((cycleSummary at: 'Breast Milk') round: 2).
									html tableData: (cycleSummary at: 'Pee').
									html tableData: (cycleSummary at: 'Mixed').
									html tableData: (cycleSummary at: 'Poop') ] ] ] ]
]

{ #category : #'as yet unclassified' }
CycleView >> summarizeCycle: anCollectionOfEvents [

	| inner |
	inner := Dictionary new.
	inner at: 'Start' put: anCollectionOfEvents first startTime.
	inner at: 'End' put: ((anCollectionOfEvents last isKindOf: DurationBabyEvent) ifTrue: [ anCollectionOfEvents last endTime ] ifFalse: [anCollectionOfEvents last startTime]).
	inner at: 'Sleep' put: 0 asDuration.
	inner at: 'Formula' put: 0.
	inner at: 'Breast Milk' put: 0.
	inner at: 'Pee' put: 0.
	inner at: 'Poop' put: 0.
	inner at: 'Mixed' put: 0.
	anCollectionOfEvents do: [ :event | 
		(event isKindOf: SleepBabyEvent) ifTrue: [ 
			event endTime ifNotNil: [ 
				inner
					at: 'Sleep'
					put: (inner at: 'Sleep') + (event endTime - event startTime) ] ].

		(event isKindOf: BottleEvent) ifTrue: [ 
			event bottleType = 'Formula'
				ifTrue: [ 
				inner
					at: 'Formula'
					put: (inner at: 'Formula') + event bottleAmount ]
				ifFalse: [ 
					inner
						at: 'Breast Milk'
						put: (inner at: 'Breast Milk') + event bottleAmount ] ].

		(event isKindOf: WetDiaperEvent) ifTrue: [ 
			inner at: 'Pee' put: (inner at: 'Pee') + 1 ].

		(event isKindOf: MixedDiaperEvent) ifTrue: [ 
			inner at: 'Mixed' put: (inner at: 'Mixed') + 1 ].

		(event isKindOf: WetDiaperEvent) ifTrue: [ 
			inner at: 'Poop' put: (inner at: 'Poop') + 1 ] ].

	^ inner
]

{ #category : #'as yet unclassified' }
CycleView >> summarizeCycles [

	cycles keysAndValuesDo: [ :cycle :events | 
		| inner |
		inner := summary at: cycle put: Dictionary new.
		inner at: 'Sleep' put: 0 asDuration .
		inner at: 'Formula' put: 0.
		inner at: 'Breast Milk' put: 0.
		inner at: 'Pee' put: 0.
		inner at: 'Poop' put: 0.
		inner at: 'Mixed' put: 0.
		events do: [ :event | 
			(event isKindOf: SleepBabyEvent) ifTrue: [ 
				event endTime ifNotNil: [  
				inner
					at: 'Sleep'
					put: (inner at: 'Sleep') + (event endTime - event startTime) ]].

			(event isKindOf: BottleEvent) ifTrue: [ 
				event bottleType = 'Formula'
					ifTrue: [ 
					inner
						at: 'Formula'
						put: (inner at: 'Formula') + event bottleAmount ]
					ifFalse: [ 
						inner
							at: 'Breast Milk'
							put: (inner at: 'Breast Milk') + event bottleAmount ] ].

			(event isKindOf: WetDiaperEvent) ifTrue: [ 
				inner at: 'Pee' put: (inner at: 'Pee') + 1 ].

			(event isKindOf: MixedDiaperEvent) ifTrue: [ 
				inner at: 'Mixed' put: (inner at: 'Mixed') + 1 ].

			(event isKindOf: WetDiaperEvent) ifTrue: [ 
				inner at: 'Poop' put: (inner at: 'Poop') + 1 ] ] ]
]
