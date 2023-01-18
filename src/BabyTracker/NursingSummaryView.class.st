Class {
	#name : #NursingSummaryView,
	#superclass : #BaseTableSummaryView,
	#category : #BabyTracker
}

{ #category : #'as yet unclassified' }
NursingSummaryView >> partitionDurationByDay: aDurationBabyEvent [

	| startDay endDay perDay |
	startDay := aDurationBabyEvent startTime asDate.
	endDay := aDurationBabyEvent endTime asDate.
	perDay := Dictionary new.
	startDay = endDay
		ifTrue: [ 
			perDay
				at: startDay
				put: aDurationBabyEvent endTime - aDurationBabyEvent startTime ]
		ifFalse: [ 
			perDay at: startDay put: endDay - aDurationBabyEvent startTime.
			perDay at: endDay put: aDurationBabyEvent endTime - endDay ].
	^ perDay
]

{ #category : #'as yet unclassified' }
NursingSummaryView >> perDaySummary [

	| events minTime sumPerDay |
	minTime := self minDate: 6.
	events := NursingEvent storedInstances select: [ :each | 
		          each endTime >= minTime ].

	sumPerDay := OrderedCollection new.
	events do: [ :each | 
		  (self partitionDurationByDay: each) keysAndValuesDo: [ :date :val | 
			  date >= minTime ifTrue: [ 
				  sumPerDay add: { 
						  date.
						  each firstSide.
						  val } ] ] ].
			^ sumPerDay
]

{ #category : #rendering }
NursingSummaryView >> renderContentOn: html [

	"A summary table of baby events"

	| perDay types sortedDays |
	types := #( 'Left' 'Right' ).
	"nested dictionary. first level keys are the days. second level keys are the types. values are the sum"


	perDay := self summaryFor: [ self perDaySummary ]. "This is the last 7 days as we count the current day"
	sortedDays := perDay keys sort: [ :k1 :k2 | k1 < k2 ].
	html heading
		level: 3;
		with: 'Nursing Summary'.
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
					html tableData:
						(perDay at: day at: subType ifAbsent: [ 0 asDuration ])
							 ] ] ] ]
]
