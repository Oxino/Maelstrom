class Business {
  String id;
  String institutionName;
  String siret;
  String address;
  String description;
  String firstName;
  String lastName;
  String email;

  Business({
    this.id = "",
    this.institutionName = "",
    this.siret = "",
    this.address = "",
    this.description = "",
    this.firstName = "",
    this.lastName = "",
    this.email = "",
  });

  Business.fromData(Map<String, dynamic> data)
      : id = data['id'],
        institutionName = data['institutionName'],
        siret = data['siret'],
        address = data['address'],
        description = data['description'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        email = data['email'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'institutionName': institutionName,
        'siret': siret,
        'address': address,
        'description': description,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };
}
