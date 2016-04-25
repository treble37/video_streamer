##Documentation

###Project overview

This project is a video uploading application that allows uploading of mp4 videos.  It is a Rails 4.2 app with an AngularJS front end to handle the file uploading.

####Approach

I used Ruby on Rails and RSpec to test and drive out the unit tests, along with Capybara to drive some simple integration testing. I also used Jasmine to unit test that a controller function $scope property values are set correctly.

####User Interface

To try and give a reasonable user experience, I used Twitter Bootstrap. It works well out of the box, has some mobile responsive capability built in, and most importantly, it's regularly updated and so are its associated rails gems. As an example, a pagination gem that incorporated Twitter Bootstrap gave me some nice out of the box styling.

####Models

There are 2 models, a User and a Video. A user can have many videos.

####Functionality

Currently, a user may upload a video to Amazon S3. It's one video at a time. A progress bar and estimated time is displayed.

##Technical notes!

###Installation instructions

I used the RVM package manager and you'll notice the .ruby-gemset and .ruby-version files in this code repository.

Step 1: *bundle install* to your RVM gemset (or whatever setup is most convenient for you)

Step 2: *rake db:migrate* to setup the Postgres database locally (you may have to create the postgres database in the database.yml file) and *rake db:seed* to create a sample user.

Step 3: Do *rails s* at the command prompt and navigate to http://localhost:3000/

If you see ng-file-upload-all.js in app/assets/javascripts you do not have to do the next step. I just used bower to get the front end plugins I needed.

  Optional step: bower install ng-file-upload --save

Step 4: You have to use your own Amazon S3 secret key information.  See application.yml.example for the format.  Substitute "xxx" with your own secret keys.

Step 5: Enable CORS on Amazon with the following rule set (basically, the most permissive for demo purposes).

```
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <CORSRule>
        <AllowedOrigin>*</AllowedOrigin>
        <AllowedMethod>GET</AllowedMethod>
        <AllowedMethod>PUT</AllowedMethod>
        <AllowedMethod>POST</AllowedMethod>
        <AllowedMethod>DELETE</AllowedMethod>
        <AllowedHeader>*</AllowedHeader>
    </CORSRule>
</CORSConfiguration>
```
Source: http://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html#how-do-i-enable-cors

Step 6: Enable this default bucket policy on your Amazon S3 plan and substitutde "bucket_name" with the name of your actual bucket:

```
{
	"Version": "2012-10-17",
	"Id": "Policy1461432288028",
	"Statement": [
		{
			"Sid": "Stmt1461432283724",
			"Effect": "Allow",
			"Principal": {
				"AWS": "*"
			},
			"Action": "s3:*",
			"Resource": "arn:aws:s3:::bucket_name/*"
		}
	]
}
```

Step 7: Running tests.  This app has Jasmine tests and RSpec tests. Run *rspec spec* to run the RSpec tests and *rake jasmine* and navigate to http://localhost:8888/ to see the results of the Jasimine tests.

###Running the web application

If you've done up to Step 3, you should be able to navigate to http://localhost:3000/user_id/videos. Depending on if this is your first user, user_id will likely be equal to 1. But you may have to check with rails console to be sure.

From /videos, you can create a new video. After you create a new video, you can edit, destroy, or show it. The menu bar at the top uses a path helper "user_videos_path(User.first)" to route you to a user's listing of videos. If you create more than one user, that means you can only use the menu bar to navigate to the first user's video listings.

###Requirements

This was created and tested on an Ubuntu 14.04 Linux system.  It should likely run on an OSx box without any trouble.

###Testing and Future Testing

This was system was tested with small video files downloaded from Vimeo ranging in size from 1 to 50 MB.  Obviously video files can be much larger, so this is definitely something that should be tested with future work. It was also tested on a local development box and not on a cloud provider such as Heroku. This is something that could be done on a future release.

I would also like to add stronger validation regarding which properties of a video should always be included (e.g., title, description, etc.) before being created as an object.

###Future work

There are a few features I would like to add in a future release. I list them below:

1 - Add a user login system.
2 - Delete the video in the S3 bucket when a user deletes the video model
3 - Some kind of image hover thumbnail as a user hovers over video choices
4 - I could allow a user to upload a new video and override an existing one. I could also change the video listing to use image thumbnails.
5 - Allowing multiple file upload with multiple progress bar coverage could be useful.
6 - A bit more test coverage would be a good goal, especially as more behavior is added to the system.
7 - Make the video width and height a bit larger and possibly adjustable depending on user's screen size

As always, in any software project, you have to decide on the core functionality to ship.
