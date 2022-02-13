import HTMLKit
import Foundation

public struct Symbol: Component {
    
    internal let content: [VectorElement]
    
    internal var classes: [String]
    
    public init(name: String) {
        
        let url = URL(fileURLWithPath: "./public/css/symbols").appendingPathComponent(name).appendingPathExtension("svg")

        do {
            self.content = try Parser.load(contentsOfFile: url)
        } catch {
            self.content = []
        }

        self.classes = ["symbol"]
    }
    
    internal init(content: [VectorElement], classes: [String]) {

        self.content = content
        self.classes = classes
    }
    
    public var body: AnyContent {
        Vector {
            content
        }
        .width(16)
        .height(16)
        .viewBox("0 0 16 16")
        .fill("currentColor")
        .class(classes.joined(separator: " "))
    }
}

extension Symbol {
    
    public func fontSize(_ size: FontSize) -> Symbol {
        
        var newSelf = self
        newSelf.classes.append(size.rawValue)
        return newSelf
    }
    
    public func foregroundColor(_ color: ForegroundColor) -> Symbol {
        
        var newSelf = self
        newSelf.classes.append(color.rawValue)
        return newSelf
    }
}
