// ImageCell.swift
//
// Copyright (c) 2016 Camden Fullmer (http://camdenfullmer.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import Alamofire
import AlamofireImage

class ImageCell: UICollectionViewCell {
    class var ReuseIdentifier: String { return "com.unsplash.identifier.\(self.dynamicType)" }
    let imageView: UIImageView
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        imageView = {
            let imageView = UIImageView(frame: frame)
            
            imageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            imageView.contentMode = .Center
            imageView.clipsToBounds = true
            
            return imageView
            }()
        
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        
        imageView.frame = contentView.bounds
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    func configureCellWithURLString(URLString: String) {
        let size = imageView.frame.size
        
        imageView.af_setImageWithURL(
            NSURL(string: URLString)!,
            placeholderImage: nil,
            filter: AspectScaledToFillSizeFilter.init(size: size),
            imageTransition: .CrossDissolve(0.2)
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.af_cancelImageRequest()
        imageView.layer.removeAllAnimations()
        imageView.image = nil
    }
    
}
