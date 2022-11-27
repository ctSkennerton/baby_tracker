Class {
	#name : #RecordBabyEvent,
	#superclass : #WAComponent,
	#instVars : [
		'nursing',
		'napping',
		'baby'
	],
	#category : #BabyTracker
}

{ #category : #accessing }
RecordBabyEvent >> baby [

	^ baby
]

{ #category : #accessing }
RecordBabyEvent >> baby: anObject [

	baby := anObject
]

{ #category : #accessing }
RecordBabyEvent >> lastBabyEvent [

	^ baby events last
]

{ #category : #accessing }
RecordBabyEvent >> napping [

	^ napping ifNil: [ napping := false ]
]

{ #category : #accessing }
RecordBabyEvent >> napping: anObject [

	napping := anObject
]

{ #category : #accessing }
RecordBabyEvent >> nursing [

	^ nursing ifNil: [ nursing := false ]
]

{ #category : #accessing }
RecordBabyEvent >> nursing: aBoolean [

	nursing := aBoolean
]

{ #category : #rendering }
RecordBabyEvent >> renderContentOn: html [

	html header with: [ 
		html heading: 'Baby Tracker'.
		self napping
			ifTrue: [ self renderWakeButton: html ]
			ifFalse: [ 
				self nursing
					ifTrue: [ self renderEndFeedingButton: html ]
					ifFalse: [ 
						self renderFeedingButton: html.
						self renderLinkButton: html for: DaiperChangeEvent.
						self renderSleepButton: html ] ] ]
]

{ #category : #rendering }
RecordBabyEvent >> renderEndFeedingButton: html [

	^ html anchor
		  attributeAt: 'role' put: 'button';
		  callback: [ 
			  self lastBabyEvent endTime: DateAndTime now.
			  self lastBabyEvent store.
			  self nursing: false ];
		  with: [ html strong with: NursingEvent endLabel ]
]

{ #category : #rendering }
RecordBabyEvent >> renderFeedingButton: html [

	^ html anchor
		  attributeAt: 'role' put: 'button';
		  callback: [ 
			  self baby addEvent: (NursingEvent new startTime: DateAndTime now; yourself).
			  self nursing: true ];
		  with: [ html strong with: NursingEvent startLabel ]
]

{ #category : #rendering }
RecordBabyEvent >> renderLinkButton: html for: aBabyEventClass [

	html anchor
		attributeAt: 'role' put: 'button';
		callback: [ self baby addEvent: (aBabyEventClass new startTime: DateAndTime now; yourself) ];
		with: [ html strong with: aBabyEventClass startLabel ]
]

{ #category : #rendering }
RecordBabyEvent >> renderSleepButton: html [

	^ html anchor
		  attributeAt: 'role' put: 'button';
		  callback: [ 
			  self baby addEvent: (SleepBabyEvent new startTime: DateAndTime now; yourself).
			  self napping: true ];
		  with: [ html strong with: SleepBabyEvent startLabel ]
]

{ #category : #rendering }
RecordBabyEvent >> renderWakeButton: html [

	^ html anchor
		  attributeAt: 'role' put: 'button';
		  callback: [ 
			  self lastBabyEvent endTime: DateAndTime now.
			  self lastBabyEvent store.
			  self napping: false ];
		  with: [ html strong with: SleepBabyEvent endLabel  ]
]
