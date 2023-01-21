Class {
	#name : #BabyTrackerApp,
	#superclass : #WAComponent,
	#instVars : [
		'baby',
		'views',
		'currentView'
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

	^ views values.
	"^ { 
		  eventsView.
		  measurementsView }"
]

{ #category : #accessing }
BabyTrackerApp >> currentView [

	^ currentView ifNil: [ currentView := 'Events' ]
]

{ #category : #accessing }
BabyTrackerApp >> currentView: anObject [

	currentView := anObject
]

{ #category : #initialization }
BabyTrackerApp >> initialize [

	super initialize.

	views := Dictionary new.
	views at: 'Events' put: BabyEventsView new.
	views at: 'Measurements' put: BabyMeasurementsView new.
	views at: 'Summary' put: SummaryView new
]

{ #category : #rendering }
BabyTrackerApp >> renderContentOn: html [

	self renderNavOn: html.

	self baby ifNotNil: [ 
		html main
			class: 'container';
			with: [ 
				html div
					class: 'row';
					with: [ 
						html div
							class: 'column';
							with: [ html render: (views at: self currentView ) ] ] ] ] 
]

{ #category : #rendering }
BabyTrackerApp >> renderNavOn: html [

	| tmpBaby |
	html navigation
		class: 'nav';
		with: [ 
			self baby
				ifNil: [ 
					html anchor
						class: 'nav-link';
						callback: [ 
							tmpBaby := self call: BabyView new yourself.
							self baby: tmpBaby ];
						with: 'Add Baby' ]
				ifNotNil: [ 
					html anchor
						class: 'nav-link';
						callback: [ 
							tmpBaby := self call: (BabyView new
										            baby: self baby;
										            yourself).
							self baby: tmpBaby ];
						with: self baby name.
					html space.
					html anchor
						class: 'nav-link';
						callback: [ self showEvents ];
						with: 'Events'.
					html space.
					html anchor
						class: 'nav-link';
						callback: [ self showMeasurements ];
						with: 'Measurements'.
					html space.
					html anchor
					class: 'nav-link';
						callback: [ self showSummary ];
						with: 'Summary' ] ]
]

{ #category : #'as yet unclassified' }
BabyTrackerApp >> showEvents [

	self currentView: 'Events'
]

{ #category : #'as yet unclassified' }
BabyTrackerApp >> showMeasurements [

	self currentView: 'Measurements'
]

{ #category : #'as yet unclassified' }
BabyTrackerApp >> showSummary [

	self currentView: 'Summary'
]

{ #category : #updating }
BabyTrackerApp >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.
	"anHtmlRoot stylesheet url: 'https://unpkg.com/mvp.css@1.12/mvp.css'"
	"anHtmlRoot stylesheet url:
		'https://unpkg.com/@picocss/pico@latest/css/pico.min.css'"
	anHtmlRoot title: 'Baby Tracker'.
	anHtmlRoot meta
		name: 'viewport';
		content: 'width=device-width, initial-scale=1'.
		
	anHtmlRoot stylesheet url: 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css'.
	anHtmlRoot javascript url: 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js'.

	"anHtmlRoot stylesheet url:
		'https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.css'.
	anHtmlRoot stylesheet url:
		'https://cdnjs.cloudflare.com/ajax/libs/milligram/1.4.1/milligram.css'"
	"anHtmlRoot javascript url: 'https://cdn.plot.ly/plotly-2.4.2.min.js'"
]
