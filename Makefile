default:
	swift build

project:
	swift package generate-xcodeproj
 
production:
	swift build -c release -Xswiftc -static-stdlib

clean:
	swift package clean && rm -r ./.build

test:
	swift test