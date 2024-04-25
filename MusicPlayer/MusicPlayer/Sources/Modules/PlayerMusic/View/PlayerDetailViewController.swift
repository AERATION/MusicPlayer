
import UIKit
import Foundation
import Combine
import MediaPlayer

final class PlayerDetailViewController: UIViewController {
    
    //MARK: Properties
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
        let image = C.Images.backword
        button.setImage(image, for: .normal)
        return button
    } ()
    
    private let forwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = .blue
        let image = C.Images.forward
        button.setImage(image, for: .normal)
        return button
    } ()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .blue
        let image = C.Images.pause
        button.setImage(image, for: .normal)
        return button
    } ()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17.0)
        return button
    } ()
    
    let detailViewModel = PlayerDetailViewModel()
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    //MARK: Private methods
    private func configureUI() {
        view.addSubview(trackNameLabel)
        view.addSubview(trackArtistLabel)
        view.addSubview(currentTrackDurationLabel)
        view.addSubview(trackDurationLabel)
        view.addSubview(trackDurationSlider)
        view.addSubview(backwardButton)
        view.addSubview(forwardButton)
        view.addSubview(playPauseButton)
        view.addSubview(backButton)
        addTargets()
        makeConstraints()
        bindToViewModel()
    }
    
    private func bindToViewModel() {
        detailViewModel.$isPlaying
            .sink { [weak self] state in
                guard let self = self else { return }
                let imageName = state ? "pause.fill" : "play.fill"
                let image = UIImage(systemName: imageName, withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 40)))
                self.playPauseButton.setImage(image, for: .normal)
            }
            .store(in: &subscriptions)
        
        detailViewModel.$maxCurrentDuration
            .sink { [weak self] duration in
                self?.trackDurationSlider.maximumValue = Float(duration)
                let dateFormatter = DateFormatter()
                self?.trackDurationLabel.text = dateFormatter.string(from: duration)
            }
            .store(in: &subscriptions)
        
        detailViewModel.$currentDuration
            .sink { [weak self] duration in
                self?.trackDurationSlider.value = Float(duration)
                let dateFormatter = DateFormatter()
                self?.currentTrackDurationLabel.text = dateFormatter.string(from: duration)
            }
            .store(in: &subscriptions)
        
        detailViewModel.$currentTrackName
            .sink { [weak self] trackName in
                self?.trackNameLabel.text = trackName
            }
            .store(in: &subscriptions)
        
        detailViewModel.$currentTrackArtist
            .sink { [weak self] trackArtist in
                self?.trackArtistLabel.text = trackArtist
            }
            .store(in: &subscriptions)
    }
    
    private func addTargets() {
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        backwardButton.addTarget(self, action: #selector(backTrackButtonTapped), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(nextTrackButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func playPauseButtonTapped() {
        detailViewModel.pauseTrack()
    }
    
    @objc private func nextTrackButtonTapped() {
        detailViewModel.onForwardButtonTapped()
    }
    
    @objc private func backTrackButtonTapped() {
        detailViewModel.onBackwordButtonTapped()
    }
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    private func makeConstraints() {
        trackNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(C.Constraints.trackNameLabelHeight)
        }
        
        trackArtistLabel.snp.makeConstraints { make in
            make.top.equalTo(trackNameLabel.snp.bottom).offset(C.Constraints.trackArtistlabelTop)
            make.centerX.equalToSuperview()
            make.height.equalTo(C.Constraints.trackArtistLabelHeight)
        }
        
        currentTrackDurationLabel.snp.makeConstraints { make in
            make.leading.equalTo(C.Constraints.currentTrackDurationLabelLeading)
            make.top.equalTo(trackArtistLabel.snp.bottom).offset(C.Constraints.currentTrackDurationLabelTop)
            make.height.equalTo(C.Constraints.currentTrackDurationLabelHeight)
        }
        
        trackDurationLabel.snp.makeConstraints { make in
            make.trailing.equalTo(C.Constraints.trackDurationLabelTrailing)
            make.top.equalTo(trackArtistLabel.snp.bottom).offset(C.Constraints.trackDurationLabelTop)
            make.height.equalTo(C.Constraints.trackDurationLabelHeight)
        }
        
        trackDurationSlider.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(C.Constraints.trackDurationSliderLeading)
            make.trailing.equalToSuperview().offset(C.Constraints.trackDurationSliderTrailing)
            make.top.equalTo(currentTrackDurationLabel.snp.bottom).offset(C.Constraints.trackDurationSliderTop)
            make.height.equalTo(C.Constraints.trackDurationSliderHeight)
        }
        
        playPauseButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(trackDurationSlider.snp.bottom).offset(C.Constraints.playPauseButtonTop)
            make.height.equalTo(C.Constraints.playPauseButtonHeight)
            make.width.equalTo(C.Constraints.playPauseButtonWidth)
        }
        
        backwardButton.snp.makeConstraints { make in
            make.top.equalTo(playPauseButton.snp.top)
            make.trailing.equalTo(playPauseButton.snp.leading).offset(C.Constraints.backwordButtonTrailing)
            make.height.equalTo(C.Constraints.backwordButtonHeight)
            make.width.equalTo(C.Constraints.backwordButtonWidth)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.top.equalTo(playPauseButton.snp.top)
            make.leading.equalTo(playPauseButton.snp.trailing).offset(C.Constraints.forwardButtonLeading)
            make.height.equalTo(C.Constraints.forwardButtonHeight)
            make.width.equalTo(C.Constraints.forwardButtonWidth)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(C.Constraints.backButtonLeading)
            make.top.equalToSuperview().offset(C.Constraints.backButtonTop)
            make.height.equalTo(C.Constraints.backButtonHeight)
            make.width.equalTo(C.Constraints.backButtonWidth)
        }
    }
}
