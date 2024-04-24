
import Foundation
import UIKit
import MediaPlayer

class MusicCell: UITableViewCell {
    
    static var identifier: String { "\(Self.self)" }
    
    var player: AVPlayer!
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        return label
    } ()
    
    private let trackDurationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        return label
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellUI()
        makeCellContraints()
    }
      
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
      
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        trackDurationLabel.text = nil
    }
    
    private func configureCellUI() {
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(trackDurationLabel)
        
    }
    
    private func makeCellContraints() {
        trackNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(32)
        }
        
        trackDurationLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(32)
        }
    }
    
    func configureCell(track: TestTrack) {
        trackNameLabel.text = "\(track.trackName) - \(track.artistName)"
//        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "\(track.trackName)", ofType: "mp3")!))
        player = AVPlayer(url: URL(fileURLWithPath: track.trackURL))
        let duration = player.currentItem?.asset.duration.seconds
        let currentTime = Date(timeIntervalSince1970: duration!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        let formattedTime = dateFormatter.string(from: currentTime)
        trackDurationLabel.text = formattedTime
    }
    
}
