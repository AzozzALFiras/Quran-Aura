import SwiftUI

struct RemoteImage: View {
    let url: String?
    let placeholder: String
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    
    @State private var image: UIImage? = nil
    @State private var isLoading = false
    
    init(url: String?, placeholder: String = "person.circle.fill", width: CGFloat = 60, height: CGFloat = 60, cornerRadius: CGFloat = 8) {
        self.url = url
        self.placeholder = placeholder
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color(.systemGray6))
                        .frame(width: width, height: height)
                    
                    Image(systemName: placeholder)
                        .font(.system(size: min(width, height) * 0.4))
                        .foregroundColor(.gray)
                    
                    if isLoading {
                        ProgressView()
                            .scaleEffect(0.8)
                    }
                }
                .onAppear {
                    loadImage()
                }
            }
        }
    }
    
    private func loadImage() {
        guard let urlString = url, let imageURL = URL(string: urlString) else { return }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let data = data, let downloadedImage = UIImage(data: data) {
                    self.image = downloadedImage
                }
            }
        }.resume()
    }
}