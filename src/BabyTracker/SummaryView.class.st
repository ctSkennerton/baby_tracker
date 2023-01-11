Class {
	#name : #SummaryView,
	#superclass : #WAComponent,
	#instVars : [
		'diaperSummaryView',
		'sleepSummaryView',
		'feedingSummaryView'
	],
	#category : #BabyTracker
}

{ #category : #accessing }
SummaryView >> children [

	^ { 
		  sleepSummaryView.
		  diaperSummaryView. feedingSummaryView  }
]

{ #category : #initialization }
SummaryView >> initialize [

	super initialize.
	diaperSummaryView := BabyDiaperSummaryView new.
	sleepSummaryView := BabySleepSummaryView new.
	feedingSummaryView := FeedingSummaryView new.
]

{ #category : #rendering }
SummaryView >> renderContentOn: html [

	html div
		class: 'row';
		with: [ 
			html div
				class: 'column';
				with: [ html render: diaperSummaryView ] ].
	html div
		class: 'row';
		with: [ 
			html div
				class: 'column';
				with: [ html render: feedingSummaryView  ] ].
	html div
		class: 'row';
		with: [ 
			html div
				class: 'column';
				with: [ html render: sleepSummaryView ] ]
]
