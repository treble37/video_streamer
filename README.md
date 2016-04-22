##Documentation

###Project overview

This project is a video uploading application that allows uploading of mp4 videos.  It is a Rails 4.2 app with an AngularJS front end to handle the file uploading.

####Approach

I used Ruby on Rails and RSpec to test and drive out the unit tests, along with Capybara to drive the integration testing.

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

Step 2: *rake db:migrate* to setup the SQLite database locally and *rake db:seed* to create a sample user.

Step 3: Do *rails s* at the command prompt and navigate to http://localhost:3000/

If you see ng-file-upload-all.js in app/assets/javascripts you do not have to do the next step. I just used bower to get the front end plugins I needed.

  Optional step: bower install ng-file-upload --save

Step 4: You have to use your own Amazon S3 secret key information.  See application.yml.example for the format.  Substitute "xxx" with your own secret keys.

###Running the web application

If you've done up to Step 3, you should be able to navigate to http://localhost:3000/user_id/videos. Depending on if this is your first user, user_id will likely be equal to 1. But you may have to check with rails console to be sure.

From /videos, you can create a new video. After you create a new video, you can edit, destroy, or show it. The menu bar at the top uses a path helper "user_videos_path(User.first)" to route you to a user's listing of videos. If you create more than one user, that means you can only use the menu bar to navigate to the first user's video listings.

###Requirements

This was created and tested on an Ubuntu 14.04 Linux system.  It should likely run on an OSx box without any trouble.

###Future work

I could add a user login system.

####User Interface

I could allow a user to upload a new video and override an existing one. I could also change the video listing to use image thumbnails.

As always, in any software project, you have to decide on the core functionality to ship.
