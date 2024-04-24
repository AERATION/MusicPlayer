
import UIKit
import Foundation
import Combine
import MediaPlayer

class PlayerDetailViewController: UIViewController {
    
    var currentTrack: Track = Track(trackName: "", artistName: "")
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    } ()
    
    private let trackArtistLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    } ()
    
    private let currentTrackDurationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    } ()
    
    private let trackDurationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    } ()
    
    private let trackDurationSlider: UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = .clear
        slider.isUserInteractionEnabled = false
        slider.minimumValue = 0
        slider.value = 0
        return slider
    } ()
    
    private let backwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = .blue
        let image = UIImage(systemName: "backward.fill",withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30)))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let forwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = .blue
        let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30)))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .blue
        let image = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 40)))
        button.setImage(image, for: .normal)
        return button
    }()
    
    let detailVM = PlayerDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(trackNameLabel)
        view.addSubview(trackArtistLabel)
        view.addSubview(currentTrackDurationLabel)
        view.addSubview(trackDurationLabel)
        view.addSubview(trackDurationSlider)
        view.addSubview(backwardButton)
        view.addSubview(forwardButton)
        view.addSubview(playPauseButton)
        addTargets()
        makeConstraints()
        bindToViewModel()
        
    }
    
    private func bindToViewModel() {
        detailVM.$isPlaying
            .sink { [weak self] state in
                if state {
                    let image = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 40)))
                    self?.playPauseButton.setImage(image, for: .normal)
                } else {
                    let image = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 40)))
                    self?.playPauseButton.setImage(image, for: .normal)
                }
            }
            .store(in: &subscriptions)
        
        detailVM.$maxCurrentDuration
            .sink { [weak self] duration in
                self?.trackDurationSlider.maximumValue = Float(duration)
                let maxCurrentTime = Date(timeIntervalSince1970: duration)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "mm:ss"
                let formattedTime = dateFormatter.string(from: maxCurrentTime)
                self?.trackDurationLabel.text = formattedTime
            }
            .store(in: &subscriptions)
        
        detailVM.$currentDuration
            .sink { [weak self] duration in
                self?.trackDurationSlider.value = Float(duration)
                let currentTime = Date(timeIntervalSince1970: duration)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "mm:ss"
                let formattedTime = dateFormatter.string(from: currentTime)
                self?.currentTrackDurationLabel.text = formattedTime
            }
            .store(in: &subscriptions)
        
        MusicService.shared.$currentTrackIndex
            .sink { [weak self] currentTrack in
                self?.trackNameLabel.text = MusicService.shared.newTracks[currentTrack].trackName
                self?.trackArtistLabel.text = MusicService.shared.newTracks[currentTrack].artistName
            }
            .store(in: &subscriptions)
    }
    
    private func addTargets() {
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        backwardButton.addTarget(self, action: #selector(backTrackButtonTapped), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(nextTrackButtonTapped), for: .touchUpInside)
    }
    
    @objc private func playPauseButtonTapped() {
        detailVM.pauseTrack()
    }
    
    @objc private func nextTrackButtonTapped() {
        detailVM.onForwardButtonTapped()
    }
    
    @objc private func backTrackButtonTapped() {
        detailVM.onBackwordButtonTapped()
    }
    
    private func makeConstraints() {
        trackNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(42)
        }
        
        trackArtistLabel.snp.makeConstraints { make in
            make.top.equalTo(trackNameLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }
        
        currentTrackDurationLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(trackArtistLabel.snp.bottom).offset(32)
            make.height.equalTo(22)
        }
        
        trackDurationLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.top.equalTo(trackArtistLabel.snp.bottom).offset(32)
            make.height.equalTo(22)
        }
        
        trackDurationSlider.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(currentTrackDurationLabel.snp.bottom).offset(8)
            make.height.equalTo(4)
        }
        
        playPauseButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(trackDurationSlider.snp.bottom).offset(32)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        
        backwardButton.snp.makeConstraints { make in
            make.top.equalTo(playPauseButton.snp.top)
            make.trailing.equalTo(playPauseButton.snp.leading).offset(-32)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.top.equalTo(playPauseButton.snp.top)
            make.leading.equalTo(playPauseButton.snp.trailing).offset(32)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
    }
}