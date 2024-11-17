extends Resource
class_name MailResource;

@export var from: String;
@export var to: String;
@export var subject: String;
@export_multiline var body: String;
@export var unread_icon: Texture2D;
@export var read_icon: Texture2D;

var was_read: bool = false;

func get_mail_icon() -> Texture2D:
	return read_icon if was_read else unread_icon;
