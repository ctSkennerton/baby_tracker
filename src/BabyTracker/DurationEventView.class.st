Class {
	#name : #DurationEventView,
	#superclass : #BabyEventView,
	#category : #BabyTracker
}

{ #category : #rendering }
DurationEventView >> renderEndTimeOn: html [

	"comment stating purpose of instance-side method"

html label for: 'end-time'; with: 'End: '.
			html dateTimeLocalInput
			id: 'end-time';
				attributeAt: 'step' put: '1';
				callback: [ :value | self babyEvent endTime: value asDateAndTime ];
				value: (DatePrinter with: self babyEvent endTime) isoLocal 
]

{ #category : #rendering }
DurationEventView >> renderFormFieldsOn: html [

	"comment stating purpose of instance-side method"
	super renderFormFieldsOn: html.
	self renderEndTimeOn: html
]
