# DemoProduct

This is a demo Product

In terms of implementation:
1. UI
scrollview to scroll 3 imageviews
button as a trigger to present the viewcontroller for input
uipickerview to pick the commodity
searchbar + uitableview for location input and auto completion and timer (invalidate the old when input fast) for delay reloading

it contains two view controllers : rootviewcontroller holds the scrollview, and inputviwecontroller holds that for input

3rd library: TAPageControl (make it more similar as mock object)


2.API
Class : APIComuunicator
almofire for post request
send result to data processor

3rd library: Alamofire

3.data
class DataProcessor 
use cache to store the result sent by api communicator
provide data for view controller
provide matching result for view controller
swiftJSON for data analysis

3rd library SwiftJSON



4 design pattern

kvo
singleton
delegate
singleton
