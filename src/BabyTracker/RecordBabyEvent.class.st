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

{ #category : #'as yet unclassified' }
RecordBabyEvent >> defaultButtonCssClass [

	^ 'btn btn-secondary border-dark'
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

	^ self
		  renderButtonOn: html
		  with: [ html text: BottleEvent startLabel ]
		  callback: [ 
			  | event edited |
			  event := BottleEvent new
				           startTime: DateAndTime now;
				           yourself.
			  edited := self call: event edit.
			  edited ifNotNil: [ self baby addEvent: edited ] ].
		
	"
	| bottleEvent |
	^ html anchor
		  attributeAt: 'role' put: 'button';
		  class: self defaultButtonCssClass;
		  callback: [ 
			  | edited |
			  bottleEvent := BottleEvent new
				                 startTime: DateAndTime now;
				                 yourself.
			  edited := self call: bottleEvent edit.
			  edited ifNotNil: [ self baby addEvent: edited ] ];
		  with: [ html text: BottleEvent startLabel ]"
]

{ #category : #rendering }
RecordBabyEvent >> renderButtonOn: html with: withBlock callback: callbackBlock [

	"create a button with customizations from the with and callback blocks"

	^ html anchor
		  attributeAt: 'role' put: 'button';
		  class: self defaultButtonCssClass;
		  callback: callbackBlock;
		  with: withBlock
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
							"html div
								class: 'btn-group m-1';
								with: [ 
									self renderLeftNursingButton: html.
									self renderRightNursingButton: html ]."

							html div
								class: 'btn-group m-1';
								with: [ 
									self renderLinkButton: html for: WetDiaperEvent.
									self renderLinkButton: html for: MixedDiaperEvent.
									self renderLinkButton: html for: SoiledDiaperEvent ].

							html div
								class: 'btn-group m-1';
								with: [ self renderBottleButton: html ].

							"html div
								class: 'btn-group m-1';
								with: [ self renderPumpButton: html ]."

							html div
								class: 'btn-group m-1';
								with: [ self renderSleepButton: html ] ] ] ]
]

{ #category : #rendering }
RecordBabyEvent >> renderDiaperButton: html forType: aString [

	^ self renderButtonOn: html with: [ html text: DaiperChangeEvent startLabel ] callback: [ |event| event := DaiperChangeEvent new
				           startTime: DateAndTime now;
				           daiperType: aString;
				           yourself.
			  self baby addEvent: event ].
	"| event |
	^ html anchor
		  attributeAt: 'role' put: 'button';
		  class: self defaultButtonCssClass;
		  callback: [ 
			  event := DaiperChangeEvent new
				           startTime: DateAndTime now;
				           daiperType: aString;
				           yourself.
			  self baby addEvent: event ];
		  with: [ html strong with: DaiperChangeEvent startLabel ]"
]

{ #category : #rendering }
RecordBabyEvent >> renderEndFeedingButton: html [

	^ self renderButtonOn: html with: [ html text: NursingEvent endLabel  ] callback: [ "We assume here that the current event has been set properly to be a nursing event"
			  self mostRecentBabyEvent endTime: DateAndTime now.
			  self mostRecentBabyEvent store ].
"
	^ html anchor
		  attributeAt: 'role' put: 'button';
		  class: self defaultButtonCssClass;
		  callback: [ ""We assume here that the current event has been set properly to be a nursing event""
			  self mostRecentBabyEvent endTime: DateAndTime now.
			  self mostRecentBabyEvent store ];
		  with: [ html strong with: NursingEvent endLabel ]"
]

{ #category : #rendering }
RecordBabyEvent >> renderFeedingButton: html [

	^ self renderButtonOn: html with: [ html text: NursingEvent startLabel ] callback: [ 
			| nursingEvent |
			  nursingEvent := NursingEvent new
				                  startTime: DateAndTime now;
				                  yourself.
			  self baby addEvent: nursingEvent ]
	
]

{ #category : #rendering }
RecordBabyEvent >> renderFeedingButton: html forSide: side [

	^ self renderButtonOn: html with: [ html text: NursingEvent startLabel , ' ' , side ]  callback: [ |nursingEvent|
			  nursingEvent := NursingEvent new
				                  startTime: DateAndTime now;
				                  firstSide: side;
				                  yourself.
			  self baby addEvent: nursingEvent ]
	
]

{ #category : #rendering }
RecordBabyEvent >> renderLeftNursingButton: html [

	self renderFeedingButton: html forSide: 'Left'
]

{ #category : #rendering }
RecordBabyEvent >> renderLinkButton: html for: aBabyEventClass [

	self renderButtonOn: html with: [ html text: aBabyEventClass startLabel ] callback: [ 
			self baby addEvent: (aBabyEventClass new
						 startTime: DateAndTime now;
						 yourself) ]
	
]

{ #category : #rendering }
RecordBabyEvent >> renderPumpButton: html [

^ self renderButtonOn: html with: [ html text: PumpEvent startLabel ] callback: [ 
			  | pumpEvent edited |
			  pumpEvent := PumpEvent new
				               startTime: DateAndTime now;
				               yourself.
			  edited := self call: pumpEvent edit.
			  edited ifNotNil: [ self baby addEvent: edited ] ]


]

{ #category : #rendering }
RecordBabyEvent >> renderRightNursingButton: html [

	self renderFeedingButton: html forSide: 'Right'
]

{ #category : #rendering }
RecordBabyEvent >> renderSleepButton: html [

	^ self renderButtonOn: html  with: [ html text: SleepBabyEvent startLabel ]  callback: [ 
		|sleepEvent|
			  sleepEvent := SleepBabyEvent new
				                startTime: DateAndTime now;
				                yourself.
			  self baby addEvent: sleepEvent ]
	
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

	^ self renderButtonOn: html with: [ html text: SleepBabyEvent endLabel ] callback: [ 
			  self mostRecentBabyEvent endTime: DateAndTime now.
			  self mostRecentBabyEvent store ]
	
]
