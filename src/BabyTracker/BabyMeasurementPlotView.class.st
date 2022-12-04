Class {
	#name : #BabyMeasurementPlotView,
	#superclass : #WAComponent,
	#category : #BabyTracker
}

{ #category : #accessing }
BabyMeasurementPlotView >> plots [

	^ OrderedCollection streamContents: [ :s | 
		  (Pragma allNamed: #plot in: self class) do: [ :pragma | 
			  s nextPut: pragma method selector ] ]
]

{ #category : #rendering }
BabyMeasurementPlotView >> renderContentOn: html [

	html div
		class: 'container';
		with: [ self renderPlotsOn: html ]
]

{ #category : #rendering }
BabyMeasurementPlotView >> renderPlot: selector on: html [

	html div
		class: 'row';
		with: [ 
			html div
				class: 'column-md-6';
				with: [ 
					html div
						id: html nextId;
						with: [ "This is the container" ] ] ].

	html document addLoadScript:
		(JSStream on: (html jQuery script: [ :script | 
				  self perform: selector with: script with: html lastId ]))
]

{ #category : #rendering }
BabyMeasurementPlotView >> renderPlotsOn: html [

	self plots do: [ :selector | self renderPlot: selector on: html ]
]

{ #category : #'javascript-examples' }
BabyMeasurementPlotView >> scriptExampleWeightForAge: script elementId: elementId [

	<plot>
	| plotly |
	plotly := script plotly: elementId.
	plotly
		data: { 
				(PlotlyTrace scatter
					 name: '3rd';
					 showlegend: true;
					 line: (PlotlyLine new
							  shape: 'spline';
							  color: (Color r: 0.3 g: 0.3 b: 0.3);
							  dash: 'dot';
							  yourself);
					 x: ((OrderedCollection with: 0)
							  addAll: (0.5 to: 24.5 by: 1);
							  yourself);
					 y:
						 { 2.414111983. 2.756916984. 3.402293298. 3.997805608.
						 4.54738333. 5.054538727. 5.522500226. 5.954272494. 6.352668277.
						 6.720327734. 7.059731719. 7.373211901. 7.662959063. 7.93103031.
						 8.179355552. 8.409743555. 8.62388725. 8.82336957. 9.00966812.
						 9.184160166. 9.348127323. 9.502760074. 9.649162144. 9.788354721.
						 9.921280547. 10.04880788 };
					 yourself).
				(PlotlyTrace scatter
					 name: '5th';
					 showlegend: true;
					 line: (PlotlyLine new
							  shape: 'spline';
							  color: (Color r: 0.3 g: 0.3 b: 0.3);
							  dash: 'dot';
							  yourself);
					 x: ((OrderedCollection with: 0)
							  addAll: (0.5 to: 24.5 by: 1);
							  yourself);
					 y:
						 { 2.54790518. 2.894442278. 3.547610305. 4.150638506. 4.70712251.
						 5.220487543. 5.693974176. 6.130641295. 6.533372908. 6.904885578.
						 7.247735767. 7.564326904. 7.856916169. 8.127621012. 8.378425424.
						 8.611186014. 8.827637666. 9.029399482. 9.217979979. 9.394782429.
						 9.561109949. 9.718170424. 9.867081272. 10.00887405. 10.14449891.
						 10.27482891 };
					 yourself).
				(PlotlyTrace scatter
					 name: '10th';
					 showlegend: true;
					 line: (PlotlyLine new
							  shape: 'spline';
							  color: (Color r: 0.3 g: 0.3 b: 0.3);
							  dash: 'dot';
							  yourself);
					 x: ((OrderedCollection with: 0)
							  addAll: (0.5 to: 24.5 by: 1);
							  yourself);
					 y:
						 { 2.747222257. 3.101767067. 3.770157472. 4.387041982.
						 4.95592631. 5.480295205. 5.963510428. 6.408775097. 6.819122283.
						 7.197413532. 7.546341788. 7.868436369. 8.166068895. 8.441459662.
						 8.696684147. 8.933679535. 9.154251142. 9.360078736. 9.55272268.
						 9.733629905. 9.904139709. 10.06548937. 10.21881956. 10.3651796.
						 10.50553251. 10.64075987 };
					 yourself).
				(PlotlyTrace scatter
					 name: '25th';
					 showlegend: true;
					 line: (PlotlyLine new
							  shape: 'spline';
							  color: (Color r: 0.3 g: 0.3 b: 0.3);
							  dash: 'dot';
							  yourself);
					 x: ((OrderedCollection with: 0)
							  addAll: (0.5 to: 24.5 by: 1);
							  yourself);
					 y:
						 { 3.06486465. 3.437628263. 4.13899376. 4.784820426. 5.379141034.
						 5.92588831. 6.428828208. 6.891533095. 7.317373091. 7.709516114.
						 8.070932165. 8.404399764. 8.712513432. 8.997691667. 9.262185089.
						 9.508084539. 9.737329319. 9.951714686. 10.15289979. 10.34241498.
						 10.52166904. 10.69195601. 10.85446195. 11.01027128. 11.16037297.
						 11.30566645 };
					 yourself).
				(PlotlyTrace scatter
					 name: '50th';
					 showlegend: true;
					 line: (PlotlyLine new
							  shape: 'spline';
							  color: (Color r: 0.3 g: 0.3 b: 0.3);
							  yourself);
					 x: ((OrderedCollection with: 0)
							  addAll: (0.5 to: 24.5 by: 1);
							  yourself);
					 y:
						 { 3.39918645. 3.79752846. 4.544776513. 5.230584214. 5.859960798.
						 6.437587751. 6.967850457. 7.454854109. 7.902436186. 8.314178377.
						 8.693418423. 9.043261854. 9.366593571. 9.666089185. 9.944226063.
						 10.20329397. 10.4454058. 10.67250698. 10.88638558. 11.08868151.
						 11.28089537. 11.46439708. 11.64043402. 11.81013895. 11.97453748.
						 12.13455528 };
					 yourself).
				(PlotlyTrace scatter
					 name: '75th';
					 showlegend: true;
					 line: (PlotlyLine new
							  shape: 'spline';
							  color: (Color r: 0.3 g: 0.3 b: 0.3);
							  dash: 'dot';
							  yourself);
					 x: ((OrderedCollection with: 0)
							  addAll: (0.5 to: 24.5 by: 1);
							  yourself);
					 y:
						 { 3.717519384. 4.145593668. 4.946765504. 5.680083196.
						 6.351511983. 6.966523789. 7.53018045. 8.047178246. 8.52187726.
						 8.958324062. 9.360270982. 9.7311934. 10.07430572. 10.39257636.
						 10.68874201. 10.96532105. 11.2246268. 11.46877937. 11.69971783.
						 11.91921144. 12.1288704. 12.3301562. 12.52439148. 12.71276942.
						 12.89636272. 13.07613212 };
					 yourself).
				(PlotlyTrace scatter
					 name: '90th';
					 showlegend: true;
					 line: (PlotlyLine new
							  shape: 'spline';
							  color: (Color r: 0.3 g: 0.3 b: 0.3);
							  dash: 'dot';
							  yourself);
					 x: ((OrderedCollection with: 0)
							  addAll: (0.5 to: 24.5 by: 1);
							  yourself);
					 y:
						 { 3.992572231. 4.450125603. 5.305632496. 6.08764077. 6.802769825.
						 7.45711879. 8.056331004. 8.605635546. 9.109878097. 9.573546299.
						 10.00079194. 10.3954511. 10.76106284. 11.10088678. 11.4179197.
						 11.7149113. 11.99437938. 12.258624. 12.50974133. 12.74963667.
						 12.98003694. 13.20250263. 13.41843913. 13.62910755. 13.8356351.
						 14.03902484 };
					 yourself).
				(PlotlyTrace scatter
					 name: '95th';
					 showlegend: true;
					 line: (PlotlyLine new
							  shape: 'spline';
							  color: (Color r: 0.3 g: 0.3 b: 0.3);
							  dash: 'dot';
							  yourself);
					 x: ((OrderedCollection with: 0)
							  addAll: (0.5 to: 24.5 by: 1);
							  yourself);
					 y:
						 { 4.152636594. 4.628836382. 5.51916925. 6.332837055. 7.076722522.
						 7.757233948. 8.380329759. 8.951543685. 9.476008728. 9.958479736.
						 10.40335475. 10.81469528. 11.19624565. 11.5514514. 11.88347697.
						 12.19522253. 12.48934. 12.76824867. 13.03414978. 13.28904061.
						 13.53472797. 13.77284102. 14.00484351. 14.23204547. 14.45561433.
						 14.67658549 };
					 yourself).
				(PlotlyTrace scatter
					 name: '97th';
					 showlegend: true;
					 line: (PlotlyLine new
							  shape: 'spline';
							  color: (Color r: 0.3 g: 0.3 b: 0.3);
							  dash: 'dot';
							  yourself);
					 x: ((OrderedCollection with: 0)
							  addAll: (0.5 to: 24.5 by: 1);
							  yourself);
					 y:
						 { 4.254922004. 4.743581789. 5.657379108. 6.492574414.
						 7.256165568. 7.954730061. 8.59441348. 9.180938407. 9.719620693.
						 10.2153883. 10.67280092. 11.0960696. 11.48907597. 11.85539095.
						 12.19829279. 12.52078451. 12.82561033. 13.11527219. 13.39204468.
						 13.65798985. 13.91497124. 14.1646673. 14.40858419. 14.64806798.
						 14.88431632. 15.11838945 };
					 yourself) };
		layout: (PlotlyLayout new
				 title: (PlotlyText text: 'Weight For Age');
				 width: 500 height: 600;
				 xaxis: (PlotlyAxis new title: 'Age (months)');
				 yaxis: (PlotlyAxis new title: 'Weight (kg)');
				 yourself).
	plotly config beResponsive.
	script << plotly
]

{ #category : #updating }
BabyMeasurementPlotView >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.
	"self updateRootStyling: anHtmlRoot."
	anHtmlRoot javascript url: 'https://cdn.plot.ly/plotly-2.4.2.min.js'
]
