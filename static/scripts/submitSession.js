$(window).on("load", function() {
  fetchPastSessions();
  clearSessions();
  fetchSessions();
  document.getElementById("show_list").style.display = "block";
  var btn = document.getElementById("showListButton");
  showListButton.className += " active";
});
$(document).ready(function() {
  $("#sessionSubmitButton").click(function() {
    var formData = $("#sessionForm").serializeArray();
    var postData = {};
    for (let i in formData) {
      data = formData[i];
      if (data["name"] === "date") {
        weekDay = getWeekDayFromDate(data["value"]);
        data["value"] = data["value"] + " " + weekDay;
      }
      postData[data["name"]] = data["value"];
      if (!data["value"]) {
        alert("Please fill in all fields.");
        return;
      }
    }
    postData = JSON.stringify(postData);
    let url = "https://climbjio-default-rtdb.asia-southeast1.firebasedatabase.app/sessions.json";
    $.ajax(url, {
      data: postData,
      type: "POST",
      success: function(resp) {
        location.reload();
        alert("Success!");
      },
    });
  });
});