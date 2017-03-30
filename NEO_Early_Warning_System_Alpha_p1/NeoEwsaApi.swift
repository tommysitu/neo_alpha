import Foundation

enum Api {
  case fetchNeos
}

extension Api {
  var url: UrlString {
    switch self {
    case .fetchNeos:
      return "\(NetworkConfig.serverProtocol)://\(NetworkConfig.baseUrl)/neo/rest/v1/feed?\(startAndEndDateString())&api_key=\(NetworkConfig.apiKey)"
    }
  }
}

func startAndEndDateString() -> String {
  
  let today = Date()
  let calendar = Calendar.current
  let year = calendar.component(.year, from: today)
  let month = calendar.component(.month, from: today)
  let day = calendar.component(.day, from: today)
  
  let monthString = month < 10 ? "0\(month)" : "\(month)"
  let dayString = day < 10 ? "0\(day)" : "\(day)"
  
  let aWeekInTheFuture = calendar.date(byAdding: .day, value: 7, to: today)
  
  let yearInFuture = calendar.component(.year, from: aWeekInTheFuture!)
  let monthInFuture = calendar.component(.month, from: aWeekInTheFuture!)
  let dayInFuture = calendar.component(.day, from: aWeekInTheFuture!)

  let futureMonthString = monthInFuture < 10 ? "0\(monthInFuture)" : "\(monthInFuture)"
  let futureDayString = day < 10 ? "0\(dayInFuture)" : "\(dayInFuture)"
  
  return "start_date=\(year)-\(monthString)-\(dayString)&end_date=\(yearInFuture)-\(futureMonthString)-\(futureDayString)"
}
