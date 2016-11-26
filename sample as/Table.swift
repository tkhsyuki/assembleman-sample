

import Foundation
import SpriteKit
import UIKit


var Right = [String]()
var rnumber = 0

var Left = [String]()
var lnumber = 0

func addRight(color:String){
    Right.append(color)
    rnumber += 1
}


func addLeft(color:String){
    Left.append(color)
    lnumber += 1
}


/*引数として右か左かを受け取り組み合わせの国を返す関数*/
func judge(LorR:String)->String{
    var ans = ""
    //右配列
    if LorR == "R"{
        if Right[1] == "white"{
            
            if Right[0] == "blue" && Right[2] == "red"{
                ans = "フランス"
            }else if Right[0] == "green" {
                if Right[2] == "red" {
                    ans = "イタリア"
                }else if Right[2] == "green"{
                    ans = "ナイジェリア"
                }
            
            }else if Right[0] == "red" && Right[2] == "red"{
                    ans = "ペルー"
            }
        }else{
            ans = "buta"
        }
        
    //左配列
    }else if LorR == "L"{
        if Left[1] == "white"{
            if Left[0] == "blue" && Left[2] == "red"{
                ans = "フランス"
            }else if Left[0] == "green" {
                if Left[2] == "red" {
                    ans = "イタリア"
                }else if Left[2] == "green"{
                    ans = "ナイジェリア"
                }
                
            }else if Left[0] == "red" && Left[2] == "red"{
                ans = "ペルー"
            }
        }else{
            ans = "buta"
        }
    }else{
        ans = "buta"
    }
    return ans
}
