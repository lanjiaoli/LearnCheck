import UIKit

//var str = "Hello, playground"
//
////数组
///*
// 数组是一个容器,它以有序的方式存储相同类型的元素，并且允许随机访问每个元素
// */
//
////code
//let fibs = [0,1,2,3,4]
//
//var mutableFibs = [0,1,2,3,4]
////添加元素
//mutableFibs.append(5)
////添加一组数组
//mutableFibs.append(contentsOf: [6,7,8])
//
///*
// 和标准库中所有集合类型一样，数组是具有值语义的。当你把一个已经存在的数组赋值另一个变量时，这个数组的内容会被复制。
// */
//
//var x = [1,2,3]
//var y = x
//y.append(4)
//
//
//let a = NSMutableArray(array: [1,2,3])
//let b : NSArray = a
//a.insert(4, at: 3)
////它的特性并不能保证这个数组不会被改变
//print(b)//[1, 2, 3, 4]
//
//let c = a.copy() as! NSArray
//
//a.insert(5, at: 4)
//c
//
////MARK:数组索引
//let array = [1,2,3,4,5]
////迭代数组
//for value in array {
//    print(value)
//}
////迭代除了第一个元素意外的数组 其余部分
//for value in array.dropFirst() {
//    print(value)
//}
//print("分割线")
////想要迭代除了最后5个元素意外的数组
//for value in array.dropLast(2) {
//    print(value)
//}
//print("分割线")
////想要列举数组中的元素和对应的下标
//for (index, value) in array.enumerated(){
//    print("下标:\(index):" +  "值\(value)")
//}
//
//// map
////对数组进行变换
//let squares = fibs.map{fib in fib * fib}
//squares
//
//let flatMaps = squares.compactMap{fib in fib + 1}
//flatMaps
//
//let filter = squares.filter { (index) -> Bool in
//    return false
//}
//filter



//for (previous, current) in zip(array, array.dropFirst()) {
//    if previous == current {
//        result[result.endIndex - 1].append(current)
//    }else{
//        result.append([current])
//    }
//
//}

//debugPrint(result) //[[1], [2, 2, 2], [3], [4], [5]]


extension Array {
    func splitTest(where condition:(Element,Element) -> Bool) ->[[Element]]{
        var result:[[Element]] = self.isEmpty ? [] : [[self[0]]]
        for (previous, current) in zip(self, self.dropFirst()) {
            if condition(previous,current) {
                result.append([current])
            }else{
                result[result.endIndex - 1].append(current)
            }
        }
        return result
    }
    func accumulate<Result>(_ initialResult : Result, _ nextPartialResult:(Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return map { next in
            running = nextPartialResult(running,next)
            return running
        }
    }
}

//let array :[Int] = [1,2,2,2,3,4,5]
//var parts  = array.splitTest{$0 != $1}
//debugPrint(parts)

let result =  [1,2,3,4].accumulate(0, +)
debugPrint(result) //[1, 3, 6, 10]

