class_name FullEmail;
extends NinePatchRect;

@export var back_button: TextureButton;
@export var text_field: RichTextLabel;

const mail_format: String = "from: {0}\nto: {1}\nsubject: {2}\n\n{3}";

func open_mail(mail: Resource):
	if (visible):
		return;
	
	mail.was_read = true;
	text_field.text = mail_format.format([mail.from, mail.to, mail.subject, mail.body]);
	visible = true;

func _ready() -> void:
	back_button.pressed.connect(close_mail);
	visible = false;

func close_mail() -> void:
	visible = false;
