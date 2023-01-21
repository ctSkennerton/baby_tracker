Class {
	#name : #RecordBabyEvent,
	#superclass : #WAComponent,
	#instVars : [
		'nursing',
		'napping',
		'baby',
		'currentEvent',
		'stopwatch'
	],
	#category : #BabyTracker
}

{ #category : #accessing }
RecordBabyEvent >> baby [

	^ self session currentBaby
]

{ #category : #accessing }
RecordBabyEvent >> baby: anObject [

	baby := anObject
]

{ #category : #accessing }
RecordBabyEvent >> children [

	^ { stopwatch  }
]

{ #category : #initialization }
RecordBabyEvent >> initialize [ 

	super initialize .
	stopwatch := DurationCounterView new.
]

{ #category : #accessing }
RecordBabyEvent >> mostRecentBabyEvent [

	"Baby events are sorted so the newest one is at the beginning"

	^ self baby events isEmpty
		  ifTrue: [ nil ]
		  ifFalse: [ self baby events sort: [ :first :second | first startTime > second startTime ]; first ]
]

{ #category : #accessing }
RecordBabyEvent >> napping [
	|ev |
	ev := self mostRecentBabyEvent.
	^ ev ifNil: [ false ] ifNotNil: [ (ev type = 'Sleep') and: [  
		  self mostRecentBabyEvent endTime isNil]]
]

{ #category : #accessing }
RecordBabyEvent >> napping: anObject [

	napping := anObject
]

{ #category : #accessing }
RecordBabyEvent >> nursing [

	| ev |
	ev := self mostRecentBabyEvent.
	^ ev
		  ifNil: [ false ]
		  ifNotNil: [ 
		  (ev type = 'Nursing') and:[ self mostRecentBabyEvent endTime isNil ]]
]

{ #category : #accessing }
RecordBabyEvent >> nursing: aBoolean [

	nursing := aBoolean
]

{ #category : #rendering }
RecordBabyEvent >> renderBottleButton: html [

	| bottleEvent |
	^ html anchor
		  attributeAt: 'role' put: 'button';
		  class: 'btn btn-outline-dark';
		  callback: [ 
			  | edited |
			  bottleEvent := BottleEvent new
				                 startTime: DateAndTime now;
				                 yourself.
			  edited := self call: bottleEvent edit.
			  edited ifNotNil: [ self baby addEvent: edited ] ];
		  with: [ html strong with: BottleEvent startLabel ]
]

{ #category : #rendering }
RecordBabyEvent >> renderContentOn: html [

	html div
		class: 'btn-toolbar d-grid d-md-block';
		"convert button groups to block layout at smaller screen sizes https://getbootstrap.com/docs/5.0/components/buttons/#block-buttons"
		with: [ 
			self napping
				ifTrue: [ 
					self renderWakeButton: html.
					self renderStopwatchOn: html withTitle: 'sleeping for: ' ]
				ifFalse: [ "]"
					self nursing
						ifTrue: [ 
							self renderEndFeedingButton: html.
							self renderStopwatchOn: html withTitle: 'nursing for: ' ]
						ifFalse: [ 
							html div
								class: 'btn-group m-1';
								with: [ 
									self renderLeftNursingButton: html.
									self renderRightNursingButton: html ].

							html div
								class: 'btn-group m-1';
								with: [ 
									self renderLinkButton: html for: WetDiaperEvent.
									self renderLinkButton: html for: MixedDiaperEvent.
									self renderLinkButton: html for: SoiledDiaperEvent ].

							html div
								class: 'btn-group m-1';
								with: [ self renderBottleButton: html ].

							html div
								class: 'btn-group m-1';
								with: [ self renderPumpButton: html ].

							html div
								class: 'btn-group m-1';
								with: [ self renderSleepButton: html ] ] ] ]
]

{ #category : #rendering }
RecordBabyEvent >> renderDiaperButton: html forType: aString [

	| event |
	^ html anchor
		  attributeAt: 'role' put: 'button';
		  class: 'btn btn-outline-dark';
		  callback: [ 
			  event := DaiperChangeEvent new
				           startTime: DateAndTime now;
				           daiperType: aString;
				           yourself.
			  self baby addEvent: event ];
		  with: [ html strong with: DaiperChangeEvent startLabel ]
]

{ #category : #rendering }
RecordBabyEvent >> renderEndFeedingButton: html [

	^ html anchor
		  attributeAt: 'role' put: 'button';
		  class: 'btn btn-outline-dark';
		  callback: [ "We assume here that the current event has been set properly to be a nursing event"
			  self mostRecentBabyEvent endTime: DateAndTime now.
			  self mostRecentBabyEvent store ];
		  with: [ html strong with: NursingEvent endLabel ]
]

{ #category : #rendering }
RecordBabyEvent >> renderFeedingButton: html [

	| nursingEvent |
	^ html anchor
		  attributeAt: 'role' put: 'button';
		  class: 'btn btn-outline-dark';
		  callback: [ 
			  nursingEvent := NursingEvent new
				                  startTime: DateAndTime now;
				                  yourself.
			  self baby addEvent: nursingEvent ];
		  with: [ html strong with: NursingEvent startLabel ]
]

{ #category : #rendering }
RecordBabyEvent >> renderFeedingButton: html forSide: side [

	| nursingEvent |
	^ html anchor
		  attributeAt: 'role' put: 'button';
		  class: 'btn btn-outline-dark';
		  callback: [ 
			  nursingEvent := NursingEvent new
				                  startTime: DateAndTime now;
				                  firstSide: side;
				                  yourself.
			  self baby addEvent: nursingEvent ];
		  with: [ html strong with: NursingEvent startLabel , ' ' , side ]
]

{ #category : #rendering }
RecordBabyEvent >> renderLeftNursingButton: html [

	self renderFeedingButton: html forSide: 'Left'
]

{ #category : #rendering }
RecordBabyEvent >> renderLinkButton: html for: aBabyEventClass [

	html anchor
		attributeAt: 'role' put: 'button';
		class: 'btn btn-outline-dark';
		callback: [ 
			self baby addEvent: (aBabyEventClass new
						 startTime: DateAndTime now;
						 yourself) ];
		with: [ html strong with: aBabyEventClass startLabel ]
]

{ #category : #rendering }
RecordBabyEvent >> renderPumpButton: html [

	| pumpEvent |
	^ html anchor
		  attributeAt: 'role' put: 'button';
		  class: 'btn btn-outline-dark';
		  callback: [ 
			  | edited |
			  pumpEvent := PumpEvent new
				               startTime: DateAndTime now;
				               yourself.
			  edited := self call: pumpEvent edit.
			  edited ifNotNil: [ self baby addEvent: edited ] ];
		  with: [ html strong with: PumpEvent startLabel ]
]

{ #category : #rendering }
RecordBabyEvent >> renderRightNursingButton: html [

	self renderFeedingButton: html forSide: 'Right'
]

{ #category : #rendering }
RecordBabyEvent >> renderSleepButton: html [

	| sleepEvent |
	^ html anchor
		  attributeAt: 'role' put: 'button';
		  class: 'btn btn-outline-dark';
		  callback: [ 
			  sleepEvent := SleepBabyEvent new
				                startTime: DateAndTime now;
				                yourself.
			  self baby addEvent: sleepEvent ];
		  with: [ html strong with: SleepBabyEvent startLabel ]
]

{ #category : #rendering }
RecordBabyEvent >> renderStopwatchOn: html withTitle: aString [

	html div
		class: 'container';
		with: [ 
			stopwatch
				title: aString;
				startTime: self mostRecentBabyEvent startTime.
			html render: stopwatch ]
]

{ #category : #rendering }
RecordBabyEvent >> renderWakeButton: html [

	^ html anchor
		  attributeAt: 'role' put: 'button';
		  class: 'btn btn-outline-dark';
		  callback: [ 
			  self mostRecentBabyEvent endTime: DateAndTime now.
			  self mostRecentBabyEvent store ];
		  with: [ html strong with: SleepBabyEvent endLabel ]
]
