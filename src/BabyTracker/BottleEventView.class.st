Class {
	#name : #BottleEventView,
	#superclass : #BabyEventView,
	#category : #BabyTracker
}

{ #category : #rendering }
BottleEventView >> renderBottleAmountOn: html [

	html label
		for: 'bottle-amount';
		with: 'Amount (fl oz):'.
	html numberInput
		class: 'form-control';
		id: 'bottle-amount';
		attributeAt: 'step' put: '0.01';
		callback: [ :value | self babyEvent bottleAmount: value ];
		value: self babyEvent bottleAmount
]

{ #category : #rendering }
BottleEventView >> renderBottleTypesOn: html [

	html label
		for: 'bottle-type';
		with: 'Type:'.
	html select
	class: 'form-control';
		id: 'bottle-type';
		list: self babyEvent bottleTypes;
		selected: self babyEvent bottleType;
		callback: [ :value | self babyEvent bottleType: value ]
]

{ #category : #rendering }
BottleEventView >> renderFormFieldsOn: html [

	"comment stating purpose of instance-side method"

	super renderFormFieldsOn: html.
	html div
		class: self defaultFormDivCssClass ;
		with: [ self renderBottleAmountOn: html ].

	html div
		class: self defaultFormDivCssClass;
		with: [ self renderBottleTypesOn: html]
]
