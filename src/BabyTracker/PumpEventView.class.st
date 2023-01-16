Class {
	#name : #PumpEventView,
	#superclass : #BabyEventView,
	#category : #BabyTracker
}

{ #category : #rendering }
PumpEventView >> renderFormFieldsOn: html [

	"comment stating purpose of instance-side method"

	super renderFormFieldsOn: html.

	self renderPumpAmountOn: html.

]

{ #category : #rendering }
PumpEventView >> renderPumpAmountOn: html [

	html label
		for: 'pump-amount';
		with: 'Amount (mL):'.
	html numberInput
		id: 'pump-amount';
		attributeAt: 'step' put: '0.01';
		callback: [ :value | self babyEvent pumpAmount: value ];
		value: self babyEvent pumpAmount
]
