import Foundation
import Alamofire

//*********Alamofire Pattern Router*********

public enum ServicesRouter: URLRequestConvertible {
  
  //MARK: API URL PATH
  static var baseURLPath =  ws_path
  
  //MARK: API Token (if the Token is static for the api,else use the token of the user logged)
  static let authenticationToken = token
    
  
  
  //case login
  case pub()
  case categorie()
  case filtresResult()
  case news(String,String,String)
  case newsDetail(String)
  case resultats(String,String,String,String,String)
  case resultDetail(String)
  case calender(String,String,String)
  case filtresCalender()
  case lisVehicles(String,String,String,String,String,String,String)
  case list2M()
    
  //MARK: the method (post,get...) used for ech api,all api is post
  var method: HTTPMethod {
    switch self {
     /*case .categorie,.news,.newsDetail,.resultats,.filtresResult,.resultDetail,.calender,.filtresCalender,.pub,.lisVehicles:*/
        case .lisVehicles,.list2M:
       return .get
     default :
       return .post
    }
  }
  
  //MARK: API path,we do not have the path to add it in the api of crm but in the api of bridge yes
  var path: String {
    switch self {
    /*case .resultDetail :
        return ws_DetailResult
    case .categorie :
        return ws_categorie
    case .resultats :
        return ws_result
    case .news :
        return ws_news
    case .newsDetail :
        return ws_detail_news
    case .filtresResult :
        return ws_filtres_result
    case .calender :
        return ws_calender
    case .filtresCalender :
        return ws_filtresCalender
    case .pub :
        return ws_pub*/
    case .lisVehicles :
        return ws_vehicles
    case .list2M :
        return ws_2m
    default :
       return ""
    }
  }
    
  //MARK: API parameters
  public func asURLRequest() throws -> URLRequest {
    
    
    
    let parameters: [String: Any] = {  //[String: Any]
      switch self {
      
      ////////////////////////////////////////////////////////////////////////
        
      /*case  .categorie(), .filtresResult(), .filtresCalender(), .pub():
        return [:]
        
      case  .calender(let categorieAge, let typeEvent, let semester):
        let param = ["categorieAge": categorieAge, "typeEvent": typeEvent, "semester": semester]
        print("***calender=",param)
        return param
        
      case  .resultDetail(let idResult):
        let param = ["id": idResult]
        print("***resultDetail=",param)
        return param
      
      case  .newsDetail(let idNews):
        let param = ["id": idNews]
        print("***newsDetail=",param)
        return param
       
      case  .news(let categorie,let keyword,let page):
        let param = ["page": page,"categorie": categorie,"keyword": keyword]
        print("***listeNews=",param)
        return param
        
      case  .resultats(let annee,let competition,let age,let keyword,let page):
        let param = ["annee": annee,"competition": competition,"age": age,"keyword": keyword,"page": page]
        print("***listeResultats=",param)
        return param*/
      case .list2M:
        return [:]
      case  .lisVehicles(let auth_token,let updated_since,let sold,let limit,let offset,let order,let sort):
        let param = ["auth_token": auth_token,"updated_since": updated_since,"sold": sold,"limit": limit,"offset": offset,"order": order,"sort": sort]
        print("***listeResultats=",param)
        return param
      
      default://somme API without parametres
        return [:]
      }
    }()
    
    //so we have now the url with parametres
    
    
    ServicesRouter.baseURLPath =  ws_path
    
    let url = try ServicesRouter.baseURLPath.asURL()
    
    //create the request (we set the ur,method,token,timeOut)
    var request = URLRequest(url: url.appendingPathComponent(path))
    request.httpMethod = method.rawValue
    
    /*if UserStore.getCurrentUserBridge().tokenUser != nil {
       request.setValue("Bearer \(UserStore.getCurrentUserBridge().tokenUser!)", forHTTPHeaderField: "Authorization")
       print("***Bearer \(UserStore.getCurrentUserBridge().tokenUser!)")
    } else {*/
       request.setValue(ServicesRouter.authenticationToken, forHTTPHeaderField: "Authorization")
   // }
    
    request.timeoutInterval = TimeInterval(100 * 1000)
    
    return try URLEncoding.default.encode(request, with: parameters)
  }
}

