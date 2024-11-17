class_name MailEntry;
extends Button;

@export var mail_unread_icon: Texture2D;
@export var mail_read_icon: Texture2D;

const text_template: String = "from: {0}\nto: {1}\nsubject: {2}\n";

var mail: Resource;

func set_mail(mail_resourse: Resource) -> void:
	mail = mail_resourse;
	text = text_template.format([mail_resourse.from, mail_resourse.to, mail_resourse.subject]);

func _process(delta: float) -> void:
	if (mail):
		icon = mail_read_icon if mail.was_read else mail_unread_icon;
