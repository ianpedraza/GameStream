//
//  EditProfileView.swift
//  GameStream
//
//  Created by Ian Pedraza on 27/01/22.
//

import SwiftUI

struct EditProfileView: View {
    
    var body: some View {
        
        ZStack {
            
            Color(AppColors.PRIMARY).ignoresSafeArea()
            
            ScrollView {
                
                VStack {
                    
                    EditPhotoSectionView()
                    
                    EditProfileSectionView()
                    
                }
                .padding(.bottom, 18.0)
                
            }
            
        }
        
    }
    
}

struct EditProfileSectionView: View {
    
    @State var user: User = User()
    
    let editProfileViewModel = EditProfileViewModel()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            TextField(EMPTY_STRING, text: $user.email)
                .field(
                    title: "Correo electrónico",
                    hint: "ejemplo@gmail.com",
                    when: user.email.isEmpty
                )
            
            SecureField(EMPTY_STRING, text: $user.password)
                .field(
                    title: "Contraseña",
                    hint: "Introduce tu nueva contraseña",
                    when: user.password.isEmpty
                )
            
            TextField(EMPTY_STRING, text: $user.username)
                .field(
                    title: "Nombre",
                    hint: "Introduce tu nombre de usuario",
                    when: user.username.isEmpty
                )
            
            Button(action: updateData) {
                Text("Actualizar")
                    .outlinedButton()
            }
            .padding(.top, 32)
            
        }
        .padding(.horizontal, 32.0)
        .padding(.top, 32)
        .onAppear {
            guard let user = editProfileViewModel.getData() else {
                return
            }
            
            self.user = user
        }
        
    }
    
    private func updateData() {
        let _ = editProfileViewModel.saveData(user: user)
    }
    
}

struct EditPhotoSectionView: View {
    
    @State var profileImage: Image? = Image(Resources.PROFILE_PICTURE)
    @State var isCameraActive: Bool = false
    
    var body: some View {
        
        VStack {
            
            Button(action: takePhoto) {
                
                ZStack {
                    
                    profileImage!
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            width: 118,
                            height: 118
                        )
                        .clipShape(Circle())
                        .sheet(isPresented: $isCameraActive) {
                            
                            SUImagePickerView(
                                sourceType: .photoLibrary,
                                image: self.$profileImage,
                                isPresented: self.$isCameraActive
                            )
                            
                        }
                    
                    Image(systemName: "camera")
                        .foregroundColor(.white)
                }
                
            }
            
        }
        
    }
    
    private func takePhoto() {
        isCameraActive = true
    }
    
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
