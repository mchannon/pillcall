let js = {

    /* Show/hide the email form */
    toggleForm: function() {
        let emailWrapper = document.getElementById("email-wrapper");
        if (emailWrapper.className.indexOf("show") < 0) {
            emailWrapper.className = "show";
        } else {
            emailWrapper.className = "";
        }
    },

    /* Send the email form contents */
    sendMail: function() {

        let emailForm = document.getElementById("email-form");
        let feedback = document.getElementById("feedback");
        document.getElementById("email-wrapper").className = "show";
        //document.getElementById("submit").disabled = "true";
        feedback.className = "";
        feedback.innerHTML = "Sending…";

        // set up request
        let request;
        if (window.XMLHttpRequest) {
            request = new XMLHttpRequest();
        } else if (window.ActiveXObject) {
            request = new ActiveXObject("Microsoft.XMLHTTP");
        } else {
            feedback.className = "error";
            feedback.innerHTML = "Sorry, your browser does not support the mail form."
            return;
        }
        request.open("POST", "mail.php", true);
        request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        // define callback
        request.onreadystatechange = function() {
            if (this.readyState === 4) {
                if (request.status === 200) {
                    feedback.innerHTML = "Message sent!"
                    setTimeout("js.resetForm()", 3000);
                } else {
                    response = this.responseText || "Sorry, an error occurred.";
                    feedback.className = "error";
                    feedback.innerHTML = response;
                }
            }
        };

        // build the query string
        data = "";
        for (i = 0; i < emailForm.length; i++) {
            data += emailForm[i]["name"] + "=" + emailForm[i]["value"];
            if (i < emailForm.length - 1) {
                data += "&";
            }
        }

        request.send(data);

    },

    /* Reset the fields after a message is sent successfully */
    resetForm: function() {
        document.getElementById("email-wrapper").className = "";

        let feedback = document.getElementById("feedback");
        feedback.className = "";
        feedback.innerHTML = "";

        document.getElementById("name").value = "";
        document.getElementById("email").value = "";
        document.getElementById("message").value = "";
    }
};