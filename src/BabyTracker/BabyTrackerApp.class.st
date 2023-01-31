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
	views at: 'Summary' put: SummaryView new.
	views at: 'Pumps' put: PumpingView new.
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
BabyTrackerApp >> renderNavItemOn: html with: withBlock callback: callbackBlock [

	html listItem
		class: 'nav-item';
		with: [ 
			html anchor
				class: 'nav-link';
				callback: callbackBlock;
				with: withBlock ]
]

{ #category : #rendering }
BabyTrackerApp >> renderNavOn: html [

	| tmpBaby |
	html navigation
		class: 'navbar navbar-expand-lg';
		with: [ 
			html div
				class: 'container-fluid';
				with: [ 
					self baby
						ifNil: [ 
							html anchor
								class: 'navbar-brand';
								callback: [ 
									tmpBaby := self call: BabyView new yourself.
									self baby: tmpBaby ];
								with: 'Add Baby' ]
						ifNotNil: [ 
							html anchor
								class: 'navbar-brand';
								callback: [ 
									tmpBaby := self call: (BabyView new
												            baby: self baby;
												            yourself).
									self baby: tmpBaby ];
								with: self baby name.
							html button
								class: 'navbar-toggler';
								attributeAt: 'data-bs-toggle' put: 'collapse';
								attributeAt: 'data-bs-target' put: '#navbarNav';
								attributeAt: 'aria-controls' put: 'navbarNav';
								attributeAt: 'aria-expanded' put: false;
								attributeAt: 'aria-label' put: 'Toggle navigation';
								with: [ html span class: 'navbar-toggler-icon' ].
							html div
								class: 'collapse navbar-collapse';
								id: 'navbarNav';
								with: [ 
									html unorderedList
										class: 'navbar-nav';
										with: [ 
											self
												renderNavItemOn: html
												with: 'Events'
												callback: [ self showEvents ].
											self
												renderNavItemOn: html
												with: 'Measurements'
												callback: [ self showMeasurements ].

											self
												renderNavItemOn: html
												with: 'Pumps'
												callback: [ self showPumps ].
											
											self renderNavItemOn: html with: 'Summary' callback: [ self showSummary  ].
] ] ] ] ]
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
BabyTrackerApp >> showPumps [

	self currentView: 'Pumps'
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
