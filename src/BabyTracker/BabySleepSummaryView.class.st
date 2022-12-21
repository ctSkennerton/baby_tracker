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
		each startTime < minTime
			ifTrue: [ each endTime - minTime ]
			ifFalse: [ each endTime - each startTime ] ]
]
