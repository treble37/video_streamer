'use strict';

(function(angular) {
  function videoUploaderCtr($scope, $routeParams, Upload, $timeout, $http) {
    $scope.editInit = function(userId, title, description, length, bucketname) {
      $scope.title = title;
      $scope.description = description;
      $scope.userId = userId;
      $scope.length = length;
      $scope.estimatedTime = 0;
      $scope.bucketname = bucketname;
    }

    $scope.directUpload = function(file) {
      if (file) {
        var filename = file.name;
        var type = file.type;
        var query = {
                      filename: filename,
                      type: type,
                      title: $scope.title,
                      description: $scope.description,
                      length: $scope.length
                    };
        var uploadDirectUrl = '/users/' + $scope.userId + '/videos/create_s3_direct.json';
        var startTime = new Date().getTime();
        $http.post(uploadDirectUrl, query)
          .success(function(result) {
            var s3Url = 'https://' + $scope.bucketname + '.s3.amazonaws.com/' + result.fields.key;
            Upload.http({
                url: s3Url, //s3Url
                fields: result.fields, //credentials
                headers: { "Content-Type": file.type, "x-amz-acl": "bucket-owner-full-control" },
                method: 'PUT',
                data: file,
             }).progress(function(evt) {
               var currentTime = new Date().getTime();
               var uploadSpeed = evt.loaded/(currentTime - startTime);
               $scope.estimatedTime = Number((evt.total - evt.loaded)/uploadSpeed).toFixed(1);
               file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total));
               console.log('progress: ' + parseInt(100.0 * evt.loaded / evt.total));
               console.log('time left (msec): ' + $scope.estimatedTime);
             }).success(function(data, status, headers, config) {
                // file is uploaded successfully
               console.log('file ' + file.name + 'is uploaded successfully. Response: ' + data);
             }).error(function() {
               console.log('error in Upload.http of video.js');
             });
          })
          .error(function(data, status, headers, config) {
              // called asynchronously if an error occurs
              // or server returns response with an error status.
            console.log('post create_s3_direct.json error');
          });
      }
    }

  }

  videoUploaderCtr.$inject = ['$scope', '$routeParams', 'Upload', '$timeout', '$http'];
  var videoUploaderApp = angular.module('videoUploaderApp', ['ngFileUpload', 'ngRoute']);
  videoUploaderApp.controller('videoUploaderCtr', ['$scope', '$routeParams',  'Upload', '$timeout', '$http', videoUploaderCtr]);

})(angular);
