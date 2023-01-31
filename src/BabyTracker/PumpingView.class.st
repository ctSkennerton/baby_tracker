"
A dashboard for recording new Breast Pumping sessions and to viewing the store of breast milk available.
"
Class {
	#name : #PumpingView,
	#superclass : #WAComponent,
	#instVars : [
		'newPumpButton',
		'pumpList'
	],
	#category : #BabyTracker
}

{ #category : #initialization }
PumpingView >> children [

	^ { newPumpButton. pumpList  }
]

{ #category : #initialization }
PumpingView >> initialize [

	super initialize.
	newPumpButton := RecordPumpEvent new.
	pumpList := BabyEventListView new.
	pumpList events: [ PumpEvent storedInstances sortBlock: [ :first :second | first startTime > second startTime ]; satisfying: [ :each | each baby = self session currentBaby ] ]
]

{ #category : #rendering }
PumpingView >> renderContentOn: html [

	html heading: 'Pumps'.
	html div
		class: 'row mb-3';
		with: [ 
			html div
				class: 'col';
				with: [ html render: newPumpButton ] ].

	"html div
		class: 'row';
		with: [ 
			html div
				class: 'col-4';
				with: [ self renderTotalStoredOn: html ] ]."
	html div
		class: 'row mb-3 ';
		with: [ 
			html div
				class: 'col';
				with: [ html render: pumpList ] ]
]

{ #category : #rendering }
PumpingView >> renderTotalStoredOn: html [

	| totalPumpedInMilliter totalConsumedInFluidOz balanceInFluidOz balanceInMilliter |
	totalPumpedInMilliter := (PumpEvent storedInstances collect: [ :each | 
		                          each pumpAmount sum ]) first.

	totalConsumedInFluidOz := ((BottleEvent storedInstances satisfying: [ 
		                            :each | each bottleType = 'Expressed' ]) 
		                           collect: [ :each | each bottleAmount sum ])
		                          first.

	balanceInFluidOz := totalPumpedInMilliter * 0.033814
	                    - totalConsumedInFluidOz.
	balanceInMilliter := totalPumpedInMilliter
	                     - (totalConsumedInFluidOz * 29.5735).

	html div
		class: 'border shadow p-2 mb-3 bg-body rounded fs-4';
		with: [ "html div
		class: 'card text-dark bg-light mb-3';
		with: [ 
			html div
				class: 'card-body';
				with: [ 
					html heading
						level5;
						class: 'card-title';
						with:
							'Total Stored: ' , (balanceInFluidOz round: 2) asString
							, ' fl oz (' , (balanceInMilliter round: 2) asString , ' mL)' ] ]"
			html text:
					(balanceInFluidOz round: 2) asString
					, ' fl oz (' , (balanceInMilliter round: 2) asString , ' mL) in reserve' ]
]
