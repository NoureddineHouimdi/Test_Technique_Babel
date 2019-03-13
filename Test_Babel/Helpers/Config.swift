import Foundation
import UIKit

//prod: crm1.pactedeperformance.org
//dev:  crm1.itir.fr

//le pre-prod
//prod:
//dev:  http://192.168.1.74:8888/

//234 567 8
//the path of the main api (crm)  http://www.alljudo.net/images/flags/
let ws_path = "http://my2m.ma/api/front/fr"/*"http://192.168.1.74:8888/"*/
let imagePathNews = "http://www.alljudo.net/images/news/2018/"
let imagePathResults = "http://www.alljudo.net/images/flags/"
let imageDefault = "http://www.alljudo.net/images/news/2015/thumb_defaut.jpg"
let imageVideoDefault = "https://img.youtube.com/vi/" //JPbYeXddJuQ/default.jpg



let token = "Basic xxx" //in this api of the app we don't use token,but we used only in the auth bridge

 //liste des ws :
 /*
  la recherche par mot clé
  la recherche à proximité
  */

let ws_categorie = "list_cat.js"
let ws_news = "list.js"
let ws_detail_news = "Detail.js"
let ws_result = "listResultats.js"
let ws_filtres_result = "filtresResultats.js"
let ws_DetailResult = "DetailResult.js"
let ws_filtresCalender = "filtresCalender.js"
let ws_calender = "calender.js"
let ws_pub = "pub.js"
let ws_vehicles=""
let ws_2m=""

let screen_with = UIScreen.main.bounds.size.width
let screen_height = UIScreen.main.bounds.size.height
let screen_height_iphoneX = 734


//somme texte used in the app
let messageLoadData = "Chargement des données..."
let erreurConnexion = "Connexion Internet non disponible!"
let erreurMessageTimeOut = "La demande a échoué, réessaye automatique"

let formatDateOfAPI = "yyyy-MM-dd"
let formatDateOfAPI2 = "dd/MM/yyyy"
let formatDateOfAPP = "EEEE d MMM yyyy" //EEEE, MMM d, yyyy         d MMMM yyyy
let formatDateOfAPP2 = "d MMMM yyyy hh:mm:ss"
let formatDateOfAPP3 = "hh:mm"
let formatDateOfAPP4 = "dd/MM/yyyy"

let appDelegate = (UIApplication.shared.delegate as? AppDelegate)



let fontBold = "Roboto-Bold"
let fontRegular = "Roboto-Regular"
let fontMedium = "Roboto-Medium"

