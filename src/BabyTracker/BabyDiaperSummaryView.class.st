Class {
	#name : #BabyDiaperSummaryView,
	#superclass : #WAComponent,
	#category : #BabyTracker
}

{ #category : #'as yet unclassified' }
BabyDiaperSummaryView >> dailyDaiperChanges: numberOfDays [

	| groupedDaiperChanges |
	groupedDaiperChanges := Dictionary new.

	((DaiperChangeEvent storedInstances satisfying: [ :each | 
		  each startTime >= (DateAndTime now - numberOfDays days) asDate ]) 
		 project: [ :each | 
			 each daiperType || each startTime asLocalDate
			 || each daiperType count ]) do: [ :each | 
			|thisDay thisDaiperType thisDayTypes thisCount|
			thisDay := each at: 2.
			thisDaiperType := each at: 1.
			thisCount := each at: 3.
			"if this day hasn't been seen before make the inner dictionary"
			thisDayTypes := groupedDaiperChanges at: thisDay ifAbsentPut: [Dictionary new].
			thisDayTypes at: thisDaiperType put: thisCount.
		"groupedDaiperChanges
			at: (groupedDaiperChanges at: (each at: 2) ifAbsentPut: [ 
					 Dictionary new
						 at: (each at: 1) put: (each at: 3);
						 yourself ])
			at: (each at: 1)
			put: (each at: 3)" ].
	^ groupedDaiperChanges
]

{ #category : #rendering }
BabyDiaperSummaryView >> renderContentOn: html [

	"A summary table of baby events"

	| diaperChanges types sortedDays |
	types := #( 'Pee' 'Poop' 'Mixed' 'Unknown' ).
	"nested dictionary. first level keys are the days. second level keys are the types. values are the counts"
	diaperChanges := self dailyDaiperChanges: 6. "This is the last 7 days as we count the current day"
	sortedDays := diaperChanges keys sort: [ :k1 :k2 | k1 < k2 ].
	html heading
		level: 3;
		with: 'Diaper Change Summary'.
	html table class: 'table'; with: [ 
		html tableRow: [ 
			html tableHeading: ''.
			sortedDays do: [ :day | html tableHeading: day ] ].
		types do: [ :daiperType | 
			html tableRow: [ 
				html tableHeading: (daiperType = ''
						 ifTrue: [ 'Unknown' ]
						 ifFalse: [ daiperType ]).
				sortedDays do: [ :day | 
					html tableData:
						(diaperChanges at: day at: daiperType ifAbsent: [ 0 ]) ] ] ] ]
]
