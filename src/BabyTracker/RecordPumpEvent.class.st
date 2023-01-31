Class {
	#name : #RecordPumpEvent,
	#superclass : #WAComponent,
	#instVars : [
		'baby'
	],
	#category : #BabyTracker
}

{ #category : #accessing }
RecordPumpEvent >> baby [

	^ self session currentBaby 
]

{ #category : #'as yet unclassified' }
RecordPumpEvent >> defaultButtonCssClass [

	^ 'btn btn-secondary border-dark'
]

{ #category : #rendering }
RecordPumpEvent >> renderButtonOn: html with: withBlock callback: callbackBlock [

	"create a button with customizations from the with and callback blocks"

	^ html anchor
		  attributeAt: 'role' put: 'button';
		  class: self defaultButtonCssClass;
		  callback: callbackBlock;
		  with: withBlock
]

{ #category : #rendering }
RecordPumpEvent >> renderContentOn: html [

	self renderPumpButton: html
]

{ #category : #rendering }
RecordPumpEvent >> renderPumpButton: html [

	^ self
		  renderButtonOn: html
		  with: [ html text: PumpEvent startLabel ]
		  callback: [ 
			  | pumpEvent edited |
			  pumpEvent := PumpEvent new
				               startTime: DateAndTime now;
				               yourself.
			  edited := self call: pumpEvent edit.
			  edited ifNotNil: [ self baby addEvent: edited ] ]
]
