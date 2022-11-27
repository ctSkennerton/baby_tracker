Class {
	#name : #BabyEventListView,
	#superclass : #WAComponent,
	#instVars : [
		'babyEvent',
		'baby'
	],
	#category : #BabyTracker
}

{ #category : #initialization }
BabyEventListView >> baby: aBaby [

	baby:= aBaby
]

{ #category : #removing }
BabyEventListView >> editEvent: aBabyEvent [

	| edited |
	edited := self call: (BabyEventView new
			           babyEvent: aBabyEvent;
			           yourself).

	edited ifNotNil: [ edited store ]
]

{ #category : #initialization }
BabyEventListView >> initialize [

	super initialize.

]

{ #category : #removing }
BabyEventListView >> removeEvent: aBabyEvent [

	aBabyEvent unstore
]

{ #category : #rendering }
BabyEventListView >> renderContentOn: html [

	html unorderedList: [ 
		baby events sort: [ :first :second | first startTime > second startTime ]; do: [ :event | 
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
