Package.describe({
	name: "simply:magisterjs",
	version: "1.3.3",
	summary: "A JavaScript implementation of the Magister 6 API",
	git: "https://github.com/simplyGits/MagisterJS",
	documentation: "README.md"
});

Npm.depends({
	"request": "2.55.0"
});

Package.onUse(function(api) {
	api.versionsFrom("1.0.4.2");

	api.use(["coffeescript", "erasaur:meteor-lodash@3.6.0"]);

	api.addFiles([
		"src/Appointment.coffee",
		"src/Assignment.coffee",
		"src/Course.coffee",
		"src/DigitalSchoolUtility.coffee",
		"src/File.coffee",
		"src/Grade.coffee",
		"src/Magister.coffee",
		"src/Message.coffee",
		"src/MessageFolder.coffee",
		"src/Person.coffee",
		"src/private/Helpers.coffee",
		"src/ProfileInfo.coffee",
		"src/School.coffee",
		"src/StudyGuide.coffee",
		"src/MeteorExport.js",
		"default-https/meteor.coffee"
	]);
	api.addFiles("src/server/methods.coffee", "server");

	api.export("Magister");
});
