import UIKit

var greeting = "codeleet"
var result = Array(repeating: 0, count: greeting.count)

func restoreString(_ s: String, _ indices: [Int]) -> String {
    var result = Array(repeating: "c", count: s.count)
    for (index, c) in s.enumerated() {
        result[indices[index]] = "\(c)"
    }
    return result.reduce("", { $0 + $1 })
}

func maximum69Number (_ num: Int) -> Int {
        var result = "\(num)".compactMap(\.wholeNumberValue)
        for (index, value) in result.enumerated() {
            if value == 6 {
                result[index] = 9
                break
            }
        }
    return Int(result.map { "\($0)" }
                .reduce("") {
                    $0 + $1
                })!
    }
//maximum69Number(669)
//restoreString(greeting, [4,5,6,7,0,2,1,3])
func minOperations(_ nums: [Int]) -> Int {
    var result = 0
    var nums = nums
    for i in 0 ... nums.count {
        if i == nums.count - 1 {
            break
        }
        if nums[i + 1] <= nums[i] {
            result += (nums[i] + 1) - nums[i + 1]
            nums[i+1] = nums[i] + 1
        }
    }
    return result
}
print(minOperations([1,2,1]))
