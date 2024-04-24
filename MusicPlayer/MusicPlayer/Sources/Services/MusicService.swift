
import Foundation
import MediaPlayer

final class MusicService {
    
    var tracks: [Track] = [
        Track(trackName: "Animals", artistName: "Maroon"),
        Track(trackName: "Beliver", artistName: "Imagine Dragons"),
        Track(trackName: "Demons", artistName: "Imagine Dragons"),
        Track(trackName: "LostInTheEcho", artistName: "Linkin Park"),
        Track(trackName: "Numb", artistName: "Linkin Park"),
    ]
    
    var newTracks: [TestTrack] = []
    
    static let shared = MusicService()
    
    @Published var player: AVPlayer = AVPlayer()
    
    @Published var currentTrackIndex = 0
    
    func play(trackIndex: Int) {
        player.pause()
        currentTrackIndex = trackIndex
        let playerItem = AVPlayerItem(url: URL(fileURLWithPath: newTracks[trackIndex].trackURL))
        NotificationCenter.default.addObserver(self, selector: #selector(trackDidEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func nextTrack() {
        if currentTrackIndex == tracks.count-1 {
            currentTrackIndex = 0
        } else {
            currentTrackIndex += 1
        }
        play(trackIndex: currentTrackIndex)
    }
    
    func previousTrack() {
        if currentTrackIndex == 0 {
            currentTrackIndex = tracks.count-1
        } else {
            currentTrackIndex -= 1
        }
        play(trackIndex: currentTrackIndex)
    }
    
    func loadMusic() {
        let audioFileNames = Bundle.main.paths(forResourcesOfType: "mp3", inDirectory: nil)
        
        for audioUrl in audioFileNames {
            let avp = AVPlayerItem(url: URL(fileURLWithPath: audioUrl))
            let commonMetaData = avp.asset.commonMetadata
            var title: String = ""
            var artist: String = ""
            for item in commonMetaData {
                if item.commonKey!.rawValue == "title" {
                    title = item.stringValue!
                }
                if item.commonKey!.rawValue == "artist" {
                    artist = item.stringValue!
                }
            }
            newTracks.append(TestTrack(trackName: title, artistName: artist, trackURL: audioUrl))
        }
    }
    
    
    @objc func trackDidEnded() {
        nextTrack()
    }
    
}
