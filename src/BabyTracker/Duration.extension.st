Extension { #name : #Duration }

{ #category : #'*BabyTracker' }
Duration >> bt_humanReadablePrintString [

	"Return a String with a human readable representation of me"

	"99999 atRandom seconds humanReadablePrintString"

	"99999999 atRandom milliSeconds humanReadablePrintString"

	"99999999999999 atRandom nanoSeconds humanReadablePrintString"

	^ String streamContents: [ :out | self bt_printHumanReadableOn: out ]
]

{ #category : #'*BabyTracker' }
Duration >> bt_printHumanReadableOn: stream [

	"This is a trucated form of the usual printHumanReadableOn message from the Duration object.
	 The only difference is that we only print days, hours, and minutes, and change the output
	 text a little to make it more compact.
	"

	| outputWritten count |
	outputWritten := false.
	self negative ifTrue: [ 
		stream << '- '.
		^ self abs printHumanReadableOn: stream ].
	#( #( days 'day' ) #( hours 'hr' ) #( minutes 'min' )
	   #( seconds 'sec' ) ) do: [ :each | 
		count := (self perform: each first) truncated.
		count > 0 ifTrue: [ 
			outputWritten ifTrue: [ stream space ].
			count printWithCommasOn: stream.
			stream
				space;
				<< (each second asPluralBasedOn: count).
			outputWritten := true ] ].
	outputWritten ifFalse: [ stream << '0 secs' ]
]
