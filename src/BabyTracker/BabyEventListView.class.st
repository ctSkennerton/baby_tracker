Class {
	#name : #BabyEventListView,
	#superclass : #WAComponent,
	#instVars : [
		'babyEvent',
		'napping'
	],
	#category : #BabyTracker
}

{ #category : #initialization }
BabyEventListView class >> initialize [

	WAAdmin register: self asApplicationAt: 'events'
]

{ #category : #adding }
BabyEventListView >> addEvent [
	| type timestamp |
	type := self request: 'Type'.
	timestamp := self request: 'When'.
	BabyEvent addEvent: (BabyEvent type: type atTime: timestamp ).
]

{ #category : #adding }
BabyEventListView >> addEventType: aTypeName [

	BabyEvent addEvent: (BabyEvent type: aTypeName atTime: DateAndTime now)
]

{ #category : #accessing }
BabyEventListView >> lastBabyEvent [

	^ BabyEvent events last
]

{ #category : #accessing }
BabyEventListView >> napping [

	^ napping ifNil: [ napping := false ]
]

{ #category : #accessing }
BabyEventListView >> napping: anObject [

	napping := anObject
]

{ #category : #removing }
BabyEventListView >> removeEvent: aBabyEvent [

	BabyEvent removeEvent: aBabyEvent
]

{ #category : #rendering }
BabyEventListView >> renderButtonBar: html [

	html header with: [ 
		html heading: 'Events'.
		self napping
			ifTrue: [ self renderWakeButton: html ]
			ifFalse: [ 
				self renderLinkButton: html label: 'Eat'.
				self renderLinkButton: html label: 'Poop'.
				self renderLinkButton: html label: 'Daiper Change'.
				self renderSleepButton: html ] ]
]

{ #category : #rendering }
BabyEventListView >> renderContentOn: html [

	html main: [ 
		self renderButtonBar: html.
		html unorderedList: [ 
			BabyEvent events do: [ :event | 
				html listItem: [ self renderEvent: event on: html ] ] ] ]
]

{ #category : #rendering }
BabyEventListView >> renderEvent: aBabyEvent on: html [

	html
		render: aBabyEvent type;
		render: ' @ ';
		render: aBabyEvent startTime monthAbbreviation , ' '
			, aBabyEvent startTime dayOfMonth asString , ' '
			, aBabyEvent startTime hour12 asString , ':'
			, aBabyEvent startTime minutes asString , ' '
			, aBabyEvent startTime meridianAbbreviation.
	aBabyEvent endTime ifNotNil: [  
		html render: ' - ';
		render: aBabyEvent endTime monthAbbreviation , ' '
			, aBabyEvent endTime dayOfMonth asString , ' '
			, aBabyEvent endTime hour12 asString , ':'
			, aBabyEvent endTime minutes asString , ' '
			, aBabyEvent endTime meridianAbbreviation].
	html text: ' ('.
	html anchor
		callback: [ self removeEvent: aBabyEvent ];
		with: 'remove'.
	html text: ')'
]

{ #category : #rendering }
BabyEventListView >> renderLinkButton: html label: aString [

	html anchor
		attributeAt: 'role' put: 'button';
		callback: [ self addEventType: aString ];
		with: [html strong with: aString]
]

{ #category : #rendering }
BabyEventListView >> renderSleepButton: html [

	^ html anchor
		  callback: [ 
			  self addEventType: 'Sleep'.
			  self napping: true ];
		  with: [ html strong with: 'Sleep' ]
]

{ #category : #rendering }
BabyEventListView >> renderWakeButton: html [

	^ html anchor
		  attributeAt: 'role' put: 'button';
		  callback: [ 
			  self lastBabyEvent endTime: DateAndTime now.

			  self napping: false ];
		  with: [ html strong with: 'Wake' ]
]

{ #category : #updating }
BabyEventListView >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.
	anHtmlRoot stylesheet url: 'https://unpkg.com/mvp.css@1.12/mvp.css'.
	"anHtmlRoot stylesheet url:
		'https://cdnjs.cloudflare.com/ajax/libs/milligram/1.4.1/milligram.css'"
]
