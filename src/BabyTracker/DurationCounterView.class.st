"
This is a callout for a counter that tracks the time since a value
"
Class {
	#name : #DurationCounterView,
	#superclass : #WAComponent,
	#instVars : [
		'startTime',
		'title'
	],
	#category : #BabyTracker
}

{ #category : #accessing }
DurationCounterView >> duration [

	^ DateAndTime now - self startTime
]

{ #category : #initialization }
DurationCounterView >> initialize [

	super initialize .
	startTime := DateAndTime now.
	title := ''
]

{ #category : #rendering }
DurationCounterView >> renderContentOn: html [

	"html div
		class: 'container';
		with: [ "

	html text: self title.
	html span
		id: html nextId;
		with: self duration bt_humanReadablePrintString
	"]"
]

{ #category : #accessing }
DurationCounterView >> startTime [
	^ startTime
]

{ #category : #accessing }
DurationCounterView >> startTime: aDateAndtime [

	startTime := aDateAndtime 
]

{ #category : #accessing }
DurationCounterView >> title [

	^ title
]

{ #category : #accessing }
DurationCounterView >> title: aString [

	title := aString
]
