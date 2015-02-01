var chatRoomApp = angular.module('chatRoomApp', []);

chatRoomApp.controller('chatRoomCtrl', ['$scope', '$http','$timeout', function ($scope, $http, $timeout ) {
	$scope.init = function(messages) {
		$scope.messages = messages
		$scope.poll();
		//debugger;
	}

	$scope.poll = function() {
        $timeout(function() {
        	//debugger;
        	$http.get("/messages.json").then(function(data){
        		
        		$scope.messages = $scope.messages.concat(data.data) ;

        		//debugger;
        	})
            
            $scope.poll();
        }, 5000);
    };     
   

	$scope.messages = ["string one","string two"]
}]);
