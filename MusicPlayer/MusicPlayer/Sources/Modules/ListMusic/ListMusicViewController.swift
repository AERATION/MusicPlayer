
import UIKit
import SnapKit
import MediaPlayer

class ListMusicViewController: UIViewController {
    
    let listMusicViewModel = ListMusicViewModel()
    
    let listMusicTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupConstraintsTableView()
        setupTableView()
        checkMusics()
    }
    
    private func checkMusics() {
        MusicService.shared.loadMusic()
        // Получаем массив имен всех файлов аудиоресурсов в проекте Xcode
//        guard let audioFileNames = Bundle.main.paths(forResourcesOfType: "mp3", inDirectory: nil) else {
//            print("Не удалось найти аудиофайлы")
//            return
//        }
        
//        let audioFileNames = Bundle.main.paths(forResourcesOfType: "mp3", inDirectory: nil)
//    
//        var avpItem = AVPlayerItem(url: URL(fileURLWithPath: audioFileNames[0]))
//        
//        
//        var commonMetaData = avpItem.asset.commonMetadata 
//        for item in commonMetaData {
//            if item.commonKey!.rawValue == "title" {
//                print(item.stringValue)
//            }
//            if item.commonKey!.rawValue == "artist" {
//                print(item.stringValue)
//            }
//        }
    }
    
    
    private func setupConstraintsTableView() {
        view.addSubview(listMusicTableView)
        
        listMusicTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
