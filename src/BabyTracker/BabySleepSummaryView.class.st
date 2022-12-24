Class {
	#name : #BabySleepSummaryView,
	#superclass : #WAComponent,
	#category : #BabyTracker
}

{ #category : #'as yet unclassified' }
BabySleepSummaryView >> dailySleepTime: numberOfDays [

	| sleeps minTime sumSleepPerDay |
	minTime := (DateAndTime now - numberOfDays days) asDate.
	sleeps := SleepBabyEvent storedInstances select: [ :each | 
		          each endTime >= minTime ].

	sumSleepPerDay := Dictionary new.
	sleeps do: [ :each | 
		(self partitionSleepByDay: each) keysAndValuesDo: [ :key :val | 
			key >= minTime ifTrue: [ 
				sumSleepPerDay
					at: key
					update: [ :currentVal | currentVal + val ]
					initial: [ val ] ] ] ].
		^ sumSleepPerDay 
]

{ #category : #'as yet unclassified' }
BabySleepSummaryView >> partitionSleepByDay: aSleepEvent [

	| startDay endDay sleepPerDay |
	startDay := aSleepEvent startTime asDate.
	endDay := aSleepEvent endTime asDate.
	sleepPerDay := Dictionary new.
	startDay = endDay
		ifTrue: [ 
			sleepPerDay
				at: startDay
				put: aSleepEvent endTime - aSleepEvent startTime ]
		ifFalse: [ 
			sleepPerDay at: startDay put: endDay - aSleepEvent startTime.
			sleepPerDay at: endDay put: aSleepEvent endTime - endDay ].
		^sleepPerDay 
]

{ #category : #rendering }
BabySleepSummaryView >> renderContentOn: html [

	"A summary table of baby sleep events"

	| totalSleep sortedDays |
	totalSleep := self dailySleepTime: 7.
	sortedDays := totalSleep keys sort: [ :k1 :k2 | k1 < k2 ].
	html heading
		level: 3;
		with: 'Sleep Summary'.
	html table: [ 
		html tableRow: [ 
			html tableHeading: ''.
			sortedDays do: [ :day | html tableHeading: day ] ].

		html tableRow: [ 
			html tableHeading: 'Total'.
			sortedDays do: [ :day | 
				html tableData:
					(totalSleep at: day ifAbsent: [ 0 ]) bt_humanReadablePrintString ] ] ]
]
