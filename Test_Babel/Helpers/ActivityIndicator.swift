import UIKit
import NVActivityIndicatorView


class ActivityIndicator: UIViewController,NVActivityIndicatorViewable {

    func lanchingOpacView(){
        
        showLoader(messageValue:"")
    }
    
    func lanchingLoaderMore(view : UIView,messageValue :String ){
        if messageValue.isEmpty {
            let size = CGSize(width: 0, height: 0)
            
            self.startAnimating(size, message: messageValue, type: NVActivityIndicatorType(rawValue: 0)!)
            return
        }
        
        let size = CGSize(width: 30, height: 30)
        
        self.startAnimating(size, message: messageValue, type: NVActivityIndicatorType(rawValue: 3)!)
        
        /*DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
         NVActivityIndicatorPresenter.sharedInstance.setMessage("Authenticating2...")
         }*/
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            //self.stopAnimating()
        }
    }
    
    func lanchingLoaderMore2(view : UIView,messageValue :String ){
        _ = 7
        _ = 2
        let cellWidth = 30
        let cellHeight = 30
        
        (NVActivityIndicatorType.ballPulse.rawValue ... NVActivityIndicatorType.squareSpin.rawValue).forEach {
            let x = 0 //($0 - 1) % cols * cellWidth
            let y = 0 //($0 - 1) / cols * cellHeight
            let frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
            let activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                                type: NVActivityIndicatorType(rawValue: $0)!)
            let animationTypeLabel = UILabel(frame: frame)
            
            animationTypeLabel.text = String($0)
            animationTypeLabel.sizeToFit()
            animationTypeLabel.textColor = UIColor.clear
            animationTypeLabel.frame.origin.x += 5
            animationTypeLabel.frame.origin.y += CGFloat(cellHeight) - animationTypeLabel.frame.size.height
            
            activityIndicatorView.padding = 20
            if $0 == NVActivityIndicatorType.orbit.rawValue {
                activityIndicatorView.padding = 0
            }
            //view.addSubview(activityIndicatorView)
            //view.addSubview(animationTypeLabel)
            activityIndicatorView.startAnimating()
            
        }
        //call the fonction to show the loader in the parent view
        showLoader(messageValue:messageValue)
    }
    
    
    func lanchingLoader(view : UIView,messageValue :String ){
        let cols = 14
        let rows = 8
        let cellWidth = Int(view.frame.width / CGFloat(cols))
        let cellHeight = Int(view.frame.height / CGFloat(rows))
        
        (NVActivityIndicatorType.ballPulse.rawValue ... NVActivityIndicatorType.squareSpin.rawValue).forEach {
            let x = ($0 - 1) % cols * cellWidth
            let y = ($0 - 1) / cols * cellHeight
            let frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
            let activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                                type: NVActivityIndicatorType(rawValue: $0)!)
            let animationTypeLabel = UILabel(frame: frame)
            
            animationTypeLabel.text = String($0)
            animationTypeLabel.sizeToFit()
            animationTypeLabel.textColor = UIColor.clear
            animationTypeLabel.frame.origin.x += 5
            animationTypeLabel.frame.origin.y += CGFloat(cellHeight) - animationTypeLabel.frame.size.height
            
            activityIndicatorView.padding = 20
            if $0 == NVActivityIndicatorType.orbit.rawValue {
                activityIndicatorView.padding = 0
            }
            //view.addSubview(activityIndicatorView)
            //view.addSubview(animationTypeLabel)
            activityIndicatorView.startAnimating()
            
        }
        //call the fonction to show the loader in the parent view
        showLoader(messageValue:messageValue)
    }
    
    func showLoader(messageValue :String){
        if messageValue.isEmpty {
            let size = CGSize(width: 0, height: 0)
            
            self.startAnimating(size, message: messageValue, type: NVActivityIndicatorType(rawValue: 0)!)
            return
        }
        
        let size = CGSize(width: 30, height: 30)
        
        self.startAnimating(size, message: messageValue, type: NVActivityIndicatorType(rawValue: 1)!)
        
        /*DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("Authenticating2...")
        }*/
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            //self.stopAnimating()
        }
    }
    
    func closeLoader(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.stopAnimating()
        }
    }
   

    
}
