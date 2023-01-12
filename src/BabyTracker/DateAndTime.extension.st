Extension { #name : #DateAndTime }

{ #category : #'*BabyTracker' }
DateAndTime >> bt_printShort [

	^ String streamContents: [ :aStream | 
		  self bt_printShortOn: aStream ]
]

{ #category : #'*BabyTracker' }
DateAndTime >> bt_printShortOn: aStream [


		  aStream
			  nextPutAll: self monthAbbreviation;
			  nextPutAll: ' '.
		  self dayOfMonth
			  printOn: aStream
			  base: 10
			  length: 2
			  padded: true.
		  aStream nextPutAll: ' '.
		  self hour12 printOn: aStream.
		  aStream nextPutAll: ':'.
		  self minutes
			  printOn: aStream
			  base: 10
			  length: 2
			  padded: true.
		  aStream
			  nextPutAll: ' ';
			  nextPutAll: self meridianAbbreviation 
]
