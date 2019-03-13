import UIKit
import ObjectMapper

class UtilModel: NSObject {

    static var isTimeOut = 0
    
    static func getArrayOfEntity<Item:BaseMappable>(responseJSON: NSArray) -> ([Item]) {
        
        let dicData = responseJSON.compactMap({ dict in
            //print("***ID=",dict["id"])
            return dict as? Dictionary<String, Any>
        })
        
        //print("**dicData=",dicData)
        
        //***transform the dic to arry of entity Item
        var dataForTableView: [Item] = []
        for objDic in dicData {
            let obj = Mapper<Item>().map(JSON: objDic)
            dataForTableView.append(obj!)
        }
        
        return dataForTableView
    }
    
    static func getEntityFromJSON<Item:BaseMappable>(responseJSON: NSDictionary) -> (Item) {
        let user = Mapper<Item>().map(JSON: responseJSON as! [String : Any])
        return user!
    }
    
    static func getDateFromString(formDataAPI:String,formatWanted:String,dateAPI:String) -> String {
        let array = dateAPI.components(separatedBy: "T")
        var dateOrigine:String = ""
        if  array.count == 2 {
            dateOrigine = array[0]
        } else {
            dateOrigine = dateAPI
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formDataAPI // "yyyy-MM-dd
        dateFormatter.locale = NSLocale(localeIdentifier: "fr") as Locale!
        guard let date = dateFormatter.date(from: dateOrigine) else {
            return dateAPI
            //fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
        // again convert your date to string
        dateFormatter.dateFormat = formatWanted //"EEEE, MMM d, yyyy"
        
        let dateString = dateFormatter.string(from: date)
        
        return dateString
        
        let dateArr = dateString.components(separatedBy: " ")
        
        
        let day: String = dateArr[0]
        let month: String = dateArr[1]
        let year: String = dateArr[2]
        
        
        return "\(day) \(month.uppercased()) \(year)"
        //return dateString
    }
    
    static func openMail(mail: String) {
        print("****mail=",mail)
        
        if let url = URL(string: "mailto:\(mail)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                // Fallback on earlier versions
            }
        }
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
            //Util.showMessage("Le lien est invalide")
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    static func callNumber(number: String) -> Void{
        //06 23 53 31 56
        let trimmedString = number.removeWhitespace()
        guard let number = URL(string: "tel://" + trimmedString) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(number)
        } else {
            // Fallback on earlier versions
        }
        print("****number=",number)
    }
    
}
