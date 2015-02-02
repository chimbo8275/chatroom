var chatRoomApp = angular.module('chatRoomApp', []);

chatRoomApp.controller('chatRoomCtrl', ['$scope', '$http','$timeout', function ($scope, $http, $timeout ) {

    $scope.last_update_timestamp = "";
    $scope.loading = true;

	$scope.init = function(messages) {
		$scope.messages = [];
		$scope.poll();
	}

	$scope.poll = function() {
        $timeout(function() {
        	current_timestamp = new Date;

        	$http.get("/messages.json?last_received_at=" + $scope.last_update_timestamp).then(function(data){
        		$scope.messages = $scope.messages.concat(data.data);

                if(data.data.length){
                    $scope.last_update_timestamp = current_timestamp;
                }
                $scope.loading = false;
        	})
            
            $scope.poll();
        }, 5000);
    };     
   
    $scope.send_message = function() {
        $scope.loading = true;
        $http.post("/messages.json", {message: {body: $scope.body}}).then(function(data){
            $scope.body = "";
        });
        return false;
    };

}]);
