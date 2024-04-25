
import UIKit
import MediaPlayer

final class MusicViewCell: UITableViewCell {
    
    static var identifier: String { "\(Self.self)" }
    
    @IBOutlet private weak var trackNameLabel: UILabel!
    
    @IBOutlet private weak var trackDurationLabel: UILabel!
    
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
        let player: AVPlayer = AVPlayer(url: URL(fileURLWithPath: track.trackURL))
        let dateFormatter = DateFormatter()
        if let duration = player.currentItem?.asset.duration.seconds {
            trackDurationLabel.text = dateFormatter.string(from: duration)
        }
    }
}
