class_name PCDisplay;
extends Control;

@export var mail_instance: PackedScene;
@export var mail_resources: Array[Resource];
@export var mail_parent: BoxContainer;
@export var full_email: FullEmail;

func _ready() -> void:
	update_mails();
	for mail_resource in GlobalVariables.mails:
		var mail_entry := mail_instance.instantiate() as MailEntry;
		mail_entry.set_mail(mail_resource);
		mail_parent.add_child(mail_entry);
		mail_entry.pressed.connect(func(): full_email.open_mail(mail_resource));

func update_mails() -> void:
	if (GlobalVariables.mail_animation_state == 1):
		GlobalVariables.mails.append(mail_resources[0]);
		GlobalVariables.mails.append(mail_resources.slice(2).pick_random());
	elif (GlobalVariables.mail_animation_state == 2):
		GlobalVariables.mails.append(mail_resources[1]);
		GlobalVariables.mails.append(mail_resources.filter(func(x): return GlobalVariables.mails.find(x) < 0).pick_random());
	elif (GlobalVariables.mail_animation_state > 2):
		var mails_left := mail_resources.filter(func(x): return GlobalVariables.mails.find(x) < 0);
		if (mails_left.size() > 0):
			GlobalVariables.mails.append(mails_left.pick_random());
	
	GlobalVariables.mail_animation_state += 1;
