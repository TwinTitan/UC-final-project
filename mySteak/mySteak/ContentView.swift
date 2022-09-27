//
//  ContentView.swift
//  mySteak
//
//  Created by Abdallah Alshemeri on 24/09/2022.
//

import SwiftUI

struct raw: Identifiable{
    let id = UUID()
    let image: String
    let name: String
    let price: Double
}

struct additions: Identifiable{
    let id = UUID()
    let image: String
    let name: String
    let price: Double
}

struct cart: Identifiable{
    let id = UUID()
    var image: String
    var name: String
    var price: Double
}

struct ContentView: View {
    
    let rawSteaks = [
         raw(image:"rTenderloin", name: "Tenderloin", price: 3.450),
         raw(image:"rShortRibs", name: "Shortribs", price: 2.250),
         raw(image:"rSirloin", name: "Sirloin", price: 3.150),
         raw(image:"rRibeye", name: "Ribeye", price: 2.500),
         raw(image:"rBrisket", name: "Brisket", price: 4.500)
    ]
    
    let addons = [
        additions(image: "mayo", name: "Mayonnaise", price: 0.200),
        additions(image: "ketchup", name: "Ketchup", price: 0.200),
        additions(image: "barbecue", name: "Barebeue", price: 0.250),
        additions(image: "mustard", name: "Mustard", price: 0.250),
        additions(image: "mashedPotatoes", name: "Mashed Potatoes", price: 0.850),
        additions(image: "mushroom", name: "Mushrooms", price: 0.950),
        additions(image: "softDrink", name: "Soft Drinks", price: 0.300)
    ]
    @State var Baskets = [cart]()
    @State var phoneNumber = ""
    @State var personName = ""
    @State var personAddress = ""
    @State var tapped = false
    @State var taped = false
    @State var cardnumber = ""
    @State var cardCVV = ""
    @State var cardExpire = ""
    @State var confirmOrder = "checkmark.circle.fill"
    
