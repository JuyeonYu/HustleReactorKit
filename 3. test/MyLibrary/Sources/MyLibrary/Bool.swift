
public extension Bool {
    init?(bit: Int) {
        switch  bit {
        case 0:
            self = false
        case 1:
            self = true
        default:
            return nil
        }
    }
}
