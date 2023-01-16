Class {
	#name : #PumpingSummaryView,
	#superclass : #WAComponent,
	#category : #BabyTracker
}

{ #category : #'as yet unclassified' }
PumpingSummaryView >> groupedPerDay: minTime [

	"comment stating purpose of instance-side method"

	^ (BottleEvent storedInstances
		  satisfying: [ :each | each startTime >= minTime ])
		  project: [ :each | 
			  each startTime asLocalDate || each bottleType
			  || each bottleAmount sum ]
]

{ #category : #accessing }
PumpingSummaryView >> minDate: numberOfDays [

	^ (DateAndTime now - numberOfDays days) asDate
]

{ #category : #rendering }
PumpingSummaryView >> renderContentOn: html [

	"A summary table of baby events"

	| perDay types sortedDays minTime |
	types := #( 'Total' ).
	"nested dictionary. first level keys are the days. second level keys are the types. values are the sum"

	minTime := self minDate: 6.
	perDay := self summaryFor: [ 
		          (PumpEvent storedInstances satisfying: [ :each | 
			           each startTime >= minTime ]) project: [ :each | 
			          each startTime asLocalDate || 'Total'
			          || each pumpAmount sum ] ]. "This is the last 7 days as we count the current day"
	sortedDays := perDay keys sort: [ :k1 :k2 | k1 < k2 ].
	html heading
		level: 3;
		with: 'Pumping Summary'.
	html table: [ 
		html tableRow: [ 
			html tableHeading: ''.
			sortedDays do: [ :day | html tableHeading: day ] ].
		types do: [ :subType | 
			html tableRow: [ 
				html tableHeading: (subType = ''
						 ifTrue: [ 'Unknown' ]
						 ifFalse: [ subType ]).
				sortedDays do: [ :day | 
					html tableData: (perDay at: day at: subType ifAbsent: [ 0 ]) ] ] ] ]
]

{ #category : #'as yet unclassified' }
PumpingSummaryView >> summaryFor: aBlock [

	| perDay grouped |
	perDay := aBlock value.

	grouped := Dictionary new.

	perDay do: [ :each | 
		| thisDay thisType thisCount thisDayTypes |
		thisDay := each at: 1.
		thisType := each at: 2.
		thisCount := each at: 3.
		"if this day hasn't been seen before make the inner dictionary"
		thisDayTypes := grouped at: thisDay ifAbsentPut: [ Dictionary new ].
		thisDayTypes at: thisType put: thisCount.
		].
	^ grouped
]
