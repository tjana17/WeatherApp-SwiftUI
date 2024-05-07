//
//  WeatherView.swift
//  WeatherApp-SwiftUI
//
//  Created by DB-MBP-023 on 12/04/24.
//

import SwiftUI

struct WeatherView: View {
    
    var weather: OpenWeatherModel
    var forecast: ForecastModel
    @State private var isPresented = false
    
    var body: some View {
//        NavigationView {
            VStack {
                VStack {
                    VStack(alignment: .leading) {
                        VStack(alignment: .center) {
                            Text(weather.name)
                                .font(.custom("Futura", fixedSize: 22).bold())
                            Text("\(Date().formatted(.dateTime.month().day().hour().minute().weekday()))")
                                .font(.custom("Futura", fixedSize: 19))
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width, height: 160)
                        .background(Color(.blue))
                    }
                    VStack(alignment: .center) {
                        VStack {
                            VStack(alignment: .center){
                                AsyncImage(
                                    url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png"),
                                    content: { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(maxWidth: 120, maxHeight: 50)
                                    },
                                    placeholder: {
                                        ProgressView()
                                    }
                                )
                                .font(.system(size: 80))
                                HStack (alignment: .top) {
                                    Text(weather.main.feels_like.roundDouble())
                                        .font(.custom("Futura", fixedSize: 100).bold())
                                    Text("°")
                                        .font(.custom("Futura", fixedSize: 60).bold())
                                }
                                Text(weather.weather[0].main)
                                    .font(.custom("Futura", fixedSize: 30))
                            }
                            //                    .frame(width: .infinity, alignment: .leading)
                            .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding()
                        Spacer()
                        VStack (alignment: .leading, spacing: 10){
                            HStack {
                                Spacer()
                                VStack {
                                    Text(weather.wind.speed.roundDouble() + "m/s")
                                        .font(.custom("Futura", fixedSize: 19))
                                    Text("Wind")
                                        .font(.custom("Futura", fixedSize: 15))
                                        .foregroundColor(Color(.darkGray))
                                }
                                Spacer()
                                Divider()
                                Spacer()
                                VStack {
                                    Text(weather.main.pressure.roundDouble() + "hpa")
                                        .font(.custom("Futura", fixedSize: 19))
                                    Text("Pressure")
                                        .font(.custom("Futura", fixedSize: 15))
                                        .foregroundColor(Color(.darkGray))
                                }
                                Spacer()
                                Divider()
                                Spacer()
                                VStack {
                                    Text(weather.main.humidity.roundDouble() + "%")
                                        .font(.custom("Futura", fixedSize: 19))
                                    Text("Humidity")
                                        .font(.custom("Futura", fixedSize: 15))
                                        .foregroundColor(Color(.darkGray))
                                }
                                Spacer()
                                
                                
                            }
                            .padding()
                            .background(Color(.white))
                            .clipShape(.capsule)
                            .foregroundColor(.black)
                            .frame(maxHeight: 70)
                        }
                        Spacer()
                        Spacer()
                        
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width, height: 390)
                    .clipShape(RoundedRectangle(cornerRadius: 55))
                    .background(Color(.blue))
                }
                .background(Color(.blue))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .circular))
                
                VStack(alignment:.leading) {
                    HStack {
                        Text("Today")
                            .font(.custom("Avenir Next", fixedSize: 19)).bold()
                            .foregroundStyle(.white)
                        Spacer()
                        Button(action: {
                            self.isPresented.toggle()
                        }) {
                            HStack{
                                Text("Next 5 days")
                                    .font(.custom("Avenir Next", fixedSize: 19)).bold()
                                    .foregroundStyle(.white)
                                Image(systemName: "arrow.right")
                                    .foregroundStyle(.white)
                                    
                            }
                        }.fullScreenCover(isPresented: $isPresented, content: {
                            WeeklyForecastView(forecast: forecast)
                        })
                       
                    }.padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<forecast.list.count) {index in
                                let calendar = Calendar.current
                                let date = Date(timeIntervalSince1970: TimeInterval(forecast.list[index].dt))
                                let today = calendar.isDateInToday(date)
                                if today == true {
                                    TodayCardView(imageTxt: "https://openweathermap.org/img/wn/\(forecast.list[index].weather[0].icon)@2x.png",
                                                  degreeTxt: "\(forecast.list[index].main.feelsLike.roundDouble())°",
                                                  timeTxt: "\(OpenWeatherAPI().epochTime(Double(forecast.list[index].dt)))", feelsLikeTxt: forecast.list[index].weather[0].main)
                                }
                                
                            }
                        }
                    }
                    Spacer()
                        .padding(.top)
                        .padding(.bottom)
                }
                .ignoresSafeArea(.all)
            }
            .background(Color(.black))
            .ignoresSafeArea(.all)
        
        
    }
}

struct TodayCardView: View {
    
    let imageTxt: String
    let degreeTxt: String
    let timeTxt: String
    let feelsLikeTxt: String
    
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(
                url: URL(string: imageTxt),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 100, maxHeight: 50)
                },
                placeholder: {
                    ProgressView()
                }
            )
            Text(degreeTxt)
                .font(.system(size: 46))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(feelsLikeTxt)
                .font(.system(size: 21))
                .fontWeight(.medium)
                .foregroundColor(.white)
            Text(timeTxt)
                .font(.system(size: 21))
                .fontWeight(.medium)
                .foregroundColor(.white)
            
        }
        .frame(width: 120, height: 200)
        .background(Color(.gray))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    WeatherView(weather: weatherPreview, forecast: forecastPreview)
}
