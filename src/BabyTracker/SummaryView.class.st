Class {
	#name : #SummaryView,
	#superclass : #WAComponent,
	#instVars : [
		'diaperSummaryView',
		'sleepSummaryView'
	],
	#category : #BabyTracker
}

{ #category : #accessing }
SummaryView >> children [

	^ { sleepSummaryView . diaperSummaryView  }
]

{ #category : #initialization }
SummaryView >> initialize [ 

	super initialize .
	diaperSummaryView := BabyDiaperSummaryView new.
	sleepSummaryView := BabySleepSummaryView new.
]

{ #category : #rendering }
SummaryView >> renderContentOn: html [

			html div
				class: 'row';
				with: [ 
					html div
						class: 'column';
						with: [ 
							html render: diaperSummaryView.
							html render: sleepSummaryView ] ]
]
