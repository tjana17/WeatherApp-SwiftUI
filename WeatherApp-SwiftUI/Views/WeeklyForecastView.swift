//
//  WeeklyForecastView.swift
//  WeatherApp-SwiftUI
//
//  Created by DB-MBP-023 on 06/05/24.
//

import SwiftUI

struct WeeklyForecastView: View {
    @Environment(\.dismiss) var dismiss
    var forecast: ForecastModel
    
    var body: some View {
        NavigationView {
            VStack (alignment:.leading) {
                VStack(alignment:.leading) {
                    //Heading
                    HStack {
                        Text("Forecast Weather")
                            .font(.custom("Avenir Next", fixedSize: 19)).bold()
                            .foregroundStyle(.white)
                        Spacer()
                        Button("Dismiss") {
                            dismiss()
                        }
                    }.padding()
                    
                    //Forecast
                    VStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .leading) {
                                ForEach(1..<6) { index in
                                    let currentDate =  Calendar.current.date(byAdding: .day, value: index, to: Date())
                                    let date = currentDate?.stringFromDateYear(format: currentDate ?? Date())
                                    Text(date ?? "")
                                        .foregroundColor(.white)
                                        .font(.custom("Avenir Next", fixedSize: 19)).bold()
                                    Spacer()
                                    
                                    //Horizontal Scroll forecast
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(0..<forecast.list.count) { index in
                                                let date = Date(timeIntervalSince1970: TimeInterval(forecast.list[index].dt))
                                                let indexDate = date.stringYearMonthDate(date: date)
                                                let currDate = currentDate?.stringYearMonthDate(date: currentDate ?? Date())
                                                if indexDate == currDate {
                                                    TodayCardView(imageTxt: "https://openweathermap.org/img/wn/\(forecast.list[index].weather[0].icon)@2x.png",
                                                                  degreeTxt: "\(forecast.list[index].main.feelsLike.roundDouble())°",
                                                                  timeTxt: "\(OpenWeatherAPI().epochTime(Double(forecast.list[index].dt)))", feelsLikeTxt: forecast.list[index].weather[0].main)
                                                }
                                                
                                            }
                                            
                                        }
                                    }
                                }
                            }
                            
                            
                        }
                    } .padding()
                    
                }
                .background(Color(.black))
            }
        }
    }
}

#Preview {
    WeeklyForecastView(forecast: forecastPreview)
}
