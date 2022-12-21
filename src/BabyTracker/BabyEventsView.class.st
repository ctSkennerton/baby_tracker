Class {
	#name : #BabyEventsView,
	#superclass : #WAComponent,
	#instVars : [
		'buttonBar',
		'eventSummaryView',
		'eventListView'
	],
	#category : #BabyTracker
}

{ #category : #accessing }
BabyEventsView >> children [

	^ { 
		  buttonBar.
		  eventListView. eventSummaryView . }
]

{ #category : #initialization }
BabyEventsView >> initialize [

	super initialize.
	buttonBar := RecordBabyEvent new.
	eventListView := BabyEventListView new.
	eventSummaryView := BabyDiaperSummaryView new
]

{ #category : #rendering }
BabyEventsView >> renderContentOn: html [

	html main
		class: 'container';
		with: [ 
			html div class: 'row'; with: [ html render: buttonBar. ].
			html div
				class: 'row';
				with: [ 
					html div
						class: 'column';
						with: [ 
							html render: eventListView ].
					html div
						class: 'column';
						with: [ html render: eventSummaryView ] ] ]
]
