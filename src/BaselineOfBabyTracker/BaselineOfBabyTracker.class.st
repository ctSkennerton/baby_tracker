Class {
	#name : #BaselineOfBabyTracker,
	#superclass : #BaselineOf,
	#category : #BaselineOfBabyTracker
}

{ #category : #baselines }
BaselineOfBabyTracker >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		self seaside: spec.
		self restore: spec.
		self plotly: spec.
		spec
			package: 'BabyTracker'
			with: [ spec requires: #( 'Seaside3' 'ReStore' 'Plotly' ) ].
		spec
			group: 'Core' with: #( 'BabyTracker' );
			group: 'all' with: #( 'Core' );
			group: 'default' with: #( 'all' ) ]
]

{ #category : #baselines }
BaselineOfBabyTracker >> plotly: spec [

	spec baseline: 'Plotly' with: [ 
		spec
			loads: #( 'default' );
			repository: 'github://ctSkennerton/seaside-plotlyjs/src/' ]
]

{ #category : #baselines }
BaselineOfBabyTracker >> restore: spec [

	spec baseline: 'ReStore' with: [ 
		spec
			loads: #( 'default' );
			repository: 'github://rko281/ReStoreForPharo:master/' ]
]

{ #category : #baselines }
BaselineOfBabyTracker >> seaside: spec [

	spec baseline: 'Seaside3' with: [ 
		spec
			loads: #( 'default' );
			repository: 'github://SeasideSt/Seaside:master/repository' ]
]
