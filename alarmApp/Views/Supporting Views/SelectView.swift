
import SwiftUI

struct SelectView: View {
    let width: CGFloat
    @Binding var addEditViewType: AddEditViewType
    @Binding var isActive: Bool
    
    var isStandartView: Bool {
        addEditViewType == .Standard
    }
    
    var isCircularView: Bool {
        addEditViewType == .Circular
    }
    
    var body: some View {
        HStack {
            
            Button(action: {
                withAnimation {
                    addEditViewType = .Standard
                    isActive = true
                }
                
            }, label: {
                ImageDisplayView(name: standardView, width: 50)
                    .scaleEffect(isStandartView ? 1.05 : 1.0)
                    .shadow(color: blue, radius: isStandartView ? 5:0, x: 0, y: 0)
            })
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    addEditViewType = .Circular
                    isActive = true
                }
            }, label: {
                ImageDisplayView(name: circularView, width: 50)
                    .scaleEffect(isCircularView ? 1.05 : 1.0)
                    .shadow(color: blue, radius: isCircularView ? 5:0, x: 0, y: 0)
            })
        }
        .padding()
    }
}

struct SelectView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SelectView(width: 50, addEditViewType: .constant(.Standard), isActive: .constant(true))
            
            SelectView(width: 50, addEditViewType: .constant(.Circular), isActive: .constant(true))
        }
    }
}
