class Contact {
  String _nameOfContact;
  String _urlImageContact;
  String _keyRelationId;
  String _emailContact;
  String _meuContato;

  Contact(this._nameOfContact, this._urlImageContact, this._keyRelationId, this._meuContato, this._emailContact);

  String get keyRelationId => _keyRelationId;

  set keyRelationId(String value) {
    _keyRelationId = value;
  }

  String get urlImageContact => _urlImageContact;

  set urlImageContact(String value) {
    _urlImageContact = value;
  }

  String get nameOfContact => _nameOfContact;

  set nameOfContact(String value) {
    _nameOfContact = value;
  }

  String get meuContato => _meuContato;

  set meuContato(String value) {
    _meuContato = value;
  }

  String get emailContact => _emailContact;

  set emailContact(String value) {
    _emailContact = value;
  }
}