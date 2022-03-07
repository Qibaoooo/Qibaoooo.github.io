function openTab(evt, tabName) {
    // const
    const SHOW_LIST = "show_list";
    const LETS_JIO = "lets_jio";
    // reset start
    var i, tabcontent, tablinks;
    document.getElementById(SHOW_LIST).style.display = "none";
    document.getElementById(LETS_JIO).style.display = "none";
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    clearSessions();
    var body = document.getElementById("sessionTable").getElementsByTagName("tbody")[0];
    var rows = body.getElementsByTagName("tr");
    // console.log('rows after: ' + rows.length)
    // reset end
    to_act = "";
    to_hide = "";
    if (tabName === SHOW_LIST) {
        fetchSessions(tabName);
        to_act = SHOW_LIST;
        to_hide = LETS_JIO;
    } else {
        to_act = LETS_JIO;
        to_hide = SHOW_LIST;
    }
    document.getElementById(to_act).style.display = "block";
    evt.currentTarget.className += " active";
}
async function fetchPastSessions() {
    var psDiv = $(".pastSessions")
    console.log(psDiv)
    let url = "https://climbjio-default-rtdb.asia-southeast1.firebasedatabase.app/archive.json";
    const response = await fetch(url);
    const data = await response.text();
    const seshs = JSON.parse(data);
    console.log(seshs)
    for (var k in seshs) {
        var p = document.createElement("p")
        p.textContent = seshs[k]
        psDiv.append(p)
    }
}

function clearSessions() {
    var body = document.getElementById("sessionTable").getElementsByTagName("tbody")[0];
    var newBody = document.createElement("tbody");
    document.getElementById("sessionTable").replaceChild(newBody, body);
}
async function fetchSessions(tabName) {
    // alert('test')
    let url = "https://climbjio-default-rtdb.asia-southeast1.firebasedatabase.app/sessions.json";
    const response = await fetch(url);
    const data = await response.text();
    const seshs = JSON.parse(data);
    if (seshs === null) {
        var body = document.getElementById("sessionTable").getElementsByTagName("tbody")[0];
        var row = body.insertRow(-1);
        cell = row.insertCell(0);
        var p1 = document.createElement("p");
        var p2 = document.createElement("p");
        p1.textContent = "No upcoming sessions 😧";
        p2.textContent = "Create one in the  < Let 's Jio> tab";
        cell.setAttribute("colspan", 3);
        cell.appendChild(p1);
        cell.appendChild(p2);
    }
    for (let ts in seshs) {
        // console.log(seshs[ts])
        s = seshs[ts];
        var s_date = s.date;
        var s_time = s.time_1 + ":" + s.time_2 + " " + s.time_3;
        var s_gym = s.gym;
        var s_name = s.name;
        if (!s_name) {
            s_name = "none";
        }
        var id = ts;
        // date filter
        if (dateIsBeforeToday(s_date.split(" ")[0])) {
            // send BE api to delet this event & then archive it.
            console.log("deleteing session ", s_date)
            session_str = getSessionInfo(s_date, s_time, s_gym, s_name)
            apiArchiveSession(session_str)
            apiDeleteSession(id)
            continue
            // dont show this row
        }
        // date filter end
        var body = document.getElementById("sessionTable").getElementsByTagName("tbody")[0];
        var row = body.insertRow(-1);
        var cell1 = row.insertCell(0);
        var cButton = document.createElement("button");
        cButton.className = "cancelButton";
        cButton.innerHTML = "&#x2716;";
        cButton.setAttribute("data-id", ts);
        cButton.setAttribute("data-name", s_name);
        cButton.setAttribute("data-time", s_time);
        cButton.setAttribute("data-gym", s_gym);
        cButton.setAttribute("data-date", s_date);
        cButton.onclick = cancelSession;
        cell1.className = "dateCell"
        cell1.textContent = s_date;
        cell1.appendChild(cButton);
        var cell2 = row.insertCell(1);
        var p_s_time = document.createElement("p");
        p_s_time.textContent = " @ " + s_time;
        var p_s_gym = document.createElement("p");
        p_s_gym.textContent = s_gym;
        cell2.appendChild(p_s_gym);
        cell2.appendChild(p_s_time);
        var cell3 = row.insertCell(2);
        var ebutton = document.createElement("button");
        var p_name = document.createElement("p");
        p_name.innerHTML = s_name;
        ebutton.className = "editButton";
        ebutton.onclick = editSession;
        ebutton.id = ts;
        ebutton.setAttribute("data-name", s_name);
        ebutton.setAttribute("data-time", s_time);
        ebutton.setAttribute("data-gym", s_gym);
        ebutton.setAttribute("data-date", s_date);
        ebutton.appendChild(p_name)
        cell3.appendChild(ebutton);
    }
    var rows = $('tbody > tr')
    rows = rows.sort(function (a, b) {
        inta = parseInt($('td.dateCell', a).text().split(" ")[0].replaceAll("-", ""))
        intb = parseInt($('td.dateCell', b).text().split(" ")[0].replaceAll("-", ""))
        return inta - intb;
    })
    $('tbody').empty()
    $('tbody').append(rows)
}

