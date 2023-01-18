Class {
	#name : #PumpingSummaryView,
	#superclass : #BaseTableSummaryView,
	#category : #BabyTracker
}

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
