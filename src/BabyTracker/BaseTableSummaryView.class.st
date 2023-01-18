Class {
	#name : #BaseTableSummaryView,
	#superclass : #WAComponent,
	#category : #BabyTracker
}

{ #category : #accessing }
BaseTableSummaryView >> minDate: numberOfDays [

	^ (DateAndTime now - numberOfDays days) asDate
]

{ #category : #'as yet unclassified' }
BaseTableSummaryView >> summaryFor: aBlock [

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
