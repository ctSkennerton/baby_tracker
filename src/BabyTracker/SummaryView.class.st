Class {
	#name : #SummaryView,
	#superclass : #WAComponent,
	#instVars : [
		'diaperSummaryView',
		'sleepSummaryView',
		'feedingSummaryView',
		'pumpSummaryView'
	],
	#category : #BabyTracker
}

{ #category : #accessing }
SummaryView >> children [

	^ { 
		  sleepSummaryView.
		  diaperSummaryView.
		  feedingSummaryView. pumpSummaryView }
]

{ #category : #initialization }
SummaryView >> initialize [

	super initialize.
	diaperSummaryView := BabyDiaperSummaryView new.
	sleepSummaryView := BabySleepSummaryView new.
	feedingSummaryView := FeedingSummaryView new.
	pumpSummaryView := PumpingSummaryView new.
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
				with: [ html render: feedingSummaryView ] ].
	html div
		class: 'row';
		with: [ 
			html div
				class: 'column';
				with: [ html render: pumpSummaryView ] ].
	html div
		class: 'row';
		with: [ 
			html div
				class: 'column';
				with: [ html render: sleepSummaryView ] ]
]
