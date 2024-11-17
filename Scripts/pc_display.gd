class_name PCDisplay;
extends Control;

@export var mail_instance: PackedScene;
@export var mail_resources: Array[Resource];
@export var mail_parent: BoxContainer;
@export var full_email: FullEmail;

func _ready() -> void:
	for mail_resource in mail_resources:
		var mail_entry := mail_instance.instantiate() as MailEntry;
		mail_entry.set_mail(mail_resource);
		mail_parent.add_child(mail_entry);
		mail_entry.pressed.connect(func(): full_email.open_mail(mail_resource));
