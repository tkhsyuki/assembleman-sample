//
//  LeftTable.swift
//  sample as
//
//  Created by takahashi yuki on 2016/12/11.
//  Copyright © 2016年 takahashi yuki.
import Foundation
import SpriteKit
import UIKit

class LeftTable{
    
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
    func addLeftTable(color:String,number:Int){
        
        switch color {
        case "red": switch number {
        case 0:LeftTable.red0 = true
        case 1:LeftTable.red1 = true
        case 2:LeftTable.red2 = true
        default:break
            }
        case "blue": switch number {
        case 0:LeftTable.blue0 = true
        case 1:LeftTable.blue1 = true
        case 2:LeftTable.blue2 = true
        default:break
            }
        case "green": switch number {
        case 0:LeftTable.green0 = true
        case 1:LeftTable.green1 = true
        case 2:LeftTable.green2 = true
        default:break
            }
        case "white": switch number {
        case 0:LeftTable.white0 = true
        case 1:LeftTable.white1 = true
        case 2:LeftTable.white2 = true
        default:break
            }
        default:break
        }
    }
    
    /*左配列の判定、どの国でもない場合はブタ*/
    func Lcheck()->String{
        if(LeftTable.blue0 == true && LeftTable.white1 == true && LeftTable.red2 == true ){
           
            return "フランス"
            
        }else if(LeftTable.red0 == true && LeftTable.white1 == true && LeftTable.red2 == true){
        
            return "ペルー"
            
        }else if(LeftTable.green0 == true && LeftTable.white1 == true && LeftTable.red2 == true){
            
            return "イタリア"
            
        }else if(LeftTable.green0 == true && LeftTable.white1 == true && LeftTable.green2 == true){
            
            return "ナイジェリア"
        }
                  return "ブタ"
    }
    
    
    /*左配列をリセット*/
    func Lreset(){
        LeftTable.red0 = false
        LeftTable.blue0 = false
        LeftTable.white0 = false
        LeftTable.green0 = false
        LeftTable.red1 = false
        LeftTable.blue1 = false
        LeftTable.white1 = false
        LeftTable.green1 = false
        LeftTable.red2 = false
        LeftTable.blue2 = false
        LeftTable.white2 = false
        LeftTable.green2 = false
    }
}
