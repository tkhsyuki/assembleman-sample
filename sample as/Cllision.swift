
import Foundation

enum CollisionMember {
    case Attack
    case AttackBar
    case Enemy
    case Dragon
    case Edge
    
    func toInt() ->UInt32{
        switch self{
        case CollisionMember.Attack:
            return 0x1 << 1
        case CollisionMember.AttackBar:
            return 0x1 << 2
        case CollisionMember.Enemy:
            return 0x1 << 3
        case CollisionMember.Dragon:
            return 0x1 << 4
        case CollisionMember.Edge:
            return 0x1 << 5
        default:
            return 0x1 << 0
        }
    }
}
