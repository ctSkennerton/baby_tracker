ZnZincServerAdaptor startOn: 1701.

ZnZincServerAdaptor default server logLevel: 2; logToTranscript.

WAAdmin clearAll.
WAEnvironment configureApplicationDefaults.
WAEnvironment registerDefaultRequestHandlers.
WAAdmin applicationDefaults removeParent: WADevelopmentConfiguration instance.
WAAdmin applicationExceptionHandlingDefaults at: #exceptionHandler put: WAErrorHandler.
BabyTrackerApp initialize.
WAAdmin defaultDispatcher defaultName: 'babytracker'.

Transcript show: 'Baby Tracker started'; cr
