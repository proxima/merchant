var facebook_id = null;

// Additional JS functions here
window.fbAsyncInit = function() {
  FB.init({
    appId      : '461623053929710', // App ID
    channelUrl : '//merchant.botchris.com/channel.html', // Channel File
    status     : true, // check login status
    cookie     : true, // enable cookies to allow the server to access the session
    xfbml      : true  // parse XFBML
  });
  FB.Event.subscribe('auth.authResponseChange', function(response) {
    if (response.status === 'connected') {
      facebook_id = response.authResponse.userID;
      console.log('Facebook authenticated as: ' + facebook_id);
    } else if (response.status === 'not_authorized') {
      FB.login();
    } else {
      FB.login();
    }
  });
};

// Load the SDK asynchronously
(function(d){
   var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement('script'); js.id = id; js.async = true;
   js.src = "//connect.facebook.net/en_US/all.js";
   ref.parentNode.insertBefore(js, ref);
}(document));

