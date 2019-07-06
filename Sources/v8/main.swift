import js

print("Hello, Swift!")

let delim = "\n____________________________________\n"

let dir = "/Users/menangen/sources/swift/swift-v8/Sources/js"
let file = "index"
let fileURL = "\(dir)/\(file).js"

do {
    let jsFileContent = try String(contentsOf: URL(fileURLWithPath: fileURL), encoding: .utf8)
    
    print("File data:\(delim)", jsFileContent, delim)
    
    JS.hello(jsFileContent)
    JS.run { (status) in
        print("nice", status)
    }
    
    
} catch {
    print("Can't open file \(fileURL)")
}
