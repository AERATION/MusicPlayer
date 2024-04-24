
import UIKit
import MediaPlayer

class MusicViewCell: UITableViewCell {
    
    static var identifier: String { "\(Self.self)" }
    
    @IBOutlet weak var trackNameLabel: UILabel!
    
    @IBOutlet weak var trackDurationLabel: UILabel!
    
    var player: AVPlayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        trackDurationLabel.text = nil
    }
    
    func configureCell(track: Track) {
        trackNameLabel.text = "\(track.trackName) - \(track.artistName)"
        player = AVPlayer(url: URL(fileURLWithPath: track.trackURL))
        let duration = player.currentItem?.asset.duration.seconds
        let currentTime = Date(timeIntervalSince1970: duration!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        let formattedTime = dateFormatter.string(from: currentTime)
        trackDurationLabel.text = formattedTime
    }
    
}
