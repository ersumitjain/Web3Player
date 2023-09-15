//
//  PlayerViewController.swift
//  Web3AuthVideoPlayerDemo
//
//  Created by Sumit Jain on 15/09/23.
//

import UIKit
import AVKit
import AVFoundation

class PlayerViewController: UIViewController {

  // MARK: Properties
  private var loaderDelegate: Web3AuthVideoLoaderDelegate?

  // MARK: Life Cycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  let videoURLString = "http://vfx.mtime.cn/Video/2019/06/29/mp4/190629004821240734.mp4"
    playVideo(videoURL:videoURLString)
  }

}

// MARK: Private
extension PlayerViewController {
  private func playVideo(videoURL: String) {
    guard let url = URL(string: videoURL) else {
      fatalError("Wrong video url.")
    }

    self.loaderDelegate = Web3AuthVideoLoaderDelegate(withURL: url)
    if let asset = self.loaderDelegate?.streamingAssetURL {
      let videoAsset = AVURLAsset(url: asset)
      videoAsset.resourceLoader.setDelegate(self.loaderDelegate, queue: DispatchQueue.main)
      self.loaderDelegate?.completion = { localFileURL in
        if let localFileURL = localFileURL {
          print("Media file saved to: \(localFileURL)")
        } else {
          print("Failed to download media file.")
        }
      }

      let playerItem = AVPlayerItem(asset: videoAsset)
      let player = AVPlayer(playerItem: playerItem)
      let playerViewController = AVPlayerViewController()
      playerViewController.player = player
      self.present(playerViewController, animated: true) {
        playerViewController.player!.play()
      }
    }
  }
}
