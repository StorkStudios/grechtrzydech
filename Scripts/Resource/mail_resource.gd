extends Resource
class_name MailResource;

@export var from: String;
@export var to: String;
@export var subject: String;
@export_multiline var body: String;

var was_read: bool = false;
