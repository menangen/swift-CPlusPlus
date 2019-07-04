compiler = -Xcxx -I/usr/local/opt/v8/libexec/include -Xcxx -std=c++11
linker   = -Xlinker -L/usr/local/opt/v8/libexec -Xlinker -lv8 -Xlinker -lv8_libplatform

default:
	swift build $(compiler) $(linker)

project:
	swift package generate-xcodeproj

production:
	swift build -c release -Xswiftc -static-stdlib

clean:
	swift package clean

test:
	swift test

start:
	./.build/x86_64-apple-macosx/debug/swift

run:
	swift run $(compiler) $(linker)
