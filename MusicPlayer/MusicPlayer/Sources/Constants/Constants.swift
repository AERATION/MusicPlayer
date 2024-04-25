
import Foundation
import UIKit

//MARK: - Constants
enum C {
    
    //MARK: Images
    enum Images {
        static let backword = UIImage(systemName: "backward.fill",withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30)))
        static let forward = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30)))
        static let pause = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 40)))    }
    
    //MARK: Constraints
    enum Constraints {
        static let trackNameLabelHeight = 42
        
        static let trackArtistlabelTop = 8
        static let trackArtistLabelHeight = 32
        
        static let currentTrackDurationLabelLeading = 16
        static let currentTrackDurationLabelTop = 32
        static let currentTrackDurationLabelHeight = 22
        
        static let trackDurationLabelTrailing = -16
        static let trackDurationLabelTop = 32
        static let trackDurationLabelHeight = 22
        
        static let trackDurationSliderLeading = 16
        static let trackDurationSliderTrailing = -16
        static let trackDurationSliderTop = 8
        static let trackDurationSliderHeight = 4
        
        static let playPauseButtonTop = 32
        static let playPauseButtonHeight = 48
        static let playPauseButtonWidth = 48
        
        static let backwordButtonTrailing = -32
        static let backwordButtonHeight = 48
        static let backwordButtonWidth = 48
        
        static let forwardButtonLeading = 32
        static let forwardButtonHeight = 48
        static let forwardButtonWidth = 48
    }
}
