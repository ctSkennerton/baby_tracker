Class {
	#name : #BabyTrackerApp,
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
BabyTrackerApp class >> initialize [

	| app |
	app := WAAdmin
		       register: self
		       asApplicationAt: '/babytracker'
		       user:
		       (Smalltalk os environment
			        at: 'BABYTRACKER_USER'
			        ifAbsent: 'admin')
		       password:
		       (Smalltalk os environment
			        at: 'BABYTRACKER_PASSWORD'
			        ifAbsent: 'test').
	app preferenceAt: #sessionClass put: BabyTrackerSession
]

{ #category : #accessing }
BabyTrackerApp >> baby [

	^ self session currentBaby
]

{ #category : #accessing }
BabyTrackerApp >> baby: anObject [

	anObject store.
	baby := anObject
]

{ #category : #hooks }
BabyTrackerApp >> children [

^ Array with: buttonBar with: events.
]

{ #category : #initialization }
BabyTrackerApp >> initialize [

	super initialize.
	buttonBar := RecordBabyEvent new.
	events := BabyEventListView new.
	measurementsView := BabyMeasurementsView new

]

{ #category : #rendering }
BabyTrackerApp >> renderContentOn: html [

	self renderNavOn: html.
	
	self baby ifNotNil: [ html main
		class: 'container';
		with: [ 
			html div
				class: 'row';
				with: [ 
					html div
						class: 'column';
						with: [ 
							html render: buttonBar.
							html render: events ].
					html div
						class: 'column';
						with: [ html render: measurementsView ] ] ] ]
	
	
]

{ #category : #rendering }
BabyTrackerApp >> renderNavOn: html [

	| tmpBaby |
	html navigation with: [ 
		self baby
			ifNil: [ 
				html anchor
					callback: [ 
						tmpBaby := self call: (BabyView new
									            yourself).
						self baby: tmpBaby ];
					with: 'Add Baby' ]
			ifNotNil: [ html text: self baby name ] ]
]

{ #category : #updating }
BabyTrackerApp >> updateRoot: anHtmlRoot [

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
