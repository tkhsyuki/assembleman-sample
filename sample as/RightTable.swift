

import Foundation
import SpriteKit
import UIKit

class RightTable{
    
    static var red0 = false
    static var blue0 = false
    static var white0 = false
    static var green0 = false
    
    static var red1 = false
    static var blue1 = false
    static var white1 = false
    static var green1 = false
    
    static var red2 = false
    static var blue2 = false
    static var white2 = false
    static var green2 = false




    /*色,番号を指定してtrueに*/
    func addRightTable(color:String,number:Int){
        print(color,number)
        switch color {
            case "red": switch number {
                                case 0:RightTable.red0 = true
                                case 1:RightTable.red1 = true
                                case 2:RightTable.red2 = true
                                default:break
                            }
            case "blue": switch number {
                                case 0:RightTable.blue0 = true
                                case 1:RightTable.blue1 = true
                                case 2:RightTable.blue2 = true
                                default:break
                            }
            case "green": switch number {
                                case 0:
                                    
                                    RightTable.green0 = true
                                case 1:RightTable.green1 = true
                                case 2:RightTable.green2 = true
                                default:break
                            }
            case "white": switch number {
                                case 0:RightTable.white0 = true
                                case 1:RightTable.white1 = true
                                case 2:RightTable.white2 = true
                                default:break
                            }
            default:break
        }
    }
    
    /*右配列の判定、どの国でもない場合はブタ*/
    func Rcheck()->String{
        
        if(RightTable.blue0 == true && RightTable.white1 == true && RightTable.red2 == true ){
            return "フランス"
        }else if(RightTable.red0 == true && RightTable.white1 == true && RightTable.red2 == true){
            return "ペルー"
            
        }else if(RightTable.green0 == true && RightTable.white1 == true && RightTable.red2 == true){
            return "イタリア"
            
        }else if(RightTable.green0 == true && RightTable.white1 == true && RightTable.green2 == true){
            return "ナイジェリア"
        
        }else{
            return "ブタ"
        }
        
    }

    
    /*右配列をリセット*/
    func Rreset(){
        RightTable.red0 = false
        RightTable.blue0 = false
        RightTable.white0 = false
        RightTable.green0 = false
        RightTable.red1 = false
        RightTable.blue1 = false
        RightTable.white1 = false
        RightTable.green1 = false
        RightTable.red2 = false
        RightTable.blue2 = false
        RightTable.white2 = false
        RightTable.green2 = false
    }
}
