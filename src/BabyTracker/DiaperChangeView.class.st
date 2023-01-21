Class {
	#name : #DiaperChangeView,
	#superclass : #BabyEventView,
	#category : #BabyTracker
}

{ #category : #rendering }
DiaperChangeView >> renderDiaperTypeOn: html [

	"comment stating purpose of instance-side method"

	html label
		for: 'diaper-type';
		with: 'Daiper Type: '.
	html select
	class: 'form-control';
		id: 'diaper-type';
		list: { 'Mixed'. 'Pee'. 'Poop'. 'Dry' };
		selected: self babyEvent daiperType;
		callback: [ :value | self babyEvent daiperType: value ]
]

{ #category : #rendering }
DiaperChangeView >> renderFormFieldsOn: html [

	"comment stating purpose of instance-side method"

	super renderFormFieldsOn: html.
	html div
		class: 'col-12';
		with: [ 
	self renderDiaperTypeOn: html]
]
