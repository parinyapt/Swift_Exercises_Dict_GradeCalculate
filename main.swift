//Create Date 02-04-2022
//64130010049 Parinya Termkasipanich
import Foundation

var data:[String:[String:Float]] = [:]
var grade:[String:String] = [:]
var config_stdnumber:Int = 0
var menu_select:Int = 0
var use_status:Bool = true
var max_str:Int = 5

var temp_text:String = ""
var temp_status:Bool = false
var temp_count:Int = 1
var temp_name:String = ""

repeat{
  print("""
  == Menu ==
  1 > ตั้งค่าจำนวนนักเรียน
  2 > กรอกข้อมูลนักเรียนทั้งหมด
  3 > ประมวลผลผลการเรียน
  4 > ค้นหาข้อมูล
  5 > แสดงรายชื่อผู้ที่ได้คะแนนสูงสุดและต่ำสุด
  6 > แสดงข้อมูลทั้งหมดเรียงลำดับมากไปน้อยตามคะแนน
  7 > ออกจากโปรแกรม
  """)
  repeat {
    temp_status = false
    print("โปรดพิมพ์ตัวเลขเพื่อเลือกเมนูที่ต้องการ : ",terminator: "")
    temp_text = readLine()!
    if Int(temp_text) != nil && temp_text != "" {
      menu_select = Int(temp_text)!
      temp_status = true
    }
  }while(temp_status == false)

  if(menu_select == 1) {
  //menu 1 begin
    repeat {
      temp_status = false
      print("ระบุจำนวนนักเรียน (>= \(data.count)) : ",terminator: "")
      temp_text = readLine()!
      if Int(temp_text) != nil && Int(temp_text)! > 0 {
        if(Int(temp_text)! >= data.count){
          config_stdnumber = Int(temp_text)!
          temp_status = true
        }else{
          print("แจ้งเตือน! -> ไม่สามารถตั้งค่าจำนวนนักเรียนได้ เนื่องจากจำนวนข้อมูลนักเรียนในฐานข้อมูล(\(data.count))มีจำนวนมากกว่าจำนวนนักเรียนที่ต้องการตั้งค่า โปรดลองใหม่อีกครั้ง")
        }
      }
    }while(temp_status == false)
  //menu 1 end
  }else if(menu_select == 2){
  //menu 2 begin 
    if data.count < config_stdnumber {
      temp_count = data.count + 1
      while(temp_count <= config_stdnumber) {
        print("---- ข้อมูลนักเรียนคนที่ \(temp_count) ----")
        
        temp_name = ""
        
        repeat {
          temp_status = false
          print("ระบุชื่อนักเรียนคนที่ \(temp_count) : ",terminator: "")
          temp_text = readLine()!
          if Int(temp_text) == nil && Float(temp_text) == nil && temp_text != "" {
            // data.append(String(temp_text): [:])
            if(data[temp_text] == nil) {
              data[temp_text] = [:]
              temp_name = temp_text
              temp_status = true
            }else{
              print("แจ้งเตือน! -> ไม่สามารถเพิ่มชื่อนักเรียนได้ เนื่องจากชื่อ '\(temp_text)' ซ้ำในฐานข้อมูล โปรดลองใหม่อีกครั้ง")
            }
          }
        }while(temp_status == false)
  
        // print(Array(data.keys)[temp_count].count)
        if temp_name.count > max_str {
          max_str = temp_name.count
        }
        
        repeat {
          temp_status = false
          print("ระบุคะแนนสอบครั้งที่ 1 นักเรียนคนที่ \(temp_count) : ",terminator: "")
          temp_text = readLine()!
          if Float(temp_text) != nil && Float(temp_text)! >= 0 && Float(temp_text)! <= 100 {
            // score1.append(Float(temp_input)!)
            data[temp_name]!["score1"] = Float(temp_text)!
            temp_status = true
          }
        }while(temp_status == false)
        
        repeat {
          temp_status = false
          print("ระบุคะแนนสอบครั้งที่ 2 นักเรียนคนที่ \(temp_count) : ",terminator: "")
          temp_text = readLine()!
          if Float(temp_text) != nil && Float(temp_text)! >= 0 && Float(temp_text)! <= 100 {
            data[temp_name]!["score2"] = Float(temp_text)!
            temp_status = true
          }
        }while(temp_status == false)
        
        repeat {
          temp_status = false
          print("ระบุคะแนนสอบครั้งที่ 3 นักเรียนคนที่ \(temp_count) : ",terminator: "")
          temp_text = readLine()!
          if Float(temp_text) != nil && Float(temp_text)! >= 0 && Float(temp_text)! <= 100 {
            data[temp_name]!["score3"] = Float(temp_text)!
            temp_status = true
          }
        }while(temp_status == false)

        data[temp_name]!["total"] = ((data[temp_name]!["score1"]!*25)/100) + ((data[temp_name]!["score2"]!*25)/100) + ((data[temp_name]!["score3"]!*50)/100)
      
        temp_count += 1
      }
    }else{
      print("แจ้งเตือน! -> ไม่สามารถกรอกข้อมูลนักเรียนได้ เนื่องจากมีข้อมูลครบตามจำนวนนักเรียนที่ตั้งค่าแล้ว(จำนวนที่ตั้งค่าไว้ = \(config_stdnumber)) โปรดตั้งค่าจำนวนนักเรียนเพิ่มและลองใหม่อีกครั้ง")
    }
  //menu 2 end
  }else if(menu_select == 3){
  //menu 3 begin
    if data.count > 0 {
      grade = [:]
      for (key,value) in data {
        if value["total"]! >= 85 {
          grade[key] = "A"
        }else if value["total"]! >= 70 {
          grade[key] = "B"
        }else if value["total"]! >= 50 {
          grade[key] = "C"
        }else if value["total"]! >= 40 {
          grade[key] = "D"
        }else {
          grade[key] = "E"
        }
        print("\(key) ผลการเรียน \(grade[key] ?? "ไม่พบข้อมูล")")
      }
      print("ประมวลผลผลการเรียนเสร็จสมบูรณ์")
    }else{
      print("แจ้งเตือน! -> โปรดกรอกข้อมูลนักเรียนอย่างน้อย 1 คนเพื่อประมวลผลผลการเรียน")
    }
  //menu 3 end
  }else if(menu_select == 4){
  //menu 4 begin
    if data.count > 0 {
      temp_name = ""
      repeat {
        temp_status = false
        print("ระบุชื่อนักเรียนที่ต้องการค้นหา : ",terminator: "")
        temp_text = readLine()!
        if Int(temp_text) == nil && Float(temp_text) == nil && temp_text != "" {
          if(data[temp_text] != nil) {
            temp_name = temp_text
            temp_status = true
          }else{
            print("แจ้งเตือน! -> ไม่พบข้อมูลนักเรียนที่ต้องการค้นหา โปรดลองใหม่อีกครั้ง")
          }
        }
      }while(temp_status == false)
      print("\("Name".withCString { String(format: "%-"+String(max_str)+"s", $0) }) | Test1 | Test2 | Test3 | Total | Grade")
      print("\(temp_name.withCString { String(format: "%-"+String(max_str)+"s", $0) })  \(String(format: "%6.2f", data[temp_name]!["score1"] ?? "ไม่พบข้อมูล")) \(String(format: "%7.2f", data[temp_name]!["score2"] ?? "ไม่พบข้อมูล")) \(String(format: "%7.2f", data[temp_name]!["score3"] ?? "ไม่พบข้อมูล")) \(String(format: "%7.2f", data[temp_name]!["total"] ?? "ไม่พบข้อมูล")) \t\(grade[temp_name] ?? "ยังไม่ประมวลผล")")
    }else{
      print("แจ้งเตือน! -> โปรดกรอกข้อมูลนักเรียนอย่างน้อย 1 คนเพื่อค้นหาข้อมูล")
    }
  //menu 4 end
  }else if(menu_select == 5){
  //menu 5 begin
    if data.count > 0 {
      let max = data.max { a, b in a.value["total"]! < b.value["total"]! }
      let min = data.min { a, b in a.value["total"]! < b.value["total"]! }
      
      print("== สูงสุด ==\n\("Name".withCString { String(format: "%-"+String(max_str)+"s", $0) }) | Test1 | Test2 | Test3 | Total | Grade")
      temp_text = max?.key ?? "-"
      print("\(temp_text.withCString { String(format: "%-"+String(max_str)+"s", $0) })  \(String(format: "%6.2f", max?.value["score1"] ?? "ไม่พบข้อมูล")) \(String(format: "%7.2f", max?.value["score2"] ?? "ไม่พบข้อมูล")) \(String(format: "%7.2f", max?.value["score3"] ?? "ไม่พบข้อมูล")) \(String(format: "%7.2f", max?.value["total"] ?? "ไม่พบข้อมูล")) \t\(grade[temp_text] ?? "ยังไม่ประมวลผล")")
      
      print("== ต่ำสุด ==\n\("Name".withCString { String(format: "%-"+String(max_str)+"s", $0) }) | Test1 | Test2 | Test3 | Total | Grade")
      temp_text = min?.key ?? "-"
      print("\(temp_text.withCString { String(format: "%-"+String(max_str)+"s", $0) })  \(String(format: "%6.2f", min?.value["score1"] ?? "ไม่พบข้อมูล")) \(String(format: "%7.2f", min?.value["score2"] ?? "ไม่พบข้อมูล")) \(String(format: "%7.2f", min?.value["score3"] ?? "ไม่พบข้อมูล")) \(String(format: "%7.2f", min?.value["total"] ?? "ไม่พบข้อมูล")) \t\(grade[temp_text] ?? "ยังไม่ประมวลผล")")
    }else{
      print("แจ้งเตือน! -> โปรดกรอกข้อมูลนักเรียนอย่างน้อย 1 คนเพื่อแสดงรายชื่อผู้ที่ได้คะแนนสูงสุดและต่ำสุด")
    }
  //menu 5 end
  }else if(menu_select == 6){
  //menu 6 begin 
    if data.count > 0 {
      let sortedData = data.sorted {
        return $0.value["total"]! > $1.value["total"]!
      }
      print("\nNo. | \("Name".withCString { String(format: "%-"+String(max_str)+"s", $0) }) | Test1 | Test2 | Test3 | Total | Grade")
      for (index, data) in sortedData.enumerated() {
        // print(data.key)
        temp_text = data.key
        print("\(String(format: "%2d", (index+1))) \t  \(temp_text.withCString { String(format: "%-"+String(max_str)+"s", $0) })  \(String(format: "%6.2f", data.value["score1"] ?? "ไม่พบข้อมูล")) \(String(format: "%7.2f", data.value["score2"] ?? "ไม่พบข้อมูล")) \(String(format: "%7.2f", data.value["score3"] ?? "ไม่พบข้อมูล")) \(String(format: "%7.2f", data.value["total"] ?? "ไม่พบข้อมูล")) \t\(grade[temp_text] ?? "ยังไม่ประมวลผล")")
      }
    }else{
      print("แจ้งเตือน! -> โปรดกรอกข้อมูลนักเรียนอย่างน้อย 1 คนเพื่อแสดงข้อมูลทั้งหมด")
    }
  //menu 6 end 
  }else if(menu_select == 7){
  //menu 7 begin 
    print("""
    การออกจากโปรแกรมจะมีผลให้ข้อมูลทั้งหมดได้รับการลบและจะไม่สามารถกู้คืนได้อีก
    -พิมพ์ Y เพื่อยืนยันการออกจากโปรแกรม
    -พิมพ์ N เพื่อยกเลิก
    ตัวอักษรยืนยัน : 
    """,terminator: "")
    temp_text = String(readLine()!)
    if temp_text == "Y" {
      use_status = false
    }
  //menu 7 end 
  }else{
  //no menu begin 
    print("แจ้งเตือน! -> ไม่พบเมนูที่คุณเลือก โปรดลองใหม่อีกครั้ง")
  //no menu end
  }
  
}while(use_status != false)

// data = [
//   "Samit1": [
//     "score1": 10.58,
//     "score2": 10.58,
//     "score3": 10.58,
//     "total": 18.2
//   ],
//   "Samidt2": [
//     "score1": 9.54,
//     "score2": 458,
//     "score3": 158,
//     "total": 1.2
//   ]
//   ,
//   "Samidt3": [
//     "score1": 9.54,
//     "score2": 458,
//     "score3": 158,
//     "total": 133
//   ],
//   "Samidt4": [
//     "score1": 9.54,
//     "score2": 458,
//     "score3": 158,
//     "total": 10
//   ]
// ]
// let sortedTwo = data.sorted {
//   print($0)
//   print($1)
//     return $0.value["total"]! < $1.value["total"]!
// }
// print(data)