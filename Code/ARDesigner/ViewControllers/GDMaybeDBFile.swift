import Foundation

class GDMaybeDBFile {
    var tag:String // type
    var id:String
    var name:String
    var path_display:String
    var path_lower:String
    var marked:Bool
    
    init(tag: String, id: String, name: String, path_display: String, path_lower: String, marked: Bool) {
        self.tag = tag
        self.id = id
        self.name = name
        self.path_display = path_display
        self.path_lower = path_lower
        self.marked = marked
    }
    
    func isFile() -> Bool {
        return self.tag == "file"
    }
    
    func setMarked(value: Bool) {
        self.marked = value
    }
}
