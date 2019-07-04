import js

print("Hello, Swift!")

let dir = "/Volumes/RAMDisk/swift/swift-CPlusPlus/Sources/js"
let file = "index"
let fileURL = "\(dir)/\(file).js"

do {
    let jsFileContent = try String(contentsOf: URL(fileURLWithPath: fileURL), encoding: .utf8)
    
    print("File data:\n*******\n", jsFileContent, "\n*******\n")
    
    JS.hello(jsFileContent)
    
} catch {
    print("Can't open file \(fileURL)")
}
