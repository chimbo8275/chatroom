var chatRoomApp = angular.module('chatRoomApp', []);

chatRoomApp.controller('chatRoomCtrl', ['$scope', '$http','$timeout', function ($scope, $http, $timeout ) {

    $scope.last_update_timestamp = "";
    $scope.loading = true;

	$scope.init = function(messages) {
		$scope.messages = [];
		$scope.poll();
        //set room id to id of lobby room.
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
        }, 2000);
    };     
   
    $scope.send_message = function() {
        $scope.loading = true;
        $http.post("/messages.json", {message: {body: $scope.body, room_id: $scope.room_id}}).then(function(data){
            $scope.body = "";
        });
        return false;
    };

    $scope.set_room = function(room_id){
        $scope.room_id = room_id;
        //ajax call here if room id changed
        return false;
    };

    //You need to check the users room with a scope variable
    //When they are in a room change the messages to only show items from that room
    //Load the current users in that room

    //When a user joins a room you should make an ajax call to create a user_room record showing they're currrently in the room
    //Users on the right should just be the list of 'user rooms' aka users that are there for that room.  Room.find(params[:id]).users

}]);
