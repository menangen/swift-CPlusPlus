import js

print("Hello, Swift!")

let delim = "\n____________________________________\n"

let dir = "/Volumes/RAMDisk/swift/swift-CPlusPlus/Sources/js"
let file = "index"
let fileURL = "\(dir)/\(file).js"

do {
    let jsFileContent = try String(contentsOf: URL(fileURLWithPath: fileURL), encoding: .utf8)
    
    print("File data:\(delim)", jsFileContent, delim)
    
    JS.hello(jsFileContent)
    
} catch {
    print("Can't open file \(fileURL)")
}
