Class {
	#name : #DatePrinter,
	#superclass : #Object,
	#instVars : [
		'dateAndTime',
		'outputStream'
	],
	#category : #BabyTracker
}

{ #category : #'instance creation' }
DatePrinter class >> with: aDateAndTime [

	^self new dateAndTime: aDateAndTime; yourself
]

{ #category : #'instance creation' }
DatePrinter class >> with: aDateAndTime onStream: aWriteStream [

	^ self new
		  dateAndTime: aDateAndTime;
		outputStream: aWriteStream ;
		  yourself
]

{ #category : #accessing }
DatePrinter >> dateAndTime [

	^ dateAndTime
]

{ #category : #accessing }
DatePrinter >> dateAndTime: anObject [

	dateAndTime := anObject
]

{ #category : #'as yet unclassified' }
DatePrinter >> dayPadded: aNumber [

	"Print the year padded to the number of digits"

	self number: self dateAndTime dayOfMonth paddedTo: aNumber
]

{ #category : #'as yet unclassified' }
DatePrinter >> hour12Padded: aNumber [

	"Print the year padded to the number of digits"

	self number: self dateAndTime hour12 paddedTo: aNumber
]

{ #category : #'as yet unclassified' }
DatePrinter >> hour24Padded: aNumber [

	"Print the year padded to the number of digits"

	self number: self dateAndTime hour24 paddedTo: aNumber
]

{ #category : #'as yet unclassified' }
DatePrinter >> isoLocal [

	"print an ISO formatted date in the form of YYYY-MM-DDTHH:MM:SS without any timezone"
	
	self yearPadded: 4.
	self outputStream nextPutAll: '-'.
	self monthPadded: 2.
	self outputStream nextPutAll: '-'.
	self dayPadded: 2.
	self outputStream nextPutAll: 'T'.
	self hour24Padded: 2.
	self outputStream nextPutAll: ':'.
	self minutePadded: 2.
	self outputStream nextPutAll: ':'.
	self secondPadded: 2.
]

{ #category : #'as yet unclassified' }
DatePrinter >> minutePadded: aNumber [

	"Print the year padded to the number of digits"

	self number: self dateAndTime minute paddedTo: aNumber
]

{ #category : #'as yet unclassified' }
DatePrinter >> monthPadded: aNumber [

	"Print the year padded to the number of digits"

	self number: self dateAndTime month paddedTo: aNumber
]

{ #category : #private }
DatePrinter >> number: aNumber paddedTo: numberOfDigits [

	"Print the year padded to the number of digits"

	aNumber
		printOn: self outputStream
		base: 10
		length: numberOfDigits
		padded: true
]

{ #category : #accessing }
DatePrinter >> outputStream [

	^ outputStream ifNil: [ outputStream := WriteStream with: String new ]
]

{ #category : #accessing }
DatePrinter >> outputStream: anObject [

	outputStream := anObject
]

{ #category : #printing }
DatePrinter >> printOn: aStream [

	aStream nextPutAll: self outputStream contents
]

{ #category : #'as yet unclassified' }
DatePrinter >> secondPadded: aNumber [

	"Print the year padded to the number of digits"

	self number: self dateAndTime second paddedTo: aNumber
]

{ #category : #'as yet unclassified' }
DatePrinter >> yearPadded: aNumber [

	"Print the year padded to the number of digits"

	self number: self dateAndTime year paddedTo: aNumber

]
