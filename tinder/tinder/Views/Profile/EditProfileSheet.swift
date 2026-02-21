import SwiftUI

struct EditProfileSheet: View {
    @EnvironmentObject var store: UserProfileStore
    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""
    @State private var bio: String = ""
    @State private var occupation: String = ""
    @State private var school: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("About Me") {
                    fieldRow(label: "Name", text: $name)
                    fieldRow(label: "Occupation", text: $occupation)
                    fieldRow(label: "School", text: $school)
                }
                Section("Bio") {
                    TextEditor(text: $bio)
                        .frame(minHeight: 90)
                        .font(.body)
                }
                Section {
                    Text("\(bio.count)/300 characters")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .bold()
                        .foregroundColor(Color(red: 0.99, green: 0.27, blue: 0.35))
                }
            }
            .onAppear { load() }
        }
    }

    private func fieldRow(label: String, text: Binding<String>) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
                .frame(width: 90, alignment: .leading)
            TextField(label, text: text)
        }
    }

    private func load() {
        name = store.name
        bio = store.bio
        occupation = store.occupation
        school = store.school
    }

    private func save() {
        store.name = name
        store.bio = bio
        store.occupation = occupation
        store.school = school
        dismiss()
    }
}
