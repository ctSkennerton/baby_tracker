Class {
	#name : #NursingEventView,
	#superclass : #DurationEventView,
	#category : #BabyTracker
}

{ #category : #rendering }
NursingEventView >> renderFormFieldsOn: html [

	"comment stating purpose of instance-side method"

	super renderFormFieldsOn: html.
	self renderNursingSideOn: html
]

{ #category : #rendering }
NursingEventView >> renderNursingSideOn: html [

	"comment stating purpose of instance-side method"

	| firstSideRadioGroup secondSideRadioGroup |
	"html text: 'Second Side: '.
	secondSideRadioGroup := html radioGroup.
	secondSideRadioGroup radioButton
		selected: self babyEvent secondSide = 'Left';
		callback: [ self babyEvent secondSide: 'Left' ].
	html text: 'Left'.
	html space.
	secondSideRadioGroup radioButton
		selected: self babyEvent secondSide = 'Right';
		callback: [ self babyEvent secondSide: 'Right' ].
	html text: 'Right'.
	html space.
	secondSideRadioGroup radioButton
		selected: self babyEvent secondSide isNil;
		callback: [ self babyEvent secondSide: nil ].
	html text: 'None'"
	html fieldSet

		with: [ 
			html legend
				class: 'col-form-label';
				with: 'First Side'.
			firstSideRadioGroup := html radioGroup.
			html div
				class: 'form-check form-check-inline';
				with: [ 
					firstSideRadioGroup radioButton
						class: 'form-check-input';
						id: 'nursing-first-side-left';
						selected: self babyEvent firstSide = 'Left';
						callback: [ self babyEvent firstSide: 'Left' ].
					html label
						for: 'nursing-first-side-left';
						class: 'form-check-label';
						with: 'Left' ].
			html div
				class: 'form-check form-check-inline';
				with: [ 
					firstSideRadioGroup radioButton
						class: 'form-check-input';
						id: 'nursing-first-side-right';
						selected: self babyEvent firstSide = 'Right';
						callback: [ self babyEvent firstSide: 'Right' ].

					html label
						for: 'nursing-first-side-right';
						class: 'form-check-label';
						with: 'Right' ] ]
]
