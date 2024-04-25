
import Foundation
import MediaPlayer

extension DateFormatter {
    
    func string(from cmtime: Double) -> String {
        
        let newTime = Date(timeIntervalSince1970: cmtime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        
        return dateFormatter.string(from: newTime)
    }
}
