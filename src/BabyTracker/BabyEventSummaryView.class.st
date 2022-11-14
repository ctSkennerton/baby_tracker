Class {
	#name : #BabyEventSummaryView,
	#superclass : #WAComponent,
	#category : #BabyTracker
}

{ #category : #rendering }
BabyEventSummaryView >> renderContentOn: html [

	"A summary table of baby events"

	html table: [ 
		html tableRow: [ 
			html tableHeading: ''.
			html tableHeading: '1 day'.
			html tableHeading: '7 days'.
			html tableHeading: '14 days'.
			html tableHeading: '28 days' ].
		html tableRow: [ 
			html tableHeading: 'Sleeping'.
			html tableData: ''.
			html tableData: ''.
			html tableData: ''.
			html tableData: '' ].
		html tableRow: [ 
			html tableHeading: 'Daiper Changes'.
			html tableData: ''.
			html tableData: ''.
			html tableData: ''.
			html tableData: '' ].
		html tableRow: [ 
			html tableHeading: 'Eating'.
			html tableData: ''.
			html tableData: ''.
			html tableData: ''.
			html tableData: '' ] ]
]
