Class {
	#name : #BabyEventListView,
	#superclass : #WAComponent,
	#instVars : [
		'babyEvent'
	],
	#category : #BabyTracker
}

{ #category : #adding }
BabyEventListView >> addEvent [

	| type timestamp |
	type := self request: 'Type'.
	timestamp := self request: 'When'.
	BabyEvent type: type atTime: timestamp.
]

{ #category : #adding }
BabyEventListView >> addEventType: aTypeName [

		BabyEvent type: aTypeName atTime: DateAndTime now
]

{ #category : #removing }
BabyEventListView >> editEvent: aBabyEvent [

	self call: (BabyEventView new 
        babyEvent:  aBabyEvent;
        yourself)
]

{ #category : #initialization }
BabyEventListView >> initialize [

	super initialize.

]

{ #category : #removing }
BabyEventListView >> removeEvent: aBabyEvent [

	BabyEvent removeEvent: aBabyEvent
]

{ #category : #rendering }
BabyEventListView >> renderContentOn: html [


		html unorderedList: [ 
			BabyEvent events do: [ :event | 
				html listItem: [ self renderEvent: event on: html ] ] ]
]

{ #category : #rendering }
BabyEventListView >> renderEvent: aBabyEvent on: html [

	html render: aBabyEvent.
	"render: aBabyEvent type;
		render: ' @ ';
		render: aBabyEvent startTime monthAbbreviation , ' '
			, aBabyEvent startTime dayOfMonth asString , ' '
			, aBabyEvent startTime hour12 asString , ':'
			, aBabyEvent startTime minutes asString , ' '
			, aBabyEvent startTime meridianAbbreviation.
	aBabyEvent endTime ifNotNil: [ 
		html
			render: ' - ';
			render: aBabyEvent endTime monthAbbreviation , ' '
				, aBabyEvent endTime dayOfMonth asString , ' '
				, aBabyEvent endTime hour12 asString , ':'
				, aBabyEvent endTime minutes asString , ' '
				, aBabyEvent endTime meridianAbbreviation ]."
	html text: ' ('.
	html anchor
		callback: [ self editEvent: aBabyEvent ];
		with: 'edit'.
	html space.
	html anchor
		callback: [ self removeEvent: aBabyEvent ];
		with: 'remove'.
	html text: ')'
]

{ #category : #updating }
BabyEventListView >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.
	anHtmlRoot stylesheet url: 'https://unpkg.com/mvp.css@1.12/mvp.css'.
	"anHtmlRoot stylesheet url:
		'https://cdnjs.cloudflare.com/ajax/libs/milligram/1.4.1/milligram.css'"
]
