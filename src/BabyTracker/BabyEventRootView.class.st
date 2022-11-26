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

{ #category : #updating }
BabyEventRootView >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.
	anHtmlRoot stylesheet url: 'https://unpkg.com/mvp.css@1.12/mvp.css'.
	"anHtmlRoot stylesheet url:
		'https://cdnjs.cloudflare.com/ajax/libs/milligram/1.4.1/milligram.css'"
]
