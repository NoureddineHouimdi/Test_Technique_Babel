import UIKit
import TTGSnackbar
import Alamofire
import AlamofireImage
import UIColor_Hex_Swift
import GoogleMobileAds

class UtilsView: NSObject {
    
    static func hidRightButtonNav(navigationItem:UINavigationItem) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40.0, height: 50.0))
        
        let navBtnItem = UIBarButtonItem(customView: view)
        
        navigationItem.rightBarButtonItem = navBtnItem
    }
    
    static func hidLeftButtonNav(navigationItem:UINavigationItem) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40.0, height: 50.0))
        
        let navBtnItem = UIBarButtonItem(customView: view)
        
        navigationItem.leftBarButtonItem = navBtnItem
    }

    static func addIconeToNaveBar(navigationItem:UINavigationItem,frame: CGRect,image: UIImage,toResize: Bool,actionValue: Selector,parent: UIViewController,position: Int) -> Void {
        
        var resizedImage : UIImage!
        
        if toResize {
            let sacleSize = frame.size
            UIGraphicsBeginImageContextWithOptions(sacleSize, false, 0.0)
            image.draw(in: CGRect(x: 0, y: 0, width: sacleSize.width, height: sacleSize.height))
            resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        } else {
            resizedImage = image
        }
        //
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40.0, height: 50.0))//UIButton(frame: frame)
        view.backgroundColor = UIColor.clear
        
        
        let button = UIButton(frame: CGRect(x: (40-frame.size.width)/2, y: 7, width: frame.size.width, height: frame.size.height))
        //button.setImage(resizedImage, for: .normal)
        
        let img = UIImageView(image: resizedImage)
        
        img.frame = CGRect(x: (view.frame.size.width - img.frame.size.width) / 2, y: (view.frame.size.height - img.frame.size.height) / 2, width: img.frame.size.width, height: img.frame.size.height)
        
        view.addSubview(img)
        button.frame = view.frame
        view.addSubview(button)
        
        
        button.addTarget(parent, action: actionValue, for: .touchUpInside)
        
        let navBtnItem = UIBarButtonItem(customView: view)
        navBtnItem.action = actionValue
        navBtnItem.target = parent
        
        if position == 0 {
         navigationItem.leftBarButtonItem = navBtnItem
        } else {
         navigationItem.rightBarButtonItem = navBtnItem
        }
    }
    
    static func makeCornerViewWithColor(view:UIView) -> Void {
        view.layer.cornerRadius = view.frame.size.width / 20
        view.layer.borderWidth = 1.5
        view.clipsToBounds = true
    }
    
    static func makeRoundView(view:UIView) -> Void {
        view.layer.cornerRadius = view.frame.size.width / 2
        view.clipsToBounds = true
    }
    
    static func showMessage(_ message: String) {
        let tost = TTGSnackbar.init(message: message, duration: .middle)
        //tost.backgroundColor = UIColor(appBleuColor)
        tost.bottomMargin = 60
        tost.leftMargin = 20
        tost.rightMargin = 20
        
        tost.backgroundColor = UIColor.clear
        
       // let gradientLayer = Util.getGradientLayer(color1: appGradienColor1, color2: appGradienColor2, frame: CGRect(x: 0, y: 0, width: screen_with-40 , height: tost.frame.height))
        
       // gradientLayer.cornerRadius = 5
        
        //if tost.layer.sublayers == nil {
         //   tost.layer.addSublayer(gradientLayer)
        //}
        
        tost.show()
    }
    
    static func resizeUIImage(image:UIImage,size:CGSize) -> (UIImage) {
        //if (module == moduleEntreprise) || (module == moduleFederation)  {
         //   return image.scaled(to: size, scalingMode: .aspectFit) //no cropping
        //}
        return image.scaled(to: size, scalingMode: .aspectFill) // croppin
    }
    
    static func loadImage(imageView: UIImageView,imageTag: Int=0,imageName: String,module: String = "news") -> Void {
        
        var imageLink = ""
        
        if  imageName != "" {
            if module == "video" {
                imageLink = imageVideoDefault+imageName+"/default.jpg"
            } else
            if module == "news" {
                imageLink = imagePathNews+imageName
            } else
            if module == "results" {
                imageLink = imagePathResults+imageName
            } else {
                imageLink = imageName
            }
        } else {
            imageLink = imageDefault
        }
        
        
        print("**imageLink=",imageLink)
        
        Alamofire.request(imageLink).responseImage { response in
            debugPrint(response)
            print("**imageLinkrequest=",response.request)
            print("**imageLinkresponse=",response.response)
            debugPrint(response.result)
            
            guard response.result.isSuccess else {
                UtilsView.loadImage(imageView: imageView,imageTag: imageTag,imageName: imageName)
                return
            }
            
            if let image = response.result.value {
                    print("image downloaded2: \(image)")
                    //if imageView.tag == imageTag {
                   // imageView.image = image
                        imageView.image = UtilsView.resizeUIImage(image: image, size: CGSize(width: imageView.frame.size.width*2, height: imageView.frame.size.height*2))
                    //} else {
                     //   print("image downloaded not for this imageView")
                    //}
                
            }
        }
    }
    
    static func getGradientLayer(color1:String, color2:String, frame:CGRect) -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors =  [color1.isEmpty ? UIColor.clear : UIColor(color1)  ,color2.isEmpty ? UIColor.clear : UIColor(color2)].map{$0.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }
    
    static func openSite(siteV: String) {
        
        print("****site=",siteV)
        
        
        var site = siteV
        
        if site.range(of: "http://") == nil && site.range(of: "https://") == nil  {
            site = "http://" + site
            //Util.showMessage("Le lien est invalide")
            //return
        }
        
        
        
        guard let url = URL(string: site) else {
            UtilsView.showMessage("Le lien est invalide")
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    class func widthForView(value:Float) -> CGSize {
        return CGSize.init(width: screen_with - CGFloat(value), height: 0)
    }
    
    static func getSizeText(valueString: String,fontName: String,fontSize:Float,sizeValue:Float,buttonPadding:Float) -> CGSize {
        var size = CGSize.zero//
        
        if valueString.isEmpty {
            return size
        }
        
        let labelFont: UIFont? = UIFont(name: fontName, size: CGFloat(fontSize))//
        let systemFontAttrDict = [ NSAttributedStringKey.font : labelFont ]//
        
        
        let message = NSMutableAttributedString.init(string: valueString, attributes: systemFontAttrDict)//
        
        let rect: CGRect = message.boundingRect(with: UtilsView.widthForView(value:sizeValue), options: .usesLineFragmentOrigin, context: nil)//
        size = CGSize(width: rect.size.width, height: rect.size.height + CGFloat(buttonPadding))//
        
        return size
    }
    
    static func addPub(view: UIViewController) {
        let bannerView: GADBannerView = GADBannerView(adSize: kGADAdSizeBanner)
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.view.addSubview(bannerView)
        view.view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: view.bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view.view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = view
        
        bannerView.load(GADRequest())
    }
}
