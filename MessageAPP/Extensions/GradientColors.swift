//
//  GradientColors.swift
//  Cooper Teste
//
//  Created by Mauro Figueiredo on 18/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import UIKit

public enum GradientColors: String{
    case cherryBlossoms
    case dirtyFog
    case almost
    case moor
    case aqualicious
    case siriusTamed
    case jonquil
    case alostmemory
    case blurrybeach
    case daytripper
    case pinotnoir
    case miaka
    case influenza
    case calmdarya
    case stellar
    case moonrise
    case peach
    case dracula
    case mantle
    case titanium
    case seablizz
    case mystic
    case shroomhaze
    case borabora
    case veniceblue
    case electricviolet
    case kashmir
    case steelgray
    case pinky
    case purpleparadise
    case aubergine
    case rosewater
    case montecarlo
    var  gradient: (first: UIColor, second: UIColor){
        switch self {
        case .cherryBlossoms:
            return (UIColor(hexString: "#fbd3e9"), UIColor(hexString: "bb377d"))
        case .dirtyFog:
            return (UIColor(hexString: "#b993d6"),UIColor(hexString: "#8ca6db"))
        case .almost:
            return (UIColor(hexString:"#ddd6f3"),UIColor(hexString: "#faaca8"))
        case .moor:
            return (UIColor(hexString:"#616161"),UIColor(hexString: "#9bc5c3"))
        case .aqualicious:
             return (UIColor(hexString:"#50c9c3"),UIColor(hexString: "#96deda"))
        case .siriusTamed:
            return (UIColor(hexString:"#efefbb"),UIColor(hexString: "#d4d3dd"))
        case .jonquil:
            return (UIColor(hexString:"#ffeeee"),UIColor(hexString: "#ddefbb"))
        case .alostmemory:
            return (UIColor(hexString:"#de6262"),UIColor(hexString: "#ffb88c"))
       case .blurrybeach:
            return (UIColor(hexString:"#d53369"),UIColor(hexString: "#cbad6d"))
       case .daytripper:
            return (UIColor(hexString:"#f857a6"),UIColor(hexString: "#ff5858"))
        case .pinotnoir:
            return (UIColor(hexString: "#4b6cb7"),UIColor(hexString: "#182848"))
        case .miaka:
            return (UIColor(hexString:"#fc35ac"),UIColor(hexString: "#0abfbc"))
        case .influenza:
            return (UIColor(hexString:"#c04848"),UIColor(hexString: "#480048"))
        case .calmdarya:
            return (UIColor(hexString:"#5f2c82"),UIColor(hexString: "#49a09d"))
        case .stellar:
            return (UIColor(hexString:"#7474bf"),UIColor(hexString: "#348ac7"))
        case .moonrise:
            return (UIColor(hexString:"#dae2f8"),UIColor(hexString: "#d6a4a4"))
        case .peach:
             return (UIColor(hexString:"#ed4264"),UIColor(hexString: "#ffedbc"))
        case .dracula:
             return (UIColor(hexString:"#dc2424"),UIColor(hexString: "#4a569d"))
        case .mantle:
             return (UIColor(hexString:"#24c6dc"),UIColor(hexString: "#514a9d"))
        case .titanium:
             return (UIColor(hexString:"#283048"),UIColor(hexString: "#859398"))
        case .seablizz:
             return (UIColor(hexString:"#1cd8d2"),UIColor(hexString: "#93edc7"))
        case .mystic:
             return (UIColor(hexString:"#757f9a"),UIColor(hexString: "#d7dde8"))
        case .shroomhaze:
             return (UIColor(hexString:"#5c258d"),UIColor(hexString: "#4389a2"))
        case .borabora:
            return (UIColor(hexString:"#2bc0e4"),UIColor(hexString: "#eaecc6"))
        case .veniceblue:
            return (UIColor(hexString:"#085078"),UIColor(hexString: "#85d8ce"))
        case .electricviolet:
            return (UIColor(hexString:"#4776e6"),UIColor(hexString: "#8e54e9"))
        case .kashmir:
            return (UIColor(hexString:"#614385"),UIColor(hexString: "#516395"))
        case .steelgray:
            return (UIColor(hexString:"#1f1c2c"),UIColor(hexString: "#928dab"))
        case .pinky:
            return (UIColor(hexString:"#dd5e89"),UIColor(hexString: "#f7bb97"))
        case .purpleparadise:
            return (UIColor(hexString:"#1d2b64"),UIColor(hexString: "#f8cdda"))
        case .aubergine:
            return (UIColor(hexString:"#aa076b"),UIColor(hexString: "#61045f"))
        case .rosewater:
            return (UIColor(hexString:"#e55d87"),UIColor(hexString: "#5fc3e4"))
        case .montecarlo:
            return (UIColor(hexString:"#cc95c0"),UIColor(hexString: "#7aa1d2"))
        }
    }
}
