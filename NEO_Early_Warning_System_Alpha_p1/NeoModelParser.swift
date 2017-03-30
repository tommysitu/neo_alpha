import Foundation

typealias JsonBlobData = Dictionary<String, AnyObject>

func parse(forPeriod data: JsonBlobData?) -> [Neo] {
  
  guard let data = data else { return [] }
  guard let objectData = data[JsonKey.near_earth_objects.rawValue] as? JsonBlobData else { return [] }
  
  var neosToReturn: [Neo] = []
  
  for day in objectData {
    if let dayData = day.value as? [JsonBlobData] {
      neosToReturn.append(contentsOf: parse(day: dayData))
    }
  }
  
  return neosToReturn
}

func parse(day data: [JsonBlobData]) -> [Neo] {
  
  return data.map() { neoData in
    parse(neoData: neoData)
  }
}

func parse(neoData data: JsonBlobData) -> Neo {
  
  let name = (data[JsonKey.name.rawValue] as? String) ?? "missing name data"
  let referenceId = (data[JsonKey.neo_reference_id.rawValue] as? String) ?? "missing name data"
  
  return Neo(name: name, referenceId: referenceId)
}
