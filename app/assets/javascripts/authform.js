window.onload = function()
{
    var anchors = document.getElementsByTagName("a");
    for (var foo = 0; foo < anchors.length; foo++) {
        if (anchors[foo].className == "httpauth") {
            createForm(anchors[foo]);
        }
    }
}

function createForm(httpauth)
{
    var form = document.createElement("form");
    form.action = httpauth.href;
    form.method = "get";
    form.onsubmit = login;
    form.id = httpauth.id;
	var userPrepend = document.createElement("div");
	userPrepend.className = "input-prepend";
    var username = document.createElement("label");
	username.id='LogIn';
	username.className="add-on";
	var iconUser = document.createElement("i");
	iconUser.className = "icon-user";
    var usernameInput = document.createElement("input");
    usernameInput.name = "username";
	usernameInput.placeholder = "Username";
    usernameInput.type = "text";
    usernameInput.id = httpauth.id + "-username";
	
	username.appendChild(iconUser);
	
	
	var passPrepend = document.createElement("div");
	passPrepend.className="input-prepend";
    var password = document.createElement("label");
	password.id='LogIn';
	password.className="add-on";
	var iconPw = document.createElement("i");
	iconPw.className="icon-key";
    var passwordInput = document.createElement("input");
    passwordInput.name = "password";
	passwordInput.placeholder = "Password";
    passwordInput.type = "password";
    passwordInput.id = httpauth.id + "-password";
	
    password.appendChild(iconPw);   
	
	
    var submit = document.createElement("input");
    submit.type = "submit";
    submit.value = "Log in";
	submit.id ="LogIn";
	submit.className="btn btn-primary";
	
	userPrepend.appendChild(username);
	form.appendChild(userPrepend);
	userPrepend.appendChild(usernameInput);
	
    passPrepend.appendChild(password);
	form.appendChild(passPrepend);
    passPrepend.appendChild(passwordInput);
    form.appendChild(submit);
	
    httpauth.parentNode.replaceChild(form, httpauth);
	
}

function getHTTPObject() {
	var xmlhttp = false;
	if (typeof XMLHttpRequest != 'undefined') {
		try {
			xmlhttp = new XMLHttpRequest();
		} catch (e) {
			xmlhttp = false;
		}
	} else {
        /*@cc_on
        @if (@_jscript_version >= 5)
            try {
                xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (e) {
                try {
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                } catch (E) {
                    xmlhttp = false;
                }
            }
        @end @*/
    }
	return xmlhttp;
}

function login()
{
    var username = document.getElementById(this.id + "-username").value;
    var password = document.getElementById(this.id + "-password").value;
    var http = getHTTPObject();
	//var url = "http://" + username + ":" + password + "@" + this.action.substr(7);
	var url = this.action;

    http.open("get", url, false, username, password);
    http.send("");
//		alert(http.status);
	if (http.status == 200) {
		document.location = url;
	}location.reload();
    return false;
}

function logout(out_url)
{
    var http = getHTTPObject();
    http.open("get", this.parentNode.action, false, "null", "null");
    http.send("");
    if(window.alert("You have been logged out. You will be redirected to our homepage.")){
		window.location.href = out_url;
	  }	window.location.href = out_url;
    return false;
}
