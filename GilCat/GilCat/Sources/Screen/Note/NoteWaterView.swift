//
//  NoteWaterView.swift
//  GilCat
//
//  Created by KYUBO A. SHIM on 2022/06/12.
//

import SwiftUI

struct NoteWaterView: View {
    
    @State private var waterless = false
    @State private var watermid = true
    @State private var waterfull = false
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var catInfo: InfoToNote
    
    init() {
        Theme.navigationBarColors(background: .systemFill, titleColor: .white)
    }
    
    var body: some View {
        ZStack {
            Color("BackGroundColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                infoTextView(Text: "※ 시간을 선택해서 수정해주세요.")
                
                Spacer()
                
                HStack(alignment: .lastTextBaseline, spacing: 15) {
                    getwaterNameView(name: "물")
                
                }
                
                Image("waterBowl")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/6)
                
                // custom picker View
                GilCatTimePicker(hourEx: $catInfo.waterInfo.timeIndex)
                
                HStack(spacing: 15) {

                    waterPercentageView(text: "25%", isClick: waterless)
                        .onTapGesture {
                            waterless = true
                            watermid = false
                            waterfull = false
                        }
                        .padding()
                    
                    waterPercentageView(text: "50%", isClick: watermid)
                        .onTapGesture {
                            waterless = false
                            watermid = true
                            waterfull = false
                        }
                        .padding()
                    
                    waterPercentageView(text: "100%", isClick: waterfull)
                        .onTapGesture {
                            waterless = false
                            watermid = false
                            waterfull = true
                        }
                        .padding()
                }
                .padding()
                
                Spacer()
                
                createWaterView()
                
            }
            .navigationTitle("급식 입력")
            .navigationViewStyle(.stack)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                        .onTapGesture {
                            self.presentation.wrappedValue.dismiss()
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    private func getwaterNameView(name foodName: String) -> some View {
        Text(foodName)
            .font(.system(size: 36, weight: .heavy))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .frame(width: 240, height: 100)
    }
    
    @ViewBuilder
    private func createWaterView() -> some View {
        Button {
            // 1. 선택된 값 받아오기
            // Param 에 아마 서버에서 주고 받는 또는 data 연결 변수 들어갈 듯
            // 2. 빠져나가기
            self.presentation.wrappedValue.dismiss()
        } label: {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/12, alignment: .center)
                .cornerRadius(20)
                .foregroundColor(Color("ButtonColor"))
                .overlay {
                    Text("등록 완료")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 10)
        }
    }
    
    // 첫 안내 뷰
    @ViewBuilder
    private func infoTextView(Text text: String) -> some View {
        Text(text)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.white)
            .opacity(0.6)
            .padding(.top, 15)
    }
    
    @ViewBuilder
    private func waterPercentageView(text: String, isClick: Bool) -> some View {
        Text(text)
            .font(.system(size: 22, weight: .heavy))
            .foregroundColor(.white)
            .opacity(0.6)
            .frame(width: 70, height: 70, alignment: .center)
            .overlay {
                if !isClick {
                    RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, lineWidth: 6)
                                .frame(width: 90, height: 90)
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color("ButtonColor"))
                    
                    Text(text)
                        .font(.system(size: 22, weight: .heavy))
                        .foregroundColor(.white)
                }
            }
    }
    
}

struct NoteWaterView_Previews: PreviewProvider {
    static var previews: some View {
        NoteWaterView().environmentObject(InfoToNote())
    }
}
