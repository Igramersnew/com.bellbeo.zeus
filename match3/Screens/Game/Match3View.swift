import Combine
import SwiftUI

struct Match3View: View {
    @Binding var reloadBoard: Bool
    @EnvironmentObject var viewModel: ViewModel

    @State private var squares = [Int: CGRect]()
    @State private var selectedIndex: Int? = nil
    @State private var selectionOpacity = 0.5
    @State private var canMove = true

    private enum Space: Hashable {
        case board
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            ZStack {
                VStack(spacing: 2)  {
                    ForEach(0..<ViewModel.Constant.boardHeight, id: \.self) { y in
                        HStack(spacing: 2) {
                            ForEach(0..<ViewModel.Constant.boardWidth, id: \.self) { x in
                                let index = x + y * ViewModel.Constant.boardWidth
                                GeometryReader { proxy in
                                    RoundedRectangle(cornerRadius: proxy.size.width*0.1)
                                        .aspectRatio(1, contentMode: .fit)
                                        .preference(
                                            key: SquaresPreferenceKey.self,
                                            value: [index: proxy.frame(in: .named(Space.board))]
                                        )
                                        .foregroundColor(Color.white.opacity(0.001))
                                }
                                .onTapGesture { Task { await handleTap(at: index) } }
                            }
                        }
                    }
                }
            }
            .aspectRatio(ViewModel.Constant.aspectRatio, contentMode: .fit)

            if let selectedIndex = selectedIndex, let rect = squares[selectedIndex] {
                RoundedRectangle(cornerRadius: rect.width*0.1)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: rect.size.width)
                    .offset(x: rect.minX, y: rect.minY)
                    .foregroundColor(Color.purple)
                    .opacity(selectionOpacity)
                    .onAppear { selectionOpacity = 1.0 }
                    .onDisappear { selectionOpacity = 0.5 }
                    .animation(Animation.easeInOut(duration: 1).repeatForever(), value: selectionOpacity)
                    .allowsHitTesting(false)
            }

            ForEach(viewModel.cells) { cell in
                let square = squares[cell.position] ?? .init(origin: .zero, size: .zero)
                let rect = square//.insetBy(dx: square.size.width * 0.1, dy: square.size.height * 0.1)
                Image(ViewModel.Constant.gameElements[cell.content].image)
                    .resizable()
                    .frame(width: rect.size.width, height: rect.size.height)
                    .scaledToFit()
                    .scaleEffect(cell.isMatched ? 1e-6 : 1, anchor: .center)
                    .offset(x: rect.minX, y: rect.minY)
                    .transition(.move(edge: .top))
                    .shadow(radius: 2)
                    .allowsHitTesting(false)
            }
        }
        .coordinateSpace(name: Space.board)
        .onPreferenceChange(SquaresPreferenceKey.self) { squares = $0 }
        .onChange(of: reloadBoard, perform: { _ in
            viewModel.reloadBoard()
        })
    }

    private func handleTap(at index: Int) async {
        let cell = viewModel.cells[index]

        guard selectedIndex != cell.position else { return selectedIndex = nil }

        guard let selectedIndex = selectedIndex else { return selectedIndex = cell.position }

        guard canMove, ViewModel.isAdjacent(selectedIndex, to: cell.position) else { return }

        self.selectedIndex = nil

        canMove = false
        await animate(with: .easeInOut(duration:0.5)) { viewModel.exchange(selectedIndex, with: cell.position) }
        canMove = true
    }
}