    var body: some View {
        NavigationView{
            
            ZStack{
                
                Color.gray
                    .ignoresSafeArea()
                
                Image("bg")
                    .resizable()
                    .opacity(0.60)
                Color.white
                    .frame(width: 390, height:80)
                    .opacity(0.40)
                    .padding(.top,10)
                Color.white
                    .frame(width: 390, height:80)
                    .opacity(0.40)
                    .padding(.bottom, 210)
                
                VStack{
                    
                    Text("Welcome to mySteak")
                        .frame(width: 350, height: 100)
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .background(.gray)
                        .clipShape(Capsule())
                        .padding()
                    
                    Text("Please choose from the menu:")
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .padding()
                    
                    Text("Raw Steak:")
                        .font(.title2)
                        .foregroundColor(Color.white)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(rawSteaks) { steak in
                                Button(action: {
                                    Baskets.append(cart(image: steak.image, name: steak.name, price: steak.price))
                                }) {
                                    HStack{
                                        Image(steak.image)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                        Text(steak.name)
                                            .foregroundColor(Color.white)
                                            .font(.title3)
                                        Text("\(String(format: "%.3f", (steak.price)))KWD")
                                            .foregroundColor(Color.yellow)
                                    }
                                }
                            }
                        }
                    }
                    Text("Addons:")
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .padding(.top, 10)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(addons) { addon in
                                Button(action: {
                                    Baskets.append(cart(image: addon.image, name: addon.name, price: addon.price))
                                }) {
                                    HStack{
                                        Image(addon.image)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                        Text(addon.name)
                                            .foregroundColor(Color.white)
                                            .font(.title3)
                                        Text("\(String(format: "%.3f", (addon.price)))KWD")
                                            .foregroundColor(Color.yellow)
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                    
                    if !Baskets.isEmpty {
                        NavigationLink(destination: checkoutView(phoneNumber: $phoneNumber, personAddress: $personAddress, PersonName: $personName, tapped: $tapped, taped: $taped, cardNumber: $cardnumber, cardExpire: $cardExpire, cardCVV: $cardCVV, Baskets: $Baskets, confirmOrder: $confirmOrder)){
                            HStack{
                                Text("Checkout")
                                    .foregroundColor(Color.white)
                                    .font(.largeTitle)
                                Image(systemName: "cart")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.white)
                                Text("\(Baskets.count)")
                                    .foregroundColor(Color.white)
                                    .font(.largeTitle)
                                
                            }   .frame(width: 300, height: 50)
                                .background(.green)
                                .clipShape(RoundedRectangle(cornerRadius: 45))
                        }
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct checkoutView: View {
    @Binding var phoneNumber: String
    @Binding var personAddress: String
    @Binding var PersonName: String
    @Binding var tapped: Bool
    @Binding var taped: Bool
    @Binding var cardNumber: String
    @Binding var cardExpire: String
    @Binding var cardCVV: String
    @Binding var Baskets: [cart]
    @Binding var confirmOrder: String
    var body: some View {
        ZStack{
            Color.gray
                .ignoresSafeArea()
            VStack{
                List{
                    ForEach(Baskets) { basket in
                            HStack{
                                Image(basket.image)
                                    .frame(width: 10, height: 10)
                                Text(basket.name)
                                    .font(.title3)
                                    .background(.yellow)
                                Spacer()
                                Text("\(String(format: "%.3f", (basket.price)))KWD")
                        }
                    }
                }
                Button(action: {
                    if !Baskets.isEmpty{
                        Baskets.remove(at:0)
                    }
                }) {
                    if !Baskets.isEmpty{
                        Image(systemName: "minus.circle")
                            .foregroundColor(Color.red)
                            .font(.largeTitle)
                    }
                }
                TextField("Enter your name", text: $PersonName)
                    .frame(width: 250, height: 30)
                    .textFieldStyle(.roundedBorder)
                    .padding(.trailing, 100)
                    .padding(.bottom)
                TextField("Enter your street address", text: $personAddress)
                    .frame(width: 250, height: 30)
                    .textFieldStyle(.roundedBorder)
                    .padding(.trailing, 100)
                    .padding(.bottom)
                TextField("Enter Your number", text: $phoneNumber)
                    .frame(width: 250, height: 30)
                    .textFieldStyle(.roundedBorder)
                    .padding(.trailing, 100)
                    .padding(.bottom)
                Text("Choose Payment:")
                    .foregroundColor(Color.white)
                    .font(.largeTitle)
                    .padding()
                HStack{
                    Image(systemName: "checkmark.circle")
                        .font(.title2)
                        .foregroundColor(tapped ? .green : .white)
                        .onTapGesture {
                            if taped == false{
                                withAnimation(.easeIn(duration: 0.4)) {
                                    tapped.toggle()
                                }
                            }
                        }
                    Text("K-Net")
                        .font(.title2)
                }.padding(.trailing, 205)
                HStack{
                    Image(systemName: "checkmark.circle")
                        .font(.title2)
                        .foregroundColor(taped ? .green : .white)
                        .onTapGesture {
                            if tapped == false{
                                withAnimation(.easeIn(duration: 0.4)) {
                                    taped.toggle()
                                }
                            }
                        }
                    Text("Cash on Delivery")
                        .font(.title2)
                }.padding(.trailing, 100)
                    .padding()
                if tapped == true{
                    TextField("Card Number", text: $cardNumber)
                        .frame(width: 250, height: 30)
                        .textFieldStyle(.roundedBorder)
                        .padding(.trailing, 100)
                        .padding(.bottom)
                    TextField("Expiry Date", text: $cardExpire)
                        .frame(width: 250, height: 30)
                        .textFieldStyle(.roundedBorder)
                        .padding(.trailing, 100)
                        .padding(.bottom)
                    TextField("CVV", text: $cardCVV)
                        .frame(width: 250, height: 30)
                        .textFieldStyle(.roundedBorder)
                        .padding(.trailing, 100)
                        .padding(.bottom)
                }
                NavigationLink(destination: confirmView(confirmOrder: $confirmOrder)){
                    if !PersonName.isEmpty && !personAddress.isEmpty && !phoneNumber.isEmpty{
                        if tapped || taped == true{
                            
                                HStack{
                                    Text("Confirm")
                                        .foregroundColor(Color.white)
                                        .font(.largeTitle)
                                    
                                }   .frame(width: 300, height: 50)
                                    .background(.green)
                                    .clipShape(RoundedRectangle(cornerRadius: 45))
                        }
                    }
                }
            }
        }
    }
}
struct confirmView: View{
    @Binding var confirmOrder: String
    var body: some View{
        VStack{
            Image(systemName: confirmOrder)
                .foregroundColor(Color.green)
                .font(.system(size: 200))
            Text("Order Confirmed")
                .font(.system(size: 50))
        }
    }
}