function editSession(event) {
    var btn = event.currentTarget;
    let user_names = btn.getAttribute("data-name");
    let id = btn.id;
    let url = "https://climbjio-default-rtdb.asia-southeast1.firebasedatabase.app/sessions/" + id + ".json";
    info = "Joining session @ " + btn.getAttribute("data-gym") + " on " + btn.getAttribute("data-time") + ", " + btn.getAttribute("data-date");
    new_names = prompt(info + "\n" + "Add/remove your name(s) here: ", user_names);
    if (new_names === null || new_names === "") {
        // new_names=user_names
        if (new_names === "") {
            alert("Please enter climber names.");
        }
        return;
    }
    var postData = new Object();
    postData["name"] = String(new_names);
    postData = JSON.stringify(postData);
    // console.log(postData)
    $.ajax(url, {
        data: postData,
        type: "PATCH",
        success: function (resp) {
            location.reload();
            alert("Success!");
        },
    });
}

function cancelSession(event) {
    var b = event.currentTarget;
    info = "• " + b.getAttribute("data-date") + " / " + b.getAttribute("data-time") + " @ " + b.getAttribute("data-gym") + " / " + b.getAttribute("data-name") + "\n";
    resp = confirm("Cancel: \n" + info + "Confirm?");
    console.log(resp);
    if (!resp) {
        return;
    }
    id = b.getAttribute("data-id");
    apiDeleteSession(id, true)
}

function apiDeleteSession(s_id, showAlert = false) {
    let url = "https://climbjio-default-rtdb.asia-southeast1.firebasedatabase.app/sessions/" + s_id + ".json";
    console.log(url);
    $.ajax(url, {
        type: "DELETE",
        success: function (resp) {
            if (showAlert) {
                alert("Success!")
                location.reload()
            }
        },
    });
}

function apiArchiveSession(session_info) {
    postData = JSON.stringify(session_info);
    let url = "https://climbjio-default-rtdb.asia-southeast1.firebasedatabase.app/archive.json";
    $.ajax(url, {
        data: postData,
        type: "POST",
        success: function (resp) {
            console.log("archived " + postData)
        },
    });
}

function showCopiedToast() {
    var clipstr = "";
    var name_btns = document.getElementsByClassName("editButton");
    if (name_btns.length === 0) {
        alert("No upcoming sessions.");
        return;
    }
    for (let b of name_btns) {
        clipstr = clipstr + getSessionInfo(b.getAttribute("data-date"), b.getAttribute("data-time"), b.getAttribute("data-gym"), b.getAttribute("data-name"))
    }
    navigator.clipboard.writeText(clipstr);
    var t = document.getElementById("copiedToast");
    let showing = t.className.includes("show")
    if (!showing) {
        t.className = t.className + " show";
        setTimeout(function () {
            t.className = t.className.replace("show", "");
        }, 5000);
    }
}

function hideCopiedToast() {
    var t = document.getElementById("copiedToast");
    t.className = t.className.replace("show", "");
}

function getSessionInfo(s_date, s_time, s_gym, s_name = "none") {
    return "• " + s_date + " / " + s_time + " @ " + s_gym + " / " + s_name + "\n";
}

function getWeekDayFromDate(datestr) {
    const d = new Date(datestr);
    let day = d.getDay();
    switch (day) {
        case 0:
            return "SUN";
        case 1:
            return "MON";
        case 2:
            return "TUE";
        case 3:
            return "WED";
        case 4:
            return "THU";
        case 5:
            return "FRI";
        case 6:
            return "SAT";
    }
}

function dateIsBeforeToday(datestr) {
    const tod = new Date();
    const d = new Date(datestr);
    // console.log(tod)
    // console.log(d)
    return ((tod.getTime() - d.getTime()) > 86400000)
}