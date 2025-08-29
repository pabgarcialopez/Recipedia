//
//  ProfileEditView.swift
//  Recipedia
//
//  Created by Pablo García López on 27/8/25.
//

import SwiftUI
import PhotosUI

struct LabeledTextField: View {
    let label: String
    let axis: Axis?
    @Binding var text: String
    
    init(label: String, text: Binding<String?>, axis: Axis? = nil) {
        self.label = label
        self.axis = axis
        self._text = Binding(
            get: { text.wrappedValue ?? "" },
            set: { text.wrappedValue = $0 }
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .foregroundStyle(.separator)
            
            if let axis = axis {
                TextField(label, text: $text, axis: axis)
            } else {
                TextField(label, text: $text)
                    .bold()
            }
        }
        .padding(.init(top: 10, leading: 15, bottom: 10, trailing: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.separator, lineWidth: 1)
        )
    }
}


struct ProfileEditView: View {
    
    @ObservedObject var profileViewModel: ProfileViewModel
    
    private var user: User { profileViewModel.user }
    
    @State private var draftPicture: UIImage? = nil
    @State private var selectedPicture: PhotosPickerItem? = nil
    
//    let email: String?
//    var bio: String? = nil
//    var pictureURL: String? = nil
    
    private var photosPicker: some View {
        PhotosPicker(selection: $selectedPicture, matching: .images) {
            ZStack(alignment: .bottomTrailing) {
                Group {
                    if let draftPicture {
                        Image(uiImage: draftPicture)
                            .resizable()
                            .scaledToFill()
                    } else {
                        profileViewModel.profilePicture
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black))

                Circle()
                    .fill(Color.white)
                    .frame(width: 28, height: 28)
                    .overlay(
                        Image(systemName: "camera.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                    )
                    .offset(x: 5, y: 5)
            }
        }
        .onChange(of: selectedPicture) { loadImage(from: selectedPicture)}
    }
    
    var body: some View {
        VStack {
            
            VStack(spacing: 15) {
                photosPicker
                Text(user.fullName)
                    .font(.title2.bold())
            }
            
            Divider()
                .padding()
            
            // Details
            VStack(spacing: 15) {
                LabeledTextField(label: "First name", text: $profileViewModel.user.firstName)
                LabeledTextField(label: "Last name", text: $profileViewModel.user.lastName)
                LabeledTextField(label: "Biography", text: $profileViewModel.user.bio, axis: .vertical)
            }
        }
        .navigationTitle("Edit your profile")
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
    
    func loadImage(from item: PhotosPickerItem?) {
        Task {
            if let data = try? await item?.loadTransferable(type: Data.self) {
                self.draftPicture = UIImage(data: data)
            }
        }
    }
}

#Preview {
    ProfileEditView(profileViewModel: .preview)
}
