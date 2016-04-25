(function(){
  'use strict';

  describe('Controller: videoUploaderCtr', function () {
    var scope, element, compiledElement;

    beforeEach(function() {
      module('videoUploaderApp');
    });
    beforeEach(inject(function ($controller, $rootScope, $compile) {
      scope = $rootScope.$new();
      $controller('videoUploaderCtr', { $scope: scope });
      element = angular.element('<input ngf-select="directUpload($file)" ng-model="video_file" ngf-pattern="video/mp4" ngf-model-invalid="invalidFile" class="file optional ng-pristine ng-untouched ng-valid ng-empty" type="file" name="video[video_file]" id="video_video_file">');
      compiledElement = $compile(element)(scope);
      scope.$digest;
    }));

    it('populates the scope with the initial server side values when editInit is called', function () {
      scope.editInit('1', 'title', 'description', 'videoFileName', '5 min', 'fakeBucket');
      expect(scope.userId).toEqual('1');
      expect(scope.title).toEqual('title');
      expect(scope.description).toEqual('description');
      expect(scope.videoFileName).toEqual('videoFileName');
      expect(scope.length).toEqual('5 min');
      expect(scope.bucketname).toEqual('fakeBucket');
    });

    it ('calls directUpload on select event', function() {
      var mockFile = { type: "video/mp4", method:"POST", file:[{"name":"File 1", "body":"abcd121212"}] };
      scope.directUpload = jasmine.createSpy();
      scope.directUpload(mockFile);
      element.triggerHandler('click');
      expect(scope.directUpload).toHaveBeenCalled();
    });
  });

})();
