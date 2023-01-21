Class {
	#name : #FeedingSummaryView,
	#superclass : #WAComponent,
	#category : #BabyTracker
}

{ #category : #'as yet unclassified' }
FeedingSummaryView >> dailyFeedingAmount: numberOfDays [

	| minTime sumFeedsPerDay groupedFeeds |
	minTime := self minDate: numberOfDays.
	sumFeedsPerDay := self feedsPerDay: minTime.

	groupedFeeds := Dictionary new.

	sumFeedsPerDay do: [ :each | 
		| thisDay thisType thisCount thisDayTypes |
		thisDay := each at: 1.
		thisType := each at: 2.
		thisCount := each at: 3.
		"if this day hasn't been seen before make the inner dictionary"
		thisDayTypes := groupedFeeds
			                at: thisDay
			                ifAbsentPut: [ Dictionary new ].
		thisDayTypes at: thisType put: thisCount.
		thisDayTypes
					at: 'Total'
					update: [ :currentVal | currentVal + thisCount  ]
					initial: [ thisCount ] ].
	^ groupedFeeds
]

{ #category : #'as yet unclassified' }
FeedingSummaryView >> feedsPerDay: minTime [
	"comment stating purpose of instance-side method"
	
			
	| feeds |
	feeds := BottleEvent storedInstances satisfying: [ :each | 
		          each startTime >= minTime ].
	"asLocalDate is implemented as custom ReStore translation"
	^ feeds project: [ :each | each startTime asLocalDate || each bottleType || each bottleAmount sum ].
]

{ #category : #'as yet unclassified' }
FeedingSummaryView >> minDate: numberOfDays [

	^(DateAndTime now - numberOfDays days) asDate.

]

{ #category : #rendering }
FeedingSummaryView >> renderContentOn: html [

	"A summary table of baby events"

	| feedings types sortedDays |
	types := #( 'Expressed' 'Formula' 'Total' ).
	"nested dictionary. first level keys are the days. second level keys are the types. values are the sum"
	feedings := self dailyFeedingAmount: 6. "This is the last 7 days as we count the current day"
	sortedDays := feedings keys sort: [ :k1 :k2 | k1 < k2 ].
	html heading
		level: 3;
		with: 'Feeding Summary'.
	html table class: 'table'; with: [ 
		html tableRow: [ 
			html tableHeading: ''.
			sortedDays do: [ :day | html tableHeading: day ] ].
		types do: [ :feedType | 
			html tableRow: [ 
				html tableHeading: (feedType = ''
						 ifTrue: [ 'Unknown' ]
						 ifFalse: [ feedType ]).
				sortedDays do: [ :day | 
					html tableData:
						((feedings at: day at: feedType ifAbsent: [ 0.0 ]) round: 2) ] ] ] ]
]
