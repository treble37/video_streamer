'use strict';

(function(angular) {
  function videoUploaderCtr($scope, $routeParams, Upload, $timeout) {
    $scope.videoResource = {title: "", description: "", video_file: ""};
    $scope.editInit = function(userId, title, description, length) {
      $scope.title = title;
      $scope.description = description;
      $scope.userId = userId;
      $scope.length = length;
    }
    $scope.uploadFiles = function(files, errFiles) {
      var startTime = new Date().getTime();
      $scope.files = files;
      $scope.errFiles = errFiles;
      $scope.estimatedTimes = [];
      angular.forEach(files, function(file, key) {
          file.upload = Upload.upload({
              url: '/users/' + $scope.userId + '/videos.json',
              fields: { 'video[title]': $scope.title,
                        'video[description]': $scope.description,
                        'video[video_file]': $scope.video_file },
              file: $scope.video_file
          });

          file.upload.then(function (response) {
              $timeout(function () {
                  file.result = response.data;
              });
          }, function (response) {
              if (response.status > 0)
                  $scope.errorMsg = response.status + ': ' + response.data;
          }, function (evt) {
              var currentTime = new Date().getTime();
              var uploadSpeed = evt.loaded/(currentTime - startTime);
              $scope.estimatedTimes[key] = (currentTime - startTime)/uploadSpeed;
              file.progress = Math.min(100, parseInt(100.0 *
                                       evt.loaded / evt.total));
          });
      });
    }

  }

  videoUploaderCtr.$inject = ['$scope', '$routeParams', 'Upload', '$timeout'];
  var videoUploaderApp = angular.module('videoUploaderApp', ['ngFileUpload', 'ngRoute']);
  videoUploaderApp.controller('videoUploaderCtr', ['$scope', '$routeParams',  'Upload', '$timeout', videoUploaderCtr]);

})(angular);
