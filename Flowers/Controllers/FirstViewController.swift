/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class FirstViewController: UIViewController {
	@IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var loadingView: UIView! {
    didSet {
      loadingView.layer.cornerRadius = 9
    }
  }
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

	override func viewDidLoad() {
		super.viewDidLoad()
    showSpinner()
		let url = URL(string: "https://koenig-media.raywenderlich.com/uploads/2021/06/3ff2c920240634ed81efeffeb2fc6070.jpeg")
		if let url = url {
			loadImage(with: url)
		}
	}
  
  private func showSpinner() {
    activityIndicator.startAnimating()
    activityIndicator.isHidden = false
    loadingView.isHidden = false
  }
  
  private func hideSpinner() {
    activityIndicator.stopAnimating()
    activityIndicator.isHidden = true
    loadingView.isHidden = true
  }
}

extension FirstViewController {
	private func loadImage(with url: URL) {
    let session = URLSession(configuration: .ephemeral)
		let dataTask = session.dataTask(with: url) { [weak self] data, _, _ in
      guard let self = self else {
        return
      }
			if let data = data {
				DispatchQueue.main.async {
					self.imageView.image = UIImage(data: data)
          self.hideSpinner()
				}
			}
		}
		dataTask.resume()
	}
}
