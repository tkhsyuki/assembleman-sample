

import Foundation
import SpriteKit
import UIKit

class RightTable{
    
    var red0 = false
    var blue0 = false
    var white0 = false
    var green0 = false
    
    var red1 = false
    var blue1 = false
    var white1 = false
    var green1 = false
    
    var red2 = false
    var blue2 = false
    var white2 = false
    var green2 = false




    /*色,番号を指定してtrueに*/
    func addRightTable(color:String,number:Int){
        
        switch color {
            case "red": switch number {
                                case 0:red0 = true
                                case 1:red1 = true
                                case 2:red2 = true
                                default:break
                            }
            case "blue": switch number {
                                case 0:blue0 = true
                                case 1:blue1 = true
                                case 2:blue2 = true
                                default:break
                            }
            case "green": switch number {
                                case 0:green0 = true
                                case 1:green1 = true
                                case 2:green2 = true
                                default:break
                            }
            case "white": switch number {
                                case 0:white0 = true
                                case 1:white1 = true
                                case 2:white2 = true
                                default:break
                            }
            default:break
        }
    }
    
    /*右配列の判定、どの国でもない場合はブタ*/
    func Rcheck()->String{
        if(red0 == true && white1 == true && blue2 == true ){
             self.Rreset()
            return "フランス"
           
        }else if(red0 == true && white1 == true && red2 == true){
            self.Rreset()
            return "ペルー"
            
        }else if(red0 == true && white1 == true && green2 == true){
            self.Rreset()
            return "イタリア"
            
        }else if(green0 == true && white1 == true && green2 == true){
            self.Rreset()
            return "ナイジェリア"
        
        }else{
            self.Rreset()
            return "ブタ"
        }
    
    
    }

    
    /*右配列をリセット*/
    func Rreset(){
        self.red0 = false
        self.blue0 = false
        self.white0 = false
        self.green0 = false
        self.red1 = false
        self.blue1 = false
        self.white1 = false
        self.green1 = false
        self.red2 = false
        self.blue2 = false
        self.white2 = false
        self.green2 = false
    }
}
