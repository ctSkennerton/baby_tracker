Class {
	#name : #BabyEventRootView,
	#superclass : #WAComponent,
	#instVars : [
		'buttonBar',
		'events'
	],
	#category : #BabyTracker
}

{ #category : #'class initialization' }
BabyEventRootView class >> initialize [

	WAAdmin register: self asApplicationAt: 'events'
]

{ #category : #hooks }
BabyEventRootView >> children [

^ Array with: buttonBar with: events.
]

{ #category : #initialization }
BabyEventRootView >> initialize [ 

	super initialize .
	buttonBar := RecordBabyEvent new.
	events := BabyEventListView new.
]

{ #category : #rendering }
BabyEventRootView >> renderContentOn: html [

	html main: [ 
		html render: buttonBar.
		html render: events  ]
]
