Class {
	#name : #BabyEventRootView,
	#superclass : #WAComponent,
	#instVars : [
		'buttonBar',
		'events',
		'measurementsView',
		'baby'
	],
	#category : #BabyTracker
}

{ #category : #'class initialization' }
BabyEventRootView class >> initialize [

	WAAdmin register: self asApplicationAt: 'events'
]

{ #category : #accessing }
BabyEventRootView >> baby [

	^ baby ifNil: [ 
		  baby := Baby storedInstances isEmpty
			  ifTrue: [ Baby new ]
			  ifFalse: [ Baby storedInstances first ] ]
]

{ #category : #accessing }
BabyEventRootView >> baby: anObject [

	anObject store.
	baby := anObject
]

{ #category : #hooks }
BabyEventRootView >> children [

^ Array with: buttonBar with: events.
]

{ #category : #initialization }
BabyEventRootView >> initialize [

	super initialize.
	buttonBar := RecordBabyEvent new
		             baby: self baby;
		             yourself.
	events := BabyEventListView new
		          baby: self baby;
		          yourself.
	measurementsView := BabyMeasurementsView new baby: self baby; yourself.
]

{ #category : #rendering }
BabyEventRootView >> renderContentOn: html [

	self renderNavOn: html.

	html main
		class: 'container';
		with: [ 
			html div class: 'row'; with: [ 
			html div
				class: 'column';
				with: [ 
					html render: buttonBar.
					html render: events ].
			html div
				class: 'column';
				with: [ html render: measurementsView ] ]]
]

{ #category : #rendering }
BabyEventRootView >> renderNavOn: html [

	| tmpBaby |
	html navigation with: [ 
		self baby name
			ifNil: [ 
				html anchor
					callback: [ 
						tmpBaby := self call: (BabyView new
									            baby: self baby;
									            yourself).
						self baby: tmpBaby ];
					with: 'Add Baby' ]
			ifNotNil: [ html text: self baby name ] ].
]

{ #category : #updating }
BabyEventRootView >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.
	"anHtmlRoot stylesheet url: 'https://unpkg.com/mvp.css@1.12/mvp.css'"
	"anHtmlRoot stylesheet url:
		'https://unpkg.com/@picocss/pico@latest/css/pico.min.css'"
	anHtmlRoot title: 'Baby Tracker'.

	anHtmlRoot stylesheet url:
		'https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.css'.
	anHtmlRoot stylesheet url:
		'https://cdnjs.cloudflare.com/ajax/libs/milligram/1.4.1/milligram.css'.
	anHtmlRoot javascript url: 'https://cdn.plot.ly/plotly-2.4.2.min.js'
]
