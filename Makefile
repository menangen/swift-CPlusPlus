default:
	swift build -Xcxx -I/usr/local/Cellar/v8/7.5.288.22/libexec/include -Xcxx -std=c++11 -Xlinker -lv8 -Xlinker -L/usr/local/Cellar/v8/7.5.288.22/libexec

project:
	swift package generate-xcodeproj

production:
	swift build -c release -Xswiftc -static-stdlib

clean:
	swift package clean

test:
	swift test
