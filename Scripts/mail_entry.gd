class_name MailEntry;
extends Button;

const text_template: String = "from: {0}\nto: {1}\nsubject: {2}\n";

var mail: Resource;

func set_mail(mail_resourse: Resource) -> void:
	mail = mail_resourse;
	text = text_template.format([mail_resourse.from, mail_resourse.to, mail_resourse.subject]);

func _process(delta: float) -> void:
	if (mail):
		icon = mail.get_mail_icon();
