#function to print test data
print= (str)->document.write "<h1>#{str}</h1>"


mock = new Batman.MockSocket("testurl")
mock.onmessage = (str)-> print str.data
mock.send "Hello "
mock.send "World!"