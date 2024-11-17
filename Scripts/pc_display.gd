class_name PCDisplay;
extends Control;

@export var mail_instance: PackedScene;
@export var mail_resources: Array[Resource];
@export var mail_parent: BoxContainer;
@export var full_email: FullEmail;
@export var random_mails: int;

func _ready() -> void:
	update_mails();
	for mail_resource in GlobalVariables.mails:
		var mail_entry := mail_instance.instantiate() as MailEntry;
		mail_entry.set_mail(mail_resource);
		mail_parent.add_child(mail_entry);
		mail_entry.pressed.connect(func(): full_email.open_mail(mail_resource));

func update_mails() -> void:
	if (GlobalVariables.mail_animation_state == 0):
		GlobalVariables.mails.append(mail_resources[0]);
	if (GlobalVariables.mail_animation_state == 1):
		GlobalVariables.mails.append(mail_resources[1]);
		GlobalVariables.add_random_mail(mail_resources.slice(3));
	elif (GlobalVariables.mail_animation_state == 2):
		GlobalVariables.mails.append(mail_resources[2]);
		GlobalVariables.add_random_mail(mail_resources);
	elif (GlobalVariables.mail_animation_state > 2):
		for i in range(random_mails):
			GlobalVariables.add_random_mail(mail_resources);
	
	GlobalVariables.mail_animation_state += 1;
